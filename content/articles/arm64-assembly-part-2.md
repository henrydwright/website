Title: How to train your (snap)dragon - part 2 - libraries
Date: 2024-12-01 14:29:00
Category: Blog
Tags: assembly,windows,C,fun
Description: Learn arm64 assembly on Windows in three hard steps (part 2 of 3)
Thumb_Image: dragon.jpg
Slug: arm64-assembly-part-2

In the [last part of this three part set of tutorials](./arm64-assembly-part-1.html), we successfully wrote a small function in arm64 assembly language and called it from a C program. In this tutorial we will write a program written only in arm64 assembly, and make it output "Hello, world!" using standard C library functions.

## First steps

To start with, follow the steps from part 1 to set up a correctly configured project in Visual Studio.

In order to understand what happens next we need to understand a little about how Windows runs executables. There are several subsystems in Windows which run executables in different ways. The one we will target is a console application which runs on the command line.

The Windows linker needs to be told what type of application exists in the binary code files it is given. For the project we've created, the linker will be told to create a console application with `\SUBSYSTEM:CONSOLE` ([see documentation here which explains some of the other subsystems](https://learn.microsoft.com/en-us/cpp/build/reference/subsystem-specify-subsystem?view=msvc-170)).

By examining the [documentation for entry point](https://learn.microsoft.com/en-us/cpp/build/reference/entry-entry-point-symbol?view=msvc-170), we can find the first function that Windows is looking for in our program. By default, Windows looks to run a function that does some set up for the C runtime (to allow all C standard functions to work). This function is called `mainCRTStartup`, and once it is finished it calls the traditional C entry point of `main`.

Let's start by creating the smallest possible program that runs and stops.

Make an assembly file called `Hello.asm` and insert into it the following code.

```Assembly
; Hello World in ARM64 Assembly for Windows

	AREA	Hello, CODE, READONLY
	EXPORT	mainCRTStartup [FUNC]
	IMPORT	ExitProcess

mainCRTStartup PROC
	mov		x0, #0
	bl		ExitProcess
	ENDP

	END
```

Here we make our first use of the Windows API, with the [ExitProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess) function. In general to make use of a library function we must:

1. Ensure the linker knows that this file needs a label from elsewhere (in a library most often) using `IMPORT` directive.
2. Lookup what arguments it needs, by inspecting the documentation and adhering to these.
3. Call the function in code, by adhering to the ARM Architecture Procedure Call Standard (placing arguments into registers in order, then calling with `bl`).

<div class="remark success"><b>Time to run!</b> Compile the program above and test that it works. All it does is open and immediately exit.</div>

#### Relevant sections of armasm user guide / Microsoft documentation

* [IMPORT](https://developer.arm.com/documentation/dui0801/l/Directives-Reference/IMPORT-and-EXTERN?lang=en)
* [bl](https://developer.arm.com/documentation/dui0801/l/A64-General-Instructions/BL--A64-?lang=en)
* [ExitProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess)

## Declaring some data

Assembly language doesn't have any special ideas about how a programmer stores information beyond the concept of memory and registers. How we use memory
is subject to a set of conventions, some of which are so core that the CPU provides additional support for them.

We can store data in two different ways in a program

1. Registers - in arm64, we can use `x0-x30` as general purpose, being mindful of the [ABI conventions](https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170) which mean functions we call may overwrite our contents if we don't save it.
2. Memory - here we use the much slower RAM, and store data in different parts of this. So long as we don't try to read or write to memory that isn't ours, we can store data any way we like. That said, the three principle ways are:

	1. Globals - we reserve some memory at the top of our program, near the machine code and mark it as read/write. We can have the assembler initialise the values at compile time. Very useful for constants or global state.
	2. Stack - this is a convention honoured by many processors (arm64 and x86 amongst them) where there is a dynamic portion of memory that grows and shrinks as the program executes. On arm64, it starts at the highest address and grows downwards (to lower addresses) and shrinks back upwards. The current top of the stack is indicated by the stack pointer (on arm64, `sp`).
	3. Heap - here we make use of the Operating System to assign us a portion of memory of a certain size and give us a pointer to it which we can store on the stack or in a register. In the C standard library we would use `malloc` for this.

In this tutorial (and the next part) we will demonstrate both Globals and Stack usage.

### Globally

To start with, we will demonstrate use of a global to store some data:

```Assembly
; Hello World in ARM64 Assembly for Windows

	AREA	HelloData, DATA
helloText DCB "Hello, world!",0

	AREA	Hello, CODE, READONLY
	EXPORT	mainCRTStartup [FUNC]
	IMPORT	ExitProcess

mainCRTStartup PROC
	mov		x0, #0
	bl		ExitProcess
	ENDP

	END
```

We create a new `AREA` for data and store a set of bytes (the `B` in `DCB` stands for bytes). The contents of these bytes are the null-terminated (hence the `0`) ASCII string for _"Hello, world!"_.

Note how easy the assembler makes it for us to define a string constant.

<div class="remark success"><b>Time to run!</b> Check this program works by running it. You'll notice it does nothing but run and exit again. This is by design, we'll make it do stuff later. </div>

### Stack
We'll now see why string constants are much easier to define globally in `armasm` - this is because the work is done at assembly time, rather than at runtime, and because the syntax for doing so is much easier!

To use the stack the same code looks like this (comments for clarity, with `X` signifying an unknown byte value):

```Assembly
; Hello World in ARM64 Assembly for Windows

	AREA	Hello, CODE, READONLY
	EXPORT	mainCRTStartup [FUNC]
	IMPORT	ExitProcess

mainCRTStartup PROC
	sub		sp, sp, #16				 ; stack must be 16-byte aligned and we need 14 bytes for "Hello, world!\0"
								     ; arm64 is little endian, so least significant byte will be stored into memory first (hence we put string in reverse order in bytes)
	movk	x0, #0x6548				 
	movk	x0, #0x6C6C, LSL #16	 
	movk	x0, #0x2C6F, LSL #32     
	movk	x0, #0x7720, LSL #48     
	movk	x1, #0x726F				 
	movk	x1, #0x646C, LSL #16	 
	movk	x1, #0x0021, LSL #32	 
	stp		x0, x1, [sp, #0]		 
	add		sp, sp, #16	
	mov		x0, #0
	bl		ExitProcess
	ENDP

	END
```

One of the arm64 requirements is that the stack pointer must be 16-byte aligned, so we can only increase and decrease the size of stack in 16-byte increments. The code works as follows:

1. Increase the size of the stack by 16 bytes (`sub sp, sp, #16`)
2. Set the registers `x0` and `x1` to house "Hello, w" and "orld!\0" respectively (the various `movk` commands are setting 2 bytes at time of the registers)
3. Store the pair of registers to memory at the address pointed to by the stack pointer (`stp x0, x1, [sp, #0]`)
4. Once done, decrease the size of the stack by 16 bytes (`add sp, sp,  #16`)

To go into even more detail we can look at it line by line and get the below with the state reflecting the state _after_ the instruction has run. You'll notice that we're storing the string in reverse order into `x0` and `x1`. This is because arm64 is little endian, meaning the least significant byte is read first in any instruction.

<div>

<table class="table row-hover">
<thead>
<tr>
<td>
Instruction
</td>
<td>
<code>x0</code>
</td>
<td>
<code>x1</code>
</td>
<td>
Memory state at <code>sp</code>
</td>
</tr>
</thead>
<tbody>
<tr>
<td><code>sub	sp, sp, #16</code></td>
<td><code>0x________________</code></td>
<td><code>0x________________</code></td>
<td><code>__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __</code></td>
</tr>
<tr>
<td><code>movk	x0, #0x6548</code></td>
<td><code>0x____________6548</code> ("eH")</td>
<td><code>0x________________</code></td>
<td><code>__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __</code></td>
</tr>
<tr>
<td><code>movk	x0, #0x6C6C, LSL #16</code></td>
<td><code>0x________6C6C6548</code> ("lleH")</td>
<td><code>0x________________</code></td>
<td><code>__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __</code></td>
</tr>
<tr>
<td><code>movk	x0, #0x2C6F, LSL #32</code></td>
<td><code>0x____2C6F6C6C6548</code> (",olleH")</td>
<td><code>0x________________</code></td>
<td><code>__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __</code></td>
</tr>
<tr>
<td><code>movk	x0, #0x7720, LSL #48</code></td>
<td><code>0x77202C6F6C6C6548</code> ("w ,olleH")</td>
<td><code>0x________________</code></td>
<td><code>__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __</code></td>
</tr>
<tr>
<td><code>...</code></td>
<td><code>...</code></td>
<td><code>...</code></td>
<td><code>...</code></td>
</tr>
<tr>
<td><code>movk	x1, #0x0021, LSL #32</code></td>
<td><code>0x77202C6F6C6C6548</code> ("w ,olleH")</td>
<td><code>0x____0021646C726F</code> ("\0!dlro")</td>
<td><code>__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __</code></td>
</tr>
<tr>
<td><code>stp	x0, x1, [sp, #0]</code></td>
<td><code>0x77202C6F6C6C6548</code> ("w ,olleH")</td>
<td><code>0x____0021646C726F</code> ("\0!dlro")</td>
<td><code>48 65 6C 6C 6F 2C 20 77 6F 72 6C 64 21 00 __ __</code> ("Hello, world!\0")</td>
</tr>
</tbody>
<table>
</div>




<div class="remark success"><b>Time to run!</b> Try compiling and running this example - you'll notice that it also doesn't do anything other than run and exit!</div>

#### Relevant sections of armasm user guide
* [DCB](https://developer.arm.com/documentation/dui0801/l/Directives-Reference/DCB)
* [sub](https://developer.arm.com/documentation/dui0801/l/A64-General-Instructions/SUB--immediate---A64-)
* [movk](https://developer.arm.com/documentation/dui0801/l/A64-General-Instructions/MOVK--A64-)
* [stp](https://developer.arm.com/documentation/dui0801/l/A64-Data-Transfer-Instructions/STP--A64-)

## Using a C standard library function

For simplicity, we'll go back to using a global definition of the "Hello, world!" string. 

In the next part we'll finish off our standalone program, by actually printing "Hello, world" to the screen. We can do this using the C standard library function `printf` ([documented here in a non platform specific way](https://www.tutorialspoint.com/c_standard_library/c_function_printf.htm))

The C standard library defines a number of functions that a C programmer can expect to find implemented on all platforms with the same interface. It means that a C program written with these functions should be able to be compiled on any platform which implements the C standard library.

Windows implements the C standard library, as does Linux, and many other OSs. For example, we can find the `printf` function also documented in the [Microsoft documentation for Windows](https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/printf-printf-l-wprintf-wprintf-l?view=msvc-170).

In order to use the `printf` function in our assembly program, we need to change a few things:

1. We need to ensure the set up for the C language runtime is done _before_ we call `printf`
2. We need to make sure that the linker knows to create our executable in such a way that the C language runtime is available to our program at run time
3. We need to call the function using the procedure call standard

To complete part 1, we simply change the main entry point for our code from `mainCRTStartup` to `main` and ensure we return `0` for success at the end. This is because the C language runtime on Windows will call `main` automatically once it has finished setting up.

To complete part 3, we put a pointer to the location of the global label "helloText" as the first argument and then branch to `printf`. Before we do this we preserve the link register (in `x19`), as it will be overwritten when we use `bl` and we'll need the value later to return to the C language runtime and clean up. We restore it after the `bl` instruction.

This is the part we do in code, leaving us with the program here:
```Assembly
; Hello World in ARM64 Assembly for Windows

	AREA	HelloData, DATA
helloText DCB "Hello, world!",0

	AREA	Hello, CODE, READONLY
	EXPORT	main [FUNC]
	IMPORT	printf

	ALIGN
main PROC
	ldr		x0, =helloText
	mov		LR, x30					; preseve the link register
	bl		printf
	mov		x30, LR					; restore the link register
	mov		x0, #0
	ret
	ENDP

	END
```

If we try and assemble this without changing any settings in Visual Studio this will fail with error `LNK2019 unresolved external symbol printf referenced in function main` (because the linker has no idea what `printf` means) and `LNK2001 unresolved external symbol mainCRTStartup` (because the linker can't find the `mainCRTStartup` entry point it's looking for). We need to tell the linker to add the C Runtime Library (with associated startup code) to our final executable, and include the printf defintion.

To do this we right click on the project, click Properties -> Linker -> Input. Edit additional dependencies to add `"legacy_stdio_definitions.lib; libcmt.lib"`. 

<div class="remark success"><b>Time to run!</b> With these settings changed, the program should compile and run successfully</div>

#### Relevant sections of armasm user guide / Microsoft documentation
* [IMPORT](https://developer.arm.com/documentation/dui0801/l/Directives-Reference/IMPORT-and-EXTERN)
* [ALIGN](https://developer.arm.com/documentation/dui0801/l/Directives-Reference/ALIGN)
* [ldr](https://developer.arm.com/documentation/dui0801/l/A64-Data-Transfer-Instructions/LDR--literal-)
* [bl](https://developer.arm.com/documentation/dui0801/l/A64-General-Instructions/BL--A64-)
* [printf](https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/printf-printf-l-wprintf-wprintf-l?view=msvc-170)

## Things to try

* Change your code to print to the screen "Hello, world!" but use the stack rather than a global variable
* Lookup another C standard library function and try using it in your code

## What next?

In part 3 of 3, we'll go further and explore how to print "Hello, world!" to the screen using only Windows NT (kernel) system calls.

[Click here to go to part 3 of 3](./arm64-assembly-part-3.html).
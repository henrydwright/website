Title: How to train your (snap)dragon - part 3 - do NT do this
Date: 2024-12-11 19:38:00
Category: Blog
Tags: assembly,windows,C,fun
Description: Learn arm64 assembly on Windows in three hard steps (part 3 of 3)
Thumb_Image: dragon.jpg
Slug: arm64-assembly-part-3

In the [previous part of this three part set of tutorials](./arm64-assembly-part-2.html), we learnt about global, stack and heap memory and called a function from the C standard library. In this tutorial we'll make use of Windows library functions and build up to needing no libraries at all and using system calls direct to the Windows NT kernel.

## Using higher level Windows API calls

Throughout this last tutorial, we'll build on what we did in part 2. In part 2 we used C Standard Library calls, meaning that we could take the same code, and use the equivalent Linux tools to assemble and link it and the code would work on (arm64) Linux machines.

To get to a point where we have "Hello world" working with just system calls we'll need to first understand a little about the Windows APIs. Windows makes its API available across several libraries, each with different functions, introduced in different Windows versions. 

Windows APIs refer to a huge list of data types which are defined in various headers for C programs, and [on this webpage also](https://learn.microsoft.com/en-us/windows/win32/winprog/windows-data-types). We'll need this page a lot when writing assembly as it tells us how big each Windows data type referred to in documentation is (in bytes/bits) so we can use the right memory allocations and instructions.

The first Windows API we'll use is the [Console API](https://learn.microsoft.com/en-us/windows/console/console-reference). This is the high level API which supports programs which run in a console with a text-based interface.

To write "Hello, world" to the console using this API is still relatively simple and takes two steps:

1. We get the handle (Windows term for a resource identifier/memory reference) for the output for the console our program is running within using the `GetStdHandle` function
2. We use the `WriteConsoleA` function to write to this console output 

In the code below you can also see a helpful feature of an assembly language where we define a constant using the `EQU` directive which means we can then use that constant value throughout rather then repeatedly writing the value in full.

Note below the three function calls adhere to the [ARM64 Windows ABI](https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170) which implements the ARM64 Architecture Procedure Call Standard. For the last time in detail, I'll explain how for the first two calls:

1. [**GetStdHandle**](https://learn.microsoft.com/en-us/windows/console/getstdhandle)
    1. Put the first (only) argument into `w0` (as DWORD is a 32-bit value we use the `w` variant of the register) using the `mov` instruction for the constant for `STD_OUTPUT_HANDLE` defined in the documentation.
    2. Branch to the function using `bl`
    3. Get the _return_ value from the function out of `x0` and put it into `x20` which is a non-volatile register that won't be overwritten
2. [**WriteConsoleA**](https://learn.microsoft.com/en-us/windows/console/writeconsole)
    1. Put the first argument into `x0`. In this case it's the handle value returned from the previous function (test for the curious: what instructions in the code aren't needed?)
    2. The second argument goes into `x1` and this is a pointer to the location of the ANSI text string for "Hello, world!" in the globals
    3. Put the third argument into `w2` (`w` as DWORD is 32 bits) - this is how many characters we want to write - in this case 13.
    4. The fourth argument is an optional output pointer value so we'll set it to a 64-bit zero value (NULL pointer) in `x3`. All pointers are 64-bits as the very definition of a 64-bit system is that it can address 64-bits of memory.
    5. Documentation tells us to set the fifth argument - so `x4` - to NULL (0) so we'll do that too.

```Assembly
; Hello World in ARM64 Assembly for Windows


	AREA	HelloData, DATA
DWORD EQU 4294967295
STD_OUTPUT_HANDLE EQU (DWORD-11)
helloText DCB "Hello, world!",0

	AREA	Hello, CODE, READONLY
	EXPORT	mainCRTStartup [FUNC]
	IMPORT	ExitProcess
	IMPORT	GetStdHandle
	IMPORT	WriteConsoleA

	ALIGN
mainCRTStartup PROC
	mov		w0, #STD_OUTPUT_HANDLE
	bl		GetStdHandle				; get the stdout handle
	mov		x20, x0						; store it in x20
	mov		x0, x20
	ldr		x1, =helloText				
	mov		w2, #13						; we want to write 13 characters
	mov		x3, #0
	mov		x4, #0
	bl		WriteConsoleA				; write our text to stdout
	mov		x0, #0
	bl		ExitProcess
	ENDP

	END
```

Since we're not longer using the C standard library we can remove the libraries from the linker. Right click on the project, click Properties -> Linker -> Input. Edit additional dependencies to remove the text added in part 2 `"legacy_stdio_definitions.lib; libcmt.lib"`. 

<div class="remark success"><b>Time to run!</b> With these settings changed, the program should compile and run successfully</div>


#### Relevant sections of armasm / Windows API documentation:
* [EQU](https://developer.arm.com/documentation/dui0801/l/Directives-Reference/EQU?lang=en)
* [GetStdHandle](https://learn.microsoft.com/en-us/windows/console/getstdhandle)
* [WriteConsole](https://learn.microsoft.com/en-us/windows/console/writeconsole)
* [Windows Data Types (DWORD, HANDLE)](https://learn.microsoft.com/en-us/windows/win32/winprog/windows-data-types)


## Using lower level Windows API calls
Obviously, this is programming so we could also have used other Windows API calls to achieve this, some of which are closer to the underlying system calls used. This will help us as we progress to the final layer down, and just use the NT Kernel system calls to achieve the same aim.

As with most operating systems, Windows treats console input and output just like a file (or device) that can be opened, have bytes written to or read from it, and closed. This means [we can use the Win32 File APIs to write to the console too](https://learn.microsoft.com/en-us/windows/console/console-handles)! In the code example in a moment we'll make use of `CreateFileA` and `WriteFile` to do the same "Hello world" as we did above.

### An aside on Windows filesystem namespaces
Windows has a pretty long history so the notion of a filesystem has changed several times over the years and hence within modern Windows hides two ~~wolves~~ filesystem namespaces.

1. **Win32 Namespace** - this is a file system layer that was built to maintain compatibility/familiarity with the DOS/Win16 file system and for those familiar with this way of navigating Windows-based systems. It is the paths you are familiar with (such as `C:\folder\example.txt`). It also includes the DOS reserved devices (such as `CONOUT$` for the console output device). These paths are used by most Win32 API calls as the name implies.
2. **NT Namespace** - this is how modern Windows operating systems 'see' files at the lowest, kernel, level. Everything (devices and files) is an object represented as a path (e.g. `\Device\HarddiskVolume2\folder\example.txt`). The various Win32 names for things are symbolically linked to NT objects via the `\??\` path. These paths are used by NT kernel system calls and lowest level NT APIs (e.g. for drivers).

If you are interested in reading more, this [guide by Chris Denton is excellent](https://chrisdenton.github.io/omnipath/Overview.html) when read alongside the [official Windows documentation](https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file#win32-file-namespaces).

The below example shows the other way of writing "Hello, world!" using the other bits.

```Assembly
; Hello World in ARM64 Assembly for Windows


	AREA	HelloData, DATA
NULL EQU 0

FILE_ATTRIBUTE_NORMAL EQU 0x00000080 ; copied from WinNT.h
FILE_GENERIC_WRITE EQU 0x00120116 ; (STANDARD_RIGHTS_WRITE || FILE_WRITE_DATA || FILE_WRITE_ATTRIBUTES || FILE_WRITE_EA || FILE_APPEND_DATA || SYNCHRONIZE)
FILE_GENERIC_READ EQU 0x00120089 ; (STANDARD_RIGHTS_READ || FILE_READ_DATA || FILE_READ_ATTRIBUTES || FILE_READ_EA || SYNCHRONIZE)

stdOutPathConOut DCB "CONOUT$$",0
helloText DCB "Hello, world!",0

	AREA	Hello, CODE, READONLY
	EXPORT	mainCRTStartup [FUNC]
	IMPORT	ExitProcess
	IMPORT	CreateFileA
	IMPORT	WriteFile

	ALIGN
mainCRTStartup PROC
	ldr		x0, =stdOutPathConOut
	movl	w21, #FILE_GENERIC_READ
	movl	w22, #FILE_GENERIC_WRITE
	orr		w1, w21, w22
	mov		w2, #2
	mov		x3, #NULL
	mov		w4, #3
	mov		w5, #FILE_ATTRIBUTE_NORMAL
	mov		x6, #NULL
	bl		CreateFileA

	ldr		x1, =helloText
	mov		w2, #13
	mov		x3, #NULL
	mov		x4, #NULL
	bl		WriteFile

	mov		x0, #0
	bl		ExitProcess
	ENDP

	END
```

<div class="remark success"><b>Time to run!</b> This program should run and print <i>Hello, world!</i> to the screen.</div>

#### Relevant sections of Windows API documentation:

* [CreateFileA](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea)
* [WriteFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile)

## Laying out a struct

The system calls we are about to make use of rely on us making use of the notion of C-style `struct` data structures. As C is a low-level language it makes use of structs as a way of organising data in memory to pass more complex groups of data around.

The GNU documentation tells us a little about [how structs are laid out in C programming](https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Structure-Layout.html). This article essentially describes the following - we put each element within the struct one after another in memory, aligning as the architecture requires. Alignment in ARM64 is [described in detail here](https://developer.arm.com/documentation/102376/0100/Alignment-and-endianness) however it is most easily summed up as needing elements to have an address which is fully divisible by its size. This means a DWORD (32-bit value) must be 2-byte aligned.

To use a practical example, we'll examine one similar to the one in the GNU documentation pictorally, namely:

```C
struct foo
{
  char a;
  int c;
  char b;
  long d;
};
```

We start by putting the first element (the `char`) at the start. Because the `int` is 32-bits, we need it to be at an address divisible by 4, hence we add 3 bytes of empty 'padding' after the char so we're back to being divisble by 4. We repeat the same for the next `char` and the following `long` 64-bit value. This is illustrated in the figure below.

<img src="/images/articles/dragon/struct_padding.png"/>

We can then extract elements by addressing into the `struct` by addressing into it at a given offset. Imagine we had a pointer to the start of the struct in `x0` - we can then read parts of the struct by reading the relevant offset. For `c` in this struct we need an offset of 4 bytes so an instruction like `ldr w20 [x0, #4]`.

Of course, we could have laid this struct out more efficiently to minimise the padding required by starting with the largest items and moving to the smallest. Here is another example - can you see how this still obeys the same rules but is more efficient?

```C
struct foo
{
  long d;
  int c;
  char a;
  char b;
};
```

<img src="/images/articles/dragon/struct_padding_efficient.png"/>

As an exercise, you may wish to work out how the [IO_STATUS_BLOCK](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/ns-wdm-_io_status_block) struct we'll need to use later may be laid out in memory.

## String encodings
All computers know is binary, and everything else is an abstraction. We need some way of mapping between numbers (ultimately binary) and characters like we'd use in text. There are multiple encodings to do this. 

Windows NT system calls (and other Windows APIs) make relatively extensive use of UTF-16 strings which are **not** compatible with UTF-8 or ASCII strings on account of using 16 bits for each character, rather than just 8. For example, the character `C` would be 0x43 in UTF-8 and is 0x0043 in UTF-16.

If you want to [read more you can find more on this Stack Overflow post](https://stackoverflow.com/questions/496321/utf-8-utf-16-and-utf-32).

This, alongside the namespaces content (and the need to escape the `\` character), explains why the file path definition line in UTF-16 looks like `stdOutFilePath DCB "\\",0,"?",0,"?",0,"\\",0,"C", 0, "O", 0, "N",0,0,0`

## Using Windows NT system calls

We can remove the use of libraries completely using system calls. These are essentially where we set up certain parameters just like a function call, but instead of jumping to some other code we hand over control to the kernel.

This would not be a wholly wild thing to do in Linux as the system call numbers have remained stable over time. This is **not** the case for Windows NT, where the system call numbers have changed _between_ versions of Windows and even between builds of the same versions of Windows. 

As a result of being a terrible idea, and obviously thus unsupported, it's also not officially documented as a way to do anything. Luckily [Nt Doc](https://ntdoc.m417z.com/) contains some of the documentation we need, and the Windows driver guides often include an official way to make the same system call using a function call with the same name.

We're doing this to prove we can do it, not that it's a good idea. As a result, you may need to modify this code for your build of Windows to get it to work by using the call numbers outlined here: [https://j00ru.vexillium.org/syscalls/nt/64/](https://j00ru.vexillium.org/syscalls/nt/64/). The below code was tested working on Windows 11 (build 26100.2314).

These all correspond to function calls we could make using the functions in the header files. 

Putting all of this and our knowledge from the first 2 tutorials together, we get our magnum opus - a "Hello, world" program that makes use of ARM64 assembly, and Windows NT system calls alone without a single library in sight... You can also [download the code here](/images/articles/dragon/hello.asm).

```Assembly
; Hello World in ARM64 Assembly for Windows


	AREA	HelloData, DATA
NULL EQU 0
NtCurrentProcess EQU -1

STANDARD_RIGHTS_WRITE EQU 0x00020000		; copied from WinNT.h
FILE_WRITE_DATA EQU 0x0002
FILE_WRITE_ATTRIBUTES EQU 0x0100
FILE_WRITE_EA EQU 0x0010
FILE_APPEND_DATA EQU 0x0004
SYNCHRONIZE EQU 0x00100000
FILE_GENERIC_WRITE EQU 0x00120116 ; (STANDARD_RIGHTS_WRITE || FILE_WRITE_DATA || FILE_WRITE_ATTRIBUTES || FILE_WRITE_EA || FILE_APPEND_DATA || SYNCHRONIZE)


FILE_ATTRIBUTE_NORMAL EQU 0x00000080 
FILE_SHARE_WRITE EQU 0x00000002 

FILE_OPEN EQU 0x00000001					; copied from NtDoc (online)
FILE_OPEN_IF EQU 0x00000003

helloText DCB "Hello, world!",0				; char*
	ALIGN 8
stdOutHandle DCQ 0							; HANDLE (8b)
	ALIGN 8
offset DCQ 0								; LARGE_INTEGER (8b)
	ALIGN 2
stdOutFilePath DCB "\\",0,"?",0,"?",0,"\\",0,"C", 0, "O", 0, "N",0,0,0



	AREA	Hello, CODE, READONLY
	EXPORT	mainCRTStartup [FUNC]
	EXPORT	clearIOStatus [FUNC]

	ALIGN
clearIOStatus PROC
	mov x3, #0								
	str x3, [x0, #0]						; NTSTATUS Status = 0
	str x3, [x0, #8]						; PVOID Pointer = 0
	str x3, [x1, #0]						; ULONG InformationContent = 0
	mov x3, x1								
	str x3, [x0, #16]						; ULONG_PTR Information = &InformationContent
	ret
	ENDP

	ALIGN
mainCRTStartup PROC
	; CREATE THE ObjectName STRUCT ON THE STACK
	sub		sp, sp, #16						; struct ObjectName (UNICODE_STRING) = USHORT (2b) + USHORT (2b) + [4b to align] + PWSTR (8b) = 16b
	mov		x19, sp
	mov		w0, #14
	strh	w0, [sp, #0]					; USHORT Length (in bytes) = 14
	strh	w0, [sp, #2]					; USHORT MaximumLength (in bytes) = 14
	ldr		x0, =stdOutFilePath
	str		x0, [sp, #8]					; PWSTR Buffer = &stdOutFilePath

	; CREATE THE ObjectAttributes STRUCT ON THE STACK
	sub		sp, sp, #48						; struct ObjectAttributes (POBJECT_ATTRIBUTES) = ULONG (4b) + [4b to align] + HANDLE (8b) + PUNICODE_STRING (8b) + ULONG (4b) + [4b to align] + PSECURITY_DESCRIPTION (8b) + PSECURITY_QUALITY_OF_SERVICE (8b) = 48b
	mov		x20, sp
	mov		w0, #48
	str		w0, [sp, #0]					; ULONG Length (in bytes) = 48
	mov		x0, #NULL
	str		x0, [sp, #8]					; HANDLE RootDirectory = NULL
	mov		x0, x19
	str		x0, [sp, #16]					; PUNICODE_STRING ObjectName = &[ObjectName struct on stack]
	mov		w0, #0
	str		w0, [sp, #24]					; ULONG Attributes = NULL
	mov		x0, #0
	str		x0, [sp, #32]					; PSECURITY_DESCRIPTOR SecurityDescriptor = NULL
	str		x0, [sp, #40]					; PSECURITY_QUALITY_OF_SERVICE SecurityQualityOfService = NULL

	; CREATE THE IoStatusBlock STRUCT ON THE STACK
	sub		sp, sp, #32						; ULONG Information = 4b + [4b to align] = 8b
											; struct IOStatusBlock (IO_STATUS_BLOCK) = NTSTATUS (4b) + [4b to align] + PVOID (8b) + ULONG_PTR (8b) = 24b
	str		xzr, [sp, #0]					; ULONG *(IOStatusBlock.Information) = 0
	mov		x21, sp
	str		xzr, [sp, #8]					; NTSTATUS Status = 0
	str		xzr, [sp, #16]					; PVOID Pointer = NULL
	str		x21, [sp, #24]					; ULONG_PTR Information = &[ULONG on stack]
	add		x22, sp, #8

	; GET THE FILE HANDLE FOR WRITING TO CONSOLE (CONOUT$), PUT IN X19
											; NtCreateFile
	ldr		x0, =stdOutHandle				; out FileHandle (PHANDLE)
	movl	w1, #FILE_GENERIC_WRITE         ; in  DesiredAccess (ACCESS_MASK / DWORD)
	mov		x2, x20							; in  ObjectAttributes (POBJECT_ATTRIBUTES)
	mov		x3, x22							; out IoStatusBlock (PIO_STATUS_BLOCK)
	mov		x4, #NULL						; in  AllocationSize (PLARGE_INTEGER)
	mov  	w5, #FILE_ATTRIBUTE_NORMAL		; in  FileAttributes (ULONG)
	mov 	w6, #FILE_SHARE_WRITE			; in  ShareAccess (ULONG)
	mov		w7, #FILE_OPEN					; in  CreateDisposition (ULONG)
	mov		w8, #0							; in  CreateOptions (ULONG)
	mov		x9, #NULL						; in  EaBuffer (PVOID)
	mov		w10, #0							; in  EaLength (ULONG)
	sub		sp, sp, #32						; remaining arguments go on the stack
	str		w8, [sp, #0]
	str		x9, [sp, #8]
	str		w10, [sp, #16]
	svc		#0x0055							; SYSTEM CALL
	add		sp, sp, #32
	ldr		x19, =stdOutHandle
	ldr		x19, [x19, #0]

	; CLEAR THE IO_STATUS_BLOCK BEFORE WE USE IT
	mov	x0, x22
	mov x1, x21
	bl clearIOStatus						; set up the IO_STATUS_BLOCK before we use it

	; WRITE TO THE CONSOLE BUFFER
											; NtWriteFile
	mov		x0, x19							; in FileHandle (HANDLE)
	mov		x1, #NULL						; in Event (HANDLE)
	mov		x2, #NULL						; in ApcRoutine (PIO_APC_ROUTINE)
	mov		x3, #NULL						; in ApcContext (PVOID)
	mov		x4, x22							; out IoStatusBlock (PIO_STATUS_BLOCK)
	ldr		x5, =helloText					; in Buffer (PVOID)
	mov		w6, #13							; in Length (ULONG)
	ldr		x7,	=offset			     		; in ByteOffset (PLARGE_INTEGER)
	mov		x8, #NULL						; in Key (PULONG)
	sub		sp, sp, #16						; remaining arguments go on the stack
	str		w8, [sp, #0]
	svc		#0x0008							; SYSTEM CALL
	add		sp, sp, #16

	; EXIT
											; NtTerminateProcess
	mov		x0, #NtCurrentProcess			
	mov		x1, #0
	svc		#0x002c							; SYSTEM CALL
	ENDP

	END
```

## What next?

That's the end of our series of 3 tutorials - hope you enjoyed it and if you liked it do [buy me a coffee at the link here](https://monzo.me/henrywright60/5.00?d=ArmBlog&h=jui6N4).

## Also read
* [ARM A-profile A64 Instruction Set Architecture](https://developer.arm.com/documentation/ddi0602/2024-09)
* [ARMv8-A Architecture Reference Manual](https://developer.arm.com/documentation/ddi0487/fc/)
* [WinMain application entry point for Windows](https://learn.microsoft.com/en-us/windows/win32/learnwin32/winmain--the-application-entry-point)
* [Microsoft Universal C Runtime Function Reference](https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/crt-alphabetical-function-reference?view=msvc-170)
* [Microsoft Linker Reference](https://learn.microsoft.com/en-us/cpp/build/reference/linker-options?view=msvc-170)
* [Microsoft C Runtime .lib files](https://learn.microsoft.com/en-us/cpp/c-runtime-library/crt-library-features?view=msvc-170)
* [Windows ARM64 ABI Conventions](https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170)
* [Windows Data Types](https://learn.microsoft.com/en-us/windows/win32/winprog/windows-data-types)
* [NTSTATUS Codes](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-erref/596a1078-e883-4972-9bbc-49e60bebca55)
* [NtDoc - documentation for NT calls](https://ntdoc.m417z.com/)
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
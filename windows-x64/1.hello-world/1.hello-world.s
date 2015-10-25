; Simon Whitehead, 2015
; ---------------------
;
; 1. Hello world
;
;    This program prints "Hello world!" to the Console
;    then exits

; Windows APIs

; GetStdHandle
; ------------
; HANDLE WINAPI GetStdHandle(
;     _In_ DWORD nStdHandle
; ); 
extern GetStdHandle

; WriteFile
; ------------
; BOOL WINAPI WriteFile(
;   _In_        HANDLE       hFile,
;   _In_        LPCVOID      lpBuffer,
;   _In_        DWORD        nNumberOfBytesToWrite,
;   _Out_opt_   LPDWORD      lpNumberOfBytesWritten,
;   _Inout_opt_ LPOVERLAPPED lpOverlapped
; );
extern WriteFile

; ExitProcess
; -----------
; VOID WINAPI ExitProcess(
;     _In_ UINT uExitCode
; );
extern ExitProcess

global start

section .data

    STD_OUTPUT_HANDLE   equ -11
    NULL                equ 0

    msg                 db "Hello World!", 10, 0
    msg.len             equ $-msg

section .bss
empty               resd 1

section .text

start:

    ; Get a handle to stdout
    mov rcx,STD_OUTPUT_HANDLE
    call    GetStdHandle

    mov rcx,rax			; hFile
    mov rdx,msg			; lpBuffer
    mov r8,msg.len		; nNumberOfBytesToWrite
    mov r9,empty		; lpNumberOfBytesWritten
    push    NULL		; lpOverlapped
    call    WriteFile

    mov rcx,NULL
    call    ExitProcess


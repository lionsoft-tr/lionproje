; hello.asm
BITS 64

extern GetModuleHandleA
extern GetProcAddress
extern LoadLibraryA
extern MessageBoxA
extern ExitProcess
extern RegisterClassExA
extern CreateWindowExA
extern ShowWindow
extern UpdateWindow
extern DefWindowProcA
extern PostQuitMessage

section .data
    class_name db 'MyWindowClass',0
    window_title db 'Hello, World!',0
    msg db 'Hello, World!',0

    ; Window Class Structure
    wc WNDCLASSEXA struct
        cbSize      dd ?
        style        dd ?
        lpfnWndProc  dq ?
        cbClsExtra   dd ?
        cbWndExtra   dd ?
        hInstance    dq ?
        hIcon        dq ?
        hCursor      dq ?
        hbrBackground dq ?
        lpszMenuName dq ?
        lpszClassName dq ?
        hIconSm      dq ?
    wc WNDCLASSEXA ends

section .bss
    hwnd resq 1
    hInstance resq 1
    msg_data MSG

section .text
    global main
    main:
        ; Get hInstance
        call GetModuleHandleA
        mov [hInstance], rax

        ; Window Class
        mov rax, [hInstance]
        mov [wc.hInstance], rax
        mov rax, wc
        mov [wc.cbSize], 48 ; Size of WNDCLASSEXA
        mov [wc.lpfnWndProc], rax
        mov [wc.lpszClassName], class_name
        mov [wc.hCursor], 0
        mov [wc.hbrBackground], 0xFFFFFF ; White background

        ; Register Window Class
        mov rax, RegisterClassExA
        call rax
        test rax, rax
        jz exit_program

        ; Create Window
        mov rax, [hInstance]
        mov rdi, 0
        mov rsi, window_title
        mov rdx, class_name
        mov rcx, 0
        mov rbx, 0x80CF0000 ; WS_OVERLAPPEDWINDOW
        mov r8, 0
        mov r9, 0
        mov r10, 0
        mov r11, 0
        mov r12, 0
        mov r13, rax
        call CreateWindowExA
        mov [hwnd], rax
        test rax, rax
        jz exit_program

        ; Show Window
        mov rax, [hwnd]
        mov rdi, 1 ; SW_SHOWNORMAL
        call ShowWindow

        ; Update Window
        mov rax, [hwnd]
        call UpdateWindow

        ; Message Loop
        message_loop:
            mov rax, msg_data
            mov rdi, rax
            call GetMessageA
            test rax, rax
            jz exit_program
            mov rax, msg_data
            call TranslateMessage
            mov rax, msg_data
            call DispatchMessageA
            jmp message_loop

        ; Exit Program
        exit_program:
            mov rax, ExitProcess
            xor rdi, rdi
            call rax

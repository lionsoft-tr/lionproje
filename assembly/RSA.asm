section .data
    p dw 61                ; ilk asal sayı
    q dw 53                ; ikinci asal sayı
    n dw 0                 ; n = p * q
    phi dw 0               ; Φ(n) = (p-1) * (q-1)
    e dw 17                ; e değeri (küçük bir asal sayı seçildi)
    d dw 0                 ; d değeri (bulunacak)
    msg db 'HELLO', 0      ; Şifrelenecek mesaj

section .bss
    enc resb 6             ; Şifreli mesaj
    dec resb 6             ; Çözülmüş mesaj

section .text
    global _start

_start:
    ; n = p * q
    mov ax, [p]
    mov bx, [q]
    mul bx
    mov [n], ax

    ; phi = (p-1) * (q-1)
    mov ax, [p]
    sub ax, 1
    mov bx, [q]
    sub bx, 1
    mul bx
    mov [phi], ax

    ; d * e ≡ 1 (mod phi)
    ; Burada küçük sayılar için manuel olarak d'yi belirledim (d = 2753)
    mov [d], 2753

    ; Şifreleme: C = M^e mod n
    ; Mesajın her karakterini şifrele
    mov esi, msg
    mov edi, enc
enc_loop:
    lodsb
    or al, al
    jz enc_done
    mov bl, al
    mov ax, [e]
    call mod_exp
    stosb
    jmp enc_loop
enc_done:

    ; Çözme: M = C^d mod n
    ; Şifreli mesajın her karakterini çöz
    mov esi, enc
    mov edi, dec
dec_loop:
    lodsb
    or al, al
    jz dec_done
    mov bl, al
    mov ax, [d]
    call mod_exp
    stosb
    jmp dec_loop
dec_done:

    ; Programı bitir
    mov eax, 60
    xor edi, edi
    syscall

mod_exp:
    ; Modüler üs alma işlemi
    ; girdi: bl = taban, ax = üs
    ; çıktı: al = sonuç
    mov cx, ax
    mov dx, 1
mod_exp_loop:
    test cx, 1
    jz skip_mul
    mul dx
    mov dx, ax
    skip_mul:
    mul bl
    mov ax, [n]
    div ax
    mov dx, ah
    mov al, dl
    shr cx, 1
    jnz mod_exp_loop
    mov al, dl
    ret

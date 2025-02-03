Bugün  emu8086 üzerinde assembly programları yazacağız hemen baslayalim.
Emu8086 assembly dilinde kod yazmayı destekleyen bir x86 mimarisi emulatordur.
Bu derslerde önceki derslerde işlemediğimiz bazı komutları yazacağız ama hiç gözünüz korkmasın hepsini aciklayacagim merak etmeyin.


Program ilerde license key isteyebilir istediği zaman şunu kullanın:
Kod Seç
User: glaitm
Key: 27R3VDEFYFX4N0VC3FRTQZX


INT komutu
int komutu işlemciye interrupt taleplerini iletmek icin kullanılırız Bu interrupt talepleri donanım olaylarını(örneğin ekrana yazı yazdırma klavyeden veri alma vb.) islemciye bildirmek icin kullanırız.


Ekrana karakter bastirma(02h)

Kod Seç
mov ah, 02h ; 02h Karakter bastirma islevidir
mov dl, karakter ; dl registerine karakter degerini aktardik
int 21h ; Genel dos islevlerini cagirmak icin 21h interruptunu kullanıyoruz
ret ; programi sonlandiralim

karakter db "f"




Ekrana string bastirma(09h)

Kod Seç
   
mov ah, 09h ; 09h String bastirma islevidir
mov dl,offset yazi ; yazi degeri string oldugu icin offset kullaniyorsunuz offset kullanmak istemiyorsaniz mov yerine lea kullanabilirsiniz
int 21h
ret
yazi db "emu8086" , '$'; 09h islevinde stringler $ karakterine kadardır


Kullanicidan karakter alma(01h ve 08h)
Kod Seç
mov ah,01h ; kullanicidan karakter aliyor ve al registerine aktariyor
int 21h
   
mov dl,al
mov ah,02h ; eger klavyeden input alırken ekranda gözükmemesini istiyorsanız 02h yerine 08h yazabilirsiniz
int 21h ; aldigi karakteri ekrana bastiriyor


Kullanicidan yazi alma(0AH)
Hizli anlamaniz icin basit "Merhaba,(isim)" programi

Kod Seç Genişlet
lea dx, isim
mov ah, 0Ah
int 21h

lea dx, newline
mov ah, 09h
int 21h

lea dx, mesaj
; ah = 09h zaten
int 21h

lea dx, isim + 2 ;ilk 2 byte veri uzunlugu icerdigi icin +2 diyoruz   
int 21h
ret

isim db 22 dup('$') ; 22 tane '$' doldurur
mesaj db "Merhaba,$"
newline db 0Dh, 0Ah, '$'




Klasor olusturma ve silme(39H ve 3Ah)
Kod Seç
lea dx,klasor
mov ah,39h ; '3Ah' yazarsaniz klasor silinir

int 21h

ret
klasor db "C:\klasor" , 0
Emu8086 nın dosya konumuna gidip vdrive kısmından C ye girerseniz klasoru görebilirsiniz



Dosya açma,oluşturma ve kapatma(3Ch,3Dh,3Eh)

Kod Seç Genişlet

mov ah,3Ch ; mevcud dosyayi acmak icin 3Dh kullanabilirsiniz
lea dx,filename
; assagidaki cx kodunu dosya mevcud degilse kullanin
   
;cx = 0 normal mod
;cx=1 sadece okunabilir dosya olusturmak icin
;cx=2 gizli dosya
;cx=4 sistem dosyasi
;cx=7 gizli, sistem, sadece okunabilir dosya
;cx=16 arsiv
mov cx ,0
         
mov al,2; al=0 sadece okuma , al=1 sadece yazma , al=2 okuma/yazma
   
int 21h
mov handle,ax
   
mov ah,3Eh ; dosyayi kapatalim
mov bx,handle
int 21h
ret

filename db "test.txt",0
handle dw ?; dosyada islemler yapmak icin dosya taniticisi bos sekilde tanimliyoruz sonra ax registerine aktarilcak bizde cekecegiz
 


Dosya'ya yazı yazdırma(40h)
Kod Seç Genişlet
mov ah,3Dh ; mevcuddaki dosyayi aciyoruz
lea dx, filename
mov al,1
int 21h

mov handle,ax

mov ah,40h
mov bx,handle
lea dx,metin
mov cx,metin_len

int 21h



mov ah,3Eh
mov bx,handle
int 21h
ret

filename db "test.txt", 0   
handle dw ?                 
metin db 'Selam Emu8086'
metin_len equ $-metin  ;metinin uzunlugunu aliyoruz

Dosya'dan yazı okuma(3FH)
Kod Seç Genişlet
mov ah, 3Dh
lea dx, filename
mov al, 0
int 21h
mov handle, ax

mov ah, 3Fh
mov bx, handle
mov cx, 128
lea dx, buffer
int 21h

mov ah, 3Eh
mov bx, handle
int 21h

mov ah, 09h
lea dx, buffer
int 21h

ret

filename db 'test.txt', 0
handle dw ?
buffer db 128 dup(0)
db '$'
Ornekler
Hareket eden piksel
Assagidaki ornek kodla klavyeden resimler cizebilirsiniz
Kod Seç Genişlet
mov al, 13h;320x200 pikselli sayfa acar
mov ah, 0
int 10h ; video olaylari icin kesme
mov cx, 25 ; pikselimizin konumunu veriyoruz (x: kordinati)
mov dx, 25
   
start:
    mov ah, 01h; burda bir tusa basilip basilmadigini kontrol ediyoruz
    int 16h
    jz start ; basilmadiysa geri donuyor
   
	mov al, 1100b ;rengi
	mov ah, 0ch
	int 10h     ; pikselin ayarlari
	
   
    mov ah, 00h ;basilan tusa bakiyor al registerine aktariyor
    int 16h
    cmp al, 'a'
    je sol
    cmp al, 's'
    je assagi
    cmp al, 'd'
    je sag
    cmp al, 'w'
    je yukari
	
	
	jmp start
	
sol:
    dec cx
    jmp start
sag:
    inc cx
    jmp start
yukari:
    dec dx
    jmp start
assagi:
    inc dx
    jmp start
Basit Hesap Makinesi
Kod Seç Genişlet
org 100h

; birinci sayiyi aliyor
mov ah, 01h
int 21h
sub al, '0' ; Ascii degerinden sayisal degere ceviriyor
mov bl, al
;ikinci sayiyi aliyor
mov ah, 01h
int 21h
sub al, '0'
mov bh, al

mov ah, 01h ; islemi aliyor
int 21h
mov cl, al

cmp cl, '+'
je toplama

cmp cl, '-'
je cikarma

cmp cl, '*'
je carpma

cmp cl, '/'
je bolme

jmp bitis

toplama:
    add bl, bh
    mov al, bl
    jmp yazdir

cikarma:
    sub bl, bh
    mov al, bl
    jmp yazdir

carpma:
    mov al, bl
    mul bh
    mov bl, al
    mov al, bl
    jmp yazdir

bolme:
    mov al, bl
    mov ah, 0
    div bh
    mov bl, al
    mov al, bl
    jmp yazdir

yazdir:
    add al, '0' ; Sonucu yazdiriyor
    mov ah, 02h
    mov dl, al
    int 21h
    jmp bitis

bitis:
    mov ah, 4Ch
    int 21h


Assemblyle yapabileceginiz seyler hakkinda
Isletim sistemi
https://wiki.osdev.org/Expanded_Main_Page
https://github.com/mig-hub/mikeOS Bu acik kaynak kodlu isletim sistemini minciklayarak ogrenebilirsiniz

Linux Assembly
https://www.youtube.com/watch?v=VQAKkuLL31g&list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn
https://github.com/armut/x86-Linux-Assembly-Examples

Binary Exploitation
https://www.youtube.com/watch?v=iyAyN3GFM7A&list=PLhixgUqwRTjxglIswKp9mpkfPNfHkzyeN
https://ctf101.org/binary-exploitation/overview/

Oyun
https://www.youtube.com/watch?v=RhsaakpatqI&list=PLvpbDCl_H7mfgmEJPl1bTHlH5g-f0kWDM&index=1
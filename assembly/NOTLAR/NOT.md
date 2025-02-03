Başlangıç (ORG 0100H ve JMP start)
assembly
Kodu kopyala
ORG 0100H

JMP start
ORG 0100H: Programın bellekteki başlangıç adresini 0100H olarak belirler.
JMP start: Programı start etiketine yönlendirir, yani kodun ana başlama noktasına atlar.
Sabit Tanımlamalar (EQU)
assembly
Kodu kopyala
newline                EQU 0AH   ; \n
cret                   EQU 0DH   ; \r
bcksp                  EQU 08H   ; \b
EQU direktifi, sembolik sabitleri tanımlar. Örneğin, newline sembolik sabiti 0AH değerine eşitlenmiştir, bu da yeni satır karakterini temsil eder.
Hardcoded String Tanımlaması
assembly
Kodu kopyala
hardcoded_string       DB      'Selam! Bu sifrelenmis bi mesajdir', cret, newline, '$'
DB (Define Byte) komutuyla hardcoded_string isimli bir sabit karakter dizisi tanımlanmıştır.
Dizinin içinde sabit bir metin (Selam! Bu sifrelenmis bi mesajdir), ardından cret (0DH) ve newline (0AH) karakterleri bulunur.
Dizinin sonunda $ karakteri, dizi sonunu belirtir.
Mesaj Dizileri
assembly
Kodu kopyala
message_welcome        DB      newline, 'Monoalfabetik sifreleme sistemine hosgeldinieeeaaaz! ', cret, newline
                       DB      'lutfen nasil islenicegini sec:', cret, newline
                       DB      '1- input string (max: 256 chars)', cret, newline
                       DB      '2- hard string kullan xd', cret, newline, '$'
message_welcome ve diğer mesaj dizileri, kullanıcıya gösterilecek metinleri içerir.
Her bir metin DB komutuyla tanımlanmıştır. Metinler arasında cret ve newline gibi kontrol karakterleri bulunur.
Her bir metin sonunda $ karakteri dizinin sonunu belirtir.
Program Başlangıcı (start Etiketi)
assembly
Kodu kopyala
start:
    LEA     DX, message_welcome
    MOV     AH, 09
    INT     21H
    MOV     AH, 0
    INT     16H
    CMP     AL, '2'        
    JE      use_hc
    CMP     AL, '1'        
    JNE     start
    CALL    get_input
    JMP     start_process
start etiketi, programın başlangıç noktasını belirtir.
message_welcome dizisi ekrana yazdırılır (INT 21H, AH=09 ile).
Kullanıcıdan girdi almak için INT 16H kullanılır.
Kullanıcının girdiği komutlara (1 veya 2) göre program farklı yollar izler (JE ve JNE komutları).
get_input çağrılır ve ardından start_process etiketine atlanır.
Hardcoded String Kullanımı (use_hc Etiketi)
assembly
Kodu kopyala
use_hc:
    LEA     DX, message_using_hc
    MOV     AH, 09
    INT     21H
    LEA     SI, hardcoded_string
    ; Devam eden işlemler...
use_hc etiketi, hardcoded stringin kullanıldığı durumu başlatır.
message_using_hc dizisi ekrana yazdırılır.
hardcoded_string adresi SI register'ına atanır, bu şekilde hardcoded string üzerinde işlemler yapılır.
Şifreleme ve Şifre Çözme İşlemleri
assembly
Kodu kopyala
start_process:
    ; Orjinal stringi ekrana yazdır
    LEA     DX, message_display_org
    MOV     AH, 09         
    INT     21H             
    LEA     DX, SI
    MOV     AH, 09          
    INT     21H             

    ; Şifreleme
    LEA     DX, message_encrypting
    MOV     AH, 09
    INT     21H
    MOV     AH, 1
    CALL    encrypt_decrypt

    ; Şifrelenmiş metni ekrana yazdır
    LEA     DX, message_display_enc
    MOV     AH, 09
    INT     21H
    LEA     DX, SI
    MOV     AH, 09
    INT     21H

    ; Şifre çözme
    LEA     DX, message_decrypting
    MOV     AH, 09
    INT     21H
    MOV     AH, 0
    CALL    encrypt_decrypt

    ; Çözülmüş metni ekrana yazdır
    LEA     DX, message_display_dec
    MOV     AH, 09
    INT     21H
    LEA     DX, SI
    MOV     AH, 09
    INT     21H
start_process etiketi, şifreleme ve şifre çözme işlemlerini içeren ana işlem döngüsünü başlatır.
İlk olarak orijinal string (SI register'ında) ekrana yazdırılır.
Ardından şifreleme (AH=1) ve şifre çözme (AH=0) işlemleri sırasıyla encrypt_decrypt prosedürüyle gerçekleştirilir.
Her işlemin ardından sonuç ekrana yazdırılır.
Tekrar Deneme ve Çıkış
assembly
Kodu kopyala
try_again:
    LEA     DX, message_try_again    
    MOV     AH, 09
    INT     21H
    MOV     AH, 0
    INT     16H
    CMP     AL, 'y'
    JE      start
    CMP     AL, 'n'
    JNE     try_again
try_again etiketi, kullanıcıya programı tekrar çalıştırmak veya çıkmak isteyip istemediğini sorar.
Kullanıcı y veya n tuşlarına basarak karar verir. y ise start etiketine atlanır, n ise program sonlandırılır.
Anahtar Bekleme
assembly
Kodu kopyala
; Herhangi bir tuşa basarak çıkış yapılmasını bekler
LEA     DX, message_press_key
MOV     AH, 09
INT     21H
MOV     AH, 0
INT     16H
RET
Programın sonunda kullanıcıdan herhangi bir tuşa basmasını bekler (INT 16H, AH=00 ile).
Bu şekilde Assembly dilindeki bu program, hardcoded string kullanarak basit bir monoalfabetik şifreleme ve çözme işlemi gerçekleştirir. Her adım, mesajlarla kullanıcıya durumu bildirir ve isteğe bağlı olarak tekrar çalıştırılabilir.




ORG 0100H: Programın bellekte hangi adresle başlayacağını belirler. Burada 0100H adresinden başlayacak demektir.

JMP start: Programın başlaması için start etiketine atlar. Başlangıç noktası start etiketidir.

EQU: Bu, sembolik sabitlerin tanımlandığı yerdir. Örneğin, newline EQU 0AH satırı, newline sembolünün 0AH değerine eşit olduğunu belirtir. Bu, yeni satır karakterinin ASCII kodudur.

DB: Bu, veri tanımlama komutudur. Bellekte veri saklamak için kullanılır. Örneğin, hardcoded_string DB 'Selam! Bu sifrelenmis bi mesajdir', cret, newline, '$' satırı, hardcoded_string isimli bir dizedir ve içinde metin, yeni satır (cret) ve satır sonu (newline) karakterleri bulunur.

LEA: Load Effective Address'ın kısaltmasıdır. Bir değişkenin veya etiketin bellek adresini yükler. Örneğin, LEA DX, message_welcome satırı, DX kaydına message_welcome etiketinin bellek adresini yükler.

MOV: Bir değeri başka bir yere (kayıt veya bellek konumu) kopyalamak için kullanılır. Örneğin, MOV AH, 09 satırı, AH kaydına 09 değerini atar.

INT 21H: Bu, 21H kesme çağrısı olarak bilinen bir DOS işletim sistemi servisidir. AH kaydındaki belirli bir işlev kodunu kullanarak işletim sistemine bir hizmet çağrısı yapar. Örneğin, INT 21H komutu, AH kaydındaki işlev koduna göre dosya işlemleri, ekran çıktıları vb. yapar.

CMP: İki değeri karşılaştırmak için kullanılır. Örneğin, CMP AL, '2' satırı, AL kaydındaki değeri '2' ile karşılaştırır.

JE, JNE, JMP: Koşullu ve koşulsuz atlama komutlarıdır. JE eşitse atla, JNE eşit değilse atla, JMP ise her zaman atlar.

CALL: Bir alt programı (prosedür veya alt rutin) çağırmak için kullanılır. Örneğin, CALL get_input satırı, get_input prosedürünü çağırır.

PUSH, POP: PUSH bir değeri yığına iter (stack), POP ise yığından (stack) değer çeker. Bu genellikle alt programlarda geçici değerler saklamak için kullanılır.

RET: Bir prosedürden (alt program) dönüş yapar.

Bu komutlar, assembly dilinde program akışını kontrol etmek, veri taşımak, işlem yapmak ve prosedürleri yönetmek için kullanılır. Assembly dilinde programlar genellikle donanım düzeyinde hızlı çalışma sağlar ve direkt olarak işlemci talimat setini kullanır.

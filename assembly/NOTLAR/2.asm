Bugün assembly dersleri konusunun 2. bölümünü yazıyorum hemen baslayalim
Memoydeki adrese veri girmek
Assembly dilinde direk memorydeki belli bir adresi göstermek için köşeli parantezleri kullanırız
örnek:
Kod Seç
mov [0x00E0], 0x1234


Bu resimdede gördüğümüz gibi 00E isimli adrese veri girilmis oldu
Eğer biz burda mov yerine movb kullansaydık 1 bytelık bir veri girmiş olurdu

şimdi bu memoryde adrese veri girmeyle ilgili örnek kodlara bakalım
Kod Seç
mov A, 0x00E0
mov [A] , 0x1234
Burda a registerine istedigimiz belleğin adresini veriyoruz ve köseli parantezleri kullanarak o adresin icine verimizi giriyoruz


Kod Seç
mov A,0x00E0
mov [A+2], 0x1234
Bu kodu calıstırdıgımızda 2 byte sonrasına yazdırıyor veriyi yani 0x00E0 yerine 0x00E2 yerine yazdırıyor

Hemen bu öğrendiklerimizle Hello World yazan bir program yazalım
Bu kodu calıstırmadan önce sağ üstten "Toggle right pane" isimli yeri açınız

Kod Seç Genişlet
jmp main
string:
    db "Hello World"
    db 0x00
main:
    mov A,string
    mov C,0x02E0
    loop:
        cmpb [A],0x00
        je end
        movb [C],[A]
        add a,1
        add c,1

        jmp loop
    end:
        hlt
Yukarıdaki kodu adım adım açıklayalım
Uyari: movb [C],[A] komudu gercek işlemcilerde yazamayız bu yüzden acmak icin sol üstteki "Config" yerinden Easy Mode isimli yeri kapayıp açabilirsiniz bazen anlayamıyabiliyor
Kod Seç
jmp main
string:
    db "Hello World"
    db 0x00
Burada direk jmp main diyoruz çünkü bir önceki derstede anlattığım gibi assemblyde komutlar hex değerlerine çevriliyor ve bizde bu komutlarlarla hex degerleri cakısmasın diye bu kodu calıstırmıyoruz ancak genede memorye yazılıyor bunlar.
db 0x00 dememizin sebebi de stringin bittiğini anlamamız için
Kod Seç
main:
    mov A,string
    mov C,0x02E0
Burda a registerine stringin basladıgı labeli yazıyoruz bildiginiz gibi assemblyde direk memory girmek yerine label girerek direk adresi gösterebiliyoruz


0x02E0 adresi memoryde yukarıda toggle right pane'de işaretlediğim kutucukları temsil ediyor
Kod Seç
loop:
        cmpb [A],0x00
        je end
        movb [C],[A]
        add a,1
        add c,1

        jmp loop
    end:
        hlt
Burayı zaten biliyorsunuz ama burda cmp yerine cmpb ve mov yerine movb yazdık çünkü mov komudu 2 bytelik veri taşır ancak movb boyutu sadece 1 byte.
Stacklere giris
Stackleri şöyle anlatayım bir tabak yığını düşünün üst üste binmiş ama siz burdan sadece en son eklenen tabağı alabiliyorsunuz ve en son bir tabak ekleyebiliyorsunuz
Assemblydede tam buna benzer şekilde memoryde bir adres seçiyoruz ve oraya veri veriyoruz sadece en son eklenen veriyi alabiliyoruz ve yeni bir veri biz ekleyebiliyoruz
Stackin bellekte hangi adreste olduğunu gösteren registere stack pointer denir yani kısa adiyla sp

push ve pop komudu:

push komudu adından anlasılacagı gibi stacke yeni veri ekler
pop komudu ise stackte en son eklenen veriyi ceker
kodla acıklayalım
Kod Seç
mov sp,0x00EF
push 0x1122
push 0x3344
push 0x5566

pop A
pop B
pop C


burda gördügünüz gibi 1122 3344 5566 değerlerini sırayla cekerek  a b c registerlarına ekledi ve hafızada belirttiğimiz yeri kırmızıyla işaretledi

Fonksiyonlara Giriş
Fonksiyonları şöyle izah edebiliriz bir kod düşünün o kodu kodumuzda sürekli kullanmamız gerekiyor eğerki biz bu kodu sürekli aynı şekilde yazarsak kodumuzun boyutu gereğinden fazla olur.
Bu gibi durumlarda devreye fonksiyonlar giriyor fonksiyonlar istedigimiz zaman çağırabileceğimiz kod parçacıklarıdır.

call ve ret komudu:

call komudu fonksiyon çağırmaya yarayan komuttur
ret komudu ise fonksiyonu cagırdıgımız zaman geri sonra calıstırılacak koda dönmeyi sağlar
Kod Seç
mov sp,0x00EF
call fonksiyon
mov A,1
hlt
fonksiyon:
    mov B,1
    ret
Bu kodun sonucunda b değerinin 1 a değerininde 1 olduğunu görebiliyoruz

Not: Fonksiyon işlemleri stack pointera adres atamamız gerekiyor çünkü fonksiyon işlemleri stack kullanıyor

Evet dostlar bu dersimizde burada bitmiştir bi sonraki derste daha somut bir örnek olan emu8086 isimli uygulamayla 8086 mimarisine giriş yapacağız.
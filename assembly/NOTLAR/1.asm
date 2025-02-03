bugün size assembly anlatacagım lafı uzatmadan baslayalım
assembly düşük seviyeli bir programlama dilidir assembly kodu yazarken işlemcinin nasıl çalıştığını daha rahat kavrayabilirsiniz
simdi bunun icin bi emulatore ihtiyacımız olacak ben şu websitedeki emulatoru kullanıyorum
https://asm-sim.web.app/

Emulatore genel bir bakis atalim

sol kısımda kodu yazma ve calistirma yerleri bulunuyor
sağ altta memory bulunuyor yazdığımız kodlar vs. hex türünde değerle burda

db komutu:
ilk işleyecegimiz komut db komutu olacak db komutu verdiginiz degeri direk hafızaya yazar
ornek:
Kod Seç
db 0x04
bu komudu yazıp assemble dedigimiz zaman memory kısmında 04 degerini görmüş olacağız


mov komutu:
bu komut verdigin degeri belirttiğin registera aktarır
örneğin:
Kod Seç
mov a,0x0001
Bu komut A registerine 1 değerini tasıyacaktır "Assemble" ve "Run" dediğimiz zaman göreceğiz
mov komutunu yazdıgımızda sagda memoryde 06 gibi degerler görüyoruz biz assemblyde mov gibi basit komutlar yazıyoruz çeşitli işlemler yapmak için ancak sağda memoryde daha farklı sayısal ifadeler var bizim assembly mov gibi komutları bilgisayarın anlayacagı sekilde hex degerine ceviriyor
yani mov a,0x0001 yazmakla
Kod Seç
db 0x06
db 0x00
db 0x00
db 0x01
yazmak arasında fark yoktur
mov komutunun devre id si 0x06 dır
Not: Burda 0x0001 yerine direk 1 şeklindede yazabilirsiniz

add komutu:
bu komut verdigimiz registerin degerine belirttigimiz sayıyı ekler
örneğin:
Kod Seç
mov A,0x0001
add A,1
A registerine 1 degerini ekliyor bunun sonucunda A registerinde 2 degeri oluyor

Instruction pointer nedir
Instruction pointer bir sonraki calısacak komudun bellekteki adresini tutar
Sağ üstte IP isimli kısım instruction pointerı temsil eder

Kod Seç
mov A,5
mov B,3
add A,4
add B,3
Böyle basit bir program yazalım ardından Assemble Dedikten sonra yavaş yavaş step diyelim gördüğünüz gibi IP değeri dörder dörder artıyor

jmp komudu:
bu komut aslında IP yi manipüle ederek kod içinde atlamalar yapmamızı sağlar
az önceki koddan yola çıkarak sonsuz defa a ve b registerine değer ekleyen bir kod yazalım



ben yavas yavas geldigimde add komudunun IP degerinin 0008 oldugunu görüyorum demekki IP yi 0x0008 seklinde degistirmeliyiz
Kod Seç
mov A,5
mov B,3
add A,4
add B,3
jmp 0x0008
evet bu programı calıstırdıgımızda siz programı kapatana dek a değerine 4 ve b degerine 3 eklemeye devam edecek

Label nedir:
az önce biz direk IP(Instruction pointer) degerini bulup yazıyoduk ama aslında assembly dilinde buna gerek yok çünkü labellar var
Kod Seç
mov A,5
mov B,3
loop:
	add A,4
	add B,3
	jmp loop
pythondaki gibi tabla yazmak zorunda degilsiniz havalı gözüksün diye tabla yazdım

Şartlı ifadelere giriş
şartlı ifadeler assemblyde cmp komuduyla yazılır
sağ üstte cmp komuduyla alakalı C ve Z flagları vardır
Eğer İkiside eşitse                  : C = 0 ,Z = 1
Eğer Birinci değer ikinciden büyükse : C = 0 ,Z = 0
Eğer Birinci değer ikinciden küçükse : C = 1 ,Z = 0
şimdi bu komudu nasıl kullanacagımızı örnekle öğrenelim
Kod Seç
mov A,1
cmp A,1
je program ; je eşitse anlamına gelir
hlt ; bu programi durduran koddur
program:
	mov D,1
verdigim kodda eğer a registeri 1 e eşitse direk program isimli labela atlar ve program durmaz D registeri 1 olur
bu da benzer kosul islemleri daha fazlasına bakmak için sağ en üstten "Docs" bölümüne gidebilirsiniz

ja : büyükse
jae: büyükse yada eşitse
jb : küçükse
jbe: küçükse yada eşitse

Not : ";" yorum satırı anlamına gelir biraz gec ogrendik ama olsun

şimdi bu öğrendiklerimizle A registerine 3 defa 3 ekleyen bir program yazıp dersimizi bitirelim

Kod Seç
loop:
	cmp c,10
	je end

	add a,3
	add c,1

	jmp loop
end:
	hlt
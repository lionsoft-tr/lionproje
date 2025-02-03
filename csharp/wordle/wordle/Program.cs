using System;
using System.Collections.Generic;
using System.IO;

namespace wordle
{
    class Program
    {
        static Random random = new Random();
        static List<char> harfler = new List<char>();//kendi yazdıgımız kelimedeki harfler
        static List<char> harfler2 = new List<char>();//5 harfli kelimedeki harfler
        static List<string> besharfli = new List<string>();//5 harfli kelimelerin verisini tutar
        static int bitirici = 0;//5 kelimenın kacını dogru buldugumuzu verisini tutar
        static string kelime;//tahmin ettiğimiz kelime
        static void Main(string[] args)
        {
            string yol = "5harfv2.txt";//kullanıcı/source/repos/wordle/bin/debug/5harfv2.txt
            string dosya = File.ReadAllText(yol);//5 harfli kelimelerin hepsini txt den koda aktarır
            string[] rowdata = dosya.Split(',');//aralarındaki virgülü silip tüm 5 harfli kelimeleri array haline getirir
            for (int i = 0; i < rowdata.Length; i++)//bunlarıda daha kolay kullanabılmemız veya List de bulunan ozellıkler ıcın liste aktarırız
            {
                besharfli.Add(rowdata[i]);//0. 1. 2. .... tüm kelimeler aktarılır
            }
            int sec = random.Next(0, 280);//289 tane kelime vardı sanırsam ama riske atmamak ıcın 280 yazdım gectım(0 ve 280 arasından sayı secer)
            string secılıkelıme = besharfli[sec];//bes harfli kelimelerin bulundugu listeden rastgele bir kelime seçer(0 ve 280 arasında)
            foreach (var item in secılıkelıme)
            {
                harfler2.Add(char.ToLower(item));//secılen kelimeleri harflerine ayırır(kendi yazdıgımız kelimenin 1. harfiyle bu kelımenın 1. harfı aynımı vs. diye) ve tüm harfleri küçük yapar(neden olmasın)
            }
            harfler2.Remove(harfler2[0]);//bu hata yuzunden 30-45 dakkam gitti. neden bilmiyorum ama listedeki kelimeleri alırken program 1 kez bosluk bırakıp 1 kez de satr atlamıs programda bunu okurken 1.elemanı bosluk elemanı olan \r iknci elemanı satır atlama 
            harfler2.Remove(harfler2[0]);//elemanı olan \n diye okumus ılk harfımızde 3.eleman olarak gozukmus yanı kendı yazdıgımız kelimedeki 1. elemanı yanlıslıkla \r a esıt olup olmadıgınıa bakıyomus 2.elemanıda aynı sekılde o yuzden asla esıt olmuyolardı ve kazanamıyoduk
            Console.WriteLine("kelime bulma uygulamasına hos geldınız.");
            Console.WriteLine("bir kelime girin...");
            for (int i = 0; i < 6; i++)//kullanıcıya 6 hak veriyoruz
            {
                if (bitirici < 5)//eğer birbirine eşit olan harf sayısı 5 ten azsa ve dongudeki i değeri 6 değilse yeniden deneme hakkı
                {
                    kelimegir();
                }
                if(bitirici == 5)//eğer tahmin ettiği kelimedeki 1. harf bizim 1. harfimizle 2. 2.yle vs. tüm harfler bırbırıne esıt yanı kelıme aynıysa oyunu bıtırıyoruz
                {
                    kazandın();
                }
            }
            if(bitirici < 5)//eğer dongu bıttıyse 6 hakta harcanmssa ve hala bulunamamıssa oyun bıtıyor
            {
                kaybettin();
            }
        }
        static void kelimegir()//burdakı ıslemlerı 6 kez yapcagımızdan 6 kez yazmak veya donguya alıp 6 kez calıstırmak gıbı bişey yapıp kafam karıscagna ve kod kotu gozukmesın dıye metoda alıp dongude cagırdım
        {
            bitirici = 0;//oyun basladıgında bırbırıne esıt kelıme sayısını 0 a esıtlıyoruz
            Console.ForegroundColor = ConsoleColor.White;
            kelime = Console.ReadLine();
            foreach (var item in kelime)
            {
                harfler.Add(item);//yazılan kelimeyi harflere ayırıp listeye aktarıyoruz
            }
            if (harfler[0] == harfler2[0])//yazılan kelimedeki 1. harfle bizim kelimemizdeki 1. harf dogrumu dıye bakıyoruz
            {
                Console.ForegroundColor = ConsoleColor.Green;//eğer aynıysa o harfi yazmadan once konsulu yesıl yapıp harfı yazıyoruz
                Console.Write(harfler[0]); bitirici++;//ikiside birbirine eşit oldugundan bulunan kelıme sayısı 1 artıyo
            }
            else//eğer esıt değillerse o harfın bu kelımede olup olunmadıgına bakılıyor
            {
                for (int i = 0; i < 5; i++)
                {
                    if (i == 0)
                    {
                        continue;//zaten yazdıgımız kelimedeki 0. harfe baktık yine 0. harfe bakmaması ıcın donguyu burda bıtırıyore ve en basa geri atıyoruz
                    }
                    if (harfler[0] == harfler2[i])//eğer 0.harf 4. harfe eşitse rengi sarı yapıp ekrana yazıyoruz
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.Write(harfler[0]);
                        break;//eğer harf kelimenin baska yerınde varsa sarı yapıp donguyu kırıyoruz
                    }
                    if (i > 3)//eğer en son denememizdede yoksa harfi beyaz bı sekılde yazıyoruz
                    {
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write(harfler[0]);
                    }
                }
                
            }
            if (harfler[1] == harfler2[1])//aynı sey 1.harfe yapıyoz
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.Write(harfler[1]); bitirici++;
            }
            else
            {
                for (int i = 0; i < 5; i++)
                {
                    if (i == 1)
                    {
                        continue;
                    }
                    if (harfler[1] == harfler2[i])
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.Write(harfler[1]);
                        break;
                    }
                    if (i > 3)
                    {
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write(harfler[1]);
                    }
                }

            }
            if (harfler[2] == harfler2[2])//2. harfe
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.Write(harfler[2]); bitirici++;
            }
            else
            {
                for (int i = 0; i < 5; i++)
                {
                    if (i == 2)
                    {
                        continue;
                    }
                    if (harfler[2] == harfler2[i])
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.Write(harfler[2]);
                        break;
                    }
                    if (i > 3)
                    {
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write(harfler[2]);
                    }
                }

            }
            if (harfler[3] == harfler2[3])//3. harfe
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.Write(harfler[3]); bitirici++;
            }
            else
            {
                for (int i = 0; i < 5; i++)
                {
                    if (i == 3)
                    {
                        continue;
                    }
                    if (harfler[3] == harfler2[i])
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.Write(harfler[3]);
                        break;
                    }
                    if (i > 3)
                    {
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write(harfler[3]);
                    }
                }

            }
            if (harfler[4] == harfler2[4])//4.harfe
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.Write(harfler[4]); bitirici++;
            }
            else
            {
                for (int i = 0; i < 5; i++)
                {
                    if (i == 4)
                    {
                        if (i > 3)
                        {
                            Console.ForegroundColor = ConsoleColor.White;
                            Console.Write(harfler[4]);
                        }
                        continue;
                    }
                    if (harfler[4] == harfler2[i])
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.Write(harfler[4]);
                        break;
                    }
                }
            }
            Console.WriteLine();//burdaki komut sayesınde yazdıgım kelıme ıle cevap olan kelıme konsol ekranında yan yana degıl alt sartırda oluyor
            harfler.Clear();//kendi yazdıgımız kelimenin oldugu listeyi temizliyor ve yeni kelime ıcın yer acıyoruz
        }
        static void kazandın()//kazanınca bu fonksiyona geliyoruz
        {
            Console.ForegroundColor= ConsoleColor.White;
            Console.WriteLine("tebrikler oyun bitti");
            Console.ReadLine();
            bitirici++;
        }
        static void kaybettin()//kaybedincede bu fonksiyona
        {
            Console.ForegroundColor = ConsoleColor.White;
            Console.WriteLine("kaybettiniz yeniden başlamak için herhangi bir tuşa basınız");
            Console.ReadLine();
        }
    }
}

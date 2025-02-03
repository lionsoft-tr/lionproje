using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace kelime_bulma
{
    class Program
    {
        static Random random = new Random();
        static string kelimealıcı;
        static bool kelimebulundu;
        static int bölüm = 0;
        static List<char> harfler1 = new List<char>() { 'a', 's', 'ı', 'y' };
        static List<string> kelimeler1 = new List<string>() { "yasa", "ay", "yas" }; static int kelimeler1sayı = 3;
        static void Main(string[] args)
        {
            Console.WriteLine("kelime bulma uygulamasına hoşgeldin");
            gameplay();
            Console.ReadLine();
        }
        static void gameplay()
        {
            Console.WriteLine(bölüm + ". bölüm");
            foreach (var item in kelimeler1)
            {
                Console.Write("1 kelime " + item.Length + " harflidir ");
            }
            Console.WriteLine("harfler : ");
            foreach (var item in harfler1)
            {
                Console.Write(item);
                Console.Write(" ");
            }
            Console.WriteLine("kelime giriniz.");

            for (int i = 0; i < kelimeler1sayı - 1; i++)
            {
                for (int j = 0; j < 2; j++)
                {
                    if (j > 0)
                    {
                        Console.WriteLine("kelime giriniz.");
                    }
                    kelimebulundu = false;
                    kelimealıcı = Console.ReadLine();
                    kelimedoğrulama(kelimealıcı);
                    if (kelimebulundu == true)
                    {
                        j = 3;
                        Console.WriteLine("doğru kelime!");
                    }
                    else
                    {
                        j = 0;
                        Console.WriteLine("yanlış kelime");
                    }
                }

            }
        }

        static void kelimedoğrulama(string kelime)
        {
            for (int i = 0; i < kelimeler1.Count; i++)
            {
                if(kelime == kelimeler1[i])
                {
                    kelimebulundu = true;
                    kelimeler1.Remove(kelimeler1[i]);
                }
            }
        }
    }
}

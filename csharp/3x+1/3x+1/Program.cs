using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _3x_1
{
    internal class Program
    {
        static List<Int64> bolunmesayısı = new List<Int64>();
        static List<Int64> kacıncıbolunen = new List<Int64>();
        static int kacadet = 0 ;
        static Int64 bastakısayı = 0;
        static void Main(string[] args)
        {
            Int64 maxBolunme = 0;
            Int64 maxBolunenSayi = 0;
            for (Int64 i = 1; i < Int64.MaxValue; i++)
            {
                bolme(i);
                if (kacadet > maxBolunme) // Eğer bu sayı şu ana kadar en çok bölünen sayıysa
                {
                    maxBolunme = kacadet;
                    maxBolunenSayi = bastakısayı;
                }
                kacadet = 0;
            }
            Console.WriteLine($"En çok bölünen sayı: {maxBolunenSayi} ve bu sayı {maxBolunme} kez bölündü.");
            Console.ReadLine();
        }
        static void bolme(Int64 sayı)
        {
            bastakısayı = sayı;
            while(sayı != 1)
            {
                if (sayı % 2 == 0)
                {
                    sayı = sayı / 2;
                }
                else
                {
                    sayı = sayı * 3 + 1;
                }
                kacadet++;
            }
            bolunmesayısı.Add(kacadet);kacıncıbolunen.Add(bastakısayı);
        }
    }
}

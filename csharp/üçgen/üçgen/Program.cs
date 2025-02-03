using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace üçgen
{
    internal class Program
    {//2 kenarın karesinin toplamı nın hipotenüse eşit oludugundan,bu iki karenin 0 dan 100 e kadar kac tane deger alınca karelerının toplamı hıpotenus eder
        static int kenar1 = 0; static int kenar2 = 0; static double hipotenüs = 0; static int kontrol = 0; static int hipotenüssayısı = 0;
        static void Main(string[] args)
        {
            sayılarıdeneme();
            Console.ReadLine();
        }
        static void sayılarıdeneme()
        {
            for (int i = 1; i < 100; i++)
            {
                for (int j = 1; j < 100; j++)
                {
                    kenar1 = i; kenar2 = j;
                    hipotenüs = Math.Sqrt(Math.Pow(Convert.ToDouble(kenar1), 2) + Math.Pow(Convert.ToDouble(kenar2), 2));
                    kontrol = Convert.ToInt32(hipotenüs);
                    if (hipotenüs == kontrol)
                    {
                        hipotenüssayısı++;
                        Console.WriteLine("kenar 1 : " + kenar1 + " kenar 2 : " + kenar2 + " = " + hipotenüs);
                    }
                }
            }
            Console.WriteLine(hipotenüssayısı);
        }
    }
}

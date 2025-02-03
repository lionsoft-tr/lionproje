using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace asalsayılar
{
    class Program
    {
        //static List<int> bölenler = new List<int>();
        static bool a;
        static List<double> asallar = new List<double>();
        static void Main(string[] args)
        {
            //2 nin üstü olan sayılara x ekleyince hengi üstleri asal olur ve kaç tane
            int x = 1;
            for (double i = 2; i < 20; i++)
            {
                double f = Math.Pow(2, i) + x;
                asalmakinesi(f);
            }
            foreach (var item in asallar)
            {
                Console.WriteLine(item);
            }
            Console.ReadLine();
        }
        static void asalmakinesi(double sayı)
        {
            a = false;
            for (int i = 0; i < sayı; i++)
            {
                if(i != 1)
                {
                    if(i != 0)
                    {
                        if (i != sayı)
                        {
                            if(sayı % i == 0)
                            {
                                //bölenler.Add(i);
                                a = true;
                            }
                        }
                    }
                    
                }
            }
            if(a == false)
            {
                asallar.Add(sayı);
            }
        }
    }
}

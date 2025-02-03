using System;
using System.IO;
using System.Security.Cryptography;

namespace cybersecurity
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Please enter a username:");
            string username = Console.ReadLine();

            Console.WriteLine("Please enter a password:");
            string password = Console.ReadLine();

            //Generate the key and IV
            byte[] key = new byte[16];//şifreleme için rastgele anahtarlar oluşturuyoruz tek anahtar riskli o yüzden çoklu anahtar kulklanıyoruz

            byte[] iv = new byte[16];//innosilation vectır (aşılama vektörü)

            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(key);//rastgele anahtar ve aşılama vektörü alıyoruz
                rng.GetBytes(iv);
            }

            //Encrypt the password
            byte[] encryptedPassword = Encrypt(password, key, iv);
            string encryptedPasswordString = Convert.ToBase64String(encryptedPassword);
            Console.WriteLine("Encrypted password: " + encryptedPasswordString);

            //Decrypt the password
            string decryptedPassword = Decrypt(encryptedPassword, key, iv);
            Console.WriteLine("Decrypted password: " + decryptedPassword);
            Console.ReadLine();
        }
        static string Decrypt(byte[] cipheredtext, byte[] key, byte[] iv)
        {
            string simpletext = String.Empty;
            using (Aes aes = Aes.Create())
            {
                ICryptoTransform decryptor = aes.CreateDecryptor(key, iv);
                using (MemoryStream memoryStream = new MemoryStream(cipheredtext))
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader streamReader = new StreamReader(cryptoStream))
                        {
                            simpletext = streamReader.ReadToEnd();
                        }
                    }
                }
            }
            return simpletext;
        }
        static byte[] Encrypt(string simpletext, byte[] key, byte[] iv)
        {
            byte[] cipheredtext;
            using (Aes aes = Aes.Create())
            {
                ICryptoTransform encryptor = aes.CreateEncryptor(key, iv);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    using (CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter streamWriter = new StreamWriter(cryptoStream))
                        {
                            streamWriter.Write(simpletext);
                        }

                        cipheredtext = memoryStream.ToArray();
                    }
                }
            }
            return cipheredtext;
        }
    }
}

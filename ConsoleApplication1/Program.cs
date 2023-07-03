using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = @"d:\temp\test.txt";
//--take  both again with a merge into 3 from 1
//--<<<<<<< HEAD
            int b3 = 3; //added line after branch
//--=======
//take both lines
//<<<<<<< HEAD
//-->>>>>>> b1
            int b2 = 2;         // line from b2 off master
//=======
            int b1 = 1; // fresh branch off of master
//>>>>>>> f9729f8 (added line to b1 after branch from master)

            System.IO.FileStream fs = new System.IO.FileStream(path, System.IO.FileMode.Open);
            byte[] data = new byte[(int)fs.Length];
            fs.Read(data, 0, (int)fs.Length);
            fs.Close();
            fs.Dispose();

            System.Security.Cryptography.SHA1CryptoServiceProvider sha1 = new System.Security.Cryptography.SHA1CryptoServiceProvider();
            byte[] theHash = sha1.ComputeHash(data);

            Console.Write("the hash is ");
            
            foreach (byte b in theHash)
                Console.Write(string.Format("{0:x2} ", b));

            Console.WriteLine();

            UnicodeEncoding u = new UnicodeEncoding();
            Console.WriteLine("hash in string form is " + Convert.ToBase64String(theHash));

            Console.ReadLine();
            return; 
        }
    }
}

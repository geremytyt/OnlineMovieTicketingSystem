using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace MovieTicketingSystem
{
    public class Security
    {
        public static String GetHash(string strPass)
        {
            //convert string into byte array
            byte[] binPass = Encoding.Default.GetBytes(strPass);

            //SHA hash algorithm
            SHA256 sha = SHA256.Create();

            //convert ori binPass to binPass in hashed format
            byte[] binHash = sha.ComputeHash(binPass);

            //convert has in bin> string
            string strHash = Convert.ToBase64String(binHash);

            return strHash;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ZXing;
using System.Drawing;
using ZXing.QrCode;
using System.IO;
using System.Drawing.Imaging;
using System.Data.SqlClient;
using System.Configuration;

namespace MovieTicketingSystem
{
    public static class QrCode
    {
        private static string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        public static void GenerateQrCode(string paymentNo)
        {
            // Get the QR code image as a byte array
            var writer = new BarcodeWriter
            {
                Format = BarcodeFormat.QR_CODE,
                Options = new QrCodeEncodingOptions
                {
                    Width = 300,
                    Height = 300,
                    Margin = 0
                }
            };
            var qrCode = writer.Write($"Payment Number: {paymentNo}");
            var stream = new MemoryStream();
            
            qrCode.Save(stream, ImageFormat.Png);
            var qrCodeBytes = stream.ToArray();


            // Update the payment record in the database with the QR code image
            SqlConnection connection = new SqlConnection(cs);
            
            connection.Open();
            SqlCommand command = new SqlCommand("UPDATE Payment SET qrCode = @qrCode WHERE paymentNo = @paymentNo", connection);
                
            command.Parameters.AddWithValue("@qrCode", qrCodeBytes);
            command.Parameters.AddWithValue("@paymentNo", paymentNo);
            command.ExecuteNonQuery();

            connection.Close();
                
        }

    }
}
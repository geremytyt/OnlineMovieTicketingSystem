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

            // Generate a unique filename based on the payment number
            string filename = $"qr_{paymentNo}.png";
            
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
            string filepath = Path.Combine(baseDirectory, "Image/qrCodes", filename);

            // Save the QR code image to disk
            var qrCode = writer.Write($"Payment Number: {paymentNo}");
          
            qrCode.Save(filepath, ImageFormat.Png);

            // Save the URL of the image file to the qrCode column in the database
            SqlConnection connection = new SqlConnection(cs);
            connection.Open();
            SqlCommand command = new SqlCommand("UPDATE Payment SET qrCode = @qrCode WHERE paymentNo = @paymentNo", connection);
            command.Parameters.AddWithValue("@qrCode", $"~/Image/qrCodes/{filename}");
            command.Parameters.AddWithValue("@paymentNo", paymentNo);
            command.ExecuteNonQuery();
            connection.Close();
        }




    }
}
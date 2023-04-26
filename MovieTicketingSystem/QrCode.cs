using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ZXing;
using System.Drawing;
using ZXing.QrCode;
using System.IO;
using System.Drawing.Imaging;

namespace MovieTicketingSystem
{
    public static class QrCode
    {
        public static byte[] GenerateQrCode(string purchaseNumber)
        {
            // Generate the QR code
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
            var qrCode = writer.Write($"Purchase Number: {purchaseNumber}");

            // Save the QR code image to a file
            var filePath = "~/Image/qrCodes/qrCode1.png";
            qrCode.Save(HttpContext.Current.Server.MapPath(filePath), ImageFormat.Png);

            // Read the QR code image from the file and convert it to a byte array
            using (var stream = new MemoryStream())
            {
                using (var fileStream = File.OpenRead(HttpContext.Current.Server.MapPath(filePath)))
                {
                    fileStream.CopyTo(stream);
                }
                return stream.ToArray();
            }
        }

    }
}
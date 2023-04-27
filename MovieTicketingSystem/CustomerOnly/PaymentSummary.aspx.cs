using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using MailKit.Net.Smtp;
using MailKit;
using MimeKit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MailKit.Security;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class PaymentSummary : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //get info from previous page
                //string paymentNo = Request.QueryString["paymentNo"];
                string paymentNo = "T0001";
                

                //Retrieve payment details from database
                string paymentQuery = "SELECT paymentNo, purchaseNo, paymentDateTime, paymentAmount, cardNo, status FROM Payment WHERE paymentNo = @paymentNo";
          

                SqlConnection connection = new SqlConnection(cs);       
                connection.Open();

                // Retrieve payment details
                SqlCommand paymentCommand = new SqlCommand(paymentQuery, connection);
                paymentCommand.Parameters.AddWithValue("@paymentNo", paymentNo);
                SqlDataReader paymentReader = paymentCommand.ExecuteReader();

                if (paymentReader.Read())
                {
                    // Populate the payment details labels
                    lblStatus.Text = paymentReader["status"].ToString();
                    lblPaymentNo.Text = paymentNo;
                    lblPurchaseNo.Text = paymentReader["purchaseNo"].ToString();
                    lblPaymentDateTime.Text = DateTime.Parse(paymentReader["paymentDateTime"].ToString()).ToString("d/M/yyyy H:m:ss");
                    lblPaymentAmount.Text = string.Format("RM{0:#,##0.00}", paymentReader["paymentAmount"]);
                    lblCardNo.Text = paymentReader["cardNo"].ToString();
     
                    paymentReader.Close();               
                }
                
            }
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            // Get the custID from session
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();
            string custName = "";
            string custEmail = "";

            //if (cookie != null)
            //{
            //    string sql = "SELECT custName, custEmail FROM Customer WHERE custId = @custId";
            //    SqlConnection con = new SqlConnection(cs);
            //    SqlCommand cmd = new SqlCommand(sql, con);
            //    con.Open();
            //    cmd.Parameters.AddWithValue("@custId", custId);
            //    SqlDataReader dr = cmd.ExecuteReader();

            //    custName = dr["custName"].ToString();
            //    custEmail = dr["custEmail"].ToString();

            //    dr.Close();
            //    con.Close();
            //}


            // Generate the QR code byte array
            var qrCodeBytes = QrCode.GenerateQrCode("P0002");

            var apiKey = "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";

            // Create a new SendGrid client
            var client = new SendGridClient(apiKey);

            // Create a new email message
            var from = new EmailAddress("leeyw-pm20@student.tarc.edu.my", "Starlight Cinema");
            var to = new EmailAddress("geremytanyentsen@gmail.com", "Staff");
            var subject = "Payment Confirmation";
            var plainTextContent = "Payment has been made";
            var htmlContent = $@" Thank you for your purchase!Here are your payment details.<br><br>
                          Payment Number: {lblPaymentNo.Text}<br>
                          Purchase Number: {lblPurchaseNo.Text}<br>
                          Payment Date and Time: {lblPaymentDateTime.Text}<br>
                          Payment Amount: {lblPaymentAmount.Text}<br>
                          Card Number: {lblCardNo.Text}<br><br>
                          
                          Scan the QR code for purchase number";

            // Convert the QR code byte array to a base64 string
            var qrCodeBase64 = Convert.ToBase64String(qrCodeBytes);

            // Attach the QR code to the email message
            var attachment = new Attachment
            {
                Content = qrCodeBase64,
                Filename = "qrCode.png",
                Type = "image/png",
                Disposition = "attachment"
            };
            var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);
            msg.AddAttachment(attachment);

            // Send the email message
            var response = client.SendEmailAsync(msg).Result;

            // Check the response status code
            if (response.StatusCode == System.Net.HttpStatusCode.Accepted)
            {
                // Email sent successfully
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Payment confirmation email has been sent');", true);
            }


            //Reset Ticket and Cart Session
            //Session.Remove("Cart");
            //Session.Remove("Ticket");

            Response.Redirect("~/Annonymous/Home.aspx");
        }
    }
}

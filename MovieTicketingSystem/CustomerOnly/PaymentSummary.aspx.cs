using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
//using MailKit.Net.Smtp;
//using MailKit;
//using MimeKit;
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
            //var qrCodeBytes = QrCode.GenerateQrCode("P0002");

            // Attach the QR code to an email and send it
            //var message = new MimeMessage();
            //message.From.Add(new MailboxAddress("StarLight Cinema", "geremytyt-pm20@student.tarc.edu.my"));
            //message.To.Add(new MailboxAddress(custName, "geremytanyentsen@gmail.com"));
            //message.Subject = "Purchase Summary";

            //var builder = new BodyBuilder();
            //builder.HtmlBody = $@"<p>Thank you for your purchase! Here are your payment details.</p>
            //                  <p>Payment Number: {lblPaymentNo.Text}</p>
            //                  <p>Purchase Number: {lblPurchaseNo.Text}</p>
            //                  <p>Payment Date and Time: {lblPaymentDateTime.Text}</p>
            //                  <p>Payment Amount: {lblPaymentAmount.Text}</p>
            //                  <p>Card Number: {lblCardNo.Text}</p>
            //                  <br>
            //                  <p><em>Scan the QR code for purchase number</em></p>";

            //builder.Attachments.Add("qrCode.png", qrCodeBytes, new ContentType("image", "png"));

            //message.Body = builder.ToMessageBody();

            //using (var client = new SmtpClient())
            //{
            //    client.Connect("smtp-relay.sendinblue.com", 587, false);
            //    client.Authenticate("geremytanyentsen@gmail.com", "yXs5nbHImU4VJkEh");
            //    client.Send(message);
            //    client.Disconnect(true);
            //}


            //Reset Ticket and Cart Session
            //Session.Remove("Cart");
            //Session.Remove("Ticket");

            Response.Redirect("~/Annonymous/Home.aspx");
        }
    }
}

﻿using System;
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
using MovieTicketingSystem.Model;
using System.Net;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class PaymentSummary : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Get the customer cart from session
                List<CartItem> cart = (List<CartItem>)HttpContext.Current.Session["Cart"];
                List<Ticket> tickets = (List<Ticket>)HttpContext.Current.Session["Tickets"];


               
                //get all the details of movie selected
                if(tickets != null)
                {
                    Schedule s = (Schedule)Session["schedule"];
                    HttpCookie cookie2 = Request.Cookies["movieName"];
                    string scheduleDateTime = s.scheduleDateTime.ToString();
                    string[] dateTimeParts = scheduleDateTime.Split(' ');
                    lblShowingDate.Text = dateTimeParts[0];
                    lblShowingTime.Text = dateTimeParts[1];
                    lblMovie.Text = cookie2.Value;

                    string seatNos = "";
                    int count = 0;
                    foreach (Ticket ticket in tickets)
                    {
                        seatNos += ticket.seatNo.ToString() + ",";
                        count++;
                        if (count == 3)
                        {
                            seatNos += "<br /> ";
                            count = 0;
                        }
                    }
                    lblSeatNo.Text = seatNos.TrimEnd(',').Trim();
                }
                else
                {
                    movieDetails.Visible = false;
                }
                
                //get food purchase info
                if (cart != null)
                {
                    rptCartItems.DataSource = cart;
                    rptCartItems.DataBind();
                   
                }
                else
                {
                    cartDetails.Visible = false;
                }

                //get info from previous page
                string paymentNo = Request.QueryString["paymentNo"];
                try
                {
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
                catch (SqlException)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                }


            }
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            List<CartItem> cart = (List<CartItem>)HttpContext.Current.Session["Cart"];
            // Get the custID from session
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();
            string custName = "";
            string custEmail = "";

            //Get customer email and name to send email

            if (custId != null)
            {
                try
                {
                    string sql = "SELECT custName, custEmail FROM Customer WHERE custId = @custId";
                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@custId", custId);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        custName = dr["custName"].ToString();
                        custEmail = dr["custEmail"].ToString();
                    }

                    dr.Close();
                    con.Close();
                }
                catch (SqlException)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                }

            }


            string paymentNo = Request.QueryString["paymentNo"];
         
            var apiKey = "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";

            // Create a new SendGrid client
            var client = new SendGridClient(apiKey);

            string foodPurchased = "";

            if (cart != null)
            {
                foreach (CartItem item in cart)
                {
                    foodPurchased += item.menuName + ", ";
                }
            }

            // Remove the trailing comma and space
            foodPurchased = foodPurchased.TrimEnd(',', ' ');

            // Create a new email message
            var from = new EmailAddress("leeyw-pm20@student.tarc.edu.my", "Starlight Cinema");
            var to = new EmailAddress(custEmail, custName);
            var subject = "Payment Confirmation";
            var plainTextContent = "Payment has been made";
            var htmlContent = $@" Thank you for your purchase! Here are your purchase details.<br><br>
                          Payment Number: {lblPaymentNo.Text}<br>
                          Purchase Number: {lblPurchaseNo.Text}<br>
                          Payment Date and Time: {lblPaymentDateTime.Text}<br>
                          Payment Amount: {lblPaymentAmount.Text}<br><br>
                          Movie: {lblMovie.Text}<br>
                          Showing Date: {lblShowingDate.Text}<br>
                          Showing Time: {lblShowingTime.Text}<br>
                          Seat(s): {lblSeatNo.Text}<br>
                          Food Purchased: {foodPurchased}<br>
                          
                          
                          Scan the QR code for purchase number";

            // Generate the QR code for the payment number
            QrCode.GenerateQrCode(paymentNo);

            // Generate the QR code for the payment number
            QrCode.GenerateQrCode(paymentNo);

            try
            {
                // Retrieve the file path of the QR code image from the database
                SqlConnection connection = new SqlConnection(cs);
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT qrCode FROM Payment WHERE paymentNo = @paymentNo", connection);
                command.Parameters.AddWithValue("@paymentNo", paymentNo);
                string qrCodePath = command.ExecuteScalar().ToString();
                connection.Close();


            // Read the contents of the file into a byte array
            byte[] qrCodeBytes = File.ReadAllBytes(Server.MapPath(qrCodePath));

            // Convert the byte array to a base64 string
            string base64String = Convert.ToBase64String(qrCodeBytes);

            // Attach the QR code to the email message as a base64 string
            var attachment = new Attachment
            {
                Content = base64String,
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
            }
            catch (SqlException)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
            }

            //Reset Ticket and Cart Session
            Session.Remove("Cart");
            Session.Remove("Tickets");
            Session.Remove("Schedule");

            Response.Redirect("~/Annonymous/Home.aspx");
        }
        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}

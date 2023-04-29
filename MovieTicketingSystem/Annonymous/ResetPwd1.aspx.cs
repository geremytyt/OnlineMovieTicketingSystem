using MovieTicketingSystem.Model;
using SendGrid.Helpers.Mail;
using SendGrid;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class ResetPwd1 : System.Web.UI.Page
    {
        string cs = Global.cs;
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnToken_Click(object sender, EventArgs e)
        {

            string email = txtEmail.Text;
            Customer c = db.Customers.SingleOrDefault(
            cust => cust.custEmail== email && cust.custStatus !="Suspended");
            if (c != null)
            {
                string token = generateToken();
                string destination = "https://localhost:44377/Annonymous/ResetPwd2.aspx?email=" + txtEmail.Text + "&token=" + token;
                var apiKey = "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";

                // Create a new SendGrid client
                var client = new SendGridClient(apiKey);

                // Create a new email message
                var from = new EmailAddress("leeyw-pm20@student.tarc.edu.my", "Starlight Cinema");
                var to = new EmailAddress(txtEmail.Text, c.custName);
                var subject = "Password Reset Request at Starlight Cinema";
                var plainTextContent = "Password Reset Token from Starlight Cinema";
                var htmlContent = "<div><h1>Password Reset</h1>\n<p>Hi there,</p>\n<p>You recently requested to reset your password. To do so, please click on the button below:</p>\n<p><a href=" + destination + "><button>Reset Password</button></a></p>\n<p>If you did not make this request, please ignore this message.</p>\n<p>Thanks,<br>Starlight Cinema</p></div>";
                var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);

                // Send the email message
                var response = client.SendEmailAsync(msg).Result;

                // Check the response status code
                if (response.StatusCode == System.Net.HttpStatusCode.Accepted)
                {
                    // Email sent successfully
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('The token is sent. Please check your email.');", true);
                }
                else
                {
                    // Email failed to send
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('The token is not sent. Please retry.'); window.location.href='../Annonymous/ResetPwd1.aspx';", true);
                }
            }
            else
            {
                cvEmail.IsValid = false;
            }

        }

        private string generateToken()
        {
            var random = new Random();
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var randomString = new string(Enumerable.Repeat(chars, 6)
                .Select(s => s[random.Next(s.Length)]).ToArray());
            string expiryDate = DateTime.Now.AddMinutes(5).ToString("yyyy-MM-ddTHH:mm:ssZ");

            string token = randomString + "/" + expiryDate;

            string email = txtEmail.Text;
            string hash = Security.GetHash(token);
            string sql = "UPDATE Customer SET custToken=@token WHERE custEmail=@email";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@token", token);
            cmd.Parameters.AddWithValue("@email", email);

            cmd.ExecuteNonQuery();

            con.Close();

            return hash;
        }

    }
}
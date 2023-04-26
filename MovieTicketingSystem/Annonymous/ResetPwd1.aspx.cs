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
            User u = db.Users.SingleOrDefault(
            user => user.Username == email && user.Role == "Customer");
            if (u != null)
            {
                string token = generateToken();
                string destination = "https://localhost:44377/Annonymous/ResetPassword2.aspx?token=" + token;
                var apiKey = "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";

                // Create a new SendGrid client
                var client = new SendGridClient(apiKey);

                // Create a new email message
                var from = new EmailAddress("leeyw-pm20@student.tarc.edu.my", "Starlight Cinema");
                var to = new EmailAddress(txtEmail.Text, "Customer");
                var subject = "Reset your Password";
                var plainTextContent = "Here is your token";
                var htmlContent = "Reset your password " + "<a href=" + destination + ">here</a>";
                var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);

                // Send the email message
                var response = client.SendEmailAsync(msg).Result;

                // Check the response status code
                if (response.StatusCode == System.Net.HttpStatusCode.Accepted)
                {
                    // Email sent successfully
                    Response.Redirect("ResetPassword2.aspx");
                }
                else
                {
                    // Email failed to send
                    Response.Redirect("ResetPassword1.aspx");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('The token is not sent. Please retry.');", true);
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

            string token = randomString + "/" + txtEmail.Text + "/" + expiryDate;

            string email = txtEmail.Text;
            string hash = Security.GetHash(token);
            string sql = "UPDATE Customer SET signature=@signature WHERE custEmail=@email";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@signature", hash);
            cmd.Parameters.AddWithValue("@email", email);

            cmd.ExecuteNonQuery();

            con.Close();

            return token;
        }

    }
}
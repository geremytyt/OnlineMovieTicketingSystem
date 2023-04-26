using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class StaffResetPwd2 : System.Web.UI.Page
    {
        string cs = Global.cs;
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            string token = Request.QueryString["token"];
            if (token != null)
            {
                string hash = Security.GetHash(token);
                Customer c = db.Customers.SingleOrDefault(
                customer => customer.signature == hash);
                if (c != null)
                {
                    string[] details = token.Split('/');
                    if (Convert.ToDateTime(details[2]) < DateTime.Now)
                    {
                        Response.Redirect("StaffResetPwd1.aspx");
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your token has expired. Please try again.');", true);
                    }
                }

            }
            else
            {

            }
        }
        protected void btnToken_Click(object sender, EventArgs e)
        {
            string email = Request.QueryString["token"].Split('/')[1];
            string text = txtPassword.Text;
            string password = Security.GetHash(text);
            string sql = "UPDATE Staff SET staffPassword=@Password WHERE staffEmail=@email";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("StaffLogin.aspx");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your password has been reset.');", true);
        }
    }
}
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
            string email = Request.QueryString["email"];
            if (token != null && email != null)
            {
                string hash = Security.GetHash(token);
                Staff s = db.Staffs.SingleOrDefault(
                staff => staff.staffEmail == email);
                if (s != null)
                {
                    if (Security.GetHash(s.staffToken) == token)
                    {
                        if (Convert.ToDateTime(s.staffToken.Split('/')[1]) < DateTime.Now)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your token has expired. Please try again.');window.location.href='../Annonymous/StaffResetPwd1.aspx';", true);
                        }
                    }
                }

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Invalid token.');window.location.href='../Annonymous/StaffResetPwd1.aspx';", true);
            }
        }
        protected void btnToken_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = Request.QueryString["email"];
                string text = txtNewPwd.Text;
                string password = Security.GetHash(text);
                try
                {
                    string sql = "UPDATE Staff SET staffPassword=@Password, staffToken=@token WHERE staffEmail=@email";

                    SqlConnection con = new SqlConnection(cs);

                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@token", DBNull.Value);
                    cmd.Parameters.AddWithValue("@Password", password);

                    cmd.ExecuteNonQuery();

                    con.Close();
                }
                catch (SqlException)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                }


                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your password has been reset.');window.location.href='../Annonymous/StaffLogin.aspx';", true);
            }
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
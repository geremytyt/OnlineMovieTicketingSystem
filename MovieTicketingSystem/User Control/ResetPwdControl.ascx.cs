using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.User_Control
{
    public partial class ResetPwdControl : System.Web.UI.UserControl
    {
        string cs = Global.cs;
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            HttpCookie cookie = null;
            if (Page.User.IsInRole("Customer"))
            {
                cookie = Request.Cookies["Customer"];
            }
            else if (Page.User.IsInRole("Staff") || Page.User.IsInRole("Manager")) {
                cookie = Request.Cookies["Staff"];
            }
            if (cookie != null)
            {
                string oldPassword = txtOldPwd.Text;
                string hash = Security.GetHash(oldPassword);
                if (Page.User.IsInRole("Customer"))
                {
                    Customer c = db.Customers.SingleOrDefault(
                    user => user.custId == cookie.Value.ToString() &&
                    user.custPassword == hash
                    );
                    if (c != null)
                    {
                        string password = Security.GetHash(txtCfmPwd.Text);
                        string sql = "UPDATE Customer SET custPassword=@Password WHERE custId=@Id";

                        SqlConnection con = new SqlConnection(cs);

                        con.Open();

                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@Id", cookie.Value.ToString());
                        cmd.Parameters.AddWithValue("@Password", password);

                        cmd.ExecuteNonQuery();

                        con.Close();
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your password has been reset successfully');", true);
                    }
                    else { 
                        cvNotFound.IsValid= false;
                    }
                }else if (Page.User.IsInRole("Staff") || Page.User.IsInRole("Manager"))
                {
                    Staff s = db.Staffs.SingleOrDefault(
                    user => user.staffId == cookie.Value.ToString() &&
                    user.staffPassword == hash);
                    if (s != null)
                    {
                        string password = Security.GetHash(txtCfmPwd.Text);
                        string sql = "UPDATE Staff SET staffPassword=@Password WHERE staffId=@Id";

                        SqlConnection con = new SqlConnection(cs);

                        con.Open();

                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@Id", cookie.Value.ToString());
                        cmd.Parameters.AddWithValue("@Password", password);

                        cmd.ExecuteNonQuery();

                        con.Close();
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your password has been reset successfully');", true);
                    }
                    else {
                        cvNotFound.IsValid = false;
                    }
                }
            }
        }
    }
}
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
            HttpCookie cookie = Request.Cookies["Customer"];
            if (cookie != null)
            {
                string oldPassword = txtOldPwd.Text;
                string hash = Security.GetHash(oldPassword);
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
                }
            }
        }
    }
}
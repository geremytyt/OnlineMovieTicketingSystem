using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.Annonymous
{
    public partial class ResetPassword2 : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnToken_Click(object sender, EventArgs e)
        {
            string email = Request.QueryString["email"] ?? "";
            string text = txtPassword.Text;
            string password = Security.GetHash(text);
            string sql = "UPDATE Customer SET custPassword=@Password WHERE custEmail=@email";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("Login.aspx");
        }
    }
}
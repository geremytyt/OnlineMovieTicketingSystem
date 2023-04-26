using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class StaffResetPassword : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["Staff"];
            if (cookie != null)
            {
                string sql = "SELECT * FROM Staff WHERE staffId = @id";
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();
                cmd.Parameters.AddWithValue("@id", cookie.Value.ToString());
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    imgPreview.ImageUrl = dr[7].ToString();
                }
                dr.Close();
                con.Close();
            }
        }
        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("StaffProfile.aspx");
        }

        protected void btnResetPwd_Click(object sender, EventArgs e)
        {
            Response.Redirect("StaffResetPassword.aspx");
        }
    }
}
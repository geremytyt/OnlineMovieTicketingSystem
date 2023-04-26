using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class MoviePurchase : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool found = false;
            string id = Request.QueryString["movieId"] ?? "";
            if (!IsPostBack)
            {    
                string sql = "SELECT * FROM movie WHERE movieId = @Id";
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    found = true;
                    txtMovie.Text = dr["movieName"].ToString();
                }
                if (!found)
                {
                    Response.Redirect("~/Annonymous/Home.aspx");
                }
            }
        }
        protected void btnNext_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["movieId"] ?? "";
            string number = ddlTime.SelectedValue;
            Response.Redirect(String.Format("MovieSeatSelection.aspx?scheduleNo={0}&movieId={1}", number, id));
        }

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            HttpCookie cookie = Request.Cookies["Slide"];
            if (cookie != null)
            {
                string slideIndex = id.Substring(id.Length - 3);
                cookie.Expires = DateTime.Now.AddHours(3);
                cookie.Value = slideIndex;
                Response.Cookies.Add(cookie);
            }

            Response.Redirect("MoviePurchase.aspx?movieId=" + id);
        }
    }
}
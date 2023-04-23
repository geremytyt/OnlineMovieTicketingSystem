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
    public partial class Movie : System.Web.UI.Page
    {
        private List<DateTime> dates = new List<DateTime>();
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool found = false;
            string id = Request.QueryString["movieId"];
            if (String.IsNullOrEmpty(id))
            {
                Response.Redirect("Home.aspx");
            }
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
                    lbMovieName.Text = dr["movieName"].ToString();
                    imgPoster.ImageUrl = dr["posterURL"].ToString();
                }
                if (!found)
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }
        protected void btnNext_Click(object sender, EventArgs e)
        {
            string url = String.Format("MovieSeatSelection.aspx?scheduleNo={0}&movieId={1}", ddlDate.SelectedValue, Request.QueryString["movieId"]);
            Response.Redirect(url);
        }
    }
}
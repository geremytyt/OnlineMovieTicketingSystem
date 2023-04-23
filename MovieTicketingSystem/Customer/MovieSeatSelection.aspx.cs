using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem
{
    public partial class MovieSeatSelection : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool found=false;
            string id = Request.QueryString["movieId"];
            if (String.IsNullOrEmpty(id))
            {
                Response.Redirect("Home.aspx");
            }
            string scheduleNo = Request.QueryString["scheduleNo"];
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
                dr.Close();
                sql = "SELECT * FROM schedule WHERE scheduleNo = @Num";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Num", scheduleNo);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    found= true;
                    lbHall.Text = dr["hallNo"].ToString();
                    lbDateTime.Text = dr["scheduleDateTime"].ToString();
                }
                if (!found)
                {
                    Response.Redirect("Home.aspx");
                }
                dr.Close();
                con.Close();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Response.Redirect("Food.aspx");
        }
    }
}
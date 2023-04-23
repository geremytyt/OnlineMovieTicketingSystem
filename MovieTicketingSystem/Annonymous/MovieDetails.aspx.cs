using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class MovieDetails : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString; 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bool found = false;
                string id = Request.QueryString["movieId"] ?? "";
                string url = "";
                string sql = "SELECT * FROM Movie WHERE (movieId = @id)";
                //step 3 : establish connection
                SqlConnection con = new SqlConnection(cs);
                //step 4 sql command
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    found= true;
                    DateTime date = DateTime.Parse(dr["releaseDate"].ToString());
                    lbMovieName.Text = dr["movieName"].ToString();
                    lbReleaseDate.Text = date.ToString("yyyy-MM-dd");
                    lbDuration.Text = dr["movieDuration"].ToString();
                    lbGenre.Text = dr["genre"].ToString();
                    lbLanguage.Text = dr["language"].ToString();
                    lbSynopsis.Text = dr["synopsis"].ToString();
                    lbActor.Text = dr["actor"].ToString();
                    lbDirector.Text = dr["director"].ToString();
                    lbClassification.Text = dr["ageRating"].ToString();
                    imgMoviePoster.ImageUrl = ResolveUrl(dr["posterURL"].ToString());
                    url = dr["trailerURL"].ToString();
                    btnBuy.CommandArgument = id;
                }
                if (!found)
                {
                    Response.Redirect("Home.aspx");
                }
                string iframehtml = string.Format("<iframe src='{0}' frameborder='0' class='embed-responsive embed-responsive-4by3' allow='autoplay; gyroscope; picture-in-picture; encrypted-media' allowfullscreen></iframe>", url);
                LiteralControl iframecontrol = new LiteralControl(iframehtml);
                pnlVideoPreview.Controls.Clear();
                pnlVideoPreview.Controls.Add(iframecontrol);
            }
           
        }

        protected void btbBuy_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Response.Redirect("~/Customer/Movie.aspx?movieId=" + id);
        }
    }
}
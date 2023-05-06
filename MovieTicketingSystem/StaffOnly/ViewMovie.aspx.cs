using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ViewMovie : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bool found = false;
                string id = Request.QueryString["movieId"] ?? "";
                try { 
                string sql = "SELECT * FROM movie WHERE movieId = @Id";
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {

                    found = true;
                    DateTime date = DateTime.Parse(dr["releaseDate"].ToString());
                    DateTime endDate = DateTime.Parse(dr["endDate"].ToString());
                    txtMovieId.Text = id;
                    txtMovieName.Text = dr["movieName"].ToString();
                    txtDate.Text = date.ToString("dd/MM/yyyy");
                    txtEndDate.Text = endDate.ToString("dd/MM/yyyy");
                    txtDuration.Text = String.Format("{0} hrs {1} mins", Convert.ToInt32(dr["movieDuration"]) / 60, Convert.ToInt32(dr["movieDuration"]) % 60);
                    txtGenre.Text = dr["genre"].ToString();
                    txtLanguage.Text = dr["language"].ToString();
                    txtSynopsis.Text = dr["synopsis"].ToString();
                    txtActor.Text = dr["actor"].ToString();
                    txtDirector.Text = dr["director"].ToString();
                    txtAge.Text = dr["ageRating"].ToString();
                    posterImage.ImageUrl = ResolveUrl(dr["posterURL"].ToString());
                    txtMovieURL.Text = dr["trailerURL"].ToString();
                    slideImageView.ImageUrl = ResolveUrl(dr["slideURL"].ToString());
                }
                dr.Close();
                con.Close();
                }
                catch (SqlException ex)
                {
                    // Handle the exception and display an error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                }
                if (!found)
                {
                    Response.Redirect("StaffMovie.aspx");
                }
                string url = txtMovieURL.Text.Trim();
                string iframeHtml = string.Format("<iframe src='{0}' frameborder='0' class='embed-responsive embed-responsive-4by3' allow='autoplay; gyroscope; picture-in-picture; encrypted-media' allowfullscreen></iframe>", url);
                LiteralControl iframeControl = new LiteralControl(iframeHtml);
                pnlVideoPreview.Controls.Clear();
                pnlVideoPreview.Controls.Add(iframeControl);
            }

        }

        protected void btnModify_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditMovie.aspx?movieId=" + Request.QueryString["movieId"]);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Response.Redirect("StaffMovie.aspx");
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
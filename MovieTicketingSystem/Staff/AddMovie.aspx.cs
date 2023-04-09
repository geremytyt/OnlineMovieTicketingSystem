using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class AddMovie : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string movieId = txtMovieId.Text;
            string movieName = txtMovieName.Text;
            string actor = txtActor.Text;
            string director = txtDirector.Text;
            DateTime date = DateTime.Parse(txtDate.Text);
            int duration = 0;
            if(txtDuration.Text.Length > 0)
            {
                duration = Convert.ToInt32(txtDuration.Text);
            }
            string synopsis = txtSynopsis.Text;
            string trailerURL = txtMovieURL.Text;
            string fileUrl = "";
            string ageRating = ddlAge.SelectedValue.ToString();
            string language = ddlLanguage.SelectedValue.ToString();
            string genre = ddlGenre.SelectedValue.ToString();

            if (posterFile.HasFile)
            {
                string fileName = Path.GetFileName(posterFile.PostedFile.FileName);
                string filePath = Server.MapPath("~/Image/posterImages/" + fileName);
                posterFile.SaveAs(filePath);
                fileUrl = ResolveUrl("~/Image/posterImages/" + fileName);
            }
            else
            {
                fileUrl = imageView.ImageUrl;
            }
            string sql = "INSERT INTO Movie (movieId, movieName, releaseDate, movieDuration, genre, language, synopsis, actor, director, ageRating, posterURL, trailerURL) VALUES (@id,@name,@date,@duration,@genre,@language,@synopsis,@actor,@director,@age,@posterUrl,@trailerUrl)";
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@age", ageRating);
            cmd.Parameters.AddWithValue("@name", movieName);
            cmd.Parameters.AddWithValue("@id", movieId);
            cmd.Parameters.AddWithValue("@date", date.ToString("yyyy/MM/dd"));
            cmd.Parameters.AddWithValue("@duration", duration);
            cmd.Parameters.AddWithValue("@genre", genre);
            cmd.Parameters.AddWithValue("@language", language);
            cmd.Parameters.AddWithValue("@synopsis", synopsis);
            cmd.Parameters.AddWithValue("@actor", actor);
            cmd.Parameters.AddWithValue("@director", director);
            cmd.Parameters.AddWithValue("@posterUrl", fileUrl);
            cmd.Parameters.AddWithValue("@trailerUrl", trailerURL);
            con.Open();
            int row = cmd.ExecuteNonQuery();
            if (row >= 1)
            {
                Response.Redirect("StaffMovie.aspx");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Server.Transfer("AddMovie.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("StaffMovie.aspx");
        }
    }
}
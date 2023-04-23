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
            if (Page.IsValid)
            {
                string movieName = txtMovieName.Text;
                string actor = txtActor.Text;
                string director = txtDirector.Text;

                DateTime releaseDate = DateTime.Parse(txtDate.Text);
                DateTime endDate = DateTime.Parse(txtEndDate.Text);
                int duration = 0;
                if (txtDuration.Text.Length > 0)
                {
                    duration = Convert.ToInt32(txtDuration.Text);
                }
                string synopsis = txtSynopsis.Text;
                string trailerURL = txtMovieURL.Text;
                string ageRating = ddlAge.SelectedValue.ToString();
                string language = ddlLanguage.SelectedValue.ToString();
                string genre = ddlGenre.SelectedValue.ToString();
                string posterFileUrl = checkFile(posterFile, "~/Image/posterImages/");
                string slideFileUrl = checkFile(slideFile, "~/Image/slideImages/");

                string sql = "INSERT INTO Movie (movieName, releaseDate,endDate, movieDuration, genre, language, synopsis, actor, director, ageRating, posterURL, trailerURL, slideURL) VALUES (@name,@releaseDate,@endDate,@duration,@genre,@language,@synopsis,@actor,@director,@age,@posterUrl,@trailerUrl,@slideUrl)";
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@age", ageRating);
                cmd.Parameters.AddWithValue("@name", movieName);
                cmd.Parameters.AddWithValue("@releaseDate", releaseDate.ToString("yyyy/MM/dd"));
                cmd.Parameters.AddWithValue("@endDate", endDate.ToString("yyyy/MM/dd"));
                cmd.Parameters.AddWithValue("@duration", duration);
                cmd.Parameters.AddWithValue("@genre", genre);
                cmd.Parameters.AddWithValue("@language", language);
                cmd.Parameters.AddWithValue("@synopsis", synopsis);
                cmd.Parameters.AddWithValue("@actor", actor);
                cmd.Parameters.AddWithValue("@director", director);
                cmd.Parameters.AddWithValue("@posterUrl", posterFileUrl);
                cmd.Parameters.AddWithValue("@slideUrl", slideFileUrl);
                cmd.Parameters.AddWithValue("@trailerUrl", trailerURL);
                con.Open();
                int row = cmd.ExecuteNonQuery();
                if (row >= 1)
                {
                    Response.Redirect("StaffMovie.aspx");
                }
            }

        }

        private string checkFile(FileUpload file, string path)
        {
            string fileUrl;
            if (file.HasFile)
            {
                string fileName = Path.GetFileName(file.PostedFile.FileName);
                string filePath = Server.MapPath(path + fileName);
                file.SaveAs(filePath);
                fileUrl = ResolveUrl(path + fileName);
            }
            else
            {
                if (file.ID == "posterFile")
                {
                    fileUrl = imageView.ImageUrl;
                }
                else
                {
                    fileUrl = slideImageView.ImageUrl;
                }
            }
            return fileUrl;
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
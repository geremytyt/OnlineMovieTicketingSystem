using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class EditMovie : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bool found = false;
                string id = Request.QueryString["movieId"] ?? "";
                string sql = "SELECT * FROM movie WHERE movieId = @Id";
                try { 
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    found = true;
                    txtMovieID.Text = id;
                    DateTime date = DateTime.Parse(dr["releaseDate"].ToString());
                    if(dr["endDate"].ToString() != "")
                    {
                        DateTime endDate = DateTime.Parse(dr["endDate"].ToString());
                        txtEndDate.Text = endDate.ToString("yyyy-MM-dd");
                        txtDuration.Text = dr["movieDuration"].ToString();
                    }
                    txtMovieName.Text = dr["movieName"].ToString();
                    txtDate.Text = date.ToString("yyyy-MM-dd");
                    ddlGenre.SelectedValue = dr["genre"].ToString();
                    ddlLanguage.SelectedValue = dr["language"].ToString();
                    txtSynopsis.Text = dr["synopsis"].ToString();
                    txtActor.Text = dr["actor"].ToString();
                    txtDirector.Text = dr["director"].ToString();
                    ddlAge.SelectedValue = dr["ageRating"].ToString();
                    imageView.ImageUrl = ResolveUrl(dr["posterURL"].ToString());
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
            }
            string url = txtMovieURL.Text.Trim();
            string iframeHtml = string.Format("<iframe src='{0}' frameborder='0' class='embed-responsive embed-responsive-4by3' allow='autoplay; gyroscope; picture-in-picture; encrypted-media' allowfullscreen></iframe>", url);
            LiteralControl iframeControl = new LiteralControl(iframeHtml);
            trailerContainer.ContentTemplateContainer.Controls.Clear();
            trailerContainer.ContentTemplateContainer.Controls.Add(iframeControl);

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["movieId"] ?? "";
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
            string sql = "UPDATE Movie SET movieName = @name, releaseDate = @date, endDate = @endDate, movieDuration = @duration, genre = @genre, language = @language, synopsis = @synopsis, actor = @actor, ageRating = @age, posterURL = @posterUrl, trailerURL = @trailerUrl, slideURL = @slideUrl, director = @director WHERE  (movieId = @id)";
            try { 
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@age", ageRating);
            cmd.Parameters.AddWithValue("@name", movieName);
            cmd.Parameters.AddWithValue("@date", releaseDate.ToString("yyyy/MM/dd"));
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
                Response.Redirect("ViewMovie.aspx?movieId=" + id);
            }
            }
            catch (SqlException ex)
            {
                // Handle the exception and display an error message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
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
            Server.Transfer("EditMovie.aspx?movieId=" + Request.QueryString["movieId"]);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("StaffMovie.aspx");
        }

        protected void EndDateValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime startDate = DateTime.Parse(txtDate.Text);
            DateTime endDate = DateTime.Parse(txtEndDate.Text);
            if (startDate < endDate)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }

        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
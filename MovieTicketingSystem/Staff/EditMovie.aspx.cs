﻿using MovieTicketingSystem.Model;
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
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {

                    found = true;
                    DateTime date = DateTime.Parse(dr["releaseDate"].ToString());
                    txtMovieId.Text = id;
                    txtMovieName.Text = dr["movieName"].ToString();
                    txtDate.Text = date.ToString("yyyy-MM-dd");
                    txtDuration.Text = dr["movieDuration"].ToString();
                    ddlGenre.SelectedValue = dr["genre"].ToString();
                    ddlLanguage.SelectedValue = dr["language"].ToString();
                    txtSynopsis.Text = dr["synopsis"].ToString();
                    txtActor.Text = dr["actor"].ToString();
                    txtDirector.Text = dr["director"].ToString();
                    ddlAge.SelectedValue = dr["ageRating"].ToString();
                    imageView.ImageUrl = ResolveUrl(dr["posterURL"].ToString());
                    txtMovieURL.Text = dr["trailerURL"].ToString();
                }
                dr.Close();
                con.Close();
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
            string movieId = txtMovieId.Text;
            string movieName = txtMovieName.Text;
            string actor = txtActor.Text;
            string director = txtDirector.Text;
            DateTime date = DateTime.Parse(txtDate.Text); 
            int duration = 0;
            if (txtDuration.Text.Length > 0)
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
            string sql = "UPDATE Movie SET movieName = @name, releaseDate = @date, movieDuration = @duration, genre = @genre, language = @language, synopsis = @synopsis, actor = @actor, ageRating = @age, posterURL = @posterUrl, trailerURL = @trailerUrl,director = @director WHERE  (movieId = @id)";
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", movieId);
            cmd.Parameters.AddWithValue("@age", ageRating);
            cmd.Parameters.AddWithValue("@name", movieName);
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
            if(row >= 1)
            {
                Response.Redirect("ViewMovie.aspx?movieId=" + movieId);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Server.Transfer("EditMovie.aspx?movieId=" + Request.QueryString["movieId"]);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewMovie.aspx?movieId=" + Request.QueryString["movieId"]);
        }
    }
}
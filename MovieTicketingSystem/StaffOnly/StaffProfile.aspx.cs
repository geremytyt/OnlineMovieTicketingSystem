using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class StaffProfile : System.Web.UI.Page
    {
        movieDBEntities db = new movieDBEntities();
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie cookie = Request.Cookies["Staff"];
                if (cookie != null)
                {
                    try { 
                    string sql = "SELECT * FROM Staff WHERE staffId = @id";
                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@id", cookie.Value.ToString());
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        txtName.Text = dr[1].ToString().Trim();
                        txtEmail.Text = dr[2].ToString();
                        txtPhone.Text = dr[6].ToString();
                        txtIC.Text = dr[4].ToString();
                        Session["Phone"] = dr[6].ToString();
                        Session["IC"] = dr[4].ToString();
                        rblGender.SelectedValue = dr[5].ToString();
                        if (dr[7].ToString() != "") {
                            imgPreview.ImageUrl = dr[7].ToString();
                        }
                        txtPosition.Text = dr[8].ToString().Trim();
                    }
                    con.Close();
                    }
                    catch (SqlException ex)
                    {
                        // Handle the exception and display an error message
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                    }
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string exist = Session["IC"].ToString();
            if (exist != null)
            {
                if (exist != txtIC.Text)
                {
                    if (db.Staffs.Any(s => s.staffIC == txtIC.Text.Trim()))
                    {
                        //display error msg
                        cvExistIC.IsValid = false;
                    }
                }
            }
            exist = Session["Phone"].ToString();
            if (exist != null)
            {
                if (exist != txtPhone.Text)
                {
                    if (db.Staffs.Any(s => s.staffPhoneNo == txtPhone.Text.Trim()))
                    {
                        //display error msg
                        cvExistPhone.IsValid = false;
                    }
                }
            }
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png",".PNG",".JPEG",".JPG" };
            string fileUrl = null;
            HttpCookie cookie = Request.Cookies["Staff"];
            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                string fileExtension = Path.GetExtension(fileName);
                if (!allowedExtensions.Contains(fileExtension.ToLower()))
                {
                    cvImage.IsValid = false;
                }
                fileName = cookie.Value.ToString() + fileName.Substring(fileName.IndexOf(".")); ;
                string filePath = Server.MapPath("~/Image/staffImages/" + fileName);
                fileUpload.SaveAs(filePath);
                fileUrl = ResolveUrl("~/Image/staffImages/" + fileName);
            }
            else
            {
                fileUrl = imgPreview.ImageUrl;
            }
            if (Page.IsValid)
            {

                string name = txtName.Text;
                string phone = txtPhone.Text;
                string gender = rblGender.SelectedValue;
                string ic = txtIC.Text;
                try { 
                string sql = "UPDATE Staff SET staffName=@Name, staffPhoneNo=@Phone, staffGender=@Gender,staffIC=@IC, staffPhoto=@Photo WHERE staffId=@Id";

                SqlConnection con = new SqlConnection(cs);

                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", cookie.Value.ToString());
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@IC", ic);
                cmd.Parameters.AddWithValue("@Photo", fileUrl);

                cmd.ExecuteNonQuery();

                con.Close();
                }
                catch (SqlException ex)
                {
                    // Handle the exception and display an error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                }

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your profile has been edited successfully'); window.location.href='../StaffOnly/StaffProfile.aspx';", true);
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

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
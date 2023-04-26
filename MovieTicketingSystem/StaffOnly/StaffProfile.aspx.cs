using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
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
            HttpCookie cookie = Request.Cookies["Staff"];
            if (cookie != null)
            {
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
                    txtIC.Text =  dr[4].ToString();
                    rblGender.SelectedValue = dr[5].ToString();
                    imgPreview.ImageUrl = dr[7].ToString();
                    txtPosition.Text = dr[8].ToString().Trim();
                }
                con.Close();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (db.Staffs.Any(s => s.staffIC == txtIC.Text.Trim()))
            {
                //display error msg
                cvExistPhone.IsValid = false;
            }
            if (db.Staffs.Any(s => s.staffPhoneNo == txtPhone.Text.Trim()))
            {
                //display error msg
                cvExistPhone.IsValid = false;
            }
            if (Page.IsValid)
            {
                HttpCookie cookie = Request.Cookies["Staff"];
                string fileUrl = null;
                if (fileUpload.HasFile)
                {
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    fileName = cookie.Value.ToString() + fileName.Substring(fileName.IndexOf(".")); ;
                    string filePath = Server.MapPath("~/Image/staffImages" + fileName);
                    fileUpload.SaveAs(filePath);
                    fileUrl = ResolveUrl("~/Image/" + fileName);
                }
                else
                {
                    fileUrl = imgPreview.ImageUrl;
                }
  
                string name = txtName.Text;
                string phone = txtPhone.Text;
                string gender = rblGender.SelectedValue;
                string ic = txtIC.Text;
                string sql = "UPDATE Staff SET staffName=@Name, staffPhoneNo=@Phone, staffGender=@Gender,staffIC=@IC, staffPhoto=@Photo WHERE staffId=@Id";

                SqlConnection con = new SqlConnection(cs);

                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", cookie.Value.ToString());
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@IC", ic);
                cmd.Parameters.AddWithValue("@Photo", ".." + fileUrl);

                cmd.ExecuteNonQuery();

                con.Close();
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
    }
}
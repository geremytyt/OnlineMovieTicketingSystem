using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;


namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Profile : System.Web.UI.Page
    {
        movieDBEntities db = new movieDBEntities();
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDob.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
                HttpCookie cookie = Request.Cookies["Customer"];
                if (cookie != null)
                {
                    try
                    {
                        string sql = "SELECT * FROM Customer WHERE custId = @id";
                        SqlConnection con = new SqlConnection(cs);
                        SqlCommand cmd = new SqlCommand(sql, con);
                        con.Open();
                        cmd.Parameters.AddWithValue("@id", cookie.Value.ToString());
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            txtName.Text = dr[1].ToString().Trim();
                            txtEmail.Text = dr[2].ToString();
                            txtDob.Text = (Convert.ToDateTime(dr[4]).ToString("yyyy-MM-dd"));
                            txtPhone.Text = dr[5].ToString();
                            Session["Phone"] = dr[5].ToString();
                            rblGender.SelectedValue = dr[6].ToString();
                            imgPreview.ImageUrl = dr[7].ToString();

                        }
                        con.Close();
                    } catch (SqlException)
                    {       
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                    }
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string exist = Session["Phone"].ToString();
            if (exist != null)
            {
                if (exist != txtPhone.Text)
                {
                    if (db.Customers.Any(c => c.custPhoneNo == txtPhone.Text.Trim()))
                    {
                        //display error msg
                        cvExistPhone.IsValid = false;
                    }
                }
            }
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".PNG", ".JPEG", ".JPG" };
            HttpCookie cookie = Request.Cookies["Customer"];
            string fileUrl = null;
            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                string fileExtension = Path.GetExtension(fileName);
                if (!allowedExtensions.Contains(fileExtension.ToLower()))
                {
                    cvImage.IsValid = false;
                }
                fileName = cookie.Value.ToString() + fileName.Substring(fileName.IndexOf(".")); ;
                string filePath = Server.MapPath("~/Image/customerImages/" + fileName);
                fileUpload.SaveAs(filePath);
                fileUrl = ResolveUrl("~/Image/customerImages/" + fileName);
            }
            else
            {
                fileUrl = imgPreview.ImageUrl;
            }
            if (Page.IsValid) {
                string name = txtName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string gender = rblGender.SelectedValue.Trim();
                DateTime dob = DateTime.Parse(txtDob.Text);
                try { 
                string sql = "UPDATE Customer SET custName=@Name, custPhoneNo=@Phone, custGender=@Gender,custDob=@Dob, custPhoto=@Photo WHERE custId=@Id";

                SqlConnection con = new SqlConnection(cs);

                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", cookie.Value.ToString());
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@Dob", dob);
                cmd.Parameters.AddWithValue("@Photo", fileUrl);

                cmd.ExecuteNonQuery();

                con.Close();
                }
                catch (SqlException)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                }
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('Your profile has been edited successfully'); window.location.href='../CustomerOnly/Profile.aspx';", true);

            }


        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void btnTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect("Tickets.aspx");
        }

        protected void btnHistory_Click(object sender, EventArgs e)
        {
            Response.Redirect("History.aspx");
        }

        protected void btnResetPwd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ResetPassword.aspx");
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
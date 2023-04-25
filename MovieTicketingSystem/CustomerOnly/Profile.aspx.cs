using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Profile : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            Customer cust = (Customer)Session["Customer"];
            if (cust != null)
            {
                txtName.Text = cust.custName.ToString();
                txtEmail.Text = cust.custEmail.ToString();
                txtPhone.Text = cust.custPhoneNo.ToString();
                txtDob.Text = (Convert.ToDateTime(cust.custDob).ToString("yyyy-MM-dd"));
                rblGender.SelectedValue = cust.custDob.ToString();
                imgPreview.ImageUrl = cust.custPhoto.ToString();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string fileUrl = null;
            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = Server.MapPath("~/Image/" + fileName);
                fileUpload.SaveAs(filePath);
                fileUrl = ResolveUrl("~/Image/" + fileName);
            }
            else {
                fileUrl = imgPreview.ImageUrl;
            }
            string name = txtName.Text;
            string phone = txtPhone.Text;
            string gender = rblGender.SelectedValue;
            DateTime dob = DateTime.Parse(txtDob.Text);
            string sql = "UPDATE Customer SET custName=@Name, custPhoneNo=@Phone, custGender=@Gender,custDob=@Dob, custPhoto=@Photo WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", "C001");
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@Dob", dob);
            cmd.Parameters.AddWithValue("@Photo", ".." + fileUrl);

            cmd.ExecuteNonQuery();

            con.Close();

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
    }
}
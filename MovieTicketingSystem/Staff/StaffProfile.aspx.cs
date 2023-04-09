using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class StaffProfile : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sql = "SELECT TOP 1 * FROM Staff";
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtName.Text = dr[1].ToString();
                    txtEmail.Text = dr[2].ToString();
                    txtPhone.Text = dr[6].ToString();
                    txtIC.Text =  dr[4].ToString();
                    rblGender.SelectedValue = dr[5].ToString();
                    imgPreview.ImageUrl = dr[7].ToString();
                    txtPosition.Text = dr[8].ToString();
                }
                con.Close();
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
            cmd.Parameters.AddWithValue("@Id", "S001");
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@IC", ic);
            cmd.Parameters.AddWithValue("@Photo", ".." + fileUrl);

            cmd.ExecuteNonQuery();

            con.Close();

        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            string password = Security.GetHash(TextBox3.Text);
            string sql = "UPDATE Staff SET staffPassword=@Password WHERE staffId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", "S001");
            cmd.Parameters.AddWithValue("@Password", password);

            cmd.ExecuteNonQuery();

            con.Close();
        }
    }
}
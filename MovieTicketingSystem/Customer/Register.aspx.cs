using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.View
{
    public partial class Register : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string generateID()
        {
            string sql = "SELECT TOP 1 * FROM Customer ORDER BY custId DESC";
            string id = "";
            int count = 0;
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read()) {
                count = int.Parse((dr[0].ToString().Substring(1,3))) +1;
                id = "C" + count.ToString("000");
            }

            con.Close();

            return id;
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string id = generateID();
            if (Page.IsValid)
            {

                string name = txtName.Text;
                string email = txtEmail.Text;
                string password = txtPassword.Text;
                string phone = txtPhone.Text;
                DateTime dob = Convert.ToDateTime(txtDob.Text);
                string gender = rblGender.SelectedValue.Substring(0,1);

                string sql = "INSERT INTO Customer (custId, custName, custEmail, custPassword, custPhoneNo,  custDob, custGender, custStatus) VALUES (@Id, @Name, @Email, @Password, @PhoneNo, @Dob, @Gender, @Status)";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@PhoneNo", phone);
                cmd.Parameters.AddWithValue("@Dob", dob);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@Status", "Active");

                con.Open();

                cmd.ExecuteNonQuery();

                con.Close();

                Response.Redirect("Login.aspx");
            }
        }
    }
}
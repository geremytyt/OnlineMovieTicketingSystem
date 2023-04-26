using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Security.Policy;

namespace MovieTicketingSystem.Annonymous
{
    public partial class Register : System.Web.UI.Page
    {
        movieDBEntities db = new movieDBEntities();
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            txtDob.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
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

            if (dr.Read())
            {
                count = int.Parse((dr[0].ToString().Substring(1, 3))) + 1;
                id = "C" + count.ToString("000");
            }
            dr.Close();
            con.Close();

            return id;
        }

        private void validateAll() {
            //Check for duplicated email
            if (db.Users.Any(u => u.Username == txtEmail.Text))
            {
                //display error msg
                cvExistEmail.IsValid = false;
            }
            //Check for duplicated phone
            if (db.Customers.Any(c => c.custPhoneNo == txtPhone.Text))
            {
                //display error msg
                cvExistPhone.IsValid = false;
            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            validateAll();
            string id = generateID();
            if (Page.IsValid)
            {

                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string phone = txtPhone.Text.Trim();
                DateTime dob = Convert.ToDateTime(txtDob.Text);
                string gender = rblGender.SelectedValue.Substring(0, 1);
                string hash = Security.GetHash(password);

                
                string sql = "INSERT INTO Customer (custId, custName, custEmail, custPassword, custPhoneNo,  custDob, custGender, custStatus) VALUES (@Id, @Name, @Email, @Password, @PhoneNo, @Dob, @Gender, @Status)";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", hash);
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
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Manager
{
    public partial class ManageStaff : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
 
        }

        private string generateID()
        {
            string sql = "SELECT TOP 1 * FROM Staff ORDER BY staffId DESC";
            string id = "";
            int count = 0;
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                count = int.Parse((dr[0].ToString().Substring(1, 3))) + 1;
                id = "S" + count.ToString("000");
            }

            con.Close();

            return id;
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtEmail.ReadOnly = true;
            btnDelete.Enabled = true;
            btnEdit.Enabled = true;
            btnAdd.Enabled = false;
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowIndex == GridView1.SelectedIndex)
                {
                    lblId.Text = row.Cells[0].Text;
                    txtName.Text = row.Cells[1].Text;
                    txtEmail.Text = row.Cells[2].Text;
                    txtPhone.Text = row.Cells[4].Text;
                    txtIC.Text = row.Cells[3].Text;
                    rblGender.SelectedValue = row.Cells[5].Text;

                }

            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string name = txtName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string gender = rblGender.SelectedValue.Substring(0, 1);
            string ic = txtIC.Text;
            string sql = "UPDATE Staff SET staffName=@Name, staffPhoneNo=@Phone, staffGender=@Gender,staffIC=@ic WHERE staffId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@ic", ic);

            cmd.ExecuteNonQuery();

            con.Close();
            Response.Redirect("ManageActiveStaff.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string sql = "UPDATE Staff SET staffStatus=@Status WHERE staffId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Status", "Resigned");

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("ManageActiveStaff.aspx");
        }

        protected void btnResigned_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageResignedStaff.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string id = generateID();
            if (Page.IsValid)
            {
                string name = txtName.Text;
                string email = txtEmail.Text;
                string phone = txtPhone.Text;
                string ic = txtIC.Text;
                string gender = rblGender.SelectedValue.Substring(0, 1);

                string sql = "INSERT INTO Staff (staffId, staffName, staffEmail, staffPassword, staffPhoneNo, staffIC , staffGender, staffStatus, position) VALUES (@Id, @Name, @Email, @Password, @PhoneNo, @IC, @Gender, @Status, @position)";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", Security.GetHash("admin123"));
                cmd.Parameters.AddWithValue("@PhoneNo", phone);
                cmd.Parameters.AddWithValue("@IC", ic);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@Status", "Active");
                cmd.Parameters.AddWithValue("@position", "Staff");

                con.Open();

                cmd.ExecuteNonQuery();

                con.Close();

                Response.Redirect("ManageActiveStaff.aspx");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtEmail.ReadOnly = false;
            btnDelete.Enabled = false;
            btnEdit.Enabled = false;
            btnAdd.Enabled = true;
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowIndex == GridView1.SelectedIndex)
                {
                    lblId.Text = generateID();
                    txtName.Text = "";
                    txtEmail.Text = "";
                    txtPhone.Text = "";
                    txtIC.Text = "";
                    rblGender.SelectedIndex = -1;
                    GridView1.SelectedIndex = -1;

                }

            }
        }
    }
}
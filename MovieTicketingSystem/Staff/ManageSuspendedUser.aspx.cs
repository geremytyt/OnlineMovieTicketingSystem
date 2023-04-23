using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class ManageSuspendedUser : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string sql = "UPDATE Customer SET custStatus=@Status WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Status", "Active");

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("ManageSuspendedUser.aspx");

        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string name = txtName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string gender = rblGender.SelectedValue.Substring(0, 1);
            DateTime dob = DateTime.Parse(txtDob.Text);
            string sql = "UPDATE Customer SET custName=@Name, custPhoneNo=@Phone, custGender=@Gender,custDob=@Dob WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@Dob", dob);


            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("ManageSuspendedUser.aspx");
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnDelete.Enabled = true;
            btnEdit.Enabled = true;
            foreach (GridViewRow row in GridView2.Rows)
            {
                if (row.RowIndex == GridView2.SelectedIndex)
                {
                    lblId.Text = row.Cells[0].Text;
                    txtName.Text = row.Cells[1].Text;
                    txtEmail.Text = row.Cells[2].Text;
                    txtPhone.Text = row.Cells[4].Text;
                    txtDob.Text = (Convert.ToDateTime(row.Cells[3].Text).ToString("yyyy-MM-dd"));

                    rblGender.SelectedValue = row.Cells[5].Text;
                }

            }
        }

        protected void btnActive_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageActiveUser.aspx");
        }
    }
}
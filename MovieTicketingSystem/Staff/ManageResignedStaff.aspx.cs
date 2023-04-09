using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class ManageResignedStaff : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnActive_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageActiveStaff.aspx");
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

            btnDelete.Enabled = true;
            btnEdit.Enabled = true;
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

            Response.Redirect("ManageResignedStaff.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;;
            string sql = "UPDATE Staff SET staffStatus=@Status WHERE staffId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Status", "Active");

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("ManageResignedStaff.aspx");
        }
    }
}
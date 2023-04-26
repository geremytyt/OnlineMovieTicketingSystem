using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ManageUser : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnDelete.Enabled = true;
            btnEdit.Enabled = true;
            foreach (GridViewRow row in gvUser.Rows) { 
                if(row.RowIndex == gvUser.SelectedIndex){
                    lblId.Text =  row.Cells[0].Text;
                    txtName.Text = row.Cells[1].Text;
                    txtEmail.Text = row.Cells[2].Text;
                    txtPhone.Text = row.Cells[4].Text;
                    txtDob.Text = (Convert.ToDateTime(row.Cells[3].Text).ToString("yyyy-MM-dd"));
                    rblGender.SelectedValue = row.Cells[5].Text;
                }

            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string sql = "UPDATE Customer SET custStatus=@Status WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Status", "Suspended");

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("ManageActiveUser.aspx");

        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string name = txtName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string gender = rblGender.SelectedValue.Substring(0,1);
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

            Response.Redirect("ManageActiveUser.aspx");
        }

        protected void btns_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = gvUser.Rows[index];
            string id = selectedRow.Cells[0].Text;
            switch (e.CommandName)
            {
                case "View":
                    Response.Redirect("ViewMovie.aspx?movieId=" + id);
                    break;

                case "Edit":
                    Response.Redirect("EditMovie.aspx?movieId=" + id);
                    break;
            }
        }

        protected void btnSuspended_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageSuspendedUser.aspx");
        }
    }
}
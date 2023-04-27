using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.ManagerOnly
{
    public partial class ManageResignedStaff : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sql = "SELECT[staffId], [staffName], [staffEmail], [staffIC], [staffPhoneNo], [staffGender], [position] FROM[Staff] WHERE([staffStatus] = @staffStatus AND [position] <> @position)";
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                sda.SelectCommand.Parameters.AddWithValue("@staffStatus", "Resigned");
                sda.SelectCommand.Parameters.AddWithValue("@position", "Manager");
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvStaff.DataSource = dt;
                gvStaff.DataBind();
                gvStaff.UseAccessibleHeader = true;
                gvStaff.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }


        protected void btnActive_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageActiveStaff.aspx");
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

        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = gvStaff.Rows[index];
            string id = selectedRow.Cells[0].Text;
            txtEmail.ReadOnly = true;
            btnDelete.Enabled = true;
            btnEdit.Enabled = true;
            lblId.Text = selectedRow.Cells[0].Text;
            txtName.Text = selectedRow.Cells[1].Text;
            txtEmail.Text = selectedRow.Cells[2].Text;
            txtPhone.Text = selectedRow.Cells[4].Text;
            txtIC.Text = selectedRow.Cells[3].Text;
            rblGender.SelectedValue = selectedRow.Cells[5].Text;
            ddlPosition.SelectedValue = selectedRow.Cells[6].Text;
        }
    }
}
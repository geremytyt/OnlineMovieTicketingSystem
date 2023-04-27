using System;
using System.Collections.Generic;
using System.Data;
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
            if (!IsPostBack)
            {
                string sql = "SELECT [custId], [custName], [custEmail], [custDob], [custPhoneNo], [custGender] FROM [Customer] WHERE ([custStatus] = @custStatus)";
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                sda.SelectCommand.Parameters.AddWithValue("@custStatus","Active");
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvUser.DataSource = dt;
                gvUser.DataBind();

            }
            gvUser.UseAccessibleHeader = true;
            gvUser.HeaderRow.TableSection = TableRowSection.TableHeader;
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

        protected void btnSuspended_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageSuspendedUser.aspx");
        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {

        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow selectedRow = gvUser.Rows[index];
        btnDelete.Enabled = true;
        btnEdit.Enabled = true;
        lblId.Text = selectedRow.Cells[0].Text;
        txtName.Text = selectedRow.Cells[1].Text;
        txtEmail.Text = selectedRow.Cells[2].Text;
        txtPhone.Text = selectedRow.Cells[4].Text;
        txtDob.Text = (Convert.ToDateTime(selectedRow.Cells[3].Text).ToString("yyyy-MM-dd"));
        rblGender.SelectedValue = selectedRow.Cells[5].Text;

        }
    }
}
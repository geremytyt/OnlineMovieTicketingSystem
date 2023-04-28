using MovieTicketingSystem.Model;
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
    public partial class ManageStaff : System.Web.UI.Page
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
                sda.SelectCommand.Parameters.AddWithValue("@staffStatus", "Active");
                sda.SelectCommand.Parameters.AddWithValue("@position", "Manager");
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvStaff.DataSource = dt;
                gvStaff.DataBind();
            }
            gvStaff.UseAccessibleHeader = true;
            gvStaff.HeaderRow.TableSection = TableRowSection.TableHeader;

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

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            string name = txtName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string gender = rblGender.SelectedValue.Substring(0, 1);
            string ic = txtIC.Text;
            string position = ddlPosition.SelectedValue;
            string sql = "UPDATE Staff SET staffName=@Name, staffPhoneNo=@Phone, staffGender=@Gender,staffIC=@ic, position=@position WHERE staffId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@ic", ic);
            cmd.Parameters.AddWithValue("@position", position);

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
                string position = ddlPosition.SelectedValue;
                string sql = "INSERT INTO Staff (staffId, staffName, staffEmail, staffPassword, staffPhoneNo, staffIC , staffGender, staffStatus, position) VALUES (@Id, @Name, @Email, @Password, @PhoneNo, @IC, @Gender, @Status, @position)";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", Security.GetHash("SLcinema123"));
                cmd.Parameters.AddWithValue("@PhoneNo", phone);
                cmd.Parameters.AddWithValue("@IC", ic);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@Status", "Active");
                cmd.Parameters.AddWithValue("@position", position);

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
            lblId.Text = generateID();
            ddlPosition.SelectedIndex = -1;
            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtIC.Text = "";
            rblGender.SelectedIndex = -1;
        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = gvStaff.Rows[index];
            string id = selectedRow.Cells[0].Text;
            txtEmail.ReadOnly = true;
            btnDelete.Enabled = true;
            btnEdit.Enabled = true;
            btnAdd.Enabled = false;
            lblId.Text = selectedRow.Cells[0].Text;
            txtName.Text = selectedRow.Cells[1].Text;
            txtEmail.Text = selectedRow.Cells[2].Text;
            txtPhone.Text = selectedRow.Cells[4].Text;
            txtIC.Text = selectedRow.Cells[3].Text;
            rblGender.SelectedValue = selectedRow.Cells[5].Text;
            ddlPosition.SelectedValue = selectedRow.Cells[6].Text.Trim();
        }
    }
}
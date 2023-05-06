using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ManageSuspendedUser : System.Web.UI.Page
    {
        string cs = Global.cs;
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try { 
                string sql = "SELECT [custId], [custName], [custEmail], [custDob], [custPhoneNo], [custGender] FROM [Customer] WHERE ([custStatus] = @custStatus)";
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                sda.SelectCommand.Parameters.AddWithValue("@custStatus", "Suspended");
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvUser.DataSource = dt;
                gvUser.DataBind();
                }
                catch (SqlException ex)
                {
                    // Handle the exception and display an error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                }
            }
            gvUser.UseAccessibleHeader = true;
            gvUser.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;
            try { 
            string sql = "UPDATE Customer SET custStatus=@Status WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Status", "Active");

            cmd.ExecuteNonQuery();

            con.Close();
            }
            catch (SqlException ex)
            {
                // Handle the exception and display an error message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
            }

            Response.Redirect("ManageSuspendedUser.aspx");

        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string exist = Session["Phone"].ToString();
            if (exist != null)
            {
                if (exist != txtPhone.Text)
                {
                    if (db.Customers.Any(c => c.custPhoneNo == txtPhone.Text.Trim()))
                    {
                        //display error msg
                        cvExistPhone.IsValid = false;
                    }
                }
            }
            if (Page.IsValid)
            {
                string id = lblId.Text;
                string name = txtName.Text;
                string email = txtEmail.Text;
                string phone = txtPhone.Text;
                string gender = rblGender.SelectedValue.Substring(0, 1);
                DateTime dob = DateTime.Parse(txtDob.Text);
                try { 
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
                }
                catch (SqlException ex)
                {
                    // Handle the exception and display an error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                }
                Response.Redirect("ManageSuspendedUser.aspx");
            }
        }

        protected void btnActive_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageActiveUser.aspx");
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

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
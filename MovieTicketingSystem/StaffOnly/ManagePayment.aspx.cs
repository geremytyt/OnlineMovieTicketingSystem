using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ManagePayment : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            btnConfirm.Visible = false;
            btnCancel.Visible = false;
            ddlStatus.Enabled = false;

            if (!IsPostBack)
            {
                string paymentNo = Request.QueryString["paymentNo"];
                if (!string.IsNullOrEmpty(paymentNo))
                {
                    try
                    {
                        SqlConnection conn = new SqlConnection(cs);
                        SqlCommand cmd = new SqlCommand("SELECT * FROM Payment WHERE paymentNo=@paymentNo", conn);
                        cmd.Parameters.AddWithValue("@paymentNo", paymentNo);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            lblPaymentNo.Text = reader["paymentNo"].ToString();
                            lblPaymentDate.Text = Convert.ToDateTime(reader["paymentDateTime"]).ToShortDateString();
                            lblPaymentTime.Text = Convert.ToDateTime(reader["paymentDateTime"]).ToShortTimeString();
                            lblPaymentAmt.Text = "RM " + reader["paymentAmount"].ToString();
                            lblCardNo.Text = reader["cardNo"].ToString();

                            string status = reader["status"].ToString();
                            ddlStatus.SelectedValue = status;

                            string purchaseNo = reader["purchaseNo"].ToString();
                            lblPurchaseNo.Text = purchaseNo;
                            reader.Close();

                            cmd = new SqlCommand("SELECT * FROM Purchase WHERE purchaseNo=@purchaseNo", conn);
                            cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                            reader = cmd.ExecuteReader();
                            if (reader.Read())
                            {
                                lblTicketTotal.Text = "RM " + reader["ticketTotal"].ToString();
                                lblFoodTotal.Text = "RM " + reader["foodTotal"].ToString();
                                lblCustID.Text = reader["custId"].ToString();
                            }
                            reader.Close();

                            // Retrieve all ticket numbers for a given purchaseNo and store them in a DataTable
                            DataTable dt = new DataTable();
                            conn = new SqlConnection(cs);

                            conn.Open();
                            cmd = new SqlCommand("SELECT ticketNo FROM Ticket WHERE purchaseNo=@purchaseNo", conn);
                            cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                            adapter.Fill(dt);

                            rptTickets.DataSource = dt;
                            rptTickets.DataBind();


                            DataTable dt2 = new DataTable();
                            conn = new SqlConnection(cs);
                            cmd = new SqlCommand("SELECT menuId FROM PurchaseMenu WHERE purchaseNo=@purchaseNo", conn);
                            cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                            SqlDataAdapter adapter2 = new SqlDataAdapter(cmd);
                            adapter2.Fill(dt2);

                            rptMenuID.DataSource = dt2;
                            rptMenuID.DataBind();


                        }
                        conn.Close();
                    }
                    catch (SqlException ex)
                    {
                        // Handle the exception and display an error message
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                    }
                }
            }
        }

        protected void paymentGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ddlStatus.Enabled = true;

            btnEdit.Visible = false;
            btnConfirm.Visible = true;
            btnDone.Visible = false;
            btnCancel.Visible = true;
            
        }


        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewPayment.aspx");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {

            string paymentNo = lblPaymentNo.Text; // Get the payment number from the label
            string newStatus = ddlStatus.SelectedValue; // Get the selected value from the dropdown list

            // Update the payment status in the database
            try { 
            SqlConnection connection = new SqlConnection(cs);
            
            connection.Open();
            string updateQuery = "UPDATE Payment SET status = @newStatus WHERE paymentNo = @paymentNo";
            using (SqlCommand command = new SqlCommand(updateQuery, connection))
            {
                command.Parameters.AddWithValue("@newStatus", newStatus);
                command.Parameters.AddWithValue("@paymentNo", paymentNo);
                command.ExecuteNonQuery();
            }
            }
            catch (SqlException ex)
            {
                // Handle the exception and display an error message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
            }


            btnEdit.Visible = true;
            btnConfirm.Visible = false;
            btnDone.Visible = true;
            btnCancel.Visible = false;
            ddlStatus.Enabled = false;  
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            btnEdit.Visible = true;
            btnConfirm.Visible = false;
            btnDone.Visible = true;
            btnCancel.Visible = false;
            ddlStatus.Enabled = false;
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
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
                            lblCustID.Text = reader["custID"].ToString();
                        }
                        reader.Close();

                        cmd = new SqlCommand("SELECT * FROM Ticket WHERE purchaseNo=@purchaseNo", conn);
                        cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                        reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            lblTicketNo.Text = reader["ticketNo"].ToString();
                        }
                        reader.Close();

                        cmd = new SqlCommand("SELECT * FROM PurchaseMenu WHERE purchaseNo=@purchaseNo", conn);
                        cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                        reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            lblMenuID.Text = reader["menuId"].ToString();
                        }
                        reader.Close();

                    }
                    conn.Close();
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
            using (SqlConnection connection = new SqlConnection(cs))
            {
                connection.Open();
                string updateQuery = "UPDATE Payment SET status = @newStatus WHERE paymentNo = @paymentNo";
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@newStatus", newStatus);
                    command.Parameters.AddWithValue("@paymentNo", paymentNo);
                    command.ExecuteNonQuery();
                }
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
    }
}
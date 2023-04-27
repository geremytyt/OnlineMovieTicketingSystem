using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class PaymentSummary : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //get info from previous page
                //string paymentNo = Request.QueryString["paymentNo"];
                string paymentNo = "T0001";
                

                //Retrieve payment details from database
                string paymentQuery = "SELECT paymentNo, purchaseNo, paymentDateTime, paymentAmount, cardNo, status FROM Payment WHERE paymentNo = @paymentNo";
          

                SqlConnection connection = new SqlConnection(cs);       
                connection.Open();

                // Retrieve payment details
                SqlCommand paymentCommand = new SqlCommand(paymentQuery, connection);
                paymentCommand.Parameters.AddWithValue("@paymentNo", paymentNo);
                SqlDataReader paymentReader = paymentCommand.ExecuteReader();

                if (paymentReader.Read())
                {
                    // Populate the payment details labels
                    lblStatus.Text = paymentReader["status"].ToString();
                    lblPaymentNo.Text = paymentNo;
                    lblPurchaseNo.Text = paymentReader["purchaseNo"].ToString();
                    lblPaymentDateTime.Text = DateTime.Parse(paymentReader["paymentDateTime"].ToString()).ToString("d/M/yyyy H:m:ss");
                    lblPaymentAmount.Text = string.Format("RM{0:#,##0.00}", paymentReader["paymentAmount"]);
                    lblCardNo.Text = paymentReader["cardNo"].ToString();
     
                    paymentReader.Close();               
                }
                
            }
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            // Get the custID from session
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();
            string custName = "";
            string custEmail = "";

            //if (cookie != null)
            //{
            //    string sql = "SELECT custName, custEmail FROM Customer WHERE custId = @custId";
            //    SqlConnection con = new SqlConnection(cs);
            //    SqlCommand cmd = new SqlCommand(sql, con);
            //    con.Open();
            //    cmd.Parameters.AddWithValue("@custId", custId);
            //    SqlDataReader dr = cmd.ExecuteReader();

            //    custName = dr["custName"].ToString();
            //    custEmail = dr["custEmail"].ToString();

            //    dr.Close();
            //    con.Close();
            //}


            //Reset Ticket and Cart Session
            Session.Remove("Cart");
            Session.Remove("Ticket");

            Response.Redirect("~/Annonymous/Home.aspx");


        }
    }
}

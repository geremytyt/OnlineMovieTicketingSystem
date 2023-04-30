using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace MovieTicketingSystem.ManagerOnly
{
    public partial class TopCustomerReport : System.Web.UI.Page
    {
        string cs = Global.cs;
        private static int topcust { get; set; }
        private static string start { get; set; }
        private static string end { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //set min and max value of date
            txtStartDate.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
            txtEndDate.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");


            litDate.Text = DateTime.Now.ToString();

            if (!IsPostBack)
            {
                string top = Request.QueryString["Top"] ?? "";
                start = Request.QueryString["Start"] ?? "";
                end = Request.QueryString["End"] ?? "";
                Literal1.Text = start + " - " + end;

                if (top != "")
                {
                    txtCust.Text = top;
                    topcust = int.Parse(top);
                }

                if (start != "")
                {
                    txtStartDate.Text = start.ToString();
                }

                if (end != "")
                {
                    txtEndDate.Text = end.ToString();
                }

                if (start != "" && top != "" && end != "")
                {
                    bindGrid();
                }

            }
        }

        [WebMethod]
        public static List<object> GetChartData()
        {
            try
            {
                string query = getQueryString();
                string constr = Global.cs;

                List<object> chartData = new List<object>();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(query))
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                chartData.Add(new object[]
                                {
                                sdr["name"].ToString(), (decimal)sdr["Total Amount(RM)"]
                                });
                            }
                        }

                        con.Close();

                        return chartData;
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception and return appropriate error message
                return new List<object> { new object[] { "Error", ex.Message } };
            }
        }

        private void bindGrid()
        {
            string sql = getQueryString();
            SqlConnection con = new SqlConnection(cs);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                GVReport.DataSource = dt;
                GVReport.DataBind();
                displayReport.Visible = true;
            }
            else {
                displayReport.Visible = true;
                displayReport.InnerHtml = "No Record Found";
            }
        }

        private static string getQueryString()
        {
            return "SELECT TOP " + topcust.ToString() + " " + 
                "Customer.custId AS ID, Customer.custName AS Name, SUM(Purchase.ticketTotal) AS [Total Ticket Bought(RM)]," +
                " SUM(Purchase.foodTotal) AS [Total Food Bought(RM)], SUM(Payment.paymentAmount) AS [Total Amount(RM)] " +
                "FROM Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo" +
                " WHERE CONVERT(Date, Payment.paymentDateTime, 23) <= '" + end + "' " +
                "AND CONVERT(Date, Payment.paymentDateTime, 23) >= '" + start + "' " +
                "GROUP BY Customer.custId, Customer.custName ORDER BY [Total Amount(RM)] DESC";
        }


        protected void btnSale_Click(object sender, EventArgs e)
        {
            Response.Redirect("SaleReport.aspx");
        }

        protected void btnRefund_Click(object sender, EventArgs e)
        {
            Response.Redirect("RefundReport.aspx");
        }
        protected void btnMovieReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("MovieReport.aspx");
        }

        protected void btnFoodReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("FoodSaleReport.aspx");
        }

        protected void btnTopFoodPurchase_Click(object sender, EventArgs e)
        {
            Response.Redirect("TopPurchasedFoodReport.aspx");
        }

        protected void btnCustDemo_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustDemoReport.aspx");
        }

        protected void btnTopCust_Click(object sender, EventArgs e)
        {
            Response.Redirect("TopCustomerReport.aspx");
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                Response.Redirect("TopCustomerReport.aspx?Top=" + txtCust.Text + "&&Start=" + txtStartDate.Text + "&&End=" + txtEndDate.Text);
            }
        }

    }
}
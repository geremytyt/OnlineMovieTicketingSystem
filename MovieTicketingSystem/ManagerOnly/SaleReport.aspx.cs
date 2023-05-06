using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using Newtonsoft.Json;
using System.Web.Services;
using System.Data.SqlClient;
using System.Globalization;

namespace MovieTicketingSystem.ManagerOnly
{
    public partial class SaleReport : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;
        private static string start { get; set; }
        private static string end { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

            DateTime current = DateTime.Now;

            litDate.Text = current.ToString();

            if (!IsPostBack)
            {
                start = Request.QueryString["Start"] ?? "";
                end = Request.QueryString["End"] ?? "";

                if (start != "")
                {
                    tbSalesReportStartDate.Text = start.ToString();
                }

                if (end != "")
                {
                    tbSalesReportEndDate.Text = end.ToString();
                }

                if (start != "" && end != "")
                {
                    bindGrid();
                }

                //set min and max value of date
                tbSalesReportStartDate.Attributes["max"] = current.ToString("yyyy-MM-dd");
                tbSalesReportEndDate.Attributes["max"] = current.ToString("yyyy-MM-dd");
                tbSalesReportEndDate.Attributes["min"] = tbSalesReportStartDate.Text;
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
                                    sdr["month"].ToString(),(decimal)sdr["totalSales"]
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
            else
            {
                displayReport.Visible = true;
                displayReport.InnerHtml = "No Record Found";
            }
        }

        private static string getQueryString()
        {
            return @"SELECT YEAR(paymentDateTime) AS year, MONTH(paymentDateTime) AS month, SUM(paymentAmount) AS totalSales
                   FROM Payment
                   WHERE paymentDateTime >= '" + start + "' AND paymentDateTime <= '" + end + @"' AND status = 'Completed'
                   GROUP BY YEAR(paymentDateTime), MONTH(paymentDateTime)
                   ORDER BY year, month";
        }

        protected void tbSalesReportStartDate_TextChanged(object sender, EventArgs e)
        {

            if (tbSalesReportEndDate.Text != null)
            {
                Response.Redirect("SaleReport.aspx?Start=" + tbSalesReportStartDate.Text + "&&End=" + tbSalesReportEndDate.Text);
            }
        }

        protected void tbSalesReportEndDate_TextChanged(object sender, EventArgs e)
        {
            if (tbSalesReportStartDate.Text != null)
            {
                Response.Redirect("SaleReport.aspx?Start=" + tbSalesReportStartDate.Text + "&&End=" + tbSalesReportEndDate.Text);
            }
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

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
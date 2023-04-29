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
    public partial class UserReport : System.Web.UI.Page
    {
        string cs = Global.cs;
        private static int topcust { get; set; }
        private static string start { get; set; }
        private static string end { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime current = DateTime.Now;



            litDate.Text = current.ToString();

            if (!IsPostBack)
            {
                string top = Request.QueryString["Top"] ?? "";
                start = Request.QueryString["Start"] ?? "";
                end = Request.QueryString["End"] ?? "";

                if (top != "")
                {
                    tbtotalItem.Text = top;
                    topcust = int.Parse(top);
                }

                if (start != "")
                {
                    tbFoodReportStartDate.Text = start.ToString();
                }

                if (end != "")
                {
                    tbFoodReportEndDate.Text = end.ToString();
                }

                if (start != "" && top != "" && end != "")
                {
                    bindGrid();
                }

                //set min and max value of date
                tbFoodReportStartDate.Attributes["max"] = current.ToString("yyyy-MM-dd");
                tbFoodReportEndDate.Attributes["max"] = current.ToString("yyyy-MM-dd");
                tbFoodReportEndDate.Attributes["min"] = tbFoodReportStartDate.Text;
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
                                    sdr["name"].ToString(),(decimal)sdr["Total_Money"]
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
        }

        private static string getQueryString()
        {
            return "SELECT TOP " + topcust.ToString() + " " + 
                "Customer.custId AS ID, Customer.custName AS name, SUM(Purchase.ticketTotal) AS Total_Ticket_Sold," +
                " SUM(Purchase.foodTotal) AS Total_Food_Sold, SUM(Payment.paymentAmount) AS Total_Amount " +
                "FROM Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo" +
                "WHERE CONVERT(Date, Payment.paymentDateTime, 23) <= '" + end + "' " + 
                "AND CONVERT(Date, Payment.paymentDateTime, 23) >= '" + start + "' " + 
                "GROUP BY Customer.custId, Customer.custName ORDER BY Total_Amount DESC";
        }


        protected void btnSale_Click(object sender, EventArgs e)
        {
            Response.Redirect("SaleReport.aspx");
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

        protected void btnUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserReport.aspx");
        }
    }
}
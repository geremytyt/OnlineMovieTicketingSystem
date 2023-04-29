using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MovieTicketingSystem.Model;
using System.Security.Policy;
using System.Web.Services;
using System.Security.Cryptography;

namespace MovieTicketingSystem.ManagerOnly
{

    public partial class CustDemoReport : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;
        private static string start { get; set; } 
        private static string end { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            litDate.Text = DateTime.Now.ToString();
        }

        [WebMethod]
        public static List<object> GetChartData()
        {
            try
            {
                string query = "SELECT custGender AS Gender, COUNT(custGender) AS Quantity FROM Customer GROUP BY custGender";
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
                                sdr["Gender"].ToString(), (int)sdr["Quantity"]
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

        [WebMethod]
        public static List<object> GetChartData2()
        {
            try
            {
                string query = "SELECT CASE WHEN DATEDIFF(YEAR, custDob, GETDATE()) < 12 THEN 'Children' WHEN DATEDIFF(YEAR, custDob, GETDATE()) BETWEEN 12 AND 54 THEN 'Adult' ELSE 'Senior' END AS [Age Group], COUNT(*) AS Quantity FROM Customer GROUP BY CASE WHEN DATEDIFF(YEAR, custDob, GETDATE()) < 12 THEN 'Children' WHEN DATEDIFF(YEAR, custDob, GETDATE()) >= 12 AND DATEDIFF(YEAR, custDob, GETDATE()) <= 54 THEN 'Adult' ELSE 'Senior' END";
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
                                sdr["Age Group"].ToString(), (int)sdr["Quantity"]
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

        protected void btnCustDemo_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustDemoReport.aspx");
        }

        protected void btnTopCust_Click(object sender, EventArgs e)
        {
            Response.Redirect("TopCustomerReport.aspx");
        }

    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.ManagerOnly
{
    public partial class MovieReport : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {
            litDate.Text = DateTime.Now.ToString();
        }

        [WebMethod]
        public static List<object> GetChartData2()
        {
            try
            {
                string query = "SELECT m.movieId, m.movieName, COUNT(*) AS ticketsSold FROM Movie AS m INNER JOIN Schedule AS s ON m.movieId = s.movieId INNER JOIN Ticket AS t ON s.scheduleNo = t.scheduleNo INNER JOIN Purchase AS p ON t.purchaseNo = p.purchaseNo WHERE (m.endDate > GETDATE()) GROUP BY m.movieId, m.movieName, m.posterURL, m.trailerURL ORDER BY ticketsSold DESC";
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
                                sdr["movieName"].ToString(), (int)sdr["ticketsSold"]
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
    }
}
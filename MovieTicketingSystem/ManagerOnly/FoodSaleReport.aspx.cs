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

    public partial class FoodSaleReport : System.Web.UI.Page
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

                if(start != "")
                {
                    tbFoodReportStartDate.Text = start.ToString();
                }
                
                if (end != "")
                {
                    tbFoodReportEndDate.Text = end.ToString();
                }

                if (start != "" && end !="")
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
            else
            {
                displayReport.Visible = true;
                displayReport.InnerHtml = "No Record Found";
            }
        }

        private static string getQueryString()
        {
            return "SELECT Menu.menuId AS ID, Menu.menuName AS name, SUM(PurchaseMenu.menuQty) AS Total_Item_Sold, Menu.menuPrice AS Price, SUM(PurchaseMenu.menuQty) * Menu.menuPrice AS Total_Money " +
                "From Menu, PurchaseMenu, Purchase, Payment " +
                "WHERE Menu.menuId = PurchaseMenu.menuId " +
                "AND PurchaseMenu.purchaseNo = Purchase.purchaseNo " +
                "AND Payment.purchaseNo = Purchase.purchaseNo " +
                "AND CONVERT(Date, Payment.paymentDateTime, 23) <= '"+ end + "' " +
                "AND CONVERT(Date, Payment.paymentDateTime, 23) >= '" + start + "' " +
                "Group By  Menu.menuId, Menu.menuName, Menu.menuPrice " +
                 "Order By Total_Money DESC";
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

        protected void tbFoodReportStartDate_TextChanged(object sender, EventArgs e)
        {
                        
            if ( tbFoodReportEndDate.Text != null)
            {
                Response.Redirect("FoodSaleReport.aspx?Start=" + tbFoodReportStartDate.Text + "&&End=" + tbFoodReportEndDate.Text);
            }
        }

        protected void tbFoodReportEndDate_TextChanged(object sender, EventArgs e)
        {
            if (tbFoodReportStartDate.Text != null)
            {
                Response.Redirect("FoodSaleReport.aspx?Start=" + tbFoodReportStartDate.Text + "&&End=" + tbFoodReportEndDate.Text);
            }
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }

    }
}
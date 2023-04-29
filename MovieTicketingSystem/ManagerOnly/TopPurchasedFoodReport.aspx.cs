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
    public partial class TopPurchasedFoodReport : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;
        private static int topitem { get; set; }
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
                    topitem = int.Parse(top);
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
                                    sdr["name"].ToString(),(int)sdr["Total_Item_Sold"]
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
            return "SELECT TOP " + topitem.ToString() +
                "Menu.menuId, Menu.menuName as name, SUM(PurchaseMenu.menuQty) AS Total_Item_Sold, (SUM(PurchaseMenu.menuQty) * Menu.menuPrice) * 100 /  " +
                "(Select SUM(Purchase.foodTotal) FROM payment, purchase  " +
                "WHERE Payment.purchaseNo = Purchase.purchaseNo  " +
                "AND CONVERT(Date, Payment.paymentDateTime, 101) <= '" + end + "' " +
                "AND CONVERT(Date, Payment.paymentDateTime, 101) > '" + start + "') precent_to_Total " +
                "From Menu, PurchaseMenu, Purchase, Payment " +
                "WHERE Menu.menuId = PurchaseMenu.menuId " +
                "AND PurchaseMenu.purchaseNo = Purchase.purchaseNo " +
                "AND Payment.purchaseNo = Purchase.purchaseNo " +
                "AND CONVERT(Date, Payment.paymentDateTime, 101) <= '" + end + "' " +
                "AND CONVERT(Date, Payment.paymentDateTime, 101) > '" + start + "' " +
                "Group By  Menu.menuId,  Menu.menuName, Menu.menuPrice " +
                "Order By Total_Item_Sold DESC";
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

        protected void tbtotalItem_TextChanged(object sender, EventArgs e)
        {
            if (tbFoodReportStartDate.Text != null || tbFoodReportEndDate.Text != null)
            {
                Response.Redirect("TopPurchasedFoodReport.aspx?Top=" + tbtotalItem.Text + "&&Start=" + tbFoodReportStartDate.Text + "&&End=" + tbFoodReportEndDate.Text);
            }
        }

        protected void tbFoodReportStartDate_TextChanged(object sender, EventArgs e)
        {

            if (tbtotalItem.Text != null || tbFoodReportEndDate.Text != null)
            {
                Response.Redirect("TopPurchasedFoodReport.aspx?Top=" + tbtotalItem.Text + "&&Start=" + tbFoodReportStartDate.Text + "&&End=" + tbFoodReportEndDate.Text);
            }
        }

        protected void tbFoodReportEndDate_TextChanged(object sender, EventArgs e)
        {
            if (tbtotalItem.Text != null || tbFoodReportStartDate.Text != null)
            {
                Response.Redirect("TopPurchasedFoodReport.aspx?Top=" + tbtotalItem.Text + "&&Start=" + tbFoodReportStartDate.Text + "&&End=" + tbFoodReportEndDate.Text);
            }
        }

        
    }


}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Manager
{
    public partial class Report : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {
            tbFoodReportStartDate.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
            tbFoodReportEndDate.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
            tbFoodReportEndDate.Attributes["min"] = tbFoodReportStartDate.Text;
        }

        protected void DDLFoodreport_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!tbtotalItem.Text.Equals(null) || Int16.Parse(tbtotalItem.Text) > 0)
            {
                switch (DDLFoodreport.SelectedItem.Text)
                {
                    case "Top Sales item":
                        lblFoodReporttitle.Text = "";
                        ReportGenerator.InnerHtml = "";
                        topAmountDiv.Visible = true;
                        timeRangeDiv.Visible = true;

                        if (tbtotalItem.Text != string.Empty && tbFoodReportStartDate.Text != string.Empty && tbFoodReportEndDate.Text != string.Empty)
                        {
                            lblFoodReporttitle.Text = " Top " + tbtotalItem.Text + " Sales Item Report \n" +
                                "(" + tbFoodReportStartDate.Text + "-" + tbFoodReportEndDate.Text + ")";
                            ReportGenerator.InnerHtml = topSalesItemReport();
                        }

                        break;
                    case "Most Purchase item":
                        lblFoodReporttitle.Text = "";
                        ReportGenerator.InnerHtml = "";
                        topAmountDiv.Visible = true;
                        timeRangeDiv.Visible = true;

                        if (tbtotalItem.Text != string.Empty && tbFoodReportStartDate.Text != string.Empty && tbFoodReportEndDate.Text != string.Empty)
                        {
                            lblFoodReporttitle.Text = " Top " + tbtotalItem.Text + " Pruchase item Report \n" +
                                    "(" + tbFoodReportStartDate.Text + "-" + tbFoodReportEndDate.Text + ")";
                            ReportGenerator.InnerHtml = mostPurchaseTtemReport();
                        }
                        break;
                    case "Menu Category Report":
                        ReportGenerator.InnerHtml = "";
                        lblFoodReporttitle.Text = " Menu Category Report ";
                        topAmountDiv.Visible = false;
                        timeRangeDiv.Visible = false;
                        ReportGenerator.InnerHtml = menuCategoryReport();
                        break;
                    case "Demographic Report":
                        ReportGenerator.InnerHtml = " ";
                        lblFoodReporttitle.Text = " Demographic Report ";
                        topAmountDiv.Visible = false;
                        timeRangeDiv.Visible = false;
                        ReportGenerator.InnerHtml = Demographic();
                        break;
                }
            }
        }


        //report generate
        private string topSalesItemReport()
        {
            StringBuilder stringBuilder = new StringBuilder("");
            stringBuilder.Append("");

            //MenuId, MenuName, orderMenu.qty * MenuPrice
            String[,] topSales ={{ "M001","Pizza", "292.50"},  {"M003","Chezzy Widget", "250.70"},
                {"M011","Fanta", "157.70"},
                {"M017","Coca-cola", "52.70"},
                {"M004","Double Set Combo", "42.50"}, };

            //Header
            stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle\">\r\n" +
               "                               <div class=\"col-2 text-center\">ID</div>\r\n" +
               "                               <div class=\"col-6 text-start\">Name</div>\r\n" +
               "                               <div class=\"col-4 text-end\">Sales</div>\r\n" +
               "                           </div>");

            //data row
            for (int i = 0; i <= topSales.GetUpperBound(0); i++)
            {
                stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle\">\r\n" +
                    "                               <div class=\"col-2 text-center \">" + topSales[i, 0] + "</div>\r\n" +
                    "                               <div class=\"col-6 text-start \">" + topSales[i, 1] + "</div>\r\n" +
                    "                               <div class=\"col-4 text-end \"> RM " + topSales[i, 2] + "</div>\r\n" +
                    "                           </div>");
            }

            return stringBuilder.ToString();
        }
        private string mostPurchaseTtemReport()
        {
            //MenuId, MenuName, orderMenu.qty, order.time, order.date
            StringBuilder stringBuilder = new StringBuilder("");
            stringBuilder.Append("");

            //MenuId, MenuName, orderMenu.qty * MenuPrice
            String[,] topSales ={{ "M001","Pizza", "190"},
                {"M003","Chezzy Widget", "150"},
                {"M011","Fanta", "120"},
                {"M017","Coca-cola", "94"},
                {"M004","Double Set Combo", "70"}, };

            //Header
            stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle\">\r\n" +
               "                               <div class=\"col-2 text-center\">ID</div>\r\n" +
               "                               <div class=\"col-6 text-start\">Name</div>\r\n" +
               "                               <div class=\"col-4 text-end\">Sales</div>\r\n" +
               "                           </div>");

            //data row
            for (int i = 0; i <= topSales.GetUpperBound(0); i++)
            {
                stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle\">\r\n" +
                    "                               <div class=\"col-2 text-center \">" + topSales[i, 0] + "</div>\r\n" +
                    "                               <div class=\"col-6 text-start \">" + topSales[i, 1] + "</div>\r\n" +
                    "                               <div class=\"col-4 text-end \"> RM " + topSales[i, 2] + "</div>\r\n" +
                    "                           </div>");
            }


            return stringBuilder.ToString();
        }

        private string menuCategoryReport()
        {
            //step 2 load detail
            string sql = "SELECT menuCategory, COUNT(*) FROM Menu GROUP BY menuCategory";

            //step 3 establish connection
            SqlConnection con = new SqlConnection(cs);

            //step 4 open connection
            con.Open();

            //step 5 sql command
            SqlCommand cmd = new SqlCommand(sql, con);

            //step 5.1 supply parameter to sql


            //step 6 execute sql
            SqlDataReader dr = cmd.ExecuteReader();

            //step 7 Read and the dr and build report
            StringBuilder stringBuilder = new StringBuilder();
            int total = 0;

            //generate table header
            stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle w-75\">\r\n" +
                "                               <div class=\"col-9 text-start\">CATEGORY</div>\r\n" +
                "                               <div class=\"col-3 text-center\">TOTAL</div>\r\n" +
                "                           </div>");

            //data row
            while (dr.Read())
            {
                //generate category
                stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle w-75\">\r\n" +
                    "                               <div class=\"col-9 text-start\">" + dr[0].ToString().Trim() + "</div>\r\n" +
                    "                               <div class=\"col-3 text-center\"> " + dr[1].ToString().Trim() + "</div>\r\n" +
                    "                           </div>");

                total += Int16.Parse(dr[1].ToString().Trim());
            }

            //footer
            stringBuilder.Append("<div class=\"row g-2 mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle w-75\">\r\n" +
                    "                               <div class=\"col-9 text-start\">TOTAL</div>\r\n" +
                    "                               <div class=\"col-3 text-center\">" + total.ToString() + "</div>\r\n" +
                    "                           </div>");

            return stringBuilder.ToString();
        }


        private string Demographic()
        {
            // movieId, movieName, ticketCategory, 

            StringBuilder stringBuilder = new StringBuilder();

            int total = 0;
            String[,] demograph ={{"Senior","5"},
                {"Child", "5"},
                {"Adult","4"}, };

            //generate table header
            stringBuilder.Append("<div style=\"width:100% text-aligin:center;\"><b>Movie : Movie 2 (ID:283221)</b></div>\n");
            stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle w-75\">\r\n" +
                "                               <div class=\"col-9 text-start\">CATEGORY</div>\r\n" +
                "                               <div class=\"col-3 text-center\">TOTAL</div>\r\n" +
                "                           </div>");

            //data row
            for (int i = 0; i <= demograph.GetUpperBound(0); i++)
            {
                //generate category
                stringBuilder.Append("<div class=\"row mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle w-75\">\r\n" +
                    "   <div class=\"col-9 text-start\">" + demograph[i, 0] + "</div>\r\n" +
                    "   <div class=\"col-3 text-center\"> " + demograph[i, 1] + "</div>\r\n</div>");

                total += int.Parse(demograph[i, 1]);
            }


            //footer
            stringBuilder.Append("<div class=\"row g-2 mx-auto my-0 py-2 border-bottom border-bottom-2 border-bottom-white align-middle w-75\">\r\n" +
                    "                               <div class=\"col-9 text-start\">TOTAL</div>\r\n" +
                    "                               <div class=\"col-3 text-center\">" + total.ToString() + "</div>\r\n" +
                    "                           </div>");

            return stringBuilder.ToString();
        }


    }
}
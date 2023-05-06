using MovieTicketingSystem.Model;
using NodaTime;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class StaffHome : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {

            String searchDate = DateTime.Now.Date.ToString();

            TBDate.Text = "Up to Date until: " + searchDate;

            searchDate = "5/5/2023";
            getTotalTicketSold(searchDate);
            getTotalFoodSold(searchDate);
            getMostPopularMovie(searchDate);
            getMostPopularFood(searchDate);
            getFoodSales(searchDate);
            getMovieSales(searchDate);
            getUpcomingSchedule(searchDate);
        }

        private void getTotalTicketSold(String searchDate)
        {
            
            string sql = "SELECT Purchase.adultQty, Purchase.childrenQty, Purchase.seniorQty, Purchase.ticketTotal, Payment.paymentDateTime  " +
                "FROM Purchase, Payment " +
                "Where Purchase.purchaseNo = Payment.purchaseNo " +
                "AND CONVERT(Date, Payment.paymentDateTime) = '" + searchDate + "'";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    int totalticketSold = int.Parse(dr[0].ToString()) + int.Parse(dr[1].ToString()) + int.Parse(dr[2].ToString());
                    litTicketSold.Text = String.Format("{0} ( RM {1:0.00} )", totalticketSold, double.Parse(dr[3].ToString()));
                }
            }
            else
            {
                litTicketSold.Text = "None";
            }
        }

        private void getTotalFoodSold(String searchDate)
        {
            
            string sql = "SELECT Purchase.purchaseNo, Sum(PurchaseMenu.menuQty), Purchase.foodTotal,Payment.paymentDateTime " +
                "FROM Purchase, Payment, PurchaseMenu, Menu " +
                "WHERE Purchase.purchaseNo = Payment.purchaseNo and " +
                "Purchase.purchaseNo = PurchaseMenu.purchaseNo and " +
                "PurchaseMenu.menuId = Menu.menuId " +
                "AND CONVERT(Date, Payment.paymentDateTime) = '" + searchDate + "'" +
                "Group By Purchase.purchaseNo, Purchase.foodTotal,Payment.paymentDateTime ";
            
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    LitFoodSold.Text = String.Format("{0:00} ( RM {1:0.00} )", dr[1].ToString(), double.Parse(dr[2].ToString()));
                }
            }
            else
            {
                LitFoodSold.Text = "None";
            }
        }

        private void getMostPopularMovie(String searchDate)
        {
            string sql = "SELECT Payment.paymentDateTime, Movie.movieName, Count(Ticket.ticketNo) " +
                "FROM Payment, Purchase, Ticket, Schedule, Movie " +
                "Where Purchase.purchaseNo = Payment.purchaseNo  " +
                "AND Ticket.purchaseNo = Purchase.purchaseNo " +
                "AND TICKET.scheduleNo = Schedule.scheduleNo " +
                "AND Schedule.movieId = Movie.movieId " +
                "AND CONVERT(Date, Payment.paymentDateTime) = '" + searchDate + "'" +
                "Group By Movie.movieName, Payment.paymentDateTime " +
                "Order BY Count(Ticket.ticketNo) DESC";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    LitlblMostMovie.Text = dr[1].ToString();
                }
            }
            else
            {
                LitlblMostMovie.Text = "None";
            }            
        }

        private void getMovieSales(String searchDate)
        {
            String sql = "SELECT SUM(Ticket.ticketPrice) AS Expr1 FROM Payment INNER JOIN Purchase ON Payment.purchaseNo = Purchase.purchaseNo INNER JOIN Ticket ON Purchase.purchaseNo = Ticket.purchaseNo INNER JOIN Schedule ON Ticket.scheduleNo = Schedule.scheduleNo INNER JOIN Movie ON Schedule.movieId = Movie.movieId WHERE (CONVERT(Date, Payment.paymentDateTime) = '" + searchDate + "')";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    LitlblMovieSales.Text = "RM " + dr[0].ToString();
                }
            }
            else
            {
                LitlblMovieSales.Text = "None";
            }
        }

        private void getMostPopularFood(String searchDate) {
            String sql = "SELECT Menu.menuId, Menu.menuName, Sum(PurchaseMenu.menuQty) " +
                "FROM Purchase, Payment, PurchaseMenu, Menu " +
                "WHERE Purchase.purchaseNo = Payment.purchaseNo and " +
                "Purchase.purchaseNo = PurchaseMenu.purchaseNo and " +
                "PurchaseMenu.menuId = Menu.menuId " +
                "AND CONVERT(Date, Payment.paymentDateTime) = '" + searchDate + "'" +
                "Group By Menu.menuId, Menu.menuName " +
                "Order By Sum(PurchaseMenu.menuQty) DESC";
            
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    LitlblMostFood.Text = dr[1].ToString();
                }
            }
            else
            {
                LitlblMostFood.Text = "None";
            }
        }

        private void getFoodSales(String searchDate)
        {
            String sql = "SELECT SUM(Menu.menuPrice * PurchaseMenu.menuQty) AS Sales FROM Purchase INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId WHERE (CONVERT(Date, Payment.paymentDateTime) = '" + searchDate + "')";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    LitlblFoodSales.Text = "RM " +  dr[0].ToString();
                }
            }
            else
            {
                LitlblFoodSales.Text = "RM 0.00";
            }
        }

        private void getUpcomingSchedule(String searchDate)
        {
            String sql = " Select Schedule.scheduleDateTime As Time, Schedule.hallNo As Hall, Movie.movieName AS Movie " +
                "From Schedule, Movie " +
                "WHERE Schedule.movieId = Movie.movieId " +
                "And CONVERT(Date, scheduleDateTime) = '" + searchDate + "'" +
                "order by scheduleDateTime";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            ScheduleTable.DataSource= dr;
            ScheduleTable.DataBind();
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }


    }
}
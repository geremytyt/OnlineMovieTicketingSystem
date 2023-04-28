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
            String CurrentDate = DateTime.Now.ToString();
            String searchDate = "8/4/2023";
            //String searchDate = DateTime.Now.ToString();

            if (Application["LoginPerformed"] != null)
            {
                int numberOfLoginPerformed = (int)Application["LoginPerformed"];
                litLoginPerfrom.Text = numberOfLoginPerformed.ToString();
            }
            else
            {
                litLoginPerfrom.Text = "0";
            }

            TBDate.Text = CurrentDate;
            
            getTotalTicketSold(searchDate);
            getTotalFoodSold(searchDate);
            getMostPopularMovie(searchDate);
            getMostPopularFood(searchDate);
            getUpcomingSchedule(searchDate);
        }

        private void getTotalTicketSold(String searchDate)
        {
            
            string sql = "SELECT Purchase.adultQty, Purchase.childrenQty, Purchase.seniorQty, Purchase.ticketTotal, Payment.paymentDateTime  " +
                "FROM Purchase, Payment " +
                "Where Purchase.purchaseNo = Payment.purchaseNo " +
                "AND CONVERT(Date, Payment.paymentDateTime, 101) = '" + searchDate + "'";

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
                "AND CONVERT(Date, Payment.paymentDateTime, 101) = '" + searchDate + "'" +
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
                "AND CONVERT(Date, Payment.paymentDateTime, 101) = '" + searchDate + "'" +
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

        private void getMostPopularFood(String searchDate) {
            String sql = "SELECT Menu.menuId, Menu.menuName, Sum(PurchaseMenu.menuQty) " +
                "FROM Purchase, Payment, PurchaseMenu, Menu " +
                "WHERE Purchase.purchaseNo = Payment.purchaseNo and " +
                "Purchase.purchaseNo = PurchaseMenu.purchaseNo and " +
                "PurchaseMenu.menuId = Menu.menuId " +
                "AND CONVERT(Date, Payment.paymentDateTime, 101) = '" + searchDate + "'" +
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

        private void getUpcomingSchedule(String searchDate)
        {
            searchDate = "01/05/2023";
            String sql = " Select Schedule.scheduleDateTime As Time, Schedule.hallNo As Hall, Movie.movieName AS Movie " +
                "From Schedule, Movie " +
                "WHERE Schedule.movieId = Movie.movieId " +
                "And CONVERT(Date, scheduleDateTime, 101) = '" + searchDate + "'" +
                "order by scheduleDateTime";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            ScheduleTable.DataSource= dr;
            ScheduleTable.DataBind();
        }
    }
}
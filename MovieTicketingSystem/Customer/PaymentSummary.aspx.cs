using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.View
{
    public partial class PaymentSummary : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //get info from previous page
                //string paymentNo = Request.QueryString["paymentNo"];
                string paymentNo = "T0001";
                // Set the payment number label
                //lblPaymentNo.Text = paymentNo;

                //Retrieve payment details from database



                string paymentQuery = "SELECT paymentNo, purchaseNo, paymentDateTime, paymentAmount, cardNo FROM Payment WHERE paymentNo = @paymentNo";
                string purchaseQuery = @"SELECT P.ticketTotal, P.foodTotal, T.scheduleNo, T.ticketCategory, T.ticketPrice, T.seatNo, S.movieId, S.hallNo, S.scheduleDateTime, M.movieName, M.movieDuration, PM.menuId, Menu.menuName
                                        FROM Purchase P
                                        JOIN Ticket T ON P.PurchaseNo = T.PurchaseNo
                                        JOIN Schedule S ON T.scheduleNo = S.scheduleNo
                                        JOIN Movie M ON S.movieId = M.movieId
                                        JOIN PurchaseMenu PM ON P.PurchaseNo = PM.PurchaseNo
                                        JOIN Menu ON PM.menuId = Menu.menuId
                                        WHERE P.PurchaseNo = @purchaseNo";

                using (SqlConnection connection = new SqlConnection(cs))
                {
                    connection.Open();

                    // Retrieve payment details
                    SqlCommand paymentCommand = new SqlCommand(paymentQuery, connection);
                    paymentCommand.Parameters.AddWithValue("@paymentNo", paymentNo);
                    SqlDataReader paymentReader = paymentCommand.ExecuteReader();

                    if (paymentReader.Read())
                    {
                        // Populate the payment details labels
                        lblPaymentNo.Text = paymentReader["paymentNo"].ToString();
                        lblPurchaseNo.Text = paymentReader["purchaseNo"].ToString();
                        lblPaymentDateTime.Text = DateTime.Parse(paymentReader["paymentDateTime"].ToString()).ToString("d/M/yyyy H:m:ss");
                        lblPaymentAmount.Text = string.Format("{0:#,##0.00}", paymentReader["paymentAmount"]);
                        lblCardNo.Text = paymentReader["cardNo"].ToString();

                        // Retrieve other details using purchaseNo
                        string purchaseNo = paymentReader["purchaseNo"].ToString();
                        paymentReader.Close();

                        //SqlCommand purchaseCommand = new SqlCommand(purchaseQuery, connection);
                        //purchaseCommand.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                        //SqlDataReader purchaseReader = purchaseCommand.ExecuteReader();

                        //if (purchaseReader.Read())
                        //{
                        //    // Populate the purchase details labels
                        //    lblPurchaseNo.Text = purchaseReader["purchaseNo"].ToString();
                        //    lblTicketNo.Text = purchaseReader["ticketNo"].ToString();
                        //    lblTitle.Text = purchaseReader["movieName"].ToString();
                        //    lblShowingDate.Text = DateTime.Parse(purchaseReader["scheduleDateTime"].ToString()).ToString("d/M/yyyy");
                        //    lblShowingTime.Text = DateTime.Parse(purchaseReader["scheduleDateTime"].ToString()).ToString("HⓂ️ss");
                        //    lblHallNo.Text = purchaseReader["hallNo"].ToString();
                        //    lblSeat.Text = purchaseReader["seatNo"].ToString();
                        //    lblMenuId.Text = purchaseReader["menuName"].ToString();
                        //}

                        //purchaseReader.Close();
                    }
                }
            }
        }

        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        //string paymentQuery = "SELECT paymentNo, paymentDateTime, paymentAmount, cardNo FROM Payment WHERE paymentNo = @paymentNo";
        //string purchaseQuery = "SELECT Purchase.purchaseNo, Ticket.ticketNo, Schedule.scheduleDateTime, Hall.hallNo, Ticket.seatNo, Movie.movieName, PurchaseMenu.menuId, Menu.menuName " +
        //                       "FROM Purchase " +
        //                       "INNER JOIN Ticket ON Purchase.purchaseNo = Ticket.purchaseNo " +
        //                       "INNER JOIN Schedule ON Ticket.scheduleNo = Schedule.scheduleNo " +
        //                       "INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo " +
        //                       "INNER JOIN Movie ON Schedule.movieId = Movie.movieId " +
        //                       "LEFT JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo " +
        //                       "LEFT JOIN Menu ON PurchaseMenu.menuId = Menu.menuId " +
        //                       "WHERE Purchase.purchaseNo = @purchaseNo";

        //using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDBConnectionString"].ConnectionString))
        //{
        //    connection.Open();

        //    // Retrieve payment details
        //    SqlCommand paymentCommand = new SqlCommand(paymentQuery, connection);
        //    paymentCommand.Parameters.AddWithValue("@paymentNo", paymentNo);
        //    SqlDataReader paymentReader = paymentCommand.ExecuteReader();

        //    if (paymentReader.Read())
        //    {
        //        // Populate the payment details labels
        //        lblPaymentNo.Text = paymentReader["paymentNo"].ToString();
        //        lblPurchaseNo.Text = paymentReader["purchaseNo"].ToString();
        //        lblPaymentDateTime.Text = DateTime.Parse(paymentReader["paymentDateTime"].ToString()).ToString("d/M/yyyy H:m:s");
        //        lblPaymentAmount.Text = string.Format("{0:#,##0.00}", paymentReader["paymentAmount"]);
        //        lblCardNo.Text = paymentReader["cardNo"].ToString();

        //        // Retrieve other details using purchaseNo
        //        string purchaseNo = paymentReader["purchaseNo"].ToString();
        //        paymentReader.Close();

        //        SqlCommand purchaseCommand = new SqlCommand(purchaseQuery, connection);
        //        purchaseCommand.Parameters.AddWithValue("@purchaseNo", purchaseNo);
        //        SqlDataReader purchaseReader = purchaseCommand.ExecuteReader();

        //        if (purchaseReader.Read())
        //        {
        //            // Populate the purchase details labels
        //            lblPurchaseNo.Text = purchaseReader["purchaseNo"].ToString();
        //            lblTicketNo.Text = purchaseReader["ticketNo"].ToString();
        //            lblTitle.Text = purchaseReader["movieName"].ToString();
        //            lblShowingDate.Text = DateTime.Parse(purchaseReader["scheduleDateTime"].ToString()).ToString("d/M/yyyy");
        //            lblShowingTime.Text = DateTime.Parse(purchaseReader["scheduleDateTime"].ToString()).ToString("H:m:ss");
        //            lblHallNo.Text = purchaseReader["hallNo"].ToString();
        //            lblSeat.Text = purchaseReader["seatNo"].ToString();
        //            lblMenuId.Text = purchaseReader["menuName"].ToString();
        //        }

        //        purchaseReader.Close();
        //    }
        //}
    }
}

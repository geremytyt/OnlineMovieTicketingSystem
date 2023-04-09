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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //get info from previous page
                //string paymentNo = Request.QueryString["paymentNo"];
                string paymentNo = "T0001";
                // Set the payment number label
                //lblPaymentNo.Text = paymentNo;

                // Retrieve payment details from database
                string connectionString = ConfigurationManager.ConnectionStrings["MovieDBConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = @"SELECT Payment.paymentNo, Payment.paymentDateTime, Payment.paymentAmount, Payment.cardNo,
                   Ticket.ticketNo, Schedule.scheduleDateTime, Hall.hallNo, Ticket.seatNo, Movie.movieName,
                   PurchaseMenu.menuId, Menu.menuName
                    FROM Payment
                    INNER JOIN Purchase ON Payment.paymentNo = Purchase.paymentNo
                    INNER JOIN Ticket ON Purchase.purchaseNo = Ticket.purchaseNo
                    INNER JOIN Schedule ON Ticket.scheduleNo = Schedule.scheduleNo
                    INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo
                    INNER JOIN Movie ON Schedule.movieId = Movie.movieId
                    LEFT JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo
                    LEFT JOIN Menu ON PurchaseMenu.menuId = Menu.menuId
                    WHERE Payment.paymentNo = @paymentNo;";


                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@paymentNo", paymentNo);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        // Populate the payment details labels
                        lblPaymentNo.Text = paymentNo.ToString();
                        lblPurchaseNo.Text = reader["purchaseNo"].ToString();
                        lblPaymentDateTime.Text = DateTime.Parse(reader["paymentDateTime"].ToString()).ToString("d/M/yyyy H:m:s");
                        lblPaymentAmount.Text = string.Format("{0:#,##0.00}", reader["paymentAmount"]);
                        lblCardNo.Text = reader["cardNo"].ToString();

                        // Populate the purchase details labels
                        lblTicketNo.Text = reader["ticketNo"].ToString();
                        lblTitle.Text = reader["movieName"].ToString();
                        lblShowingDate.Text = DateTime.Parse(reader["scheduleDateTime"].ToString()).ToString("d/M/yyyy");
                        lblShowingTime.Text = DateTime.Parse(reader["scheduleDateTime"].ToString()).ToString("H:m:ss");
                        lblHallNo.Text = reader["hallNo"].ToString();
                        lblSeat.Text = reader["seatNo"].ToString();
                        lblMenuId.Text = reader["menuName"].ToString();
                    }

                    reader.Close();
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
    }
}
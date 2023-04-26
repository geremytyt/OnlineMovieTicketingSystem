using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Payment : System.Web.UI.Page
    {
        private decimal paymentAmt = 0;
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the customer cart from session
            List<CartItem> cart = (List<CartItem>)HttpContext.Current.Session["Cart"];

            // Get the custID from session
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();


            // Retrieve the purchaseNo from the session passed from another page
            //string purchaseNo = (string)Session["purchaseNo"];
            string purchaseNo = "P0002";

            
            string query = @"SELECT P.ticketTotal, P.foodTotal, P.childrenQty, P.adultQty, P.seniorQty, T.ticketNo, T.scheduleNo, T.ticketCategory, T.ticketPrice, T.seatNo, S.movieId, S.hallNo, S.scheduleDateTime, M.movieName, M.movieDuration, PM.menuId, Menu.menuName
            FROM Purchase P
            JOIN Ticket T ON P.PurchaseNo = T.PurchaseNo
            JOIN Schedule S ON T.scheduleNo = S.scheduleNo
            JOIN Movie M ON S.movieId = M.movieId
            JOIN PurchaseMenu PM ON P.PurchaseNo = PM.PurchaseNo
            JOIN Menu ON PM.menuId = Menu.menuId
            WHERE P.PurchaseNo = @purchaseNo";


            
            SqlConnection conn = new SqlConnection(cs);

            
            SqlCommand cmd = new SqlCommand(query, conn);
                
                    
            cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);

                    
            conn.Open();

            
            SqlDataReader reader = cmd.ExecuteReader();
                    
            // Check if there is a row of data returned
            if (reader.HasRows)
            {
                // Read the row of data
                reader.Read();

                // Set the label
                lblHallNo.Text = reader["hallNo"].ToString();
                lblShowingDate.Text = ((DateTime)reader["scheduleDateTime"]).ToString("d/M/yyyy");
                lblShowingTime.Text = ((DateTime)reader["scheduleDateTime"]).ToString("H:m:ss");
                lblTitle.Text = reader["movieName"].ToString();
                lblTicketTotal.Text = reader["ticketTotal"].ToString();                          
                lblFoodTotal.Text = reader["foodTotal"].ToString();
                lblTotalChildTicket.Text = reader["childrenQty"].ToString();
                lblTotalAdultTicket.Text = reader["adultQty"].ToString();
                lblTotalSeniorTicket.Text = reader["seniorQty"].ToString();
                string scheduleNo = reader["scheduleNo"].ToString();
                string ticketNo = reader["ticketNo"].ToString();
                string ticketCategory = reader["ticketCategory"].ToString();

                //if (ticketCategory == "Adult")
                //{
                //    lblAdultTicketPrice.Text = reader["ticketPrice"].ToString();
                //    count++;
                //}
                //else if (ticketCategory == "Children")
                //{
                //    lblChildTicketPrice.Text = reader["ticketPrice"].ToString();
                //    count++;
                //}
                //else if (ticketCategory == "Senior")
                //{
                //    lblSeniorTicketPrice.Text = reader["ticketPrice"].ToString();
                //    count++;
                //}
                
                lblSeat.Text = reader["seatNo"].ToString();

                //fill in the repeater
                rptCartItems.DataSource = cart;
                rptCartItems.DataBind();
                double totalFoodPayment = 0;
                foreach (CartItem item in cart)
                {
                    double itemTotal = item.qty * item.menuPrice;
                    totalFoodPayment += itemTotal;
                }

                lblFoodTotal.Text = totalFoodPayment.ToString();

                // Calculate the payment amount by adding the ticket total and food total
                paymentAmt = Convert.ToDecimal(lblTicketTotal.Text) + Convert.ToDecimal(lblFoodTotal.Text);
                lblPaymentAmt.Text = paymentAmt.ToString("C2");    
            }
            



            // CREDIT CARD
            if (!IsPostBack)
            {
                SqlConnection conn2 = new SqlConnection(cs);
                string query2 = "SELECT * FROM Card WHERE custId = @custId";
                SqlCommand cmd2 = new SqlCommand(query2, conn2);
                cmd2.Parameters.AddWithValue("@custId", custId);

                // Create a DataTable object to store the credit cards
                DataTable dt = new DataTable();

                // Create a SqlDataAdapter object to fill the DataTable
                SqlDataAdapter da = new SqlDataAdapter(cmd2);
                        
                // Fill the DataTable with the credit cards
                da.Fill(dt);

                // Bind the DataTable to the dropdownlist
                ddlPaymentMethod.DataSource = dt;
                ddlPaymentMethod.DataTextField = "cardNo"; // use the CardNumber column to display the credit card in the dropdownlist
                                                            //ddlPaymentMethod.DataValueField = "CardId"; // use the CardId column as the value of the credit card in the dropdownlist
                ddlPaymentMethod.DataBind();

                // Add a default "Select a credit card" item to the dropdownlist
                ddlPaymentMethod.Items.Insert(0, new ListItem("Select a credit card", ""));
                ddlPaymentMethod.Items[0].Attributes.Add("disabled", "disabled");
                ddlPaymentMethod.Items.Insert(ddlPaymentMethod.Items.Count, new ListItem("Register a new credit card", "registerCreditCard"));
                                       
            }
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            //Get the customer cart from session
            List<CartItem> cart = (List<CartItem>)HttpContext.Current.Session["Cart"];

            // Get the custID from session
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();

            //If credit card is chosen as payment method
            if (ddlPaymentMethod.SelectedValue != "" && ddlPaymentMethod.SelectedValue != "registerCreditCard")
            {
                string paymentType = "card";
                decimal paymentAmount = paymentAmt;
                string accEmail = "null";
                string transactionNo = "null";
                string status = "completed";
                //string purchaseNo = (string)Session["purchaseNo"];
                string purchaseNo = "P0002";  //create new purchaseNo (increment)
                string cardNo = ddlPaymentMethod.SelectedValue;
                DateTime paymentDateTime = DateTime.Now;
                string formattedDateTime = paymentDateTime.ToString("yyyy-MM-dd H:m:s");

                // Retrieve the last schedule ID from the database
                SqlConnection connection = new SqlConnection(cs);
                
                connection.Open();
                string query = "SELECT MAX(paymentNo) FROM Payment";
                SqlCommand command = new SqlCommand(query, connection);
                object result = command.ExecuteScalar();


                int lastPaymentNo;
                if (result == DBNull.Value)
                {
                    lastPaymentNo = 0;
                }
                else
                {
                    int.TryParse(result.ToString().Substring(2), out lastPaymentNo);
                }

                int newPaymentNo = lastPaymentNo + 1;
                string formattedPaymentNo = string.Format("T{0:D4}", newPaymentNo);
                //lblPaymentNo.Text = formattedPaymentNo;

                double totalFoodPayment = 0;
                foreach (CartItem item in cart)
                {
                    double itemTotal = item.qty * item.menuPrice;
                    totalFoodPayment += itemTotal;
                }

                //Insert purchase details into Purchase table

                //SqlCommand command2 = new SqlCommand("INSERT INTO Purchase (purchaseNo, custId, ticketTotal, foodTotal, childrenQty, adultQty, seniorQty)" +
                //    "VALUES (@purchaseNo, @custId, @ticketTotal, @foodTotal, @childrenQty, @adultQty, @seniorQty)", connection);

                //command2.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                //command2.Parameters.AddWithValue("@custId", custId);
                //command2.Parameters.AddWithValue("@ticketTotal", lblTicketTotal); 
                //command2.Parameters.AddWithValue("@foodTotal", totalFoodPayment);           
                //command2.Parameters.AddWithValue("@childrenQty", lblTotalChildTicket);
                //command2.Parameters.AddWithValue("@adultQty", lblTotalAdultTicket);
                //command2.Parameters.AddWithValue("@seniorQty", lblTotalSeniorTicket);

                //command2.ExecuteNonQuery();

                // Insert the payment details into the Payment table 
                SqlCommand command3 = new SqlCommand("INSERT INTO Payment (paymentNo, purchaseNo, paymentType, paymentDateTime, paymentAmount, accEmail, cardNo, transactionNo, status) " +
                "VALUES (@paymentNo, @purchaseNo, @paymentType, @paymentDateTime, @paymentAmount, @accEmail, @cardNo, @transactionNo, @status)", connection);
                    
                command3.Parameters.AddWithValue("@paymentNo", formattedPaymentNo);
                command3.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                command3.Parameters.AddWithValue("@paymentType", paymentType);
                command3.Parameters.AddWithValue("@paymentDateTime", formattedDateTime);
                command3.Parameters.AddWithValue("@paymentAmount", paymentAmount);
                command3.Parameters.AddWithValue("@accEmail", accEmail);
                command3.Parameters.AddWithValue("@cardNo", cardNo);
                command3.Parameters.AddWithValue("@transactionNo", transactionNo);
                command3.Parameters.AddWithValue("@status", status);

                command3.ExecuteNonQuery();

                connection.Close();

                Response.Redirect("PaymentSummary.aspx?paymentNo=" + formattedPaymentNo);          
            }
        }

        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlPaymentMethod.SelectedValue;
            if (selectedValue == "registerCreditCard")
            {
                // Redirect the user to the page for registering a new credit card
                Response.Redirect("PaymentMethod.aspx");
            }
            else if (!string.IsNullOrEmpty(selectedValue))
            {
                // Do something with the selected credit card value (e.g., retrieve more information from the database)
                // ...
            }
        }
            
    }
}

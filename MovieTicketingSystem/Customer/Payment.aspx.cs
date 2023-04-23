using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPal.Api;

namespace MovieTicketingSystem.View
{
    public partial class Payment : System.Web.UI.Page
    {
        private decimal paymentAmt = 0;
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get the custID from session
            //string custId = (int)Session["custId"];
            string custId = "C001";

            // Retrieve the purchaseNo from the session passed from another page
            //string purchaseNo = (string)Session["purchaseNo"];
            string purchaseNo = "P0005";


            string query = @"SELECT P.ticketTotal, P.foodTotal, T.scheduleNo, T.ticketCategory, T.ticketPrice, T.seatNo, S.movieId, S.hallNo, S.scheduleDateTime, M.movieName, M.movieDuration, PM.menuId, Menu.menuName
            FROM Purchase P
            JOIN Ticket T ON P.PurchaseNo = T.PurchaseNo
            JOIN Schedule S ON T.scheduleNo = S.scheduleNo
            JOIN Movie M ON S.movieId = M.movieId
            JOIN PurchaseMenu PM ON P.PurchaseNo = PM.PurchaseNo
            JOIN Menu ON PM.menuId = Menu.menuId
            WHERE P.PurchaseNo = @purchaseNo";


            // Create a new SqlConnection object to connect to the database using the using statement
            using (SqlConnection conn = new SqlConnection(cs))
            {
                // Create a new SqlCommand object using the using statement
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add the purchaseNo parameter to the command
                    cmd.Parameters.AddWithValue("@purchaseNo", purchaseNo);

                    // Open the database connection
                    conn.Open();

                    // Execute the query and retrieve the results
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Check if there is a row of data returned
                        if (reader.HasRows)
                        {
                            // Read the row of data
                            reader.Read();

                            // Set the label
                            lblTicketTotal.Text = reader["ticketTotal"].ToString();                          
                            lblFoodTotal.Text = reader["foodTotal"].ToString();                           
                            string scheduleNo = reader["scheduleNo"].ToString();                          
                            //lblTicketCategory.Text = reader["ticketCategory"].ToString();                          
                            //lblTicketPrice.Text = reader["ticketPrice"].ToString();                          
                            lblSeat.Text = reader["seatNo"].ToString();

                            // Calculate the payment amount by adding the ticket total and food total
                            paymentAmt = Convert.ToDecimal(lblTicketTotal.Text) + Convert.ToDecimal(lblFoodTotal.Text);
                            lblPaymentAmt.Text = paymentAmt.ToString("C2");

                            lblHallNo.Text = reader["hallNo"].ToString();
                            lblShowingDate.Text = ((DateTime)reader["scheduleDateTime"]).ToString("d/M/yyyy");
                            lblShowingTime.Text = ((DateTime)reader["scheduleDateTime"]).ToString("H:m:ss");
                            lblTitle.Text = reader["movieName"].ToString();

                            //lblFoodPurchased.Text = reader["menuName"].ToString();

                            string foodPurchased = ""; // initialize an empty string to store the food purchased data
                            while (reader.Read())
                            {
                                // Get the menu name for the current row and add it to the foodPurchased string
                                foodPurchased += reader["menuName"].ToString() + ", ";
                            }
                            // Remove the trailing comma and space from the foodPurchased string
                            if (foodPurchased.Length > 2)
                            {
                                foodPurchased = foodPurchased.Substring(0, foodPurchased.Length - 2);
                            }
                            lblFoodPurchased.Text = foodPurchased;
                        }
                    }
                    
                }
            }



            // CREDIT CARD
            if (!IsPostBack)
            {
                // Create a SqlConnection object to connect to the database
                using (SqlConnection conn2 = new SqlConnection(cs))
                {


                    // Define the SQL query to retrieve the credit cards associated with the custID
                    string query2 = "SELECT * FROM Card WHERE custId = @custId";

                    // Create a new SqlCommand object
                    using (SqlCommand cmd2 = new SqlCommand(query2, conn2))
                    {
                        // Add the custID parameter to the command
                        cmd2.Parameters.AddWithValue("@custId", custId);

                        // Create a DataTable object to store the credit cards
                        DataTable dt = new DataTable();

                        // Create a SqlDataAdapter object to fill the DataTable
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd2))
                        {
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
                }


                
            }
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            //If credit card is chosen as payment method
            if (ddlPaymentMethod.SelectedValue != "" && ddlPaymentMethod.SelectedValue != "registerCreditCard")
            {
                string paymentType = "card";
                decimal paymentAmount = paymentAmt;
                string accEmail = "null";
                string transactionNo = "null";
                string status = "completed";
                //string purchaseNo = (string)Session["purchaseNo"];
                string purchaseNo = "P0002";
                string cardNo = ddlPaymentMethod.SelectedValue;
                DateTime paymentDateTime = DateTime.Now;
                string formattedDateTime = paymentDateTime.ToString("d/M/yyyy H:m:s");

                // Retrieve the last schedule ID from the database
                using (SqlConnection connection = new SqlConnection(cs))
                {
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

                    // Insert the payment details into the Payment table using SQL
                    using (SqlCommand command2 = new SqlCommand("INSERT INTO Payment (paymentNo, purchaseNo, paymentType, paymentDateTime, paymentAmount, accEmail, cardNo, transactionNo, status) " +
                        "VALUES (@paymentNo, @purchaseNo, @paymentType, @paymentDateTime, @paymentAmount, @accEmail, @cardNo, @transactionNo, @status)", connection))
                    {
                        command2.Parameters.AddWithValue("@paymentNo", formattedPaymentNo);
                        command2.Parameters.AddWithValue("@purchaseNo", purchaseNo);
                        command2.Parameters.AddWithValue("@paymentType", paymentType);
                        command2.Parameters.AddWithValue("@paymentDateTime", formattedDateTime);
                        command2.Parameters.AddWithValue("@paymentAmount", paymentAmount);
                        command2.Parameters.AddWithValue("@accEmail", accEmail);
                        command2.Parameters.AddWithValue("@cardNo", cardNo);
                        command2.Parameters.AddWithValue("@transactionNo", transactionNo);
                        command2.Parameters.AddWithValue("@status", status);

                        command2.ExecuteNonQuery();
                    }
                    Response.Redirect("PaymentSummary.aspx?paymentNo=" + formattedPaymentNo);
                }
                
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

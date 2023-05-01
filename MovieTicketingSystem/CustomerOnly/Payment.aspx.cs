using MovieTicketingSystem.Model;
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
            List<Ticket> tickets = (List<Ticket>)HttpContext.Current.Session["Tickets"];

            // Get the custID from session
            HttpCookie cookie = Request.Cookies["Customer"];
            Schedule s = (Schedule)Session["schedule"];
            string custId = cookie.Value.ToString();

            HttpCookie cookie2 = Request.Cookies["movieName"];
            
            
            lblTitle.Text = cookie2.Value;

            int childTicketCount = 0;
            decimal childTicketPrice = 0;
            int adultTicketCount = 0;
            decimal adultTicketPrice = 0;
            int seniorTicketCount = 0;
            decimal seniorTicketPrice = 0;
            decimal ticketTotal = 0;

            if(tickets != null)
            {
                foreach (Ticket ticket in tickets)
                {
                    string scheduleNo = ticket.scheduleNo;
                    string ticketCategory = ticket.ticketCategory;
                    decimal ticketPrice = ticket.ticketPrice;
                    //string seatNo = ticket.seatNo;

                    if (ticketCategory == "Children")
                    {
                        childTicketCount++;
                        childTicketPrice = ticketPrice;
                        ticketTotal = ticketTotal + ticketPrice;
                    }
                    else if (ticketCategory == "Adult")
                    {
                        adultTicketCount++;
                        adultTicketPrice = ticketPrice;
                        ticketTotal = ticketTotal + ticketPrice;
                    }
                    else if (ticketCategory == "Senior")
                    {
                        seniorTicketCount++;
                        seniorTicketPrice = ticketPrice;
                        ticketTotal = ticketTotal + ticketPrice;
                    }


                    //get ticket schedule details
              
                    lblHallNo.Text = s.Hall.hallNo;

                    // Split the scheduleDateTime value into date and time
                    string scheduleDateTime = s.scheduleDateTime.ToString();
                    string[] dateTimeParts = scheduleDateTime.Split(' ');
                    lblShowingDate.Text = dateTimeParts[0];
                    lblShowingTime.Text = dateTimeParts[1];

                    lblTicketTotal.Text = string.Format("RM {0:#,##0.00}", ticketTotal);
                    lblChildTicketQty.Text = string.Format("(RM {0:#,##0.00} x {1})", childTicketPrice, childTicketCount);
                    lblAdultTicketQty.Text = string.Format("(RM {0:#,##0.00} x {1})", adultTicketPrice, adultTicketCount);
                    lblSeniorTicketQty.Text = string.Format("(RM {0:#,##0.00} x {1})", seniorTicketPrice, seniorTicketCount);

                    lblTotalChildTicketPrice.Text = string.Format("RM {0:#,##0.00}", childTicketCount * childTicketPrice);
                    lblTotalAdultTicketPrice.Text = string.Format("RM {0:#,##0.00}", adultTicketCount * adultTicketPrice);
                    lblTotalSeniorTicketPrice.Text = string.Format("RM {0:#,##0.00}", seniorTicketCount * seniorTicketPrice);

                    //get all the seat selected
                    Label lblSeat = new Label();
                    lblSeat.Text = ticket.seatNo.ToString();
                    lblSeat.CssClass = "m-2";
                    seatContainer.Controls.Add(lblSeat);

                }
            }
            else
            {
                movieDetails.Visible = false;
                ticketDetails.Visible = false;
            }
            

            //Dont display if null
            if (childTicketCount == 0)
            {
                lblChild.Visible = false;
                lblChildTicketQty.Visible = false;
                lblTotalChildTicketPrice.Visible = false;
            }

            if (adultTicketCount == 0)
            {
                lblAdult.Visible = false;
                lblAdultTicketQty.Visible = false;
                lblTotalAdultTicketPrice.Visible = false;
            }

            if (seniorTicketCount == 0)
            {
                lblSenior.Visible = false;
                lblSeniorTicketQty.Visible = false;
                lblTotalSeniorTicketPrice.Visible = false;
            }

            //fill in the repeater
            double totalFoodPayment = 0;
            if (cart != null)
            {
                rptCartItems.DataSource = cart;
                rptCartItems.DataBind();   
                foreach (CartItem item in cart)
                {
                    double itemTotal = item.qty * item.menuPrice;
                    totalFoodPayment += itemTotal;
                }

                lblFoodTotal.Text = string.Format("RM {0:#,##0.00}", totalFoodPayment);
            }
            else
            {
                cartDetails.Visible=false;
            }
            
            // Calculate the payment amount by adding the ticket total and food total
            paymentAmt = Convert.ToDecimal(ticketTotal) + Convert.ToDecimal(totalFoodPayment);
            lblPaymentAmt.Text = string.Format("RM {0:#,##0.00}", paymentAmt);

            

            if (!IsPostBack)
            {
                
                // CREDIT CARD
                SqlConnection conn2 = new SqlConnection(cs);
                string query2 = "SELECT * FROM Card WHERE custId = @custId";
                SqlCommand cmd2 = new SqlCommand(query2, conn2);
                cmd2.Parameters.AddWithValue("@custId", custId);
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd2);
                da.Fill(dt);

                // Bind the DataTable to the dropdownlist
                ddlPaymentMethod.DataSource = dt;
                ddlPaymentMethod.DataTextField = "cardNo";
                ddlPaymentMethod.DataBind();

                // Loop through the credit cards in the DataTable
                foreach (DataRow dr in dt.Rows)
                {
                    // Get the expiry date of the credit card
                    DateTime expiryDate = DateTime.Parse(dr["expiryDate"].ToString());

                    // Check if the credit card has expired
                    if (expiryDate < DateTime.Today)
                    {
                        
                        //cannot be selected
                        ddlPaymentMethod.Items.FindByValue(dr["cardNo"].ToString()).Attributes.Add("disabled", "disabled");
                    }
                }

                // Add a default "Select a credit card" item to the dropdownlist
                ddlPaymentMethod.Items.Insert(0, new ListItem("Select a credit card", ""));
                ddlPaymentMethod.Items[0].Attributes.Add("disabled", "disabled");
                ddlPaymentMethod.Items.Insert(ddlPaymentMethod.Items.Count, new ListItem("Register a new credit card", "registerCreditCard"));

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //Reset Ticket and Cart Session
            Session.Remove("Cart");
            Session.Remove("Tickets");
            Session.Remove("Schedule");
            Response.Redirect("~/Annonymous/Home.aspx");
        }


        protected void btnProceed_Click(object sender, EventArgs e)
        {
            if (ddlPaymentMethod.SelectedValue != "registerCreditCard" && ddlPaymentMethod.SelectedValue != "" && ddlPaymentMethod.SelectedItem != null && ddlPaymentMethod.SelectedItem.Enabled)
            {   
                //Get the customer cart from session
                List<CartItem> cart = (List<CartItem>)HttpContext.Current.Session["Cart"];
                List<Ticket> tickets = (List<Ticket>)HttpContext.Current.Session["Tickets"];

                // Get the custID from cookie
                HttpCookie cookie = Request.Cookies["Customer"];
                string custId = cookie.Value.ToString();

                //get last purchase no
                SqlConnection connection = new SqlConnection(cs);
                connection.Open();
                string query = "SELECT MAX(purchaseNo) FROM Purchase";
                SqlCommand command = new SqlCommand(query, connection);
                object result = command.ExecuteScalar();

                int lastPurchaseNo;
                if (result == DBNull.Value)
                {
                    lastPurchaseNo = 0;
                }
                else
                {
                    int.TryParse(result.ToString().Substring(2), out lastPurchaseNo);
                }

                int newPurchaseNo = lastPurchaseNo + 1;
                string formattedPurchaseNo = string.Format("P{0:D4}", newPurchaseNo);

                int childTicketCount = 0;
                decimal childTicketPrice = 0;
                int adultTicketCount = 0;
                decimal adultTicketPrice = 0;
                int seniorTicketCount = 0;
                decimal seniorTicketPrice = 0;
                decimal ticketTotal = 0;

                if (tickets != null)
                {
                    foreach (Ticket ticket in tickets)
                    {
                        string scheduleNo = ticket.scheduleNo;
                        string ticketCategory = ticket.ticketCategory;
                        decimal ticketPrice = ticket.ticketPrice;
                        //string seatNo = ticket.seatNo;

                        if (ticketCategory == "Children")
                        {
                            childTicketCount++;
                            childTicketPrice = ticketPrice;
                            ticketTotal = ticketTotal + ticketPrice;
                        }
                        else if (ticketCategory == "Adult")
                        {
                            adultTicketCount++;
                            adultTicketPrice = ticketPrice;
                            ticketTotal = ticketTotal + ticketPrice;
                        }
                        else if (ticketCategory == "Senior")
                        {
                            seniorTicketCount++;
                            seniorTicketPrice = ticketPrice;
                            ticketTotal = ticketTotal + ticketPrice;
                        }
                    }
                }

                double totalFoodPayment = 0;

                if (cart != null)
                {
                    foreach (CartItem item in cart)
                    {
                        double itemTotal = item.qty * item.menuPrice;
                        totalFoodPayment += itemTotal;
                    }
                }

                //Create new purchase and insert purchase details into Purchase table     

                SqlCommand command2 = new SqlCommand("INSERT INTO Purchase (purchaseNo, custId, ticketTotal, foodTotal, childrenQty, adultQty, seniorQty)" +
                    "VALUES (@purchaseNo, @custId, @ticketTotal, @foodTotal, @childrenQty, @adultQty, @seniorQty)", connection);

                command2.Parameters.AddWithValue("@purchaseNo", formattedPurchaseNo);
                command2.Parameters.AddWithValue("@custId", custId);
                command2.Parameters.AddWithValue("@ticketTotal", ticketTotal);
                command2.Parameters.AddWithValue("@foodTotal", totalFoodPayment);
                command2.Parameters.AddWithValue("@childrenQty", childTicketCount);
                command2.Parameters.AddWithValue("@adultQty", adultTicketCount);
                command2.Parameters.AddWithValue("@seniorQty", seniorTicketCount);

                command2.ExecuteNonQuery();

                //Create new payment and insert payment details into Payment table
                string paymentType = "card";
                decimal paymentAmount = Convert.ToDecimal(ticketTotal) + Convert.ToDecimal(totalFoodPayment);
                string accEmail = "null";
                string transactionNo = "null";
                string status = "Completed";
                string cardNo = ddlPaymentMethod.SelectedValue;
                DateTime paymentDateTime = DateTime.Now;
                string formattedDateTime = paymentDateTime.ToString("yyyy-MM-dd H:m:s");

                // Retrieve the last schedule ID from the database

                query = "SELECT MAX(paymentNo) FROM Payment";
                command = new SqlCommand(query, connection);
                result = command.ExecuteScalar();

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

                // Insert the payment details into the Payment table 
                SqlCommand command3 = new SqlCommand("INSERT INTO Payment (paymentNo, purchaseNo, paymentType, paymentDateTime, paymentAmount, accEmail, cardNo, transactionNo, status) " +
                "VALUES (@paymentNo, @purchaseNo, @paymentType, @paymentDateTime, @paymentAmount, @accEmail, @cardNo, @transactionNo, @status)", connection);

                command3.Parameters.AddWithValue("@paymentNo", formattedPaymentNo);
                command3.Parameters.AddWithValue("@purchaseNo", formattedPurchaseNo);
                command3.Parameters.AddWithValue("@paymentType", paymentType);
                command3.Parameters.AddWithValue("@paymentDateTime", formattedDateTime);
                command3.Parameters.AddWithValue("@paymentAmount", paymentAmount);
                command3.Parameters.AddWithValue("@accEmail", accEmail);
                command3.Parameters.AddWithValue("@cardNo", cardNo);
                command3.Parameters.AddWithValue("@transactionNo", transactionNo);
                command3.Parameters.AddWithValue("@status", status);

                command3.ExecuteNonQuery();

                //Insert Tickets into Ticket table
                if (tickets != null)
                {
                    foreach (Ticket ticket in tickets)
                    {
                        string scheduleNo = ticket.scheduleNo;
                        string ticketCategory = ticket.ticketCategory;
                        decimal ticketPrice = ticket.ticketPrice;
                        string seatNo = ticket.seatNo;

                        SqlCommand command4 = new SqlCommand("INSERT INTO Ticket (purchaseNo, scheduleNo, ticketCategory, ticketPrice, seatNo) " +
                        "VALUES (@purchaseNo, @scheduleNo, @ticketCategory, @ticketPrice, @seatNo)", connection);

                        command4.Parameters.AddWithValue("@purchaseNo", formattedPurchaseNo);
                        command4.Parameters.AddWithValue("@scheduleNo", scheduleNo);
                        command4.Parameters.AddWithValue("@ticketCategory", ticketCategory);
                        command4.Parameters.AddWithValue("@ticketPrice", ticketPrice);
                        command4.Parameters.AddWithValue("@seatNo", seatNo);

                        command4.ExecuteNonQuery();
                    }
                }

                //Insert Food purchased into PurchaseMeny table
                if (cart != null)
                {
                    foreach (CartItem item in cart)
                    {
                        string menuId = item.menuID;
                        int menuQty = item.qty;

                        SqlCommand command5 = new SqlCommand("INSERT INTO PurchaseMenu (menuId, purchaseNo, menuQty) " +
                        "VALUES (@menuId, @purchaseNo, @menuQty)", connection);

                        command5.Parameters.AddWithValue("@menuId", menuId);
                        command5.Parameters.AddWithValue("@purchaseNo", formattedPurchaseNo);
                        command5.Parameters.AddWithValue("@menuQty", menuQty);


                        command5.ExecuteNonQuery();
                    }
                }

                connection.Close();

                Response.Redirect("PaymentSummary.aspx?paymentNo=" + formattedPaymentNo);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please select a credit card')", true);
            }
        }

        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();

            // Disable the expired credit cards
            foreach (ListItem item in ddlPaymentMethod.Items)
            {
                if (item.Value != "" && item.Value != "registerCreditCard")
                {
                    // Get the expiry date of the credit card
                    SqlConnection conn = new SqlConnection(cs);
                    string query = "SELECT expiryDate FROM Card WHERE cardNo = @cardNo AND custId = @custId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@cardNo", item.Value);
                    cmd.Parameters.AddWithValue("@custId", custId);
                    conn.Open();
                    DateTime expiryDate = DateTime.Parse(cmd.ExecuteScalar().ToString());
                    conn.Close();

                    // Check if the credit card has expired
                    if (expiryDate < DateTime.Today)
                    {
                        // Disable the credit card
                        item.Attributes.Add("disabled", "disabled");
                    }
                    else
                    {
                        // Enable the credit card
                        item.Attributes.Remove("disabled");
                    }
                }
            }

            string selectedValue = ddlPaymentMethod.SelectedValue;
            if (selectedValue == "registerCreditCard")
            {
                // Redirect the user to the page for registering a new credit card
                Response.Redirect("~/CustomerOnly/PaymentMethod.aspx");
            }
        }


    }
}

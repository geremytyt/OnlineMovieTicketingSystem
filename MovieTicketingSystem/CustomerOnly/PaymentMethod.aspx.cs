using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class PaymentMethod : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect the user back to payment page
            Response.Redirect("~/CustomerOnly/Payment.aspx");
        }


        protected void btnCardConfirm_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Get the values of the card details
                string cardHolderName = txtCardName.Text;
                string cardNo = txtCardNo.Text;
                string cvv = txtCvv.Text;

                // Get the selected values of the dropdowns
                string selectedMonth = ddlMonths.SelectedValue;
                string selectedYear = ddlYears.SelectedValue;

                // Set the default day to 01
                string selectedDay = "01";

                // Combine the selected values to form the expiryDate in the desired format
                string expiryDate = selectedDay + "/" + selectedMonth + "/" + selectedYear;

                // Get the custID from cookie
                HttpCookie cookie = Request.Cookies["Customer"];
                string custId = cookie.Value.ToString();
                try
                {
                    SqlConnection connection = new SqlConnection(cs);

                    connection.Open();

                    SqlCommand command = new SqlCommand("INSERT INTO Card (cardNo, custID, cvv, cardHolderName, expiryDate) VALUES (@cardNo, @custID, @cvv, @cardHolderName, @expiryDate)", connection);

                    command.Parameters.AddWithValue("@cardNo", cardNo);
                    command.Parameters.AddWithValue("@custID", custId);
                    command.Parameters.AddWithValue("@cvv", cvv);
                    command.Parameters.AddWithValue("@cardHolderName", cardHolderName);
                    command.Parameters.AddWithValue("@expiryDate", expiryDate);

                    command.ExecuteNonQuery();

                    // Redirect the user back to payment page
                    Response.Redirect("~/CustomerOnly/Payment.aspx");


                    connection.Close();
                }
                catch (SqlException)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                }

            }

        }

        protected void cvCardExists_ServerValidate(object source, ServerValidateEventArgs args)
        {
            HttpCookie cookie = Request.Cookies["Customer"];
            string custId = cookie.Value.ToString();

            string cardNo = txtCardNo.Text;
            try
            {
                SqlConnection connection = new SqlConnection(cs);
                SqlCommand checkCommand = new SqlCommand("SELECT COUNT(*) FROM Card WHERE cardNo = @cardNo AND custId = @custId", connection);
                checkCommand.Parameters.AddWithValue("@cardNo", cardNo);
                checkCommand.Parameters.AddWithValue("@custId", custId);
                connection.Open();
                int cardCount = (int)checkCommand.ExecuteScalar();
                connection.Close();

                args.IsValid = (cardCount == 0);
            }
            catch (SqlException)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
            }
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }

    }
}
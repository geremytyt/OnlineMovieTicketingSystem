﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.View
{
    public partial class PaymentMethod : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnPaymentConfirm_Click(object sender, EventArgs e)
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


            string custID = "C001";

            // Insert the card details into the Card table using SQL
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\gerem\\Downloads\\App_Data\\MovieDB.mdf;Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("INSERT INTO Card (cardNo, custID, cvv, cardHolderName, expiryDate) VALUES (@cardNo, @custID, @cvv, @cardHolderName, @expiryDate)", connection))
                {
                    command.Parameters.AddWithValue("@cardNo", cardNo);
                    command.Parameters.AddWithValue("@custID", custID);
                    command.Parameters.AddWithValue("@cvv", cvv);
                    command.Parameters.AddWithValue("@cardHolderName", cardHolderName);
                    command.Parameters.AddWithValue("@expiryDate", expiryDate);

                    command.ExecuteNonQuery();
                }
            }

            // Redirect the user back to payment page
            Response.Redirect("Payment.aspx");
        }
    }
}
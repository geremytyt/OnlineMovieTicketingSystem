using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.View
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            Server.Transfer("PaymentMethod.aspx");
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
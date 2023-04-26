using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ViewPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void paymentGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string paymentNo = paymentGridView.DataKeys[row.RowIndex]["paymentNo"].ToString();
            Response.Redirect("managePayment.aspx?paymentNo=" + paymentNo);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Tickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt2 = (Repeater)e.Item.FindControl("Repeater2");
                Repeater rpt3 = (Repeater)e.Item.FindControl("Repeater3");
                // Extract the value from the desired column of the data item
                string columnValue = DataBinder.Eval(e.Item.DataItem, "paymentNo").ToString(); // Replace "ColumnName" with the actual column name

                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource2.SelectParameters["paymentNo"].DefaultValue = columnValue;

                SqlDataSource3.SelectParameters["paymentNo"].DefaultValue = columnValue;

                rpt2.DataBind();

                rpt3.DataBind();
            }
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void btnTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect("Tickets.aspx");
        }

        protected void btnHistory_Click(object sender, EventArgs e)
        {
            Response.Redirect("History.aspx");
        }

        protected void btnResetPwd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ResetPassword.aspx");
        }
    }
}
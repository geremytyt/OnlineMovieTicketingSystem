using MovieTicketingSystem.Model;
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
        int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Customer cust = (Customer)Session["Customer"];
            if (cust != null)
            {
                DateTime currentTime = DateTime.Now;
                DateTime newTime = currentTime.AddHours(2);
                SqlDataSource1.SelectParameters["custId"].DefaultValue = cust.custId.ToString();
                SqlDataSource1.SelectParameters["scheduleDateTime"].DefaultValue = newTime.ToString("yyyy-MM-dd HH:mm:ss");
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt2 = (Repeater)e.Item.FindControl("Repeater2");
                Repeater rpt3 = (Repeater)e.Item.FindControl("Repeater3");
                // Extract the value from the desired column of the data item

                string columnValue = DataBinder.Eval(e.Item.DataItem, "paymentNo").ToString(); // Replace "ColumnName" with the actual column name
                count++;
                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource2.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt2.DataSource = SqlDataSource2;
                rpt2.DataBind();
                SqlDataSource3.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt3.DataSource = SqlDataSource3;
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
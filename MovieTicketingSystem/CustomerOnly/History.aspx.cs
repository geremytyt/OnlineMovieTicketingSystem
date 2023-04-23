using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class History : System.Web.UI.Page
    {
        private string foodTotal;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Repeater4_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt5 = (Repeater)e.Item.FindControl("Repeater5");
                Repeater rpt6 = (Repeater)e.Item.FindControl("Repeater6");
                // Extract the value from the desired column of the data item
                string columnValue = DataBinder.Eval(e.Item.DataItem, "paymentNo").ToString(); // Replace "ColumnName" with the actual column name
               
                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource5.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt5.DataSource = SqlDataSource5;
                rpt5.DataBind();

                SqlDataSource6.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt6.DataSource = SqlDataSource6;
                rpt6.DataBind();

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

        protected void Repeater6_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                foodTotal = DataBinder.Eval(e.Item.DataItem, "foodTotal").ToString();
            }
                if (e.Item.ItemType == ListItemType.Footer)
            {

               ((Label)e.Item.FindControl("Label15")).Text = foodTotal;
  

            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//step 1 import library
using System.Data.SqlClient;
using System.Text;
using System.Runtime.Remoting.Messaging;
using System.ComponentModel;

namespace MovieTicketingSystem.Annonymous
{
    public partial class Food : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_addToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Label lblName = (Label)item.FindControl("LblName");
            Label LblPrice = (Label)item.FindControl("LblPrice");
            Label LblRemarks = (Label)item.FindControl("LblRemarks");
            TextBox txtQty = (TextBox)item.FindControl("txtQty");


            Console.Write("Hello");
            Response.Redirect("cart.aspx");
        }

    }
}
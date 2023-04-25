using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //get default vlaue to be change to whenappilying session
            if (!IsPostBack)
            {
                List<CartItem> cart = (List<CartItem>)Session["Cart"];

                cartList.DataSource = cart;
                cartList.DataBind();
            }
        }

        protected void cartList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                CartItem currentItem = (CartItem)e.Item.DataItem;
                //do ur rocessing here
            }
        }

        protected void btn_proceed_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx");
        }
    }
}
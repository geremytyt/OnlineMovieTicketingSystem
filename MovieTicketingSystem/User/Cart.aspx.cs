using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.View
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //get default vlaue to be change to whenappilying session
            if (!IsPostBack)
            {
                List<CartItem> cartItems = new List<CartItem>();

                cartItems.Add(new CartItem("M001", "Popcorn (Orginal)", 9.00, 1, "../Image/Popcorn (Orginal).jpg"));
                cartItems.Add(new CartItem("M003", "Coa-cola", 2.20, 2, "../Image/Coca-cola.jpg"));

                cartList.DataSource = cartItems;
                cartList.DataBind();
            }
        }

        //inner class
        private class CartItem
        {
            public string menuID { get; set; }
            public string menuName { get; set; }
            public double menuPrice { get; set; }
            public int qty { get; set; }
            public double totalPrice { get; set; }
            public string menuUrl { get; set; }

            public CartItem(string menuID, string menuName, double menuPrice, int qty, string menuUrl)
            {
                this.menuID = menuID;
                this.menuName = menuName;
                this.menuPrice = menuPrice;
                this.qty = qty;
                this.totalPrice = menuPrice * qty;
                this.menuUrl = menuUrl;
            }

            private CartItem()
            {

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
    }

}
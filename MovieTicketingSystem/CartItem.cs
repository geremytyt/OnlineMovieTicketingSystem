using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MovieTicketingSystem
{
    public class CartItem
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
}
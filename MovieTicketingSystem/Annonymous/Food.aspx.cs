﻿using System;
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
using MovieTicketingSystem.CustomerOnly;
using MovieTicketingSystem.ManagerOnly;
using System.Security.Policy;

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
            Label lblId = (Label)item.FindControl("LBlId");
            Label lblName = (Label)item.FindControl("LblName");
            Label LblPrice = (Label)item.FindControl("LblPrice");
            Label lblUrl = (Label)item.FindControl("lblUrl");
            TextBox txtQty = (TextBox)item.FindControl("txtQty");

            double price = double.Parse(LblPrice.Text.ToString().Substring(2));
            
            String id = lblId.Text.ToString();
            String name = lblName.Text.ToString();
            int qty = int.Parse( txtQty.Text.ToString());
            String url = lblUrl.Text.ToString();
           
            System.Diagnostics.Debug.WriteLine(url);

            if (Session["Cart"] == null)
            {
                List<CartItem> cart = new List<CartItem>();

                cart.Add(new CartItem(id, name, price, qty, url));
                Session["Cart"] = cart;
            }
            else
            {
                List<CartItem> cart = (List<CartItem>)Session["Cart"];
                Boolean found = false;
                
                foreach (var cartItem in cart)
                {
                    if(cartItem.menuID.Equals(id))
                    {
                        cartItem.qty += qty;
                        found = true;
                    }                    
                }

                if (found == false)
                {
                    cart.Add(new CartItem(id, name, price, qty, url));
                }

                Session["Cart"] = cart;
            }

            Response.Redirect("../CustomerOnly/Cart.aspx");
        }

        protected void repMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ((RangeValidator)e.Item.FindControl("RVQty")).ValidationGroup = ((TextBox)e.Item.FindControl("txtQty")).UniqueID;
                ((ValidationSummary)e.Item.FindControl("VS1")).ValidationGroup = ((TextBox)e.Item.FindControl("txtQty")).UniqueID;
                ((RequiredFieldValidator)e.Item.FindControl("RFVQty")).ValidationGroup = ((TextBox)e.Item.FindControl("txtQty")).UniqueID;
                ((Button)e.Item.FindControl("btn_add_to_cart")).ValidationGroup = ((TextBox)e.Item.FindControl("txtQty")).UniqueID;
            }
        }
    }
}
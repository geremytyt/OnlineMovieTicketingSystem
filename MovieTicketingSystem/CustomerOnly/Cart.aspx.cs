using MovieTicketingSystem.Annonymous;
using MovieTicketingSystem.ManagerOnly;
using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //get default vlaue to be change to when appilying session
            
            if (!IsPostBack) {
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

        protected void btn_back_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Annonymous/Food.aspx");
        }

        protected void cartList_PreRender(object sender, EventArgs e)
        {
            if(cartList.Items.Count < 1)
            {
                NoRecords.Visible = true;
                cartList.Visible = false;
                btn_proceed.Enabled = false;
            }
        }

        protected void btnDetele_Click(object sender, EventArgs e)
        {
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Label lblId = (Label)item.FindControl("LBlId");
            CartItem removeItem = new CartItem();

            foreach(CartItem cartItem in cart)
            {
                if (cartItem.menuID.Equals(lblId.Text.ToString()))
                {
                    removeItem = cartItem;
                }
            }

            cart.Remove(removeItem);
            Session["Cart"] = cart;

            Response.Redirect("Cart.aspx");
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Button btnEdit = (Button)item.FindControl("btnEdit");
            Button btnDetele = (Button)item.FindControl("btnDetele");
            Button btnConfirm = (Button)item.FindControl("btnConfirm");
            Button btnCancel = (Button)item.FindControl("btnCancel");
            TextBox lblQty = (TextBox)item.FindControl("lblQty");

            lblQty.ReadOnly = false;
            btnEdit.Visible = false;
            btnDetele.Visible = false;
            btnConfirm.Visible = true;
            btnCancel.Visible = true;
            btn_proceed.Enabled = false;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Button btnEdit = (Button)item.FindControl("btnEdit");
            Button btnDetele = (Button)item.FindControl("btnDetele");
            Button btnConfirm = (Button)item.FindControl("btnConfirm");
            Button btnCancel = (Button)item.FindControl("btnCancel");
            TextBox lblQty = (TextBox)item.FindControl("lblQty");
            Label LBlId = (Label)item.FindControl("LBlId");

            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            CartItem modifyItem = new CartItem();

            foreach (CartItem cartItem in cart)
            {
                if (cartItem.menuID.Equals(LBlId.Text.ToString()))
                {
                    cartItem.qty = int.Parse( lblQty.Text.ToString());
                    cartItem.totalPrice = cartItem.qty * cartItem.menuPrice;
                    break;
                }
            }
           
            Session["Cart"] = cart;

            Response.Redirect("Cart.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Button btnEdit = (Button)item.FindControl("btnEdit");
            Button btnDetele = (Button)item.FindControl("btnDetele");
            Button btnConfirm = (Button)item.FindControl("btnConfirm");
            Button btnCancel = (Button)item.FindControl("btnCancel");
            TextBox lblQty = (TextBox)item.FindControl("lblQty");
            Label LBlId = (Label)item.FindControl("LBlId");

            btnEdit.Visible = true;
            btnDetele.Visible = true;
            btn_proceed.Enabled = true;
            btnConfirm.Visible = false;
            btnCancel.Visible = false;
            lblQty.ReadOnly = true;
        }
    }
}
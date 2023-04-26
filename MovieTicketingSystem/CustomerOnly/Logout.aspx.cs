using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Annonymous/Home.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                FormsAuthentication.SignOut();
                Session.Abandon();
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                if(authCookie != null)
                {
                    authCookie.Expires = DateTime.Now.AddDays(-1);
                }
                Response.Cookies.Remove("Customer");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('You have been logged out successfully'); window.location.href='../Annonymous/Home.aspx';", true);

            }
        }
    }
}
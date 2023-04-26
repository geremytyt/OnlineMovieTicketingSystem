using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class MiddlePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                // Get the current user's role
                if (HttpContext.Current.User.IsInRole("Customer"))
                {
                    Response.Redirect("Home.aspx");
                }
                else if (HttpContext.Current.User.IsInRole("Staff") || HttpContext.Current.User.IsInRole("Manager"))
                {
                    Response.Redirect("../Staff/StaffMovie.aspx");
                }
            }
        }
    }
}
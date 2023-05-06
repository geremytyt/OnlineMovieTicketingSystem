using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.ErrorPages
{
    public partial class FileNotFound : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                // Get the current user's role
                if (HttpContext.Current.User.IsInRole("Customer"))
                {
                    Response.Redirect("../Annonymous/Home.aspx");
                }
                else if (HttpContext.Current.User.IsInRole("Staff") || HttpContext.Current.User.IsInRole("Manager"))
                {
                    Response.Redirect("../StaffOnly/StaffHome.aspx");
                }
            }
        }
    }
}
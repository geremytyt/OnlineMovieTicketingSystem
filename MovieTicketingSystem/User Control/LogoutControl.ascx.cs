using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.User_Control
{
    public partial class LogoutControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Page.User.IsInRole("Customer"))
            {
                Response.Redirect("../Annonymous/Home.aspx");
            }
            else if (Page.User.IsInRole("Staff") || Page.User.IsInRole("Manager")) {
                Response.Redirect("../Staff/StaffHome.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.SignOut();
                Session.Abandon();
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                if (authCookie != null)
                {
                    authCookie.Expires = DateTime.Now.AddDays(-1);
                }
                if (Page.User.IsInRole("Customer")) {
                    Response.Cookies.Remove("Customer");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('You have been logged out successfully'); window.location.href='../Annonymous/Home.aspx';", true);
                }
                else if (Page.User.IsInRole("Staff") || Page.User.IsInRole("Manager")){
                    Response.Cookies.Remove("Staff");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notification", "alert('You have been logged out successfully'); window.location.href='../Annonymous/StaffLogin.aspx';", true);
                    }
                }
            }
        }
    }

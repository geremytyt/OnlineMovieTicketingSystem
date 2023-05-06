using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class Movies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnViewMore_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Response.Redirect("MovieDetails.aspx?movieId=" + id);
        }

        protected void btnBookNow_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Response.Redirect("~/CustomerOnly/MoviePurchase.aspx?movieId=" + id);
        }
        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
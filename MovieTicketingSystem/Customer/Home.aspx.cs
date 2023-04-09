using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.View
{
    public partial class Home : System.Web.UI.Page
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

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class MovieTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["movieName"];
            if (cookie != null)
            {
                lbMovieName.Text = cookie.Value;
            }
            else
            {
                Response.Redirect("~/Annonymous/Home.aspx");
            }
            cookie = Request.Cookies["movieInfo"];
            if (cookie != null)
            {
                lbMovieInfo.Text = cookie.Value;
            }
            cookie = Request.Cookies["hallInfo"];
            if(cookie!= null)
            {
                lbHall.Text = cookie.Value;
            }
            cookie = Request.Cookies["scheduleInfo"];
            if (cookie != null)
            {
                lbDateTime.Text = cookie.Value;
            }

            cookie = Request.Cookies["seatNum"];
            if (cookie != null)
            {
                lbSeatIndex.Text = cookie.Value;
            }
           
        }
    }
}
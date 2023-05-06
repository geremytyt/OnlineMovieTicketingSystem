﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class MovieSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string name = Request.QueryString["movieName"] ?? "";
            if(name == "")
            {
                Response.Redirect("Home.aspx");
            }
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

        protected void CurrentMovieRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label1.Text = "";
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
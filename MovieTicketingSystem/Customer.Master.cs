using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem
{
    public partial class CustomerMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Annonymous/MovieSearch.aspx?movieName="+txtSearch.Text.ToString());
        }


        void Page_Error()
        {
            Response.Write("<h1>Sorry</h1>" +
                "<p style=\"color:red;\">" +
                "One error is encountered in this page: "
                + Server.GetLastError().Message + "</p>");

            Server.ClearError();
        }
    }
}
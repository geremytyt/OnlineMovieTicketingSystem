using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem
{
    public partial class StaffMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Customer/Home.aspx");
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
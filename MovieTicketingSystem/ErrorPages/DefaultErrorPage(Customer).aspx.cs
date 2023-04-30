using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.ErrorPages
{
    public partial class DefaultErrorPage_Customer_ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string statusCode = Request.QueryString["statusCode"] ?? "";
            lblStatus.Text = statusCode;
        }
    }
}
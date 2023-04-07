using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class AddMovie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtMovieURL_TextChanged(object sender, EventArgs e)
        {
            string url = txtMovieURL.Text.Trim();
            string iframeHtml = string.Format("<iframe src='{0}' frameborder='0' class='embed-responsive embed-responsive-4by3' allow='autoplay; gyroscope; picture-in-picture; encrypted-media' allowfullscreen></iframe>", url);
            LiteralControl iframeControl = new LiteralControl(iframeHtml);
            pnlVideoPreview.Controls.Clear();
            pnlVideoPreview.Controls.Add(iframeControl);
        }
    }
}
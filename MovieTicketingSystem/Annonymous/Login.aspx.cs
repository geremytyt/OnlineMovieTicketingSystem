using EllipticCurve.Utils;
using MovieTicketingSystem.Model;
using Newtonsoft.Json.Linq;
using SendGrid;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Security.Policy;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;


namespace MovieTicketingSystem.Annonymous
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Page"] = "Customer";
        }
    }
}
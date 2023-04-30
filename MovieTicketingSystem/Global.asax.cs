using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace MovieTicketingSystem
{
    public class Global : System.Web.HttpApplication
    {
        //declare global variable to hold connection string 
        //login detail CS - conenection string
        public const string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Moviedb.mdf;Integrated Security=True";

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            Security.ProcessRoles();
        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        protected void Application_EndRequest(Object sender, EventArgs e)
        {
            if (Context.Response.StatusCode == 500)
            {
                if (Context.User.IsInRole("Customer"))
                {
                    Response.Redirect("~/ErrorPages/500Error(Customer).aspx");
                }
                else if (Context.User.IsInRole("Staff"))
                {
                    Response.Redirect("~/ErrorPages/500Error(Staff).aspx");
                }
                else
                {
                    Response.Redirect("~/ErrorPages/500Error(Customer).aspx");
                }

            }
            else if (Context.Response.StatusCode == 404)
            {
                if (Context.User.IsInRole("Customer"))
                {
                    Response.Redirect("~/ErrorPages/FileNotFound(Customer).aspx");
                }
                else if (Context.User.IsInRole("Staff"))
                {
                    Response.Redirect("~/ErrorPages/FileNotFound(Staff).aspx");
                }
                else
                {
                    Response.Redirect("~/ErrorPages/FileNotFound(Customer).aspx");
                }
            }
            else
            {
                string statusCode = Context.Response.StatusCode.ToString();

                if (statusCode.StartsWith("4") || statusCode.StartsWith("5"))
                {
                    if (Context.User.IsInRole("Customer"))
                    {
                        Response.Redirect(String.Format("~/ErrorPages/DefaultErrorPage(Customer).aspx?statusCode={0}", statusCode));
                    }
                    else if (Context.User.IsInRole("Staff"))
                    {
                        Response.Redirect(String.Format("~/ErrorPages/DefaultErrorPage(Staff).aspx?statusCode={0}", statusCode));
                    }
                    else
                    {
                        Response.Redirect(String.Format("~/ErrorPages/DefaultErrorPage(Customer).aspx?statusCode={0}", statusCode));
                    }
                    
               
                }
            }

        }
    }
}
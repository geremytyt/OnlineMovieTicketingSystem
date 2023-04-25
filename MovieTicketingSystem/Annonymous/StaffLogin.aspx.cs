using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Annonymous
{
    public partial class StaffLogin : System.Web.UI.Page
    {
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtEmail.Text;
                string password = txtPassword.Text;
                bool rememberMe = cbRemember.Checked;
                // Login the user
                String hash = Security.GetHash(password);
                User u = db.Users.SingleOrDefault(
                    user => user.Username == username &&
                    user.Hash == hash
                    );
                if (u != null)
                {
                    if (u.Role == "Staff" || u.Role == "Manager")
                    {
                        HttpCookie cookie = new HttpCookie("Staff", username);
                        cookie.Expires = DateTime.Now.AddDays(14);
                        Response.Cookies.Add(cookie);
                        Security.LoginUser(u.Username, u.Role, rememberMe);
                    }
                    else {
                        cvLogin.IsValid = false;
                    }
                }
                else
                {
                    cvLogin.IsValid = false;
                }

            }
        }
    }
}
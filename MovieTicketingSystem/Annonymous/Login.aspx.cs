using EllipticCurve.Utils;
using MovieTicketingSystem.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
        string cs = Global.cs;
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {

            if (Page.IsValid)
            {
                string id = "";
                string username = txtEmail.Text;
                string password = txtPassword.Text;
                bool rememberMe = cbRemember.Checked;
                // Login the user
                string hash = Security.GetHash(password);
                User u = db.Users.SingleOrDefault(
                    user => user.Username == username &&
                    user.Hash == hash
                    );
                if (u != null)
                {
                    if (u.Role == "Customer")
                    {
                        string sql = "SELECT * FROM Customer WHERE custEmail = @email";
                        SqlConnection con = new SqlConnection(cs);
                        SqlCommand cmd = new SqlCommand(sql, con);
                        con.Open();
                        cmd.Parameters.AddWithValue("@email", username);
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            id = dr[0].ToString();
                        }
                        dr.Close();
                        con.Close();
                        HttpCookie cookie = new HttpCookie("Customer", id);
                        cookie.Expires = DateTime.Now.AddDays(14);
                        Response.Cookies.Add(cookie);
                        Security.LoginUser(u.Username, u.Role, rememberMe);
                       
                    }
                    else
                    {
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
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
                    if (u.Role == "Customer")
                    {
                        //record found
                        //FormsAuthentication.RedirectFromLoginPage
                        //(u.Username, rememberMe);
                        Security.LoginUser(u.Username, u.Role, rememberMe);
                        Customer cust = new Customer();
                            string sql = "SELECT * FROM Customer WHERE custEmail = @email";
                            SqlConnection con = new SqlConnection(cs);
                            SqlCommand cmd = new SqlCommand(sql, con);
                            con.Open();
                            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.Read())
                            {
                                cust.custId = dr[0].ToString();
                                cust.custName = dr[1].ToString();
                                cust.custEmail = dr[2].ToString();
                                cust.custPassword = dr[3].ToString();
                                cust.custDob = (Convert.ToDateTime(dr[4]));
                                cust.custPhoneNo = dr[5].ToString();
                                cust.custGender = dr[6].ToString();
                                cust.custPhoto = dr[7].ToString();
                                cust.custStatus = dr[8].ToString();
                                cust.signature = dr[9].ToString();
                                cust.loginNo = (int)dr[10];
                            }
                            con.Close();
                        Session["Customer"] = cust;
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
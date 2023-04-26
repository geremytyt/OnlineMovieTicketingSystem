using MovieTicketingSystem.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.User_Control
{
    public partial class LoginControl : System.Web.UI.UserControl
    {
        string cs = Global.cs;
        movieDBEntities db = new movieDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (IsReCaptchValid())
            {
                if (Page.IsValid)
                {
                    string id = "";
                    string status = "";
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
                                status = dr[8].ToString().Trim();
                            }
                            dr.Close();
                            con.Close();
                            if (status == "Active")
                            {
                                HttpCookie cookie = new HttpCookie("Customer", id);
                                cookie.Expires = DateTime.Now.AddDays(14);
                                Response.Cookies.Add(cookie);
                                Security.LoginUser(u.Username, u.Role, rememberMe);
                            }
                            else {
                                cvLogin.IsValid = false;
                            }

                        }
                        else if (u.Role == "Staff" || u.Role =="Manager")
                        {
                            string sql = "SELECT * FROM Staff WHERE staffEmail = @email";
                            SqlConnection con = new SqlConnection(cs);
                            SqlCommand cmd = new SqlCommand(sql, con);
                            con.Open();
                            cmd.Parameters.AddWithValue("@email", username);
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.Read())
                            {
                                id = dr[0].ToString();
                                status = dr[9].ToString().Trim();
                            }
                            dr.Close();
                            con.Close();
                            if (status == "Active")
                            {
                                HttpCookie cookie = new HttpCookie("Staff", id);
                                cookie.Expires = DateTime.Now.AddDays(14);
                                Response.Cookies.Add(cookie);
                                Security.LoginUser(u.Username, u.Role, rememberMe);
                            }
                            else {
                                cvLogin.IsValid = false;
                            }
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
            else
            {
                cvCaptcha.IsValid = false;
            }

        }
        public bool IsReCaptchValid()
        {
            var result = false;
            var captchaResponse = Request.Form["g-recaptcha-response"];
            var secretKey = "6LdtHKwlAAAAAE4wCBTRkwOSAS3dle2MSfw7D3kM";
            var requestUri = string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, captchaResponse);
            var request = (HttpWebRequest)WebRequest.Create(requestUri);

            using (WebResponse response = request.GetResponse())
            {
                using (StreamReader stream = new StreamReader(response.GetResponseStream()))
                {
                    JObject jResponse = JObject.Parse(stream.ReadToEnd());
                    var isSuccess = jResponse.Value<bool>("success");
                    result = (isSuccess) ? true : false;
                }
            }
            return result;
        }
    }
}
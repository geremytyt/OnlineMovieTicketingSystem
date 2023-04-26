﻿using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["Customer"];
            if (cookie != null)
            {
                string sql = "SELECT * FROM Customer WHERE custId = @id";
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();
                cmd.Parameters.AddWithValue("@id", cookie.Value.ToString());
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    imgPreview.ImageUrl = dr[7].ToString();
                }
                dr.Close();
                con.Close();
            }
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void btnTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect("Tickets.aspx");
        }

        protected void btnHistory_Click(object sender, EventArgs e)
        {
            Response.Redirect("History.aspx");
        }

        protected void btnResetPwd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ResetPassword.aspx");
        }
    }
}
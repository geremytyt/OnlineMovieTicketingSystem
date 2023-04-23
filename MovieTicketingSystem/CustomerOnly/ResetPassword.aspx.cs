﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string password = Security.GetHash(txtCfmPwd.Text);
            string sql = "UPDATE Customer SET custPassword=@Password WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", "C001");
            cmd.Parameters.AddWithValue("@Password", password);

            cmd.ExecuteNonQuery();

            con.Close();
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
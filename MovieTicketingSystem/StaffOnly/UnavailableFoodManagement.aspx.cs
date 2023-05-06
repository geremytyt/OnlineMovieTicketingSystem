﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class UnavailableFoodManagement : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try { 
                string sql = "Select * FROM Menu Where available = 'false'";
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                GVMenu.DataSource = dt;
                GVMenu.DataBind();
                }
                catch (SqlException ex)
                {
                    // Handle the exception and display an error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                }
            }
            GVMenu.UseAccessibleHeader = true;
            GVMenu.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void btn_Continue_Click(object sender, EventArgs e)
        {
            //step 2 load detail
            try { 
            string sql = "UPDATE Menu SET Available=@available WHERE menuId=@menuId";

            //step 3 establish connection
            SqlConnection con = new SqlConnection(cs);

            //step 4 open connection
            con.Open();

            //step 5 sql command
            SqlCommand cmd = new SqlCommand(sql, con);

            //step 5.1 supply parameter to sql
            cmd.Parameters.AddWithValue("@available", true);
            cmd.Parameters.AddWithValue("@menuId", lblMenuId.Text);

            //step 6 execute sql

            int rowaffected = cmd.ExecuteNonQuery();

            //step 8 close dr and close con
            con.Close();
            }
            catch (SqlException ex)
            {
                // Handle the exception and display an error message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
            }

            Response.Redirect("UnavailableFoodManagement.aspx");
        }

        protected void btnAvailable_Click(object sender, EventArgs e)
        {
            Response.Redirect("AvailableFoodManagement.aspx");
        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = GVMenu.Rows[index];

            var selectedID = selectedRow.Cells[0].Text;

            menuImg.Attributes.CssStyle.Add("display", "initial");

            //step 2 load detail
            try { 
            string sql = "SELECT * FROM MENU WHERE menuId=@menuId";

            //step 3 establish connection
            SqlConnection con = new SqlConnection(cs);

            //step 4 open connection
            con.Open();

            //step 5 sql command
            SqlCommand cmd = new SqlCommand(sql, con);

            //step 5.1 supply parameter to sql
            cmd.Parameters.AddWithValue("@menuId", selectedID);

            //step 6 execute sql
            SqlDataReader dr = cmd.ExecuteReader();

            //step 7 Read and the dr
            if (dr.Read())
            {
                menuImg.ImageUrl = dr[5].ToString().Trim();
                lblMenuId.Text = dr[0].ToString().Trim();
                tbName.Text = dr[1].ToString().Trim();
                DDLCategory.SelectedItem.Text = dr[2].ToString().Trim();


                tbPrice.Text = dr[3].ToString().Trim();
                tbDecs.Text = dr[4].ToString().Trim();
            }
            else
            {
                lblMenuId.Text = " No Record Found";
                tbName.Text = " ";
                DDLCategory.ClearSelection();
                tbPrice.Text = " ";
            }

            //step 8 close dr and close con
            dr.Close();
            con.Close();
            }
            catch (SqlException ex)
            {
                // Handle the exception and display an error message
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
            }
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class History : System.Web.UI.Page
    {
        string cs = Global.cs;
        private string foodTotal;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["Customer"];
            if (cookie != null)
            {
                try
                {
                    string sql = "SELECT * FROM Customer WHERE custId = @id";
                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@id", cookie.Value.ToString());
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        if (dr[7].ToString() != "")
                        {
                            imgPreview.ImageUrl = dr[7].ToString();
                        }
                    }
                    dr.Close();
                    con.Close();
                }
                catch (SqlException)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
                }

            }

            try
            {
                string sql2 = "SELECT Payment.paymentDateTime, Payment.paymentAmount, Payment.paymentNo FROM Schedule INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo INNER JOIN Movie ON Schedule.movieId = Movie.movieId CROSS JOIN Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo CROSS JOIN Menu WHERE (Customer.custId = @custID) AND (Payment.status = 'Completed') GROUP BY Payment.paymentDateTime, Payment.paymentAmount, Payment.paymentNo ORDER BY Payment.paymentDateTime DESC";
                SqlConnection con2 = new SqlConnection(cs);
                SqlCommand cmd2 = new SqlCommand(sql2, con2);
                con2.Open();
                cmd2.Parameters.AddWithValue("@custId", cookie.Value.ToString());
                SqlDataReader dr2 = cmd2.ExecuteReader();
                if (!dr2.HasRows)
                {
                    lblNo.Text = "No Records Found";
                }
                else
                {
                    lblNo.Text = "";
                }
                Repeater4.DataSource = dr2;
                Repeater4.DataBind();
                dr2.Close();
                con2.Close();
            }
            catch (SqlException)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
            }

        }

        protected void Repeater4_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt5 = (Repeater)e.Item.FindControl("Repeater5");
                Repeater rpt6 = (Repeater)e.Item.FindControl("Repeater6");
                // Extract the value from the desired column of the data item
                string columnValue = DataBinder.Eval(e.Item.DataItem, "paymentNo").ToString(); // Replace "ColumnName" with the actual column name
               
                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource5.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt5.DataSource = SqlDataSource5;
                rpt5.DataBind();

                SqlDataSource6.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt6.DataSource = SqlDataSource6;
                rpt6.DataBind();
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

        protected void Repeater6_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (((Repeater)sender).Items.Count == 0)
            {
                ((Repeater)sender).Visible = false;
            }
            else {
                ((Repeater)sender).Visible = true;
            }
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                foodTotal = DataBinder.Eval(e.Item.DataItem, "foodTotal").ToString();
            }
            if (e.Item.ItemType == ListItemType.Footer)
            {

               ((Label)e.Item.FindControl("Label15")).Text = foodTotal;
            }
        }

        protected void ddlTime_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string sql = "SELECT Payment.paymentDateTime, Payment.paymentAmount, Payment.paymentNo FROM Schedule INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo INNER JOIN Movie ON Schedule.movieId = Movie.movieId INNER JOIN Ticket ON Schedule.scheduleNo = Ticket.scheduleNo INNER JOIN Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId ON Ticket.purchaseNo = Purchase.purchaseNo WHERE (Customer.custId = @custID) AND (Payment.paymentDateTime BETWEEN @start AND @end) AND (Payment.status = 'Completed') GROUP BY Payment.paymentDateTime, Payment.paymentAmount, Payment.paymentNo ORDER BY Payment.paymentDateTime DESC";


                HttpCookie cookie = Request.Cookies["Customer"];
                if (ddlTime.SelectedIndex == 1)
                {

                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@custId", cookie.Value.ToString());
                    cmd.Parameters.AddWithValue("@start", DateTime.Now.AddMonths(-3));
                    cmd.Parameters.AddWithValue("@end", DateTime.Now);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (!dr.HasRows)
                    {
                        lblNo.Text = "No Records Found";
                    }
                    else
                    {
                        lblNo.Text = "";
                    }
                    Repeater4.DataSource = dr;
                    Repeater4.DataBind();
                    dr.Close();
                    con.Close();
                }
                else if (ddlTime.SelectedIndex == 2)
                {
                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@custId", cookie.Value.ToString());
                    cmd.Parameters.AddWithValue("@start", DateTime.Now.AddYears(-1));
                    cmd.Parameters.AddWithValue("@end", DateTime.Now.AddMonths(-4));
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (!dr.HasRows)
                    {
                        lblNo.Text = "No Records Found";
                    }
                    else
                    {
                        lblNo.Text = "";
                    }
                    Repeater4.DataSource = dr;
                    Repeater4.DataBind();
                    dr.Close();
                    con.Close();
                }
            }
            catch (SqlException)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
            }

        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
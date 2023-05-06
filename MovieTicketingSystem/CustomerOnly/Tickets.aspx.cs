using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class Tickets : System.Web.UI.Page
    {
        int count = 0;
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["Customer"];
            if (cookie != null)
            {
                try {
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
            string sql2 = "SELECT Movie.movieName, Movie.ageRating, Payment.qrCode, Payment.paymentNo, Payment.paymentDateTime, Schedule.scheduleDateTime, Schedule.hallNo, Purchase.childrenQty, Purchase.adultQty, Purchase.seniorQty FROM Schedule INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo INNER JOIN Movie ON Schedule.movieId = Movie.movieId INNER JOIN Ticket ON Schedule.scheduleNo = Ticket.scheduleNo INNER JOIN Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId ON Ticket.purchaseNo = Purchase.purchaseNo CROSS JOIN Staff WHERE (Customer.custId = @custId) AND (Schedule.scheduleDateTime > @scheduleDateTime) AND (Payment.status = 'Completed') GROUP BY Movie.movieName, Movie.ageRating, Payment.paymentNo, Payment.paymentDateTime, Schedule.scheduleDateTime, Schedule.hallNo, Purchase.childrenQty, Purchase.adultQty, Purchase.seniorQty, Payment.qrCode ORDER BY Schedule.scheduleDateTime DESC";
            try
            {
                SqlConnection con2 = new SqlConnection(cs);
                SqlCommand cmd2 = new SqlCommand(sql2, con2);
                con2.Open();
                cmd2.Parameters.AddWithValue("@custId", cookie.Value.ToString());
                cmd2.Parameters.AddWithValue("@scheduleDateTime", DateTime.Now.AddHours(2));
                SqlDataReader dr2 = cmd2.ExecuteReader();
                if (!dr2.HasRows)
                {
                    lblNo.Text = "No Records Found";
                }

                Repeater1.DataSource = dr2;
                Repeater1.DataBind();
                dr2.Close();
                con2.Close();
            }catch (SqlException)
            {
                 ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred while processing your request. Please try again later.');", true);
            }
    }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt2 = (Repeater)e.Item.FindControl("Repeater2");
                Repeater rpt3 = (Repeater)e.Item.FindControl("Repeater3");
                // Extract the value from the desired column of the data item

                string columnValue = DataBinder.Eval(e.Item.DataItem, "paymentNo").ToString(); // Replace "ColumnName" with the actual column name
                count++;
                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource2.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt2.DataSource = SqlDataSource2;
                rpt2.DataBind();
                SqlDataSource3.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt3.DataSource = SqlDataSource3;
                rpt3.DataBind();

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

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
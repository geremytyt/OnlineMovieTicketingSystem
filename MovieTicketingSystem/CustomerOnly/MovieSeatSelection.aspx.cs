using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class MovieSeatSelection : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["movieId"] ?? "";
            Schedule schedule = (Schedule)Session["schedule"];
            if(schedule== null)
            {
                Response.Redirect("~/Annonymous/Home.aspx");
            }
            string scheduleNo = schedule.scheduleNo;
            string sql = "SELECT * FROM movie WHERE movieId = @Id";
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", id);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string movieName = dr["movieName"].ToString();
                lbMovieName.Text = movieName;
                string duration = String.Format("{0} hrs {1} mins", Convert.ToInt32(dr["movieDuration"]) / 60, Convert.ToInt32(dr["movieDuration"]) % 60);
                string movieInfo = String.Format("{0} | {1} | {2}", dr["ageRating"].ToString(), duration, dr["language"].ToString());
                lbMovieInfo.Text = movieInfo;
                HttpCookie cookieName = new HttpCookie("movieName", movieName);
                HttpCookie cookieInfo = new HttpCookie("movieInfo", movieInfo);
                cookieName.Expires = DateTime.Now.AddHours(2);
                cookieInfo.Expires = DateTime.Now.AddHours(2);
                Response.Cookies.Add(cookieName);
                Response.Cookies.Add(cookieInfo);
            }
            dr.Close();
            lbHall.Text = "Hall : " + schedule.Hall.hallNo;
            lbDateTime.Text = schedule.scheduleDateTime.ToString("ddd dd MMMM hh:mm tt");
            List<string> soldSeatNo = new List<string>();
            sql = "SELECT seatNo FROM Ticket WHERE scheduleNo = @Num";
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Num", scheduleNo);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                soldSeatNo.Add(dr["seatNo"].ToString());
            }
            dr.Close();
            con.Close();
            int row = schedule.Hall.row;
            int column = schedule.Hall.column;
            for (int i = 0; i < row; i++)
            {
                char c = (char)(i + 65);
                HtmlGenericControl divRow = new HtmlGenericControl("div");
                divRow.Attributes["class"] = "seat-row";
                for (int j = 0; j < column; j++)
                {
                    string seat = String.Format("{0}{1:D2}", c.ToString(), j + 1);
                    HtmlGenericControl divColumn = new HtmlGenericControl("div");
                    divColumn.Attributes["class"] = soldSeatNo.Contains(seat) ? "seat sold" : "seat";
                    divColumn.ID = seat;
                    divColumn.InnerText = seat;
                    divRow.Controls.Add(divColumn);
                }
                seatContainer.Controls.Add(divRow);
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            Response.Redirect("MovieTicket.aspx");
        }

    }
}
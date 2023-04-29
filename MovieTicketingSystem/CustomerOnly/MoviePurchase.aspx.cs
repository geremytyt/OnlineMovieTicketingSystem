using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class MoviePurchase : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool found = false;
            string id = Request.QueryString["movieId"] ?? "";
            if (!IsPostBack)
            {    
                string sql = "SELECT * FROM Movie WHERE movieId = @Id";  //specify the column name and sequence
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    found = true;
                    txtMovie.Text = dr["movieName"].ToString();
                }
                if (!found)
                {
                    Response.Redirect("~/Annonymous/Home.aspx");
                }
                dr.Close();
                con.Close();
            }
        }
        protected void btnNext_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["movieId"] ?? "";
            //string number = ddlTime.SelectedValue;
            string number = "SC1001";

            string sql = "SELECT Hall.hallNo, Hall.row, Hall.[column], Schedule.movieId, Schedule.scheduleDateTime FROM  Schedule INNER JOIN   Hall ON Schedule.hallNo = Hall.hallNo WHERE  (Schedule.scheduleNo = @Num)";
            Schedule schedule;
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Num", number);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                Hall hall = new Hall {hallNo = dr["hallNo"].ToString(), row = Convert.ToInt32(dr["row"].ToString()),column= Convert.ToInt32(dr["column"].ToString()) };
                schedule = new Schedule { Hall=hall,movieId=id,scheduleNo=number,scheduleDateTime=DateTime.Parse(dr["scheduleDateTime"].ToString()) };
                Session["schedule"] = schedule;
            }

            Response.Redirect(String.Format("MovieSeatSelection.aspx?movieId={0}", id));
        }

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            HttpCookie cookie = Request.Cookies["Slide"];
            if (cookie != null)
            {
                string slideIndex = id.Substring(id.Length - 3);
                cookie.Expires = DateTime.Now.AddHours(3);
                cookie.Value = slideIndex;
                Response.Cookies.Add(cookie);
            }

            Response.Redirect("MoviePurchase.aspx?movieId=" + id);
        }
    }
}
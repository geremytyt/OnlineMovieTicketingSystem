using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.CustomerOnly
{
    public partial class MovieTicket : System.Web.UI.Page
    {
        private const double adultPrice = 15.00;
        private const double seniorPrice = 10.00;
        private const double childrenPrice = 10.00;

        protected void Page_Load(object sender, EventArgs e)
        {
            Schedule s = (Schedule)Session["schedule"];
            if (s == null)
            {
                Response.Redirect("~/Annonymous/Home.aspx");
            }
            HttpCookie cookie = Request.Cookies["movieName"];
            if (cookie != null)
            {
                lbMovieName.Text = cookie.Value;
            }
            else
            {
                Response.Redirect("~/Annonymous/Home.aspx");
            }
            cookie = Request.Cookies["movieInfo"];
            if (cookie != null)
            {
                lbMovieInfo.Text = cookie.Value;
            }
            lbHall.Text = "Hall : " + s.Hall.hallNo;
            lbDateTime.Text = s.scheduleDateTime.ToString();

            cookie = Request.Cookies["seatNum"];
            if (cookie != null)
            {
                lbSeatIndex.Text = cookie.Value;
            }

        }

        protected void btnAdult_Command(object sender, CommandEventArgs e)
        {
            string[] seatNum = lbSeatIndex.Text.Split(' ');
            int adultCount = Convert.ToInt32(lbAdultCount.Text);
            int childrenCount = Convert.ToInt32(lbChildrenCount.Text);
            int seniorCount = Convert.ToInt32(lbSeniorCount.Text);
            int total = adultCount + childrenCount + seniorCount;
            string command = e.CommandArgument.ToString();
            if(command == "+")
            {
                if(total < seatNum.Length)
                {
                    adultCount++;
                    lbAdultCount.Text = adultCount.ToString();
                    UpdateTicket(adultCount, childrenCount, seniorCount);
                }
            }
            else
            {
                if (adultCount > 0)
                {
                    adultCount--;
                    lbAdultCount.Text = adultCount.ToString();
                    UpdateTicket(adultCount, childrenCount, seniorCount);
                }
            }
        }

        protected void btnChildren_Command(object sender, CommandEventArgs e)
        {
            string[] seatNum = lbSeatIndex.Text.Split(' ');
            int adultCount = Convert.ToInt32(lbAdultCount.Text);
            int childrenCount = Convert.ToInt32(lbChildrenCount.Text);
            int seniorCount = Convert.ToInt32(lbSeniorCount.Text);
            int total = adultCount + childrenCount + seniorCount;
            string command = e.CommandArgument.ToString();
            if (command == "+")
            {
                if (total < seatNum.Length)
                {
                    childrenCount++;
                    lbChildrenCount.Text = childrenCount.ToString();
                    UpdateTicket(adultCount, childrenCount, seniorCount);
                }
            }
            else
            {
                if (childrenCount > 0)
                {
                    childrenCount--;
                    lbChildrenCount.Text = childrenCount.ToString();
                    UpdateTicket(adultCount, childrenCount, seniorCount);
                }
            }
        }

        protected void btnSenior_Command(object sender, CommandEventArgs e)
        {
            string[] seatNum = lbSeatIndex.Text.Split(' ');
            int adultCount = Convert.ToInt32(lbAdultCount.Text);
            int childrenCount = Convert.ToInt32(lbChildrenCount.Text);
            int seniorCount = Convert.ToInt32(lbSeniorCount.Text);
            int total = adultCount + childrenCount + seniorCount;
            string command = e.CommandArgument.ToString();
            if (command == "+")
            {
                if (total < seatNum.Length)
                {
                    seniorCount++;
                    lbSeniorCount.Text = seniorCount.ToString();
                    UpdateTicket(adultCount, childrenCount, seniorCount);
                }
            }
            else
            {
                if (seniorCount > 0)
                {
                    seniorCount--;
                    lbSeniorCount.Text = seniorCount.ToString();
                    UpdateTicket(adultCount, childrenCount, seniorCount);
                }
            }
        }

        private void UpdateTicket(int adult, int children, int senior)
        {
            double price = adult*adultPrice + senior*seniorPrice + children*childrenPrice;
            lbAdultTicket.Text = "Adult x " + adult.ToString();
            lbChildrenTicket.Text = "Children x  " + children.ToString();
            lbSeniorTicket.Text = "Senior x  " + senior.ToString();
            lbTotalTicket.Text = "Total : RM " + price.ToString();
        }

        protected void NextPage_Command(object sender, CommandEventArgs e)
        {
            string[] seatNum = lbSeatIndex.Text.Split(' ');
            int adultCount = Convert.ToInt32(lbAdultCount.Text);
            int childrenCount = Convert.ToInt32(lbChildrenCount.Text);
            int seniorCount = Convert.ToInt32(lbSeniorCount.Text);
            int total = adultCount + childrenCount + seniorCount;
            Schedule s = (Schedule)Session["schedule"];
            List<Ticket> tickets = new List<Ticket>();
            if (seatNum.Length == total)
            {
                Ticket t;
                for (int i = 0; i < total; i++)
                {
                    if (i + 1 <= adultCount)
                    {
                        t = new Ticket
                        {
                            Schedule = s,
                            scheduleNo = s.scheduleNo,
                            seatNo = seatNum[i],
                            ticketPrice = (decimal)adultPrice,
                            ticketCategory = "Adult"
                        };
                        tickets.Add(t);
                    }
                    else if (i + 1 > adultCount && i + 1 <= adultCount + childrenCount)
                    {
                        t = new Ticket
                        {
                            Schedule = s,
                            scheduleNo = s.scheduleNo,
                            seatNo = seatNum[i],
                            ticketPrice = (decimal)childrenPrice,
                            ticketCategory = "Children"
                        };
                        tickets.Add(t);
                    }
                    else if (i + 1 > adultCount + childrenCount && i + 1 <= total)
                    {
                        t = new Ticket
                        {
                            Schedule = s,
                            scheduleNo = s.scheduleNo,
                            seatNo = seatNum[i],
                            ticketPrice = (decimal)seniorPrice,
                            ticketCategory = "Senior"
                        };
                        tickets.Add(t);
                    }
                }
                Session["Tickets"] = tickets;
                if(e.CommandArgument.ToString() == "Food")
                {
                    Response.Redirect("~/Annonymous/Food.aspx");
                }
                else
                {
                    Response.Redirect("~/CustomerOnly/Payment.aspx");
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('The total of the tickets selected does not match with the amount of seat selected!')", true);
            }

        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
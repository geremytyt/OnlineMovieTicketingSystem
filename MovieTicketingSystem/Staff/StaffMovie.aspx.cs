using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class StaffMovie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btns_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = MovieGridView.Rows[index];
            string id = selectedRow.Cells[0].Text;
            switch (e.CommandName)
            {
                case "View":
                    Response.Redirect("ViewMovie.aspx?movieId=" + id);
                    break;

                case "Edit":
                    Response.Redirect("EditMovie.aspx?movieId=" + id);
                    break;
            }
        }

        protected void btnAddMovie_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddMovie.aspx");
        }
    } 

}
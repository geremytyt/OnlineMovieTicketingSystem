using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.Staff
{
    public partial class ManageSchedule : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            scheduleGridView.PageSize = 10;
            scheduleGridView.AllowPaging = true;
            scheduleGridView.DataBind();

            btnConfirm.Visible = false;
            btnCancel.Visible = false;
            lblInvalid.Visible = false;

            // Disable editing controls
            ddlMovieID.Enabled = false;
            ddlHall.Enabled = false;
            txtScheduleDate.Enabled = false;
            txtScheduleTime.Enabled = false;

            btnEdit.Enabled = false;

            if (scheduleGridView.SelectedIndex >= 0)
            {
                btnEdit.Enabled = true;
            }

            if (txtScheduleSearch.Text.Length > 0)
                SqlDataSourceSchedule.SelectCommand = "SELECT * FROM Schedule WHERE scheduleNo LIKE N'%" + txtScheduleSearch.Text + "%' OR movieId LIKE N'%" + txtScheduleSearch.Text + 
                    "%' OR hallNo LIKE N'%" + txtScheduleSearch.Text + "%' OR scheduleDateTime LIKE N'%" + txtScheduleSearch.Text + "%'";
            else
                SqlDataSourceSchedule.SelectCommand = "SELECT * FROM Schedule ";


        }

        protected void scheduleGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected row
            GridViewRow row = scheduleGridView.SelectedRow;

            lblScheduleID.Text = row.Cells[0].Text;

            // Fill the MovieID dropdownlist with the selected value
            ddlMovieID.SelectedValue = row.Cells[1].Text;

            // Fill the Hall dropdownlist with the selected value
            ddlHall.SelectedValue = row.Cells[2].Text;

            // Get the scheduleDateTime value
            string scheduleDateTime = row.Cells[3].Text;

            // Split the scheduleDateTime value into date and time
            string[] dateTimeParts = scheduleDateTime.Split(' ');
            string datePart = dateTimeParts[0];
            string timePart = dateTimeParts[1];

            // Set the values of the scheduleDate and scheduleTime textboxes
            txtScheduleDate.Text = (Convert.ToDateTime(datePart).ToString("yyyy-MM-dd"));
            DateTime timeValue = DateTime.ParseExact(timePart, "H:mm:ss", CultureInfo.InvariantCulture);
            txtScheduleTime.Text = timeValue.ToString("HH:mm:ss");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Retrieve the last schedule ID from the database

            SqlConnection connection = new SqlConnection(cs);
            
            connection.Open();
            string query = "SELECT MAX(scheduleNo) FROM Schedule";
            SqlCommand command = new SqlCommand(query, connection);
            object result = command.ExecuteScalar();


            int lastScheduleId;
            if (result == DBNull.Value)
            {
                lastScheduleId = 0;
            }
            else
            {
                int.TryParse(result.ToString().Substring(2), out lastScheduleId);
            }

            int newScheduleId = lastScheduleId + 1;
            string formattedScheduleId = string.Format("SC{0:D4}", newScheduleId);
            lblScheduleID.Text = formattedScheduleId;
            

            // Edit buttons
            btnAdd.Visible = false;
            btnEdit.Visible = false;
            btnConfirm.Visible = true;
            btnCancel.Visible = true;

            // Enable editing controls
            ddlMovieID.Enabled = true;
            ddlHall.Enabled = true;
            txtScheduleDate.Enabled = true;
            txtScheduleTime.Enabled = true;


            // Set the dropdown lists and textboxes to their default values
            ddlMovieID.SelectedIndex = 0;
            ddlHall.SelectedIndex = 0;
            txtScheduleDate.Text = string.Empty;
            txtScheduleTime.Text = string.Empty;

            ViewState["mode"] = "add";
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            // Edit buttons
            btnAdd.Visible = false;
            btnEdit.Visible = false;
            //btnDelete.Enabled = false;
            btnConfirm.Visible = true;
            btnCancel.Visible = true;

            ViewState["mode"] = "edit";
            // Check if a row is selected in the GridView
            if (scheduleGridView.SelectedIndex >= 0)
            {
                // Get the selected scheduleNo
                GridViewRow gvrow = scheduleGridView.SelectedRow;
                lblScheduleID.Text = gvrow.Cells[0].Text;

                // Enable editing controls
                ddlMovieID.Enabled = true;
                ddlHall.Enabled = true;
                txtScheduleDate.Enabled = false;
                txtScheduleTime.Enabled = false;
            }
        }



        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            
            if (ViewState["mode"].ToString() == "add")
            {
                // Insert a new record into the Schedule table

                if (checkSchedule() == true)
                {
                    SqlConnection connection = new SqlConnection(cs);

                    connection.Open();
                    string query = "INSERT INTO Schedule (scheduleNo, movieId, hallNo, scheduleDateTime) VALUES (@scheduleNo, @movieId, @hallNo, @scheduleDateTime)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@scheduleNo", lblScheduleID.Text);
                    command.Parameters.AddWithValue("@movieId", ddlMovieID.SelectedValue);
                    command.Parameters.AddWithValue("@hallNo", ddlHall.SelectedValue);
                    DateTime scheduleDateTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text + ":00", "yyyy-MM-dd H:m:s", CultureInfo.InvariantCulture);
                    command.Parameters.AddWithValue("@scheduleDateTime", scheduleDateTime);
                    command.ExecuteNonQuery();

                    // Reset the form
                    lblScheduleID.Text = string.Empty;
                    btnAdd.Visible = true;
                    btnEdit.Visible = true;
                    btnConfirm.Visible = false;
                    btnCancel.Visible = false;
                    //btnDelete.Enabled = true;
                    ddlMovieID.SelectedIndex = 0;
                    ddlHall.SelectedIndex = 0;
                    txtScheduleDate.Text = string.Empty;
                    txtScheduleTime.Text = string.Empty;

                    // Disable editing controls
                    ddlMovieID.Enabled = false;
                    ddlHall.Enabled = false;
                    txtScheduleDate.Enabled = false;
                    txtScheduleTime.Enabled = false;

                    // Refresh the GridView
                    scheduleGridView.DataBind();


                }
                else
                {
                    lblInvalid.Visible = true;
                    //lblInvalid.Text = "Hall is not available at the selected time. Please choose a different time or hall.";
                }

            }
            else if (ViewState["mode"].ToString() == "edit")
            {
                string scheduleNo = lblScheduleID.Text;
                string movieId = ddlMovieID.SelectedValue;
                string hallNo = ddlHall.SelectedValue;
                DateTime scheduleDateTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text, "d/M/yyyy H:m:s", CultureInfo.InvariantCulture);


                SqlConnection connection = new SqlConnection(cs);
                
                string updateCommand = "UPDATE [Schedule] SET [movieId] = @movieId, [hallNo] = @hallNo, [scheduleDateTime] = @scheduleDateTime WHERE [scheduleNo] = @scheduleNo";
                using (SqlCommand command = new SqlCommand(updateCommand, connection))
                {
                    command.Parameters.AddWithValue("@movieId", movieId);
                    command.Parameters.AddWithValue("@hallNo", hallNo);
                    command.Parameters.AddWithValue("@scheduleDateTime", scheduleDateTime);
                    command.Parameters.AddWithValue("@scheduleNo", scheduleNo);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        // Update the grid view
                        scheduleGridView.DataBind();

                        // Reset the form
                        lblScheduleID.Text = string.Empty;
                        //btnAdd.Enabled = true;
                        //btnEdit.Enabled = true;
                        //btnDelete.Enabled = true;
                        ddlMovieID.SelectedIndex = 0;
                        ddlHall.SelectedIndex = 0;
                        txtScheduleDate.Text = string.Empty;
                        txtScheduleTime.Text = string.Empty;

                        //// Set the button back to Add
                        //btnConfirm.Visible = false;
                        btnAdd.Visible = true;
                        btnEdit.Visible = true;

                        // Disable editing controls
                        ddlMovieID.Enabled = false;
                        ddlHall.Enabled = false;
                        txtScheduleDate.Enabled = false;
                        txtScheduleTime.Enabled = false;

                    }
                }     

            }


        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //Reset the form
            lblScheduleID.Text = string.Empty;
            btnAdd.Enabled = true;
            btnEdit.Enabled = false;
            //btnDelete.Enabled = true;
            ddlMovieID.SelectedIndex = 0;
            ddlHall.SelectedIndex = 0;
            txtScheduleDate.Text = string.Empty;
            txtScheduleTime.Text = string.Empty;

            // Set the button back 
            btnConfirm.Visible = false;
            btnCancel.Visible = false;
            btnAdd.Visible = true;
            btnEdit.Visible = true;
            


            // Disable editing controls
            ddlMovieID.Enabled = false;
            ddlHall.Enabled = false;
            txtScheduleDate.Enabled = false;
            txtScheduleTime.Enabled = false;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            scheduleGridView.DataBind();
        }

        protected bool checkSchedule()
        {
            DateTime scheduleStartTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text + ":00", "yyyy-MM-dd H:m:s", CultureInfo.InvariantCulture);
            string movieId = ddlMovieID.SelectedValue;
            string hallNo = ddlHall.SelectedValue;
            bool hallAvailable = false;

            //Retreive info about selected movie id
            string sql = "SELECT movieDuration FROM Movie WHERE movieId = @movieId";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();

            cmd.Parameters.AddWithValue("@movieId", movieId);
            object result = cmd.ExecuteScalar();

            int movieDuration = Convert.ToInt32(result);

            DateTime scheduleEndTime = scheduleStartTime.AddMinutes(movieDuration + 60);

            con.Close();

            //get schedule and compare the time and date based on the hallNo and movieId
            //count number of schedule that overlaps with the current schedule
            string sql2 = "SELECT COUNT(*) FROM Schedule " +
                "WHERE hallNo = @hallNo AND CONVERT(date, scheduleDateTime) = CONVERT(date, @scheduleDate) " +
                "AND((scheduleDateTime >= @scheduleStartTime AND scheduleDateTime < @scheduleEndTime) " +
                "OR(@scheduleEndTime > CONVERT(datetime, scheduleDateTime) AND @scheduleEndTime <= DATEADD(minute, @movieDuration, CONVERT(datetime, scheduleDateTime))))";

            SqlConnection con2 = new SqlConnection(cs);
            SqlCommand cmd2 = new SqlCommand(sql2, con2);
            cmd2.Parameters.AddWithValue("@hallNo", hallNo);
            cmd2.Parameters.AddWithValue("@scheduleDate", txtScheduleDate.Text);
            cmd2.Parameters.AddWithValue("@scheduleStartTime", scheduleStartTime);
            cmd2.Parameters.AddWithValue("@scheduleEndTime", scheduleEndTime);
            cmd2.Parameters.AddWithValue("@movieDuration", movieDuration);

            con2.Open();
            object result2 = cmd2.ExecuteScalar();
            con2.Close();

            if (Convert.ToInt32(result2) == 0)
            {
                hallAvailable = true;
            }

            return hallAvailable;
        }
    }
}
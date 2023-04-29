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

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ManageSchedule : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sql = "Select * FROM Schedule";
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                scheduleGridView.DataSource = dt;
                scheduleGridView.DataBind();

            }

            scheduleGridView.UseAccessibleHeader = true;
            scheduleGridView.HeaderRow.TableSection = TableRowSection.TableHeader;

            //scheduleGridView.PageSize = 10;
            //scheduleGridView.AllowPaging = true;
            //scheduleGridView.DataBind();

            btnConfirm.Visible = false;
            btnCancel.Visible = false;
            

            // Disable editing controls
            ddlMovieID.Enabled = false;
            ddlHall.Enabled = false;
            txtScheduleDate.Enabled = false;
            txtScheduleTime.Enabled = false;
            ddlStatus.Enabled = false;
            btnAdd.Visible = true;
            btnEdit.Visible = true;
            btnEdit.Enabled = false;

        } 

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = scheduleGridView.Rows[index];
            lblScheduleID.Text = row.Cells[0].Text;

            // Fill the MovieID dropdownlist with the selected value
            ddlMovieID.SelectedValue = row.Cells[1].Text;

            // Fill the Hall dropdownlist with the selected value
            ddlHall.SelectedValue = row.Cells[2].Text;

            // Get the scheduleDateTime value
            string scheduleDateTime = row.Cells[3].Text;

            // Get status
            ddlStatus.SelectedValue = row.Cells[4].Text;

            // Split the scheduleDateTime value into date and time
            string[] dateTimeParts = scheduleDateTime.Split(' ');
            string datePart = dateTimeParts[0];
            string timePart = dateTimeParts[1];

            // Set the values of the scheduleDate and scheduleTime textboxes
            txtScheduleDate.Text = (Convert.ToDateTime(datePart).ToString("yyyy-MM-dd"));
            DateTime timeValue = DateTime.ParseExact(timePart, "H:mm:ss", CultureInfo.InvariantCulture);
            txtScheduleTime.Text = timeValue.ToString("HH:mm:ss");

            btnAdd.Visible = true;
            btnAdd.Enabled = true;
            btnEdit.Visible = true;

            DateTime scheduleDateTime1 = Convert.ToDateTime(row.Cells[3].Text);
            if (DateTime.Now > scheduleDateTime1 || DateTime.Now.AddDays(7) > scheduleDateTime1)
            {
                btnEdit.Enabled = false;
            }
            else
            {
                btnEdit.Enabled = true;
            }

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
            ddlStatus.SelectedValue = "Active";

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

            // Enable editing controls
            ddlMovieID.Enabled = true;
            ddlHall.Enabled = true;
            txtScheduleDate.Enabled = false;
            txtScheduleTime.Enabled = false;
            ddlStatus.Enabled = true;
        }



        protected void btnConfirm_Click(object sender, EventArgs e)
        {

            if (ViewState["mode"].ToString() == "add")
            {
                
                // Check if schedule date is at least 7 days from the current date
                DateTime scheduleDate = DateTime.ParseExact(txtScheduleDate.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                if (scheduleDate < DateTime.Now.AddDays(7))
                {
                    // Show error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Schedule Date must be at least 7 days from now!')", true);
                    
                }

                else if (checkSchedule() == true)
                {
                    // Insert a new record into the Schedule table
                    string status = "Active";
                    SqlConnection connection = new SqlConnection(cs);
                    connection.Open();
                    string query = "INSERT INTO Schedule (movieId, hallNo, scheduleDateTime, status) VALUES (@movieId, @hallNo, @scheduleDateTime, @status)";
                    SqlCommand command = new SqlCommand(query, connection);
                    //command.Parameters.AddWithValue("@id", newId);
                    //command.Parameters.AddWithValue("@scheduleNo", lblScheduleID.Text);
                    command.Parameters.AddWithValue("@movieId", ddlMovieID.SelectedValue);
                    command.Parameters.AddWithValue("@hallNo", ddlHall.SelectedValue);
                    DateTime scheduleDateTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text + ":00", "yyyy-MM-dd H:m:s", CultureInfo.InvariantCulture);
                    command.Parameters.AddWithValue("@scheduleDateTime", scheduleDateTime);
                    command.Parameters.AddWithValue("@status", status);
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
                    ddlStatus.Enabled = false;

                    // Update the grid view
                    string sql = "Select * FROM Schedule";
                    SqlConnection con = new SqlConnection(cs);
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    scheduleGridView.DataSource = dt;
                    scheduleGridView.DataBind();
                    Response.Redirect("ManageSchedule.aspx");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Hall is not available at the selected time. Please choose a different time or hall!')", true);
                }

            }
            else if (ViewState["mode"].ToString() == "edit")
            {
                
                    string scheduleNo = lblScheduleID.Text;
                    string movieId = ddlMovieID.SelectedValue;
                    string hallNo = ddlHall.SelectedValue;


                    string initialHallNo = "";
                    string sqlGetHall = "SELECT hallNo FROM Schedule WHERE scheduleNo = @scheduleNo";
                    SqlConnection con2 = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sqlGetHall, con2);
                    con2.Open();
                    cmd.Parameters.AddWithValue("@scheduleNo", lblScheduleID.Text);
                    bool chkSchedule = true;
                    // Execute the query and get a SqlDataReader
                    SqlDataReader reader = cmd.ExecuteReader();

                    reader.Read();
                    initialHallNo = reader.GetString(0);

                    //Check if hallNo was edited
                    if (!hallNo.Equals(initialHallNo))
                    {
                        //if yes, check whether hallNo is occupied
                        chkSchedule = checkSchedule();
                    }


                    if(chkSchedule == true)
                    {
                        string status = ddlStatus.SelectedValue;

                        SqlConnection connection = new SqlConnection(cs);
                        connection.Open();
                        string updateCommand = "UPDATE [Schedule] SET [movieId] = @movieId, [hallNo] = @hallNo, [status] = @status WHERE [scheduleNo] = @scheduleNo";
                        SqlCommand command = new SqlCommand(updateCommand, connection);

                        command.Parameters.AddWithValue("@movieId", movieId);
                        command.Parameters.AddWithValue("@hallNo", hallNo);
                        //command.Parameters.AddWithValue("@scheduleDateTime", scheduleDateTime);
                        command.Parameters.AddWithValue("@status", status);
                        command.Parameters.AddWithValue("@scheduleNo", scheduleNo);

                        command.ExecuteNonQuery();

                        // Update the grid view
                        string sql = "Select * FROM Schedule";
                        SqlConnection con = new SqlConnection(cs);
                        con.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        scheduleGridView.DataSource = dt;
                        scheduleGridView.DataBind();

                        // Reset the form
                        lblScheduleID.Text = string.Empty;
                        ddlMovieID.SelectedIndex = 0;
                        ddlHall.SelectedIndex = 0;
                        txtScheduleDate.Text = string.Empty;
                        txtScheduleTime.Text = string.Empty;
                        btnAdd.Visible = true;
                        btnEdit.Visible = true;

                        // Disable editing controls
                        ddlMovieID.Enabled = false;
                        ddlHall.Enabled = false;
                        txtScheduleDate.Enabled = false;
                        txtScheduleTime.Enabled = false;
                        ddlStatus.Enabled = false;


                        if (status == "Cancelled")
                        {
                            string updateCommand2 = @"UPDATE Payment SET status = @status
                                                FROM Payment
                                                INNER JOIN Purchase ON Payment.purchaseNo = Purchase.purchaseNo
                                                INNER JOIN Ticket ON Purchase.purchaseNo = Ticket.purchaseNo
                                                INNER JOIN Schedule ON Ticket.scheduleNo = Schedule.scheduleNo
                                                WHERE Schedule.scheduleNo = @scheduleNo";
                            SqlCommand command2 = new SqlCommand(updateCommand2, connection);

                            command2.Parameters.AddWithValue("@status", status);
                            command2.Parameters.AddWithValue("@scheduleNo", scheduleNo);
                            command2.ExecuteNonQuery();
                        }
                        connection.Close();
                        Response.Redirect("ManageSchedule.aspx");
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Hall is not available at the selected time. Please choose a different hall!')", true);
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


        protected bool checkSchedule()
        {
            
            string movieId = ddlMovieID.SelectedValue;
            string hallNo = ddlHall.SelectedValue;
            bool hallAvailable = false;

            string query = "SELECT scheduleDateTime FROM Schedule WHERE scheduleNo = @scheduleNo";
            SqlConnection con2 = new SqlConnection(cs);
            SqlCommand cmd3 = new SqlCommand(query, con2);

            DateTime scheduleStartTime = DateTime.Now;
            if (ViewState["mode"].ToString() == "add")
            {
                scheduleStartTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text + ":00", "yyyy-MM-dd H:m:s", CultureInfo.InvariantCulture);
            }
            else if (ViewState["mode"].ToString() == "edit")
            {
                         
                con2.Open();
                cmd3.Parameters.AddWithValue("@scheduleNo", lblScheduleID.Text);

                // Execute the query and get a SqlDataReader
                SqlDataReader reader = cmd3.ExecuteReader();
                
                // Check if there are any rows returned
                if (reader.HasRows)
                {
                    // Read the first row
                    reader.Read();

                    // Get the value of the "scheduleDateTime" column as a DateTime object
                    scheduleStartTime = reader.GetDateTime(0);

                }
                
            }

            // Retrieve info about selected movie id
            string sql = "SELECT movieDuration FROM Movie WHERE movieId = @movieId";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);

            con.Open();

            cmd.Parameters.AddWithValue("@movieId", movieId);
            object result = cmd.ExecuteScalar();

            int movieDuration = Convert.ToInt32(result);

            DateTime scheduleEndTime = scheduleStartTime.AddMinutes(movieDuration + 30);

            // Get schedule and compare the time and date based on the hallNo and movieId
            // Count number of schedules that overlap with the current schedule
            string sql2 = "SELECT COUNT(*) FROM Schedule " +
                "WHERE hallNo = @hallNo AND CONVERT(date, scheduleDateTime) = CONVERT(date, @scheduleDateTime) " +
                "AND ((@scheduleStartTime BETWEEN scheduleDateTime AND DATEADD(minute, @movieDuration + 30, scheduleDateTime)) " +
                "OR (@scheduleEndTime BETWEEN scheduleDateTime AND DATEADD(minute, @movieDuration + 30, scheduleDateTime)))";

            SqlCommand cmd2 = new SqlCommand(sql2, con);

            cmd2.Parameters.AddWithValue("@hallNo", hallNo);
            cmd2.Parameters.AddWithValue("@scheduleDateTime", scheduleStartTime);
            cmd2.Parameters.AddWithValue("@scheduleStartTime", scheduleStartTime);
            cmd2.Parameters.AddWithValue("@scheduleEndTime", scheduleEndTime);
            cmd2.Parameters.AddWithValue("@movieDuration", movieDuration);

            object result2 = cmd2.ExecuteScalar();

            if (Convert.ToInt32(result2) == 0)
            {
                hallAvailable = true;
            }
            return hallAvailable;

        }
    }
}
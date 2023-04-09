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

            // Disable editing controls
            ddlMovieID.Enabled = false;
            ddlHall.Enabled = false;
            txtScheduleDate.Enabled = false;
            txtScheduleTime.Enabled = false;

            //if (!IsPostBack)
            //{
            //    BindData();
            //}
        }

        //private void BindData()
        //{
        //    // Bind the data from the SqlDataSourceSchedule to the GridView
        //    scheduleGridView.DataSource = SqlDataSourceSchedule;
        //    scheduleGridView.DataBind();
        //}

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
            txtScheduleDate.Text = datePart;
            txtScheduleTime.Text = timePart;

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Retrieve the last schedule ID from the database
            
            using (SqlConnection connection = new SqlConnection(cs))
            {
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
            }



            // Edit buttons
            btnAdd.Visible = false;
            btnEdit.Visible = false;
            //btnDelete.Enabled = false;
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

                //// Set the values of the editing controls based on the selected schedule
                //SqlDataSourceSchedule2.SelectCommand = "SELECT * FROM [Schedule] WHERE [scheduleNo] = @scheduleNo";
                //SqlDataSourceSchedule2.SelectParameters.Clear();
                //SqlDataSourceSchedule2.SelectParameters.Add("scheduleNo", lblScheduleID.Text);
                //DataView dv = (DataView)SqlDataSourceSchedule2.Select(DataSourceSelectArguments.Empty);
                //if (dv != null && dv.Count > 0)
                //{
                //    DataRowView row = dv[0];
                //    ddlMovieID.SelectedValue = row["movieId"].ToString();
                //    ddlHall.SelectedValue = row["hallNo"].ToString();
                //    txtScheduleDate.Text = ((DateTime)row["scheduleDateTime"]).ToString("yyyy-MM-dd");
                //    txtScheduleTime.Text = ((DateTime)row["scheduleDateTime"]).ToString("HH:mm:ss");
                //}


                //// Store the original values of the editing controls in the ViewState
                //ViewState["OriginalMovieID"] = ddlMovieID.SelectedValue;
                //ViewState["OriginalHall"] = ddlHall.SelectedValue;
                //ViewState["OriginalScheduleDate"] = txtScheduleDate.Text;
                //ViewState["OriginalScheduleTime"] = txtScheduleTime.Text;

                //// Store the selected scheduleNo in the ViewState
                //ViewState["SelectedScheduleNo"] = lblScheduleID.Text;


            }
        }

        //protected void btnDelete_Click(object sender, EventArgs e)
        //{
        //    // Get the selected row index of the GridView
        //    int rowIndex = scheduleGridView.SelectedIndex;

        //    if (rowIndex >= 0)
        //    {
        //        // Get the selected scheduleNo from the GridView's DataKeys collection
        //        string scheduleNo = lblScheduleID.Text;

        //        // Delete the selected schedule from the database
        //        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDBConnectionString"].ConnectionString))
        //        {
        //            conn.Open();
        //            using (SqlCommand cmd = new SqlCommand("DELETE FROM Schedule WHERE scheduleNo = @scheduleNo", conn))
        //            {
        //                cmd.Parameters.AddWithValue("@scheduleNo", scheduleNo);
        //                cmd.ExecuteNonQuery();
        //            }
        //        }

        //        // Rebind the GridView to show the updated data
        //        scheduleGridView.DataBind();
        //    }
        //}


        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (ViewState["mode"].ToString() == "add")
            {
                // Insert a new record into the Schedule table
                
                using (SqlConnection connection = new SqlConnection(cs))
                {
                    connection.Open();
                    string query = "INSERT INTO Schedule (scheduleNo, movieId, hallNo, scheduleDateTime) VALUES (@scheduleNo, @movieId, @hallNo, @scheduleDateTime)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@scheduleNo", lblScheduleID.Text);
                    command.Parameters.AddWithValue("@movieId", ddlMovieID.SelectedValue);
                    command.Parameters.AddWithValue("@hallNo", ddlHall.SelectedValue);
                    DateTime scheduleDateTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text + ":00", "d/M/yyyy H:m:s", CultureInfo.InvariantCulture);
                    command.Parameters.AddWithValue("@scheduleDateTime", scheduleDateTime);
                    command.ExecuteNonQuery();
                }

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

                // Refresh the GridView
                scheduleGridView.DataBind();

            }
            else if (ViewState["mode"].ToString() == "edit")
            {
                string scheduleNo = lblScheduleID.Text;
                string movieId = ddlMovieID.SelectedValue;
                string hallNo = ddlHall.SelectedValue;
                DateTime scheduleDateTime = DateTime.ParseExact(txtScheduleDate.Text + " " + txtScheduleTime.Text, "d/M/yyyy H:m:s", CultureInfo.InvariantCulture);

                
                using (SqlConnection connection = new SqlConnection(cs))
                {
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
                            //btnAdd.Visible = true;


                        }
                    }
                }

            }

            // Disable editing controls
            ddlMovieID.Enabled = false;
            ddlHall.Enabled = false;
            txtScheduleDate.Enabled = false;
            txtScheduleTime.Enabled = false;

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //Reset the form
            lblScheduleID.Text = string.Empty;
            btnAdd.Enabled = true;
            btnEdit.Enabled = true;
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
            string searchValue = txtSearch.Text.Trim();

            // Get the data from the SqlDataSource control
            SqlDataSource sqlDataSource = (SqlDataSource)FindControl("SqlDataSourceSchedule");
            DataTable dt = (DataTable)sqlDataSource.Select(DataSourceSelectArguments.Empty);

            // Filter the data based on the search criteria
            DataView dv = dt.DefaultView;
            dv.RowFilter = string.Format("scheduleNo LIKE '%{0}%'", searchValue);

            // Bind the filtered data to the GridView
            scheduleGridView.DataSource = dv.ToTable();
            scheduleGridView.DataBind();
        }
    }
}
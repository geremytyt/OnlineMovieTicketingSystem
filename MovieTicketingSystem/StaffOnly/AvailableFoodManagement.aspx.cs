using MovieTicketingSystem.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class AvailableFoodManagement : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try { 
                string sql = "Select * FROM Menu Where available = 'true' ";
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

        protected void btn_insert_Click(object sender, EventArgs e)
        {
            String LastId = GVMenu.Rows[GVMenu.Rows.Count - 1].Cells[0].Text;
            int IdNum = int.Parse(LastId.Substring(2)) + 1;

            lblMenuId.Text = "MN" + IdNum.ToString("000");
            tbName.Text = "";
            DDLCategory.ClearSelection();
            tbPrice.Text = "";
            tbDecs.Text = "";
            GVMenu.SelectedIndex = -1;
            menuImg.ImageUrl = " ";
            menuImg.Attributes.CssStyle.Add("display", "none");

            //enable validation
            CVPrice.Enabled = true;
            RVUpload.Enabled = true;
            RVtbName.Enabled = true;
            RVPrice.Enabled = true;
            RVtbDecs.Enabled = true;

            //allow user to edit the textbox
            tbName.ReadOnly = false;
            DDLCategory.Enabled = true;
            tbPrice.ReadOnly = false;
            tbDecs.ReadOnly = false;

            btn_add.Visible = true;
            btn_back.Visible = true;
            FoodIMageUpload.Visible = true;

            btn_insert.Visible = false;
            btn_Discontinue.Visible = false;
            btn_edit.Visible = false;
            GVMenu.Columns[4].Visible = false;

        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            if (FoodIMageUpload.HasFile)
            {
                string fileName = Path.GetFileName(FoodIMageUpload.FileName);
                fileName = lblMenuId.Text + fileName.Substring(fileName.IndexOf("."));
                string filePath = Server.MapPath("~/Image/foodImages/" + fileName);
                FoodIMageUpload.SaveAs(filePath);
                string fileUrl = ResolveUrl("~/Image/foodImages/" + fileName);
                menuImg.ImageUrl = ".." + fileUrl;

                //step 2 load detail
                string sql = "INSERT INTO Menu VALUES (@menuId, @menuName, @menuCategory, @menuPrice, @menuDesc, @menuUrl, @available)";
                try
                {
                    //step 3 establish connection
                    SqlConnection con = new SqlConnection(cs);

                    //step 4 open connection
                    con.Open();

                    //step 5 sql command
                    SqlCommand cmd = new SqlCommand(sql, con);


                    //step 5.1 supply parameter to sql
                    cmd.Parameters.AddWithValue("@menuId", lblMenuId.Text);
                    cmd.Parameters.AddWithValue("@menuName", tbName.Text);
                    cmd.Parameters.AddWithValue("@menuCategory", DDLCategory.SelectedItem.ToString());
                    cmd.Parameters.AddWithValue("@menuPrice", tbPrice.Text);
                    cmd.Parameters.AddWithValue("@menuDesc", tbDecs.Text);
                    cmd.Parameters.AddWithValue("@menuUrl", menuImg.ImageUrl);
                    cmd.Parameters.AddWithValue("@available", true);

                    //step 6 execute sql
                    SqlDataReader dr = cmd.ExecuteReader();

                    //show the added data
                    if (dr.Read())
                    {
                        lblMenuId.Text = dr[0].ToString().Trim();
                        tbName.Text = dr[1].ToString().Trim();
                        DDLCategory.SelectedItem.Value = dr[2].ToString().Trim();
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
                Response.Redirect("AvailableFoodManagement.aspx");
            }
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            //disenable validation
            RVUpload.Enabled = false;
            RVtbName.Enabled = false;
            RVPrice.Enabled = false;
            RVtbDecs.Enabled = false;
            CVPrice.Enabled = false;

            lblMenuId.Text = "Select An Item";
            tbName.ReadOnly = true;
            DDLCategory.Enabled = false;
            tbPrice.ReadOnly = true;
            tbDecs.ReadOnly = true;
            menuImg.Attributes.CssStyle.Add("display", "none");

            btn_add.Visible = false;
            btn_back.Visible = false;
            FoodIMageUpload.Visible = false;

            btn_insert.Visible = true;
            btn_Discontinue.Visible = true;
            btn_edit.Visible = true;

            Response.Redirect("AvailableFoodManagement.aspx");
        }

        protected void btn_edit_Click(object sender, EventArgs e)
        {
            //enable validation
            //RVUpload.Enabled = true;
            CVPrice.Enabled = true;
            RVtbName.Enabled = true;
            RVPrice.Enabled = true;
            RVtbDecs.Enabled = true;

            //allow user to edit the textbox
            tbName.ReadOnly = false;
            DDLCategory.Enabled = true;
            tbPrice.ReadOnly = false;
            tbDecs.ReadOnly = false;

            GVMenu.Columns[4].Visible = false;

            btn_update.Visible = true;
            btn_cancel.Visible = true;
            FoodIMageUpload.Visible = true;
            btn_insert.Visible = false;
            btn_Discontinue.Visible = false;
            btn_edit.Visible = false;
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AvailableFoodManagement.aspx");
        }

        protected void btn_update_Click(object sender, EventArgs e)
        {

            if (FoodIMageUpload.HasFile)
            {
                string fileName = Path.GetFileName(FoodIMageUpload.FileName);
                fileName = lblMenuId.Text + fileName.Substring(fileName.IndexOf("."));
                string filePath = Server.MapPath("~/Image/foodImages/" + fileName);
                FoodIMageUpload.SaveAs(filePath);
                string fileUrl = ResolveUrl("~/Image/foodImages/" + fileName);
                menuImg.ImageUrl = ".." + fileUrl;
            }

            try
            {
                //step 2 update detail
                string sql = "UPDATE Menu SET menuName=@menuName, menuCategory=@menuCategory, menuPrice=@menuPrice, menuDesc=@menuDesc, menuUrl=@menuUrl WHERE menuId=@menuId";

                //step 3 establish connection
                SqlConnection con = new SqlConnection(cs);

                //step 4 open connection
                con.Open();

                //step 5 sql command
                SqlCommand cmd = new SqlCommand(sql, con);

                //step 5.1 supply parameter to sql
                cmd.Parameters.AddWithValue("@menuId", lblMenuId.Text);
                cmd.Parameters.AddWithValue("@menuName", tbName.Text);
                cmd.Parameters.AddWithValue("@menuCategory", DDLCategory.SelectedItem.ToString());
                cmd.Parameters.AddWithValue("@menuPrice", Double.Parse(tbPrice.Text));
                cmd.Parameters.AddWithValue("@menuDesc", tbDecs.Text);
                cmd.Parameters.AddWithValue("@menuUrl", menuImg.ImageUrl);

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

            Response.Redirect("AvailableFoodManagement.aspx");

        }

        protected void btn_Discontinue_Click(object sender, EventArgs e)
        {
            //step 2 load detail
            try
            {
                string sql = "UPDATE Menu SET Available=@available WHERE menuId=@menuId";

                //step 3 establish connection
                SqlConnection con = new SqlConnection(cs);

                //step 4 open connection
                con.Open();

                //step 5 sql command
                SqlCommand cmd = new SqlCommand(sql, con);

                //step 5.1 supply parameter to sql
                cmd.Parameters.AddWithValue("@available", false);
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

            Response.Redirect("AvailableFoodManagement.aspx");
        }

        protected void btnUnAvailable_Click(object sender, EventArgs e)
        {
            Response.Redirect("UnavailableFoodManagement.aspx");
        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow selectedRow = GVMenu.Rows[index];
            
            var selectedID = selectedRow.Cells[0].Text;

            menuImg.Attributes.CssStyle.Add("display", "initial");
            try
            {
                //step 2 load detail
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

                    btn_edit.Visible = true;
                    btn_Discontinue.Visible = true;
                }
                else
                {
                    lblMenuId.Text = " No Record Found";
                    tbName.Text = " ";
                    DDLCategory.ClearSelection();
                    tbPrice.Text = " ";

                    btn_edit.Visible = false;
                    btn_Discontinue.Visible = false;
                }

                //step 8 close dr and close con
                dr.Close();
                con.Close();

                //disenable validation
                RVUpload.Enabled = false;
                RVtbName.Enabled = false;
                RVPrice.Enabled = false;
                RVtbDecs.Enabled = false;
                CVPrice.Enabled = false;

                tbName.ReadOnly = true;
                DDLCategory.Enabled = false;
                tbPrice.ReadOnly = true;
                tbDecs.ReadOnly = true;

                btn_add.Visible = false;
                btn_back.Visible = false;
                FoodIMageUpload.Visible = false;

                btn_insert.Visible = true;
                btn_Discontinue.Visible = true;
                btn_edit.Visible = true;

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

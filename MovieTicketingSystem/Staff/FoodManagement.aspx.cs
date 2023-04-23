using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//Step 1 : import library, use classes given in the library to access DB
using System.Data.SqlClient;
using System.IO;

namespace MovieTicketingSystem.View
{
    public partial class FoodManagement : System.Web.UI.Page
    {
        //step 2: call global asax to retrieve
        string cs = Global.cs;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_insert_Click(object sender, EventArgs e)
        {
            String LastId = GVMenu.Rows[GVMenu.Rows.Count - 1].Cells[0].Text;
            int IdNum = int.Parse(LastId.Substring(2)) + 1;

            lblMenuId.Text = "MN" + IdNum.ToString("000");
            tbName.Text = "";
            tbCategory.Text = "";
            tbPrice.Text = "";
            tbDecs.Text = "";
            GVMenu.SelectedIndex = -1;
            menuImg.ImageUrl = " ";
            menuImg.Attributes.CssStyle.Add("display", "none");

            //allow user to edit the textbox
            tbName.ReadOnly = false;
            tbCategory.ReadOnly = false;
            tbPrice.ReadOnly = false;
            tbDecs.ReadOnly = false;

            btn_add.Visible = true;
            btn_back.Visible = true;
            FoodIMageUpload.Visible = true;

            btn_insert.Visible = false;
            btn_delete.Visible = false;
            btn_edit.Visible = false;

        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            if (FoodIMageUpload.HasFile)
            {
                string fileName = Path.GetFileName(FoodIMageUpload.FileName);
                string filePath = Server.MapPath("~/image/" + fileName);
                FoodIMageUpload.SaveAs(filePath);
                string fileUrl = ResolveUrl("~/image/" + fileName);
                menuImg.ImageUrl = ".." + fileUrl;

                //step 2 load detail
                string sql = "INSERT INTO Menu VALUES (@menuId, @menuName, @menuCategory, @menuPrice, @menuDesc, @menuUrl)";

                //step 3 establish connection
                SqlConnection con = new SqlConnection(cs);

                //step 4 open connection
                con.Open();

                //step 5 sql command
                SqlCommand cmd = new SqlCommand(sql, con);


                //step 5.1 supply parameter to sql
                cmd.Parameters.AddWithValue("@menuId", lblMenuId.Text);
                cmd.Parameters.AddWithValue("@menuName", tbName.Text);
                cmd.Parameters.AddWithValue("@menuCategory", tbCategory.Text);
                cmd.Parameters.AddWithValue("@menuPrice", tbPrice.Text);
                cmd.Parameters.AddWithValue("@menuDesc", tbDecs.Text);
                cmd.Parameters.AddWithValue("@menuUrl", menuImg.ImageUrl);

                //step 6 execute sql
                SqlDataReader dr = cmd.ExecuteReader();

                //show the added data
                if (dr.Read())
                {
                    lblMenuId.Text = dr[0].ToString().Trim();
                    tbName.Text = dr[1].ToString().Trim();
                    tbCategory.Text = dr[2].ToString().Trim();
                    tbPrice.Text = "RM " + dr[3].ToString().Trim();
                    tbDecs.Text = dr[4].ToString().Trim();
                }
                else
                {
                    lblMenuId.Text = " No Record Found";
                    tbName.Text = " ";
                    tbCategory.Text = " ";
                    tbPrice.Text = " ";
                }

                //step 8 close dr and close con
                dr.Close();
                con.Close();

                Response.Redirect("FoodManagement.aspx");
            }
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            lblMenuId.Text = "Select An Item";
            tbName.ReadOnly = true;
            tbCategory.ReadOnly = true;
            tbPrice.ReadOnly = true;
            tbDecs.ReadOnly = true;
            menuImg.Attributes.CssStyle.Add("display", "none");

            btn_add.Visible = false;
            btn_back.Visible = false;
            FoodIMageUpload.Visible = false;

            btn_insert.Visible = true;
            btn_delete.Visible = true;
            btn_edit.Visible = true;
        }

        protected void btn_edit_Click(object sender, EventArgs e)
        {
            //allow user to edit the textbox
            tbName.ReadOnly = false;
            tbCategory.ReadOnly = false;
            tbPrice.ReadOnly = false;
            tbDecs.ReadOnly = false;


            btn_update.Visible = true;
            btn_cancel.Visible = true;
            FoodIMageUpload.Visible = true;
            btn_insert.Visible = false;
            btn_delete.Visible = false;
            btn_edit.Visible = false;
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {

            tbName.ReadOnly = true;
            tbCategory.ReadOnly = true;
            tbPrice.ReadOnly = true;
            tbDecs.ReadOnly = true;

            btn_update.Visible = false;
            btn_cancel.Visible = false;
            FoodIMageUpload.Visible = false;

            btn_insert.Visible = true;
            btn_delete.Visible = true;
            btn_edit.Visible = true;
        }

        protected void btn_update_Click(object sender, EventArgs e)
        {

            if (FoodIMageUpload.HasFile)
            {

                string fileName = Path.GetFileName(FoodIMageUpload.FileName);
                string filePath = Server.MapPath("~/image/" + fileName);
                FoodIMageUpload.SaveAs(filePath);
                string fileUrl = ResolveUrl("~/image/" + fileName);
                menuImg.ImageUrl = ".." + fileUrl;
            }

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
                cmd.Parameters.AddWithValue("@menuCategory", tbCategory.Text);
                cmd.Parameters.AddWithValue("@menuPrice", tbPrice.Text.Substring(3));
                cmd.Parameters.AddWithValue("@menuDesc", tbDecs.Text);
                cmd.Parameters.AddWithValue("@menuUrl", menuImg.ImageUrl);

                //step 6 execute sql

                int rowaffected = cmd.ExecuteNonQuery();

                //step 8 close dr and close con
                con.Close();

                Response.Redirect("FoodManagement.aspx");

        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            //step 2 load detail
            string sql = "DELETE FROM Menu WHERE menuId=@menuId";

            //step 3 establish connection
            SqlConnection con = new SqlConnection(cs);

            //step 4 open connection
            con.Open();

            //step 5 sql command
            SqlCommand cmd = new SqlCommand(sql, con);

            //step 5.1 supply parameter to sql
            cmd.Parameters.AddWithValue("@menuId", lblMenuId.Text);

            //step 6 execute sql

            int rowaffected = cmd.ExecuteNonQuery();

            //step 8 close dr and close con
            con.Close();

            Response.Redirect("FoodManagement.aspx");
        }

        protected void GVMenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            var selectedIndex = GVMenu.SelectedIndex;

            var selectedID = GVMenu.SelectedRow.Cells[0].Text;
            menuImg.Attributes.CssStyle.Add("display", "initial");

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
                tbCategory.Text = dr[2].ToString().Trim();
                tbPrice.Text = "RM " + dr[3].ToString().Trim();
                tbDecs.Text = dr[4].ToString().Trim();
            }
            else
            {
                lblMenuId.Text = " No Record Found";
                tbName.Text = " ";
                tbCategory.Text = " ";
                tbPrice.Text = " ";
            }

            //step 8 close dr and close con
            dr.Close();
            con.Close();
        }

    }
}
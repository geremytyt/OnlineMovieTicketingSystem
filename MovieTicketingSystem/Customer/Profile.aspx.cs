using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MovieTicketingSystem.View
{
    public partial class Profile : System.Web.UI.Page
    {
        string cs = Global.cs;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { 
                string sql = "SELECT TOP 1 * FROM Customer"; 
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtName.Text = dr[1].ToString();
                    txtEmail.Text = dr[2].ToString();
                    txtPhone.Text = dr[5].ToString();
                    txtDob.Text = (Convert.ToDateTime(dr[4]).ToString("yyyy-MM-dd"));
                    rblGender.SelectedValue = dr[6].ToString();
                    imgPreview.ImageUrl = dr[7].ToString();
                }
                con.Close();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string fileUrl = null;
            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = Server.MapPath("~/Image/" + fileName);
                fileUpload.SaveAs(filePath);
                fileUrl = ResolveUrl("~/Image/" + fileName);
            }
            else {
                fileUrl = imgPreview.ImageUrl;
            }
            string name = txtName.Text;
            string phone = txtPhone.Text;
            string gender = rblGender.SelectedValue;
            DateTime dob = DateTime.Parse(txtDob.Text);
            string sql = "UPDATE Customer SET custName=@Name, custPhoneNo=@Phone, custGender=@Gender,custDob=@Dob, custPhoto=@Photo WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", "C001");
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@Dob", dob);
            cmd.Parameters.AddWithValue("@Photo", ".." + fileUrl);

            cmd.ExecuteNonQuery();

            con.Close();

        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            string password = Security.GetHash(TextBox3.Text);
            string sql = "UPDATE Customer SET custPassword=@Password WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", "C001");
            cmd.Parameters.AddWithValue("@Password", password);

            cmd.ExecuteNonQuery();

            con.Close();
        }
        protected void deleteTab_Click(object sender, EventArgs e)
        {
            string sql = "UPDATE Customer SET custStatus=@Status WHERE custId=@Id";

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Id", "C001");
            cmd.Parameters.AddWithValue("@Status", "Suspended");

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("Home.aspx");
        }

        protected void Repeater4_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt5 = (Repeater)e.Item.FindControl("Repeater5");
                Repeater rpt6 = (Repeater)e.Item.FindControl("Repeater6");
                // Extract the value from the desired column of the data item
                string columnValue = DataBinder.Eval(e.Item.DataItem, "paymentNo").ToString(); // Replace "ColumnName" with the actual column name

                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource5.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt5.DataBind();

                SqlDataSource6.SelectParameters["paymentNo"].DefaultValue = columnValue;
                rpt6.DataBind();

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

                // Set the value of the ColumnValue parameter for sqlDataSource2
                SqlDataSource2.SelectParameters["paymentNo"].DefaultValue = columnValue;

                SqlDataSource3.SelectParameters["paymentNo"].DefaultValue = columnValue;

                rpt2.DataBind();

                rpt3.DataBind();
            }
        }
    }
}
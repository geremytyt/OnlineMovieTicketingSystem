using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketingSystem.StaffOnly
{
    public partial class ViewPayment : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MovieConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try { 
                string sql = "Select * FROM Payment";
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                paymentGridView.DataSource = dt;
                paymentGridView.DataBind();
                }
                catch (SqlException ex)
                {
                    // Handle the exception and display an error message
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "window.alert('An error occurred: " + ex.Message + "');", true);
                }
                paymentGridView.UseAccessibleHeader = true;
                paymentGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            //paymentGridView.DataBind();
            
            //if (txtPaymentSearch.Text.Length > 0)
            //    SqlDataSourcePayment.SelectCommand = "SELECT * FROM Payment WHERE paymentNo LIKE N'%" + txtPaymentSearch.Text + "%' OR purchaseNo LIKE N'%" + txtPaymentSearch.Text +
            //        "%' OR status LIKE N'%" + txtPaymentSearch.Text + "%' OR paymentDateTime LIKE N'%" + txtPaymentSearch.Text + "%'";
            //else
            //    SqlDataSourcePayment.SelectCommand = "SELECT * FROM Payment ";
        }

        

        //protected void btnSearch_Click(object sender, EventArgs e)
        //{
        //    paymentGridView.DataBind();
        //}

        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string paymentNo = paymentGridView.DataKeys[row.RowIndex]["paymentNo"].ToString();
            Response.Redirect("managePayment.aspx?paymentNo=" + paymentNo);
        }

        void Page_Error()
        {
            Response.Redirect("../ErrorPages/PageLevelError2.aspx?exception=" + Server.GetLastError().Message + "&location=" + Server.UrlEncode(Request.Url.ToString()));
            Server.ClearError();
        }
    }
}
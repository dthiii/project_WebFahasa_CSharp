using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.User
{
    public partial class User : System.Web.UI.MasterPage
    {
        DataTable dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateCartQuantity();
            }            
        }

        protected string IsActive(string page)
        {
            string currentPage = Request.Url.Segments[Request.Url.Segments.Length - 1];
            return currentPage.Equals(page, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }

        public void UpdateCartQuantity()
        {
            if (Session["GioHang"] != null)
            {
                dt = (DataTable)Session["GioHang"];
                lblSoLuong.Text = dt.Rows.Count.ToString();
            }
            else
            {
                lblSoLuong.Text = "0";
            }
        }
    }
}
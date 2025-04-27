using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.User
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txtTenDangNhap.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT LoaiTK, tk.MaKH, HoKH + ' ' + TenKH as HoTenKH FROM TaiKhoan tk
                         JOIN KhachHang kh ON tk.MaKH = kh.ID
                         WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TenDangNhap", tenDangNhap);
                cmd.Parameters.AddWithValue("@MatKhau", matKhau);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string loaiTK = reader["LoaiTK"].ToString();

                    if (loaiTK == "Khách hàng")
                    {
                        string maKH = reader["MaKH"].ToString();

                        Session["TenDangNhap"] = tenDangNhap;
                        Session["LoaiTK"] = loaiTK;
                        Session["MaKH"] = maKH;
                        Session["HoTenKH"] = tenDangNhap;

                        System.Diagnostics.Debug.WriteLine("MaKH tại trang đặt hàng: " + Convert.ToInt32(Session["MaKH"]));


                        Response.Redirect("~/User/TrangChu.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Sai tên đăng nhập hoặc mật khẩu. Vui lòng kiểm tra lại.";
                    }
                }
                else
                {
                    lblMessage.Text = "Sai tên đăng nhập hoặc mật khẩu. Vui lòng kiểm tra lại.";
                }
            }
        }
    }
}
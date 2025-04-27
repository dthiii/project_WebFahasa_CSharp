using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.Admin
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
                string query = @"SELECT LoaiTK, MaNV FROM TaiKhoan 
                         WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TenDangNhap", tenDangNhap);
                cmd.Parameters.AddWithValue("@MatKhau", matKhau);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string loaiTK = reader["LoaiTK"].ToString();

                    if (loaiTK == "Quản lý")
                    {
                        string maNV = reader["MaNV"].ToString();

                        Session["TenDangNhap"] = tenDangNhap;
                        Session["LoaiTK"] = loaiTK;
                        Session["MaNV"] = maNV;

                        // Lấy tên nhân viên từ bảng NhanVien
                        reader.Close(); // Phải đóng trước khi thực hiện truy vấn tiếp theo

                        string tenNVQuery = "SELECT TenNV FROM NhanVien WHERE ID = @MaNV";
                        SqlCommand cmdTen = new SqlCommand(tenNVQuery, conn);
                        cmdTen.Parameters.AddWithValue("@MaNV", maNV);

                        object result = cmdTen.ExecuteScalar();
                        if (result != null)
                        {
                            Session["TenNhanVien"] = result.ToString();
                        }

                        Response.Redirect("~/Admin/TrangChu.aspx");
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
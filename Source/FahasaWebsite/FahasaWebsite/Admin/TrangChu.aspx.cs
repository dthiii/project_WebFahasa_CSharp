using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTongKhachHang();
            LoadDoanhThu();
            LoadTongDonHang();
            LoadTongSanPham();
            LoadTopLoaiSanPham();
            LoadTopKhachHang();
        }

        private void LoadTongKhachHang()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM dbo.KhachHang";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                lbTongKhachHang.Text = count.ToString();
            }
        }

        private void LoadDoanhThu()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT SUM(SoLuong * GiaBan) FROM dbo.CTDonHang ctdh
                         JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                object result = cmd.ExecuteScalar();

                decimal doanhThu = 0;
                if (result != DBNull.Value)
                {
                    doanhThu = Convert.ToDecimal(result);
                }

                lbDoanhThu.Text = doanhThu.ToString("N0") + " VNĐ";
            }
        }


        private void LoadTongDonHang()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM dbo.DonHang";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                lbDonHang.Text = count.ToString();
            }
        }

        private void LoadTongSanPham()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM dbo.SanPham";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                lbSanPham.Text = count.ToString();
            }
        }

        private void LoadTopLoaiSanPham()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP 3 TenLoaiSP, SUM(SoLuong) AS SoLuotMua FROM dbo.CTDonHang ctdh
                                 JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                 JOIN dbo.LoaiSP lsp ON sp.MaLoaiSP = lsp.ID
                                 GROUP BY TenLoaiSP
                                 ORDER BY SoLuotMua DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptTopLoai.DataSource = dt;
                rptTopLoai.DataBind();
            }
        }

        private void LoadTopKhachHang()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP 3 HoKH + ' ' + TenKH as HoTenKH, COUNT(MaDH) AS SoLuotMua FROM dbo.DonHang dh
                                 JOIN dbo.KhachHang kh ON dh.MaKH = kh.ID
                                 GROUP BY HoKH, TenKH
                                 ORDER BY SoLuotMua DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptKhachHang.DataSource = dt;
                rptKhachHang.DataBind();
            }
        }
    }
}
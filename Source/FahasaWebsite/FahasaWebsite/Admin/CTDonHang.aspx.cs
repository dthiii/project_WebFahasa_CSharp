using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.Admin
{
    public partial class CTDonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string maDH = Request.QueryString["MaDH"];
                System.Diagnostics.Debug.WriteLine($"MaDH={maDH}");
                if (!string.IsNullOrEmpty(maDH))
                {
                    LoadCTDonHang(maDH);
                    LoadThongTinMuaHang(maDH);
                }
            }
        }

        public void LoadCTDonHang(string maDH)
        {
            string queryDH = @"SELECT sp.HinhSP, sp.TenSP, ctdh.SoLuong, sp.GiaBan, (ctdh.SoLuong * sp.GiaBan) as ThanhTien FROM dbo.CTDonHang ctdh
                                       JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                       JOIN dbo.DonHang dh ON ctdh.MaDH = dh.ID
                                       WHERE ctdh.MaDH = @maDH
                                       GROUP BY sp.HinhSP, sp.TenSP, ctdh.SoLuong, sp.GiaBan";

            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(queryDH, conn); 
                    cmd.Parameters.AddWithValue("@maDH", maDH);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtCTDonHang = new DataTable();
                    adapter.Fill(dtCTDonHang);

                    // Gán dữ liệu vào Repeater
                    rptCTDonHang.DataSource = dtCTDonHang;
                    rptCTDonHang.DataBind();

                    // Tính tổng tiền từ DataTable
                    decimal tongTien = 0;
                    foreach (DataRow row in dtCTDonHang.Rows)
                    {
                        if (row["ThanhTien"] != DBNull.Value)
                        {
                            tongTien += Convert.ToDecimal(row["ThanhTien"]);
                        }
                    }

                    lblTongTien.Text = string.Format("{0:#,##0}₫", tongTien);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"alert('Lỗi khi tải dữ liệu: {ex.Message}');", true);
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        public void LoadThongTinMuaHang(string maDH)
        {
            string queryDH = @"SELECT TenNguoiNhan, SdtNguoiNhan, DiaChiNhan + ', ' + PhuongNguoiNhan + ', ' + QuanNguoiNhan + ', ' + TinhNguoiNhan as DiaChiNhan, dh.GhiChu, NgayDatHang, NgayGiaoHang, PTVanChuyen, PTTT FROM dbo.DonHang dh
                               WHERE dh.MaDH = @maDH";

            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(queryDH, conn);
                    cmd.Parameters.AddWithValue("@maDH", maDH);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtTTDonHang = new DataTable();
                    adapter.Fill(dtTTDonHang);

                    // Gán dữ liệu vào Repeater
                    rptThongTinMuaHang.DataSource = dtTTDonHang;
                    rptThongTinMuaHang.DataBind();
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"alert('Lỗi khi tải dữ liệu: {ex.Message}');", true);
                }
                finally
                {
                    conn.Close();
                }
            }
        }

    }
}
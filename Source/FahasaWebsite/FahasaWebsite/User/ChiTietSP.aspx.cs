using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.User
{
    public partial class ChiTietSP : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Lấy MaSP từ Query String
                if (Request.QueryString["MaSP"] != null)
                {
                    int maSP;
                    if (int.TryParse(Request.QueryString["MaSP"], out maSP))
                    {
                        LoadChiTietSanPham(maSP);
                        LoadDanhGia(maSP);
                    }
                    Session["MaSP"] = maSP;
                }
                LoadSanPhamNoiBat();
            }
        }

        private void LoadChiTietSanPham(int maSP)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                SELECT MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP, TacGia, TenNCC, NhaXuatBan, NamXuatBan
                FROM SanPham
                JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
                JOIN NhaCungCap ON SanPham.MaNCC = NhaCungCap.MaNCC
                WHERE MaSP = @MaSP";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MaSP", maSP);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        // Lưu vào ViewState để dùng sau này
                        ViewState["SanPham"] = dt;

                        // Hiển thị dữ liệu lên giao diện
                        tenSP.InnerText = dt.Rows[0]["TenSP"].ToString();
                        hinhSP.Src = dt.Rows[0]["HinhSP"].ToString();
                        giaBan.InnerText = string.Format("{0:#,##0}₫", dt.Rows[0]["GiaBan"]);
                        moTa.InnerText = dt.Rows[0]["MoTa"].ToString();
                        tenLoaiSP.InnerText = "Thể loại: " + dt.Rows[0]["TenLoaiSP"].ToString();
                        nhaCungCap.InnerText = dt.Rows[0]["TenNCC"].ToString();
                        nhaXuatBan.InnerText = dt.Rows[0]["NhaXuatBan"].ToString();
                        namXuatBan.InnerText = dt.Rows[0]["NamXuatBan"].ToString();
                        tacGia.InnerText = dt.Rows[0]["TacGia"].ToString();
                    }
                    else
                    {
                        ViewState["SanPham"] = null;
                    }
                }
            }
        }


        private void LoadDanhGia(int maSP)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                        SELECT DanhGiaSP.MaKH, HoKH + ' ' + TenKH AS HoTenKH, DiemDanhGia, BinhLuan, ThoiGian, AvatarKH
                        FROM DanhGiaSP
                        JOIN SanPham ON SanPham.MaSP = DanhGiaSP.MaSP
                        JOIN KhachHang ON DanhGiaSP.MaKH = KhachHang.MaKH
                        WHERE DanhGiaSP.MaSP = @MaSP";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaSP", maSP);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDanhGia.DataSource = dt;
                rptDanhGia.DataBind();
            }
        }

        protected string RenderStars(object soSao)
        {
            double stars = Convert.ToDouble(soSao);
            string html = "";

            for (int i = 1; i <= 5; i++)
            {
                if (i <= stars)
                    html += "<i class='fas fa-star text-primary'></i>"; // Sao đầy
                else if (i - stars < 1 && i - stars >= 0.5)
                    html += "<i class='fas fa-star-half-alt text-primary'></i>"; // Nửa sao
                else
                    html += "<i class='fas fa-star'></i>"; // Sao trống
            }
            return html;
        }

        private void LoadSanPhamNoiBat()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT SanPham.MaSP, TenSP, HinhSP, GiaBan, DiemDanhGia, TiLeGiam, GiaBan * (1 - TiLeGiam/100) AS GiaSauGiam FROM SanPham JOIN KhuyenMai on KhuyenMai.MaKM = SanPham.MaKM JOIN DanhGiaSP on DanhGiaSP.MaSP = SanPham.MaSP";
                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptSPNoiBat.DataSource = dt;
                    rptSPNoiBat.DataBind();
                }
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            themSanPhamVaoGioHang();
            string script = "thongBaoThemSPThanhCong();";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "hienThongBao", script, true);
        }

        protected void btnMua_Click(object sender, EventArgs e)
        {
            themSanPhamVaoGioHang();
            Response.Redirect("GioHang.aspx");
        }

        private void themSanPhamVaoGioHang()
        {
            DataTable dtSanPham = (DataTable)ViewState["SanPham"];
            DataTable dtGioHang;
            int soLuong = 0;
            if (Session["GioHang"] == null)
            {
                dtGioHang = new DataTable();
                dtGioHang.Columns.Add("MaSP");
                dtGioHang.Columns.Add("HinhSP");
                dtGioHang.Columns.Add("TenSP");
                dtGioHang.Columns.Add("SoLuong");
                dtGioHang.Columns.Add("GiaBan");
                dtGioHang.Columns.Add("ThanhTien");
            }
            else
            {
                dtGioHang = (DataTable)Session["GioHang"];
            }
            string maSP = Session["MaSP"]?.ToString();
            int pos = TimSP(maSP, dtGioHang);
            if (pos != -1)
            {
                soLuong = Convert.ToInt32(dtGioHang.Rows[pos]["SoLuong"]) + int.Parse(txtSoLuong.Text);
                dtGioHang.Rows[pos]["SoLuong"] = soLuong;
                dtGioHang.Rows[pos]["ThanhTien"] = Convert.ToDouble(dtGioHang.Rows[pos]["GiaBan"]) * soLuong;
            }
            else
            {
                soLuong = int.Parse(txtSoLuong.Text);
                DataRow dr = dtGioHang.NewRow();
                dr["MaSP"] = dtSanPham.Rows[0]["MaSP"];
                dr["HinhSP"] = dtSanPham.Rows[0]["HinhSP"];
                dr["TenSP"] = dtSanPham.Rows[0]["TenSP"];
                dr["GiaBan"] = dtSanPham.Rows[0]["GiaBan"];
                dr["SoLuong"] = soLuong;
                dr["ThanhTien"] = Convert.ToDouble(dtSanPham.Rows[0]["GiaBan"]) * soLuong;
                dtGioHang.Rows.Add(dr);
            }
            Session["GioHang"] = dtGioHang;
        }

        public static int TimSP(string maSP, DataTable dt)
        {
            int pos = -1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["MaSP"].ToString().ToLower() == maSP.ToLower())
                {
                    pos = i;
                    break;
                }
            }
            return pos;
        }
    }
}
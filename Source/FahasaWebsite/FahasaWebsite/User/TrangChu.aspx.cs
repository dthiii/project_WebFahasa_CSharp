using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.User
{
    public partial class Default : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["selectedCategory"] = "All"; // Mặc định chọn "Xem tất cả"
                LoadBooksByCategory("All");
                UpdateActiveClass();
                LoadBooksBestSeller();
                LoadTestimonials();
            }
        }

        protected void LoadBooksByCategory(object sender, EventArgs e)
        {
            string category = (sender as LinkButton).CommandArgument;
            ViewState["selectedCategory"] = category; // Lưu danh mục được chọn
            LoadBooksByCategory(category);
            UpdateActiveClass(); // Cập nhật class cho các nút
        }


        private void LoadBooksByCategory(string category)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP FROM SanPham " +
                    "JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP JOIN NhomSP ON LoaiSP.MaNhomSP = NhomSP.MaNhomSP";

                if (category != "All")
                {
                    query += " WHERE TenNhomSP = @Category";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (category != "All")
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);

                }
            }
            DataView dv = new DataView(dt);
            DataTable dtLimited = dv.ToTable().AsEnumerable().Take(24).CopyToDataTable();

            rptBooks.DataSource = dtLimited;
            rptBooks.DataBind();

            DataTable dtXuHuong = dv.ToTable().AsEnumerable().Take(10).CopyToDataTable();

            rptSachXuHuong.DataSource = dtXuHuong;
            rptSachXuHuong.DataBind();
        }

        private void UpdateActiveClass()
        {
            string selectedCategory = ViewState["selectedCategory"].ToString();

            // Reset tất cả nút về trạng thái mặc định
            btnAll.CssClass = "d-flex m-2 py-2 bg-light rounded-pill";
            btnVanHoc.CssClass = "d-flex m-2 py-2 bg-light rounded-pill";
            btnKinhTe.CssClass = "d-flex m-2 py-2 bg-light rounded-pill";
            btnThieuNhi.CssClass = "d-flex m-2 py-2 bg-light rounded-pill";
            btnGiaoKhoa.CssClass = "d-flex m-2 py-2 bg-light rounded-pill";

            // Thêm class "active" cho danh mục đang được chọn
            switch (selectedCategory)
            {
                case "All":
                    btnAll.CssClass += " active";
                    break;
                case "Văn học":
                    btnVanHoc.CssClass += " active";
                    break;
                case "Kinh tế":
                    btnKinhTe.CssClass += " active";
                    break;
                case "Sách thiếu nhi":
                    btnThieuNhi.CssClass += " active";
                    break;
                case "Giáo khoa - Tham khảo":
                    btnGiaoKhoa.CssClass += " active";
                    break;
            }
        }

        protected string GetActiveClass(string category)
        {
            string selectedCategory = ViewState["selectedCategory"] as string ?? "All";
            return selectedCategory == category ? "bg-primary text-white active" : "bg-light text-dark";
        }



        private void LoadBooksBestSeller()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT TOP 6 MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP FROM SanPham JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP ORDER BY GiaBan DESC";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    da.Fill(dt);

                    dt.Columns.Add("SoSaoRandom", typeof(double));
                    foreach (DataRow row in dt.Rows)
                    {
                        // Sinh số sao ngẫu nhiên từ 3.5 đến 5 (và làm tròn đến 0.5)
                        double randomStars = Math.Round(random.NextDouble() * 1.5 + 3.5, 1);
                        row["SoSaoRandom"] = randomStars;
                    }

                    rptBooksBestSeller.DataSource = dt;
                    rptBooksBestSeller.DataBind();
                }
                catch (Exception ex)
                {
                    // Xử lý lỗi
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }
        

        private void LoadTestimonials()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT TOP 3 HoKH + ' ' + TenKH AS HoTenKH, AvatarKH, DiemDanhGia, BinhLuan, ThoiGian FROM KhachHang JOIN DanhGiaChung ON KhachHang.MaKH = DanhGiaChung.MaKH ORDER BY DiemDanhGia DESC";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    da.Fill(dt);

                    dt.Columns.Add("SoSaoRandom", typeof(double));
                    foreach (DataRow row in dt.Rows)
                    {
                        // Sinh số sao ngẫu nhiên từ 3.5 đến 5 (và làm tròn đến 0.5)
                        double randomStars = Math.Round(random.NextDouble() * 1.5 + 3.5, 1);
                        row["SoSaoRandom"] = randomStars;
                    }

                    rptTestimonials.DataSource = dt;
                    rptTestimonials.DataBind();
                }
                catch (Exception ex)
                {
                    // Xử lý lỗi
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        Random random = new Random();

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
    }
}
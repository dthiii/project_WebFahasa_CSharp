using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.User
{
    public partial class SanPham : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;

        private int pageSize = 6; // Số sản phẩm mỗi trang

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNhomSanPham();
                LoadNhaCungCap();
                LoadSanPhamNoiBat();

                // Lấy số trang từ QueryString, nếu không có thì mặc định là 1
                int page = 1;
                if (Request.QueryString["page"] != null)
                {
                    int.TryParse(Request.QueryString["page"], out page);
                }

                LoadSanPham(page);
            }
        }


        private void LoadNhomSanPham()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT * FROM NhomSP";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlNhomSanPham.Items.Clear();
                        while (reader.Read())
                        {
                            ddlNhomSanPham.Items.Add(new ListItem(reader["TenNhomSP"].ToString(), reader["MaNhomSP"].ToString()));
                            int maNhomVanHoc = GetMaNhomVanHoc();
                            ddlNhomSanPham.SelectedValue = maNhomVanHoc.ToString();
                            LoadLoaiSP(maNhomVanHoc);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        private int GetMaNhomVanHoc()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Truy vấn lấy MaNhomSP của nhóm "Văn học"
                    string query = "SELECT MaNhomSP FROM NhomSP WHERE TenNhomSP = N'Văn học'";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToInt32(result) : 0;
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                    return 0;
                }
            }
        }

        private void LoadLoaiSP(int maNhom)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT MaLoaiSP, TenLoaiSP FROM LoaiSP WHERE MaNhomSP = @MaNhomSP";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaNhomSP", maNhom);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Đổ dữ liệu vào Repeater
                        rptTheLoai.DataSource = dt;
                        rptTheLoai.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        protected void ddlNhomSanPham_SelectedIndexChanged(object sender, EventArgs e)
        {

            int maNhom = 0; // Nhóm sản phẩm mặc định (Văn học)
            LoadSanPham(1);

            // Kiểm tra nếu có chọn nhóm sản phẩm, lấy giá trị từ dropdown
            if (!(!int.TryParse(ddlNhomSanPham.SelectedValue, out int selectedMaNhom) || selectedMaNhom <= 0))
            {
                maNhom = selectedMaNhom;
            }

            // Lấy số trang từ QueryString (nếu có)
            // Lấy số trang từ QueryString, nếu không có thì mặc định là 1
            int page = 1;
            if (!string.IsNullOrEmpty(Request.QueryString["page"]) && int.TryParse(Request.QueryString["page"], out int parsedPage))
            {
                page = parsedPage;
            }   

            //Load danh sách thể loại của nhóm sản phẩm được chọn
            LoadLoaiSP(maNhom);

            // Load danh sách sản phẩm thuộc nhóm sản phẩm đó
            LoadSanPhamTheoNhom(maNhom, page);
        }


        protected void rptTheLoai_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int page = 1;

            // Gọi hàm load sản phẩm theo loại đã chọn
            LoadSanPham(page);
        }

        private int GetSelectedTheLoai()
        {
            foreach (RepeaterItem item in rptTheLoai.Items)
            {
                RadioButton rdoTheLoai = (RadioButton)item.FindControl("rdoTheLoai");
                HiddenField hdfMaLoaiSP = (HiddenField)item.FindControl("hdfMaLoaiSP");

                if (rdoTheLoai != null && rdoTheLoai.Checked && hdfMaLoaiSP != null)
                {
                    return int.Parse(hdfMaLoaiSP.Value);
                }
            }
            return 0; // Không có thể loại nào được chọn
        }

        //private void LoadSanPhamTheoNhom(int maNhom, int page = 1)
        //{
        //    DataTable dt = new DataTable();
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        try
        //        {
        //            conn.Open();
        //            string query = @"SELECT MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP 
        //                     FROM SanPham 
        //                     JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
        //                     JOIN NhomSP ON LoaiSP.MaNhomSP = NhomSP.MaNhomSP
        //                     WHERE LoaiSP.MaNhomSP = @MaNhomSP";

        //            using (SqlCommand cmd = new SqlCommand(query, conn))
        //            {
        //                cmd.Parameters.AddWithValue("@MaNhomSP", maNhom);

        //                SqlDataAdapter da = new SqlDataAdapter(cmd);
        //                da.Fill(dt);
        //            }

        //            int totalItems = dt.Rows.Count;
        //            DataTable dtPaged = dt.AsEnumerable().Skip((page - 1) * pageSize).Take(pageSize).CopyToDataTable();

        //            ddlNhomSanPham.DataSource = dtPaged;
        //            ddlNhomSanPham.DataTextField = "TenNhomSP";
        //            ddlNhomSanPham.DataValueField = "MaNhomSP";
        //            ddlNhomSanPham.DataBind();

        //            GeneratePagination(totalItems, page);
        //        }
        //        catch (Exception ex)
        //        {
        //            Response.Write("Lỗi: " + ex.Message);
        //        }
        //    }
        //}

        private void LoadSanPhamTheoNhom(int maNhom, int page = 1)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP 
                             FROM SanPham 
                             JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
                             JOIN NhomSP ON LoaiSP.MaNhomSP = NhomSP.MaNhomSP
                             WHERE LoaiSP.MaNhomSP = @MaNhomSP";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaNhomSP", maNhom);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }

                    // Tổng số sản phẩm
                    int totalItems = dt.Rows.Count;
                    int totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

                    // Kiểm tra nếu không có sản phẩm
                    if (totalItems > 0)
                    {
                        // Lấy danh sách sản phẩm theo trang hiện tại
                        DataTable dtPaged = dt.AsEnumerable()
                                              .Skip((page - 1) * pageSize)
                                              .Take(pageSize)
                                              .CopyToDataTable();

                        rptSanPham.DataSource = dtPaged;
                        rptSanPham.DataBind();

                        // Tạo nút phân trang nếu có nhiều hơn 1 trang
                        if (totalPages > 1)
                        {
                            GeneratePagination(totalPages, page);
                        }
                        else
                        {
                            pagination.InnerHtml = ""; // Ẩn phân trang nếu chỉ có 1 trang
                        }
                    }
                    else
                    {
                        rptSanPham.DataSource = null;
                        rptSanPham.DataBind();
                        pagination.InnerHtml = "<p class='text-center'>Không có sản phẩm nào trong nhóm này.</p>";
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }


        private void LoadNhaCungCap()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT MaNCC, TenNCC FROM NhaCungCap";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Đổ dữ liệu vào Repeater
                        rptNhaCungCap.DataSource = dt;
                        rptNhaCungCap.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        private void LoadSanPhamNoiBat()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
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
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        public string RenderStars(object rating)
        {
            int stars = Convert.ToInt32(rating);
            string html = "";
            for (int i = 0; i < 5; i++)
            {
                if (i < stars)
                    html += "<i class='fa fa-star text-secondary'></i>";
                else
                    html += "<i class='fa fa-star'></i>";
            }
            return html;
        }

        //private void LoadSanPham()
        //{
        //    DataTable dt = new DataTable();
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        try
        //        {
        //            conn.Open();
        //            // Câu lệnh SQL có điều kiện lọc theo MaLoaiSP
        //            string query = @"SELECT MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP 
        //                     FROM SanPham 
        //                     JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
        //                     WHERE (@MaLoaiSP IS NULL OR SanPham.MaLoaiSP = @MaLoaiSP)";

        //            using (SqlCommand cmd = new SqlCommand(query, conn))
        //            {
        //                // Kiểm tra xem có MaLoaiSP không
        //                if (!string.IsNullOrEmpty(Request.QueryString["MaLoaiSP"]))
        //                {
        //                    cmd.Parameters.AddWithValue("@MaLoaiSP", Request.QueryString["MaLoaiSP"]);
        //                }
        //                else
        //                {
        //                    cmd.Parameters.AddWithValue("@MaLoaiSP", DBNull.Value); // Không có MaLoaiSP -> hiển thị tất cả
        //                }

        //                SqlDataAdapter da = new SqlDataAdapter(cmd);
        //                da.Fill(dt);
        //            }

        //            DataView dv = new DataView(dt);
        //            DataTable dtLimited = dv.ToTable().AsEnumerable().Take(6).CopyToDataTable();

        //            rptSanPham.DataSource = dtLimited;
        //            rptSanPham.DataBind();
        //        }
        //        catch (Exception ex)
        //        {
        //            Response.Write("Lỗi: " + ex.Message);
        //        }
        //    }
        //}

        private void LoadSanPham(int page = 1)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT MaSP, TenSP, HinhSP, GiaBan, MoTa, TenLoaiSP 
                             FROM SanPham 
                             JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
                             WHERE (@MaLoaiSP IS NULL OR SanPham.MaLoaiSP = @MaLoaiSP)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (!string.IsNullOrEmpty(Request.QueryString["MaLoaiSP"]))
                        {
                            cmd.Parameters.AddWithValue("@MaLoaiSP", Request.QueryString["MaLoaiSP"]);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@MaLoaiSP", DBNull.Value);
                        }

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }

                    // Tổng số sản phẩm
                    int totalItems = dt.Rows.Count;
                    int totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

                    // Lấy danh sách sản phẩm theo trang hiện tại
                    DataTable dtPaged = dt.AsEnumerable()
                                          .Skip((page - 1) * pageSize)
                                          .Take(pageSize)
                                          .CopyToDataTable();

                    rptSanPham.DataSource = dtPaged;
                    rptSanPham.DataBind();

                    // Tạo nút phân trang
                    GeneratePagination(totalPages, page);
                }
                catch (Exception ex)
                {
                    Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        private void GeneratePagination(int totalPages, int currentPage)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='pagination d-flex justify-content-center mt-5'>");

            // Nút Previous
            if (currentPage > 1)
            {
                sb.AppendFormat("<a href='?page={0}' class='rounded'>&laquo;</a>", currentPage - 1);
            }

            for (int i = 1; i <= totalPages; i++)
            {
                if (i == currentPage)
                {
                    sb.AppendFormat("<a href='?page={0}' class='active rounded'>{0}</a>", i);
                }
                else
                {
                    sb.AppendFormat("<a href='?page={0}' class='rounded'>{0}</a>", i);
                }
            }

            // Nút Next
            if (currentPage < totalPages)
            {
                sb.AppendFormat("<a href='?page={0}' class='rounded'>&raquo;</a>", currentPage + 1);
            }

            sb.Append("</div>");

            pagination.InnerHtml = sb.ToString();
        }
    }
}

using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static FahasaWebsite.Models.DiaChiModel;

namespace FahasaWebsite.Admin
{
    public partial class UpdateKH : System.Web.UI.Page
    {
        protected List<TinhThanh> danhSachTinh;
        protected List<QuanHuyen> danhSachQuan;
        protected List<PhuongXa> danhSachPhuong;

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDataFromExcel();
            if (!IsPostBack)
            {

                LoadTinh();

                string maKH = Request.QueryString["MaKH"];
                if (!string.IsNullOrEmpty(maKH))
                {
                    LoadKhachHang(maKH);
                    LoadThongTinMuaHang(maKH);
                }
            }
        }

        private void LoadKhachHang(string maKH)
        {
            string query = @"SELECT * FROM dbo.KhachHang WHERE MaKH = @MaKH";
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaKH", maKH);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtHoKH.Text = dr["HoKH"].ToString();
                    txtTenKH.Text = dr["TenKH"].ToString();
                    txtSdtKH.Text = dr["SdtKH"].ToString();
                    txtEmailKH.Text = dr["EmailKH"].ToString();
                    txtDiaChiKH.Text = dr["DiaChiKH"].ToString();

                    // Lấy giá trị từ database
                    string gioiTinhKH = dr["GioiTinhKH"].ToString().Trim();
                    string tinhKH = dr["TinhKH"].ToString().Trim();
                    string quanKH = dr["QuanKH"].ToString().Trim();
                    string phuongKH = dr["PhuongKH"].ToString().Trim();
                    System.Diagnostics.Debug.WriteLine($"ddlPhuong.SelectedValue set to: {phuongKH}");

                    // Debug giá trị
                    System.Diagnostics.Debug.WriteLine($"GioiTinhKH: {gioiTinhKH}");
                    System.Diagnostics.Debug.WriteLine($"TinhKH: {tinhKH}");
                    System.Diagnostics.Debug.WriteLine($"QuanKH: {quanKH}");
                    System.Diagnostics.Debug.WriteLine($"PhuongKH: {phuongKH}");

                    // Gán giới tính
                    if (!string.IsNullOrEmpty(gioiTinhKH))
                    {
                        try
                        {
                            // Chuẩn hóa: chuyển về dạng title case (Nam, Nu, Khac)
                            gioiTinhKH = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(gioiTinhKH.ToLower());
                            // Điều chỉnh để khớp với Value của ListItem
                            if (gioiTinhKH == "Nữ") gioiTinhKH = "Nu";
                            if (gioiTinhKH == "Khác") gioiTinhKH = "Khac";
                            ddlGioiTinhKH.SelectedValue = gioiTinhKH;
                            System.Diagnostics.Debug.WriteLine($"ddlGioiTinhKH.SelectedValue set to: {ddlGioiTinhKH.SelectedValue}");
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error setting ddlGioiTinhKH: {ex.Message}");
                        }
                    }

                    // Gán giá trị cho ddlTinh trước
                    if (!string.IsNullOrEmpty(tinhKH))
                    {
                        try
                        {
                            tinhKH = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(tinhKH.ToLower());
                            ddlTinh.SelectedValue = tinhKH;
                            System.Diagnostics.Debug.WriteLine($"ddlTinh.SelectedValue set to: {ddlTinh.SelectedValue}");
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error setting ddlTinh: {ex.Message}");
                        }
                    }

                    // Load danh sách quận dựa trên TinhKH (tên tỉnh)
                    LoadQuan(tinhKH);

                    // Gán giá trị cho ddlQuan
                    if (!string.IsNullOrEmpty(quanKH))
                    {
                        try
                        {
                            quanKH = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(quanKH.ToLower());
                            ddlQuan.SelectedValue = quanKH;
                            System.Diagnostics.Debug.WriteLine($"ddlQuan.SelectedValue set to: {ddlQuan.SelectedValue}");
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error setting ddlQuan: {ex.Message}");
                        }
                    }

                    // Load danh sách phường dựa trên QuanKH (tên quận)
                    LoadPhuong(quanKH);

                    // Gán giá trị cho ddlPhuong
                    if (!string.IsNullOrEmpty(phuongKH))
                    {
                        try
                        {
                            phuongKH = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(phuongKH.ToLower());
                            System.Diagnostics.Debug.WriteLine($"ddlPhuong.SelectedValue set to: {phuongKH}");
                            ddlPhuong.SelectedValue = phuongKH;
                            System.Diagnostics.Debug.WriteLine($"ddlPhuong.SelectedValue set to: {ddlPhuong.SelectedValue}");
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error setting ddlPhuong: {ex.Message}");
                        }
                    }

                    if (dr["NgSinhKH"] != DBNull.Value)
                    {
                        DateTime ngaysinhKH = Convert.ToDateTime(dr["NgSinhKH"]);
                        txtNgaySinh.Text = ngaysinhKH.ToString("yyyy-MM-dd");
                    }

                    string avatarKH = dr["AvatarKH"].ToString();
                    string fileName = "Chọn hình khách hàng";
                    if (!string.IsNullOrEmpty(avatarKH))
                    {
                        string baseFileName = Path.GetFileName(avatarKH);
                        fileName = $@"C:\\fakepath\\{baseFileName}";
                        fileName = fileName.Replace(@"\", @"\\");
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "updateLabel",
                        $"document.getElementById('labelUpload').innerText = '{fileName}';", true);
                }
                conn.Close();
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                string hoKH = txtHoKH.Text.Trim();
                string tenKH = txtTenKH.Text.Trim();
                string gioitinhKH = ddlGioiTinhKH.SelectedValue;
                string sdtKH = txtSdtKH.Text.Trim();
                string emailKH = txtEmailKH.Text.Trim();
                string tinhKH = ddlTinh.SelectedValue == "0" ? "" : ddlTinh.SelectedValue;
                string quanKH = ddlQuan.SelectedValue == "0" ? "" : ddlQuan.SelectedValue;
                string phuongKH = ddlPhuong.SelectedValue == "0" ? "" : ddlPhuong.SelectedValue;
                string diachiKH = txtDiaChiKH.Text.Trim();
                DateTime ngaysinhKH = DateTime.Now;

                if (!string.IsNullOrEmpty(txtNgaySinh.Text))
                {
                    ngaysinhKH = DateTime.Parse(txtNgaySinh.Text);
                }

                string avtKH = "";
                string fileName = Path.GetFileName(fileUploadImage.PostedFile.FileName);
                if (!string.IsNullOrEmpty(fileName))
                {
                    string uploadPath = Server.MapPath("~/UserTemplate/img/HinhKH/");
                    string filePath = Path.Combine(uploadPath, fileName);
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    fileUploadImage.SaveAs(filePath);
                    avtKH = "/UserTemplate/img/HinhKH/" + fileName;
                }

                string query;
                string maKH = Request.QueryString["MaKH"];
                bool isEditMode = !string.IsNullOrEmpty(maKH);

                string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    if (isEditMode)
                    {
                        query = @"UPDATE dbo.KhachHang 
                                 SET HoKH = @HoKH, TenKH = @TenKH, GioiTinhKH = @GioiTinhKH, 
                                     NgSinhKH = @NgSinhKH, SdtKH = @SdtKH, EmailKH = @EmailKH, 
                                     TinhKH = @TinhKH, QuanKH = @QuanKH, PhuongKH = @PhuongKH, DiaChiKH = @DiaChiKH" +
                                (string.IsNullOrEmpty(avtKH) ? "" : ", AvatarKH = @AvatarKH") +
                                " WHERE MaKH = @MaKH";
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(fileName))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", "alert('Vui lòng chọn hình khách hàng!');", true);
                            return;
                        }
                        query = @"INSERT INTO dbo.KhachHang (HoKH, TenKH, GioiTinhKH, NgSinhKH, SdtKH, EmailKH, TinhKH, QuanKH, PhuongKH, DiaChiKH, AvatarKH)
                                 VALUES (@HoKH, @TenKH, @GioiTinhKH, @NgSinhKH, @SdtKH, @EmailKH, @TinhKH, @QuanKH, @PhuongKH, @DiaChiKH, @AvatarKH)";
                    }

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@HoKH", hoKH);
                    cmd.Parameters.AddWithValue("@TenKH", tenKH);
                    cmd.Parameters.AddWithValue("@GioiTinhKH", gioitinhKH);
                    cmd.Parameters.AddWithValue("@NgSinhKH", ngaysinhKH);
                    cmd.Parameters.AddWithValue("@SdtKH", sdtKH);
                    cmd.Parameters.AddWithValue("@EmailKH", emailKH);
                    cmd.Parameters.AddWithValue("@TinhKH", tinhKH);
                    cmd.Parameters.AddWithValue("@QuanKH", quanKH);
                    cmd.Parameters.AddWithValue("@PhuongKH", phuongKH);
                    cmd.Parameters.AddWithValue("@DiaChiKH", diachiKH);

                    if (isEditMode)
                    {
                        cmd.Parameters.AddWithValue("@MaKH", maKH);
                        if (!string.IsNullOrEmpty(avtKH))
                        {
                            cmd.Parameters.AddWithValue("@AvatarKH", avtKH);
                        }
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@AvatarKH", avtKH);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "alert('Cập nhật khách hàng thành công!'); window.location='KhachHang.aspx';", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", "alert('Đã xảy ra lỗi khi lưu: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtHoKH.Text = "";
            txtTenKH.Text = "";
            txtSdtKH.Text = "";
            txtEmailKH.Text = "";
            txtDiaChiKH.Text = "";
            ddlGioiTinhKH.SelectedIndex = 0;
            ddlTinh.SelectedIndex = 0;
            ddlQuan.Items.Clear();
            ddlQuan.Items.Insert(0, new ListItem("Chọn quận/huyện", "0"));
            ddlPhuong.Items.Clear();
            ddlPhuong.Items.Insert(0, new ListItem("Chọn xã/phường", "0"));
            txtNgaySinh.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }

        private void LoadDataFromExcel()
        {
            string filePath = Server.MapPath("~/App_Data/DiaChiVN.xlsx");
            using (var package = new ExcelPackage(new FileInfo(filePath)))
            {
                var sheetTinh = package.Workbook.Worksheets["TinhThanh"];
                var sheetQuan = package.Workbook.Worksheets["QuanHuyen"];
                var sheetPhuong = package.Workbook.Worksheets["PhuongXa"];

                danhSachTinh = new List<TinhThanh>();
                danhSachQuan = new List<QuanHuyen>();
                danhSachPhuong = new List<PhuongXa>();

                int rowCountTinh = sheetTinh.Dimension.End.Row;
                for (int i = 2; i <= rowCountTinh; i++)
                {
                    danhSachTinh.Add(new TinhThanh
                    {
                        MaTinh = sheetTinh.Cells[i, 1].Text,
                        TenTinh = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(sheetTinh.Cells[i, 2].Text.Trim().ToLower())
                    });
                }

                int rowCountQuan = sheetQuan.Dimension.End.Row;
                for (int i = 2; i <= rowCountQuan; i++)
                {
                    danhSachQuan.Add(new QuanHuyen
                    {
                        MaQuan = sheetQuan.Cells[i, 1].Text,
                        TenQuan = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(sheetQuan.Cells[i, 2].Text.Trim().ToLower()),
                        MaTinh = sheetQuan.Cells[i, 3].Text
                    });
                }

                int rowCountPhuong = sheetPhuong.Dimension.End.Row;
                for (int i = 2; i <= rowCountPhuong; i++)
                {
                    danhSachPhuong.Add(new PhuongXa
                    {
                        MaPhuong = sheetPhuong.Cells[i, 1].Text,
                        TenPhuong = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(sheetPhuong.Cells[i, 2].Text.Trim().ToLower()),
                        MaQuan = sheetPhuong.Cells[i, 3].Text
                    });
                }
            }
        }

        protected void ddlTinh_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedTinh = ddlTinh.SelectedValue;
            LoadQuan(selectedTinh);

            ddlPhuong.Items.Clear();
            ddlPhuong.Items.Insert(0, new ListItem("Chọn xã/phường", "0"));
        }

        protected void ddlQuan_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedQuan = ddlQuan.SelectedValue;
            LoadPhuong(selectedQuan);
        }

        private void LoadTinh()
        {
            ddlTinh.DataSource = danhSachTinh;
            ddlTinh.DataTextField = "TenTinh";
            ddlTinh.DataValueField = "TenTinh";
            ddlTinh.DataBind();
            ddlTinh.Items.Insert(0, new ListItem("Chọn tỉnh/thành phố", "0"));
        }

        private void LoadQuan(string tenTinh)
        {
            var tinh = danhSachTinh.FirstOrDefault(t => t.TenTinh == tenTinh);
            string maTinh = tinh != null ? tinh.MaTinh : "0";

            var quanList = danhSachQuan.Where(q => q.MaTinh == maTinh).ToList();
            ddlQuan.DataSource = quanList;
            ddlQuan.DataTextField = "TenQuan";
            ddlQuan.DataValueField = "TenQuan";
            ddlQuan.DataBind();
            ddlQuan.Items.Insert(0, new ListItem("Chọn quận/huyện", "0"));
        }

        private void LoadPhuong(string tenQuan)
        {
            var quan = danhSachQuan.FirstOrDefault(q => q.TenQuan == tenQuan);
            string maQuan = quan != null ? quan.MaQuan : "0";

            var phuongList = danhSachPhuong.Where(p => p.MaQuan == maQuan).ToList();
            ddlPhuong.DataSource = phuongList;
            ddlPhuong.DataTextField = "TenPhuong";
            ddlPhuong.DataValueField = "TenPhuong";
            ddlPhuong.DataBind();
            ddlPhuong.Items.Insert(0, new ListItem("Chọn xã/phường", "0"));
        }

        private void LoadThongTinMuaHang(string maKH)
        {
            string query = @"SELECT COUNT(dh.MaDH) AS SoHoaDon, SUM(ctdh.SoLuong * sp.GiaBan) AS TongSoTien FROM dbo.KhachHang kh
                                LEFT JOIN dbo.DonHang dh ON dh.MaKH = kh.ID
                                JOIN dbo.CTDonHang ctdh ON ctdh.MaDH = dh.ID
                                JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                WHERE kh.MaKH = @MaKH";

            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaKH", maKH);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                rptThongTinMuaHang.DataSource = dr;
                rptThongTinMuaHang.DataBind(); 
                conn.Close();
            }
        }
    }
}
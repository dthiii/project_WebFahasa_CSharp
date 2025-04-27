using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.Admin
{
    public partial class UpdateSP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtNam.Text = DateTime.Now.Year.ToString();
                LoadLoaiSP();
                LoadNhaCungCap();

                string maSP = Request.QueryString["MaSP"];
                if (!string.IsNullOrEmpty(maSP))
                {
                    LoadSanPham(maSP);
                }
            }
        }

        private void LoadLoaiSP()
        {
            string query = "SELECT ID, TenLoaiSP FROM dbo.LoaiSP";

            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                rptLoaiSP.DataSource = dr;
                rptLoaiSP.DataBind();
                conn.Close();
            }
        }

        private void LoadSanPham(string maSP)
        {
            string query = @"SELECT TenSP, GiaNhap, GiaBan, NhaXuatBan, NamXuatBan, TacGia, MoTa, SoLuongTon, MaNCC, MaLoaiSP, HinhSP
                    FROM dbo.SanPham WHERE MaSP = @MaSP";
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaSP", maSP);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtTenSP.Text = dr["TenSP"].ToString();
                    txtGiaNhap.Text = dr["GiaNhap"].ToString();
                    txtGiaBan.Text = dr["GiaBan"].ToString();
                    txtNhaXB.Text = dr["NhaXuatBan"].ToString();
                    txtNam.Text = dr["NamXuatBan"].ToString();
                    txtTacGia.Text = dr["TacGia"].ToString();
                    txtMoTa.Text = dr["MoTa"].ToString();
                    txtSoLuong.Text = dr["SoLuongTon"].ToString();
                    ddlNCC.SelectedValue = dr["MaNCC"].ToString();

                    // Lấy MaLoaiSP và đánh dấu RadioButton tương ứng
                    string maLoaiSP = dr["MaLoaiSP"].ToString();
                    foreach (RepeaterItem item in rptLoaiSP.Items)
                    {
                        RadioButton radio = (RadioButton)item.FindControl("rdoLoaiSP");
                        if (radio != null && radio.Attributes["value"] == maLoaiSP)
                        {
                            radio.Checked = true;
                            break;
                        }
                    }

                    string hinhSP = dr["HinhSP"].ToString();
                    string fileName = "Chọn hình ảnh";
                    if (!string.IsNullOrEmpty(hinhSP))
                    {
                        string baseFileName = Path.GetFileName(hinhSP); 
                        fileName = $@"C:\\fakepath\\{baseFileName}"; 
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "updateLabel",
                        $"document.getElementById('labelUpload').innerText = '{fileName}';", true);
                }
                conn.Close();
            }
        }

        private void LoadNhaCungCap()
        {
            string query = "SELECT ID, TenNCC FROM dbo.NhaCungCap";

            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                ddlNCC.DataSource = dr;
                ddlNCC.DataTextField = "TenNCC";
                ddlNCC.DataValueField = "ID";
                ddlNCC.DataBind();

                conn.Close();
            }
        }

        private int GetSelectedLoaiSP()
        {
            foreach (RepeaterItem item in rptLoaiSP.Items)
            {
                RadioButton radio = (RadioButton)item.FindControl("rdoLoaiSP");
                if (radio != null && radio.Checked)
                {
                    string value = radio.Attributes["value"];
                    if (int.TryParse(value, out int maLoaiSP))
                    {
                        return maLoaiSP;
                    }
                }
            }
            return 0;
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                string tenSP = txtTenSP.Text.Trim();
                decimal giaNhap = decimal.Parse(txtGiaNhap.Text);
                decimal giaBan = decimal.Parse(txtGiaBan.Text);
                string nhaXB = txtNhaXB.Text.Trim();
                int namXB = int.Parse(txtNam.Text);
                string tacGia = txtTacGia.Text.Trim();
                string moTa = txtMoTa.Text.Trim();
                int soLuong = int.Parse(txtSoLuong.Text);
                int maNCC = int.Parse(ddlNCC.SelectedValue);
                int maLoaiSP = GetSelectedLoaiSP();
                DateTime ngayThem = DateTime.Now;

                // Kiểm tra loại sản phẩm
                if (maLoaiSP == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", "alert('Vui lòng chọn loại sản phẩm hợp lệ!');", true);
                    return;
                }

                string hinhSP = "";
                string fileName = Path.GetFileName(fileUploadImage.PostedFile.FileName);
                if (!string.IsNullOrEmpty(fileName))
                {
                    string uploadPath = Server.MapPath("~/UserTemplate/img/HinhSP/");
                    string filePath = Path.Combine(uploadPath, fileName);
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    fileUploadImage.SaveAs(filePath);
                    hinhSP = "/UserTemplate/img/HinhSP/" + fileName;
                }

                string query;
                string maSP = Request.QueryString["MaSP"];
                bool isEditMode = !string.IsNullOrEmpty(maSP);

                string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    if (isEditMode)
                    {
                        // Chế độ chỉnh sửa
                        query = @"UPDATE dbo.SanPham 
                         SET TenSP = @TenSP, GiaNhap = @GiaNhap, GiaBan = @GiaBan, 
                             NhaXuatBan = @NhaXB, NamXuatBan = @NamXB, TacGia = @TacGia, 
                             MoTa = @MoTa, SoLuongTon = @SoLuongTon, MaNCC = @MaNCC, 
                             MaLoaiSP = @MaLoaiSP" +
                                (string.IsNullOrEmpty(hinhSP) ? "" : ", HinhSP = @HinhSP") +
                                " WHERE MaSP = @MaSP";
                    }
                    else
                    {
                        // Chế độ thêm mới
                        if (string.IsNullOrEmpty(fileName))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", "alert('Vui lòng chọn hình sản phẩm!');", true);
                            return;
                        }
                        query = @"INSERT INTO dbo.SanPham (TenSP, GiaNhap, GiaBan, NhaXuatBan, NamXuatBan, TacGia, MoTa, SoLuongTon, MaNCC, MaLoaiSP, HinhSP, NgayThem)
                         VALUES (@TenSP, @GiaNhap, @GiaBan, @NhaXB, @NamXB, @TacGia, @MoTa, @SoLuongTon, @MaNCC, @MaLoaiSP, @HinhSP, @NgayThem)";
                    }

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TenSP", tenSP);
                    cmd.Parameters.AddWithValue("@GiaNhap", giaNhap);
                    cmd.Parameters.AddWithValue("@GiaBan", giaBan);
                    cmd.Parameters.AddWithValue("@NhaXB", nhaXB);
                    cmd.Parameters.AddWithValue("@NamXB", namXB);
                    cmd.Parameters.AddWithValue("@TacGia", tacGia);
                    cmd.Parameters.AddWithValue("@MoTa", moTa);
                    cmd.Parameters.AddWithValue("@SoLuongTon", soLuong);
                    cmd.Parameters.AddWithValue("@MaNCC", maNCC);
                    cmd.Parameters.AddWithValue("@MaLoaiSP", maLoaiSP);
                    cmd.Parameters.AddWithValue("@NgayThem", ngayThem);

                    if (isEditMode)
                    {
                        cmd.Parameters.AddWithValue("@MaSP", maSP);
                        if (!string.IsNullOrEmpty(hinhSP))
                        {
                            cmd.Parameters.AddWithValue("@HinhSP", hinhSP);
                        }
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@HinhSP", hinhSP);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "alert('Cập nhật sản phẩm thành công!'); window.location='SanPham.aspx';", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in btnLuu_Click: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", "alert('Đã xảy ra lỗi khi lưu: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtTenSP.Text = "";
            txtGiaNhap.Text = "100000";
            txtGiaBan.Text = "100000";
            txtNhaXB.Text = "";
            txtNam.Text = DateTime.Now.Year.ToString();
            txtTacGia.Text = "";
            txtMoTa.Text = "";
            txtSoLuong.Text = "100";

            ddlNCC.SelectedIndex = 0;

            foreach (RepeaterItem item in rptLoaiSP.Items)
            {
                RadioButton rb = item.FindControl("rdoLoaiSP") as RadioButton;
                if (rb != null)
                {
                    rb.Checked = false;
                }
            }
        }
    }
}
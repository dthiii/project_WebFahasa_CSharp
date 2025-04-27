using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static FahasaWebsite.Models.DiaChiModel;
using OfficeOpenXml;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;
using FahasaWebsite.Admin;

namespace FahasaWebsite.User
{
    public partial class DonHang : System.Web.UI.Page
    {
        DataTable dt = null;
        protected List<TinhThanh> danhSachTinh;
        protected List<QuanHuyen> danhSachQuan;
        protected List<PhuongXa> danhSachPhuong;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDataFromExcel();
            if (!IsPostBack)
            {
                LoadData();
                LoadTinh();

            }
        }

        protected void LoadData()
        {
            if (Session["GioHang"] != null)
            {
                dt = (DataTable)Session["GioHang"];
                grdGioHang.DataSource = dt;
                grdGioHang.DataBind();

                if (dt != null)
                {
                    double tong = (double)Session["tong"];
                    lblTongTien.Text = String.Format("{0:0,000}", tong);
                }
            }
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

        public int Insert_DonHang()
        {
            int idDonHang = -1;
            string connStr = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"
            INSERT INTO DonHang 
            (NgayDatHang, NgayGiaoHang, PTVanChuyen, PTTT, TinhTrang, MaKH, MaNV, MaCN, MaKM, 
             TenNguoiNhan, SdtNguoiNhan, EmailNguoiNhan, TinhNguoiNhan, QuanNguoiNhan, PhuongNguoiNhan, DiaChiNhan, GhiChu) 
            VALUES 
            (@NgayDatHang, @NgayGiaoHang, @PTVanChuyen, @PTTT, N'Đang xử lý', @MaKH, @MaNV, @MaCN, @MaKM, 
             @TenNguoiNhan, @SdtNguoiNhan, @EmailNguoiNhan, @Tinh, @Quan, @Phuong, @DiaChi, @GhiChu);
            SELECT SCOPE_IDENTITY();";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@NgayDatHang", DateTime.Now);
                cmd.Parameters.AddWithValue("@NgayGiaoHang", DBNull.Value); // Nếu chưa có
                cmd.Parameters.AddWithValue("@PTVanChuyen", ddlPTVanChuyen.SelectedValue);
                cmd.Parameters.AddWithValue("@PTTT", ddlPTThanhToan.SelectedValue);
                cmd.Parameters.AddWithValue("@MaKH", Convert.ToInt32(Session["MaKH"]));
                System.Diagnostics.Debug.WriteLine("MaKH tại trang đặt hàng: " + Convert.ToInt32(Session["MaKH"]));

                cmd.Parameters.AddWithValue("@MaNV", DBNull.Value); // Nếu không có nhân viên
                cmd.Parameters.AddWithValue("@MaCN", DBNull.Value); // Nếu không có chi nhánh
                cmd.Parameters.AddWithValue("@MaKM", DBNull.Value); // Nếu không có khuyến mãi
                cmd.Parameters.AddWithValue("@TenNguoiNhan", txtHoTen.Text);
                cmd.Parameters.AddWithValue("@SdtNguoiNhan", txtDienThoai.Text);
                cmd.Parameters.AddWithValue("@EmailNguoiNhan", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Tinh", ddlTinh.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Quan", ddlQuan.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Phuong", ddlPhuong.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@DiaChi", txtDiaChi.Text);
                cmd.Parameters.AddWithValue("@GhiChu", txtGhiChu.Text);

                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    idDonHang = Convert.ToInt32(result);
                }
            }

            return idDonHang;
        }

        public void Insert_CTDH(int maDH)
        {
            DataTable dtGioHang = (DataTable)Session["GioHang"];

            string connStr = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                foreach (DataRow row in dtGioHang.Rows)
                {
                    string sql = "INSERT INTO CTDonHang (MaDH, MaSP, SoLuong) VALUES (@MaDH, @MaSP, @SoLuong)";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@MaDH", maDH);
                    cmd.Parameters.AddWithValue("@MaSP", row["MaSP"]);
                    cmd.Parameters.AddWithValue("@SoLuong", row["SoLuong"]);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            int maDH = Insert_DonHang();
            if (maDH > 0)
            {
                Insert_CTDH(maDH);

                System.Diagnostics.Debug.WriteLine("MaDH tại trang đặt: " + maDH);

                Session["maDH"] = maDH;
                lblStatus.Text = "Đặt hàng thành công!";
                Session["GioHang"] = null; // Xoá giỏ hàng sau khi đặt
            }
            else
            {
                lblStatus.Text = "Đặt hàng thất bại!";
            }

            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(txtEmail.Text);
                mail.From = new MailAddress("thinguyentran123@gmail.com");
                mail.Subject = "Đặt hàng thành công - Fahasa";
                mail.Body = "Đơn hàng có mã là " + maDH + " đã được đặt thành công. Đơn hàng sẽ được gửi đến quý khách " +
                        txtHoTen.Text + "trong vòng 3 - 5 ngày làm việc. Xin cảm ơn!";
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.Credentials = new NetworkCredential("thinguyentran123@gmail.com", "gohk dlzx dqdg xbzg");
                client.Send(mail);
                Server.Transfer("GuiSP.aspx");
            }
            catch (SmtpFailedRecipientException ex)
            {
                lblStatus.Text = "Mail không được gởi! " + ex.FailedRecipient;
            }


        }
    }
}
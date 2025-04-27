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
    public partial class GuiSP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            int maDH;

            if (int.TryParse(Session["maDH"]?.ToString(), out maDH) && maDH != 0)
            {
                LoadThongTinDonHang(maDH);
            }
            else
            {
                lblThongBao.Text = "Không tìm thấy thông tin đơn hàng.";
            }
        }

        private void LoadThongTinDonHang(int maDH)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT TenNguoiNhan, SdtNguoiNhan, DiaChiNhan, PhuongNguoiNhan, QuanNguoiNhan, TinhNguoiNhan
                       FROM DonHang 
                       WHERE ID = @MaDH";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaDH", maDH);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string hoTen = reader["TenNguoiNhan"].ToString();
                    string dienThoai = reader["SdtNguoiNhan"].ToString();
                    string diaChi = reader["DiaChiNhan"].ToString();
                    string phuong = reader["PhuongNguoiNhan"].ToString();
                    string quan = reader["QuanNguoiNhan"].ToString();
                    string tinh = reader["TinhNguoiNhan"].ToString();

                    lblThongBao.Text = $@"
                <br />Xin chào (anh/chị) <strong>{hoTen}</strong>,<br />
                Quý khách vừa đặt thành công các sản phẩm của Fahasa.<br />
                Số điện thoại của quý khách là: <strong>{dienThoai}</strong>.<br />
                Mã đơn hàng của quý khách là: <strong>{maDH}</strong>.<br />
                Sản phẩm sẽ được giao đến địa chỉ: <strong>{diaChi}, {phuong}, {quan}, {tinh}</strong>.<br />
                Mọi thông tin về đơn hàng sẽ được gửi tới email của quý khách, vui lòng kiểm tra email để biết thêm chi tiết.<br />
                Cảm ơn quý khách đã tin tưởng và giao dịch tại Fahasa.<br />
                Mọi thắc mắc vui lòng liên hệ: <strong>1900 636 467</strong>.<br /><br />
            ";
                }
                else
                {
                    lblThongBao.Text = "Không tìm thấy thông tin đơn hàng.";
                }

                reader.Close();
            }
        }
    }
}
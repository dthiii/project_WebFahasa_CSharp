using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace FahasaWebsite.Admin
{
    public partial class KhachHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKH();
            }
        }

        public void LoadKH()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string queryKH = @"SELECT MaKH, AvatarKH, HoKH + ' ' + TenKH as HoTenKH, SdtKH, EmailKH, DiaChiKH + ', ' + PhuongKH + ', ' + QuanKH + ', ' + TinhKH as DiaChi FROM dbo.KhachHang";
                    SqlDataAdapter adapter = new SqlDataAdapter(queryKH, conn);
                    DataTable dtKhachHang = new DataTable();
                    adapter.Fill(dtKhachHang);

                    // Gán dữ liệu vào Repeater
                    rptKhachHang.DataSource = dtKhachHang;
                    rptKhachHang.DataBind();
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateKH.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string querySearch = @"SELECT MaKH, AvatarKH, HoKH + ' ' + TenKH as HoTenKH, SdtKH, EmailKH, DiaChiKH + ', ' + PhuongKH + ', ' + QuanKH + ', ' + TinhKH as DiaChi FROM dbo.KhachHang
                                           WHERE HoKH + ' ' + TenKH LIKE @HoTenKH
                                           ORDER BY MaKH";
                using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                {
                    cmd.Parameters.AddWithValue("@HoTenKH", "%" + keyword + "%");

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtKhachHang = new DataTable();
                    adapter.Fill(dtKhachHang);

                    rptKhachHang.DataSource = dtKhachHang;
                    rptKhachHang.DataBind();
                }
                conn.Close();
            }
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string querySearch;
                    if (string.IsNullOrEmpty(keyword))
                    {
                        querySearch = @"SELECT MaKH, AvatarKH, HoKH, TenKH, SdtKH, EmailKH, DiaChiKH + ', ' + PhuongKH + ', ' + QuanKH + ', ' + TinhKH as DiaChi FROM dbo.KhachHang";
                    }
                    else
                    {
                        querySearch = @"SELECT MaKH, AvatarKH, HoKH, TenKH, SdtKH, EmailKH, DiaChiKH + ', ' + PhuongKH + ', ' + QuanKH + ', ' + TinhKH as DiaChi FROM dbo.KhachHang
                                           WHERE HoKH + ' ' + TenKH LIKE @HoTenKH
                                           ORDER BY MaKH";
                    }

                    using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                    {
                        if (!string.IsNullOrEmpty(keyword))
                        {
                            cmd.Parameters.AddWithValue("@HoTenKH", "%" + keyword + "%");
                        }

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtKhachHang = new DataTable();
                        adapter.Fill(dtKhachHang);

                        // Tạo nội dung HTML cho Excel
                        StringBuilder sb = new StringBuilder();

                        //Thêm tiêu đề và thông tin khác vào file Excel
                        sb.Append("<h2 style='text-align: center; font-family: Times New Roman;'>DANH SÁCH KHÁCH HÀNG</h2>");
                        sb.Append("<p style='width: 800px; text-align: right; font-family: Times New Roman; font-size: 12pt; '>Ngày xuất: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "</p>");


                        sb.Append("<table border='1'>");
                        sb.Append("<tr style='font-weight: bold; background-color: #FFFF00; font-family: Times New Roman; font-size: 12pt;'>");
                        sb.Append("<th>Mã khách hàng</th>");
                        sb.Append("<th>Họ khách hàng</th>");
                        sb.Append("<th>Tên khách hàng</th>");
                        sb.Append("<th>Số điện thoại</th>");
                        sb.Append("<th>Email</th>");
                        sb.Append("<th style='width: 700px; '>Địa chỉ</th>");
                        sb.Append("</tr>");

                        foreach (DataRow row in dtKhachHang.Rows)
                        {
                            sb.Append("<tr style='font-family: Times New Roman; font-size: 12pt;'>");
                            sb.AppendFormat("<td>'{0}</td>", row["MaKH"]);
                            sb.AppendFormat("<td>{0}</td>", row["HoKH"]);
                            sb.AppendFormat("<td>{0}</td>", row["TenKH"]);
                            sb.AppendFormat("<td>{0}</td>", row["SdtKH"]);
                            sb.AppendFormat("<td>{0}</td>", row["EmailKH"]);
                            sb.AppendFormat("<td style='width: 700px; '>{0}</td>", row["DiaChi"]);
                            sb.Append("</tr>");
                        }

                        sb.Append("<tr style='font-family: Times New Roman; background-color: #E8E8E8;'>");
                        sb.Append("<td style='padding: 8px; text-align: center; font-weight: bold; '>Tổng cộng</td>");
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", dtKhachHang.Rows.Count);
                        sb.Append("<td></td>");
                        sb.Append("<td></td>");
                        sb.Append("<td></td>");
                        sb.Append("<td></td>");
                        sb.Append("</tr>");

                        sb.Append("</table>");


                        // Thiết lập response để tải file Excel
                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment;filename=DanhSachKhachHang.xls");
                        Response.Charset = "utf-8";
                        Response.ContentType = "application/vnd.ms-excel";
                        Response.Write("<html>");
                        Response.Write("<head>");
                        Response.Write("<meta charset='UTF-8'>");
                        Response.Write("</head>");
                        Response.Write("<body>");
                        Response.Write(sb.ToString());
                        Response.Write("</body>");
                        Response.Write("</html>");
                        Response.Flush();
                        Response.End();
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error in btnExportExcel_Click: {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"alert('Lỗi khi xuất Excel: {ex.Message}');", true);
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void rptKhachHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "MoreItem")
            {
                string maKH = e.CommandArgument.ToString();
                Response.Redirect($"UpdateKH.aspx?MaKH={maKH}");
            }
        }
    }
}
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
    public partial class DonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        public void LoadDonHang()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Truy vấn danh sách nhóm sản phẩm
                    string queryDH = @"SELECT dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, sum(SoLuong * sp.GiaBan) as TongTien FROM dbo.DonHang dh
                                       JOIN dbo.CTDonHang ctdh ON ctdh.MaDH = dh.ID
                                       JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                       GROUP BY dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, TinhTrang";
                    SqlDataAdapter adapter = new SqlDataAdapter(queryDH, conn);
                    DataTable dtDonHang = new DataTable();
                    adapter.Fill(dtDonHang);

                    // Gán dữ liệu vào Repeater
                    rptDonHang.DataSource = dtDonHang;
                    rptDonHang.DataBind();
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int keyword = int.Parse(txtSearch.Text);
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string querySearch = @"SELECT dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, sum(SoLuong * sp.GiaBan) as TongTien FROM dbo.DonHang dh
                                       JOIN dbo.CTDonHang ctdh ON ctdh.MaDH = dh.ID
                                       JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                       WHERE dh.MaDH = @MaDH
                                       GROUP BY dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, TinhTrang
                                       ORDER BY dh.MaDH";
                using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                {
                    cmd.Parameters.AddWithValue("@MaDH", keyword);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtDonHang = new DataTable();
                    adapter.Fill(dtDonHang);

                    rptDonHang.DataSource = dtDonHang;
                    rptDonHang.DataBind();
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
                        querySearch = @"SELECT dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, sum(SoLuong * sp.GiaBan) as TongTien FROM dbo.DonHang dh
                                       JOIN dbo.CTDonHang ctdh ON ctdh.MaDH = dh.ID
                                       JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                       GROUP BY dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, TinhTrang";
                    }
                    else
                    {
                        querySearch = @"SELECT dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, sum(SoLuong * sp.GiaBan) as TongTien FROM dbo.DonHang dh
                                       JOIN dbo.CTDonHang ctdh ON ctdh.MaDH = dh.ID
                                       JOIN dbo.SanPham sp ON ctdh.MaSP = sp.ID
                                       WHERE dh.MaDH = @MaDH
                                       GROUP BY dh.MaDH, NgayDatHang, PTVanChuyen, PTTT, TinhTrang";
                    }

                    using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                    {
                        if (!string.IsNullOrEmpty(keyword))
                        {
                            cmd.Parameters.AddWithValue("@MaDH", "%" + keyword + "%");
                        }

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtDonHang = new DataTable();
                        adapter.Fill(dtDonHang);

                        // Tạo nội dung HTML cho Excel
                        StringBuilder sb = new StringBuilder();

                        //Thêm tiêu đề và thông tin khác vào file Excel
                        sb.Append("<h2 style='text-align: center; font-family: Times New Roman;'>DANH SÁCH ĐƠN HÀNG</h2>");
                        sb.Append("<p style='width: 800px; text-align: right; font-family: Times New Roman; font-size: 12pt; '>Ngày xuất: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "</p>");


                        sb.Append("<table border='1'>");
                        sb.Append("<tr style='font-weight: bold; background-color: #FFFF00; font-family: Times New Roman; font-size: 12pt;'>");
                        sb.Append("<th>Mã đơn hàng</th>");
                        sb.Append("<th>Ngày đặt hàng</th>");
                        sb.Append("<th>Phương thức vận chuyển</th>");
                        sb.Append("<th>Phương thức thanh toán</th>");
                        sb.Append("<th>Tổng tiền</th>");
                        sb.Append("</tr>");

                        foreach (DataRow row in dtDonHang.Rows)
                        {
                            sb.Append("<tr style='font-family: Times New Roman; font-size: 12pt;'>");
                            sb.AppendFormat("<td>'{0}</td>", row["MaDH"]);
                            sb.AppendFormat("<td>{0}</td>", row["NgayDatHang"]);
                            sb.AppendFormat("<td>{0}</td>", row["PTVanChuyen"]);
                            sb.AppendFormat("<td>{0}</td>", row["PTTT"]);
                            sb.AppendFormat("<td style='text-align: right;'>{0}đ</td>", Convert.ToDecimal(row["TongTien"]).ToString("N0"));
                            sb.Append("</tr>");
                        }

                        sb.Append("<tr style='font-family: Times New Roman; background-color: #E8E8E8;'>");
                        sb.Append("<td style='padding: 8px; text-align: center; font-weight: bold; '>Tổng cộng</td>");
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", dtDonHang.Rows.Count);
                        sb.Append("<td></td>");
                        sb.Append("<td></td>");
                        sb.Append("<td></td>");
                        sb.Append("</tr>");

                        sb.Append("</table>");


                        // Thiết lập response để tải file Excel
                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment;filename=DanhSachDonHang.xls");
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

        protected void rptDonHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                string maDH = e.CommandArgument.ToString(); // Đây là mã dạng "00000001"
                System.Diagnostics.Debug.WriteLine($"ItemCommand: CommandName={e.CommandName}, MaDH={maDH}");

                if (e.CommandName == "DeleteItem" && !string.IsNullOrEmpty(maDH))
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Truy vấn ID từ MaDH (vì MaDH là cột tính toán, liên kết theo ID)
                        int maDonHangID = -1;
                        string getIDQuery = "SELECT ID FROM dbo.DonHang WHERE MaDH = @MaDH";
                        using (SqlCommand cmdGetID = new SqlCommand(getIDQuery, conn))
                        {
                            cmdGetID.Parameters.AddWithValue("@MaDH", maDH);
                            object result = cmdGetID.ExecuteScalar();
                            if (result != null)
                                maDonHangID = Convert.ToInt32(result);
                            else
                                throw new Exception("Không tìm thấy đơn hàng.");
                        }

                        // Xóa chi tiết đơn hàng
                        string deleteCTDH = "DELETE FROM dbo.CTDonHang WHERE MaDH = @MaDH";
                        using (SqlCommand cmdCT = new SqlCommand(deleteCTDH, conn))
                        {
                            cmdCT.Parameters.AddWithValue("@MaDH", maDonHangID); // ID
                            cmdCT.ExecuteNonQuery();
                        }

                        // Xóa đơn hàng
                        string deleteDH = "DELETE FROM dbo.DonHang WHERE ID = @ID";
                        using (SqlCommand cmdDH = new SqlCommand(deleteDH, conn))
                        {
                            cmdDH.Parameters.AddWithValue("@ID", maDonHangID); // ID
                            cmdDH.ExecuteNonQuery();
                        }

                        conn.Close();
                    }

                    LoadDonHang();
                }
                else if (e.CommandName == "MoreItem")
                {
                    Response.Redirect($"CTDonHang.aspx?MaDH={maDH}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in rptDonHang_ItemCommand: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"alert('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
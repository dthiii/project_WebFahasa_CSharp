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
    public partial class SanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSP();
            }
        }

        public void LoadSP()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Truy vấn danh sách nhóm sản phẩm
                    string querySP = @"SELECT HinhSP, MaSP, TenSP, GiaBan, SoLuongTon FROM dbo.SanPham";
                    SqlDataAdapter adapter = new SqlDataAdapter(querySP, conn);
                    DataTable dtSanPham = new DataTable();
                    adapter.Fill(dtSanPham);

                    // Gán dữ liệu vào Repeater
                    rptSanPham.DataSource = dtSanPham;
                    rptSanPham.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error in LoadNhomSP: {ex.Message}");
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
            Response.Redirect("UpdateSP.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string querySearch = @"SELECT HinhSP, MaSP, TenSP, GiaBan, SoLuongTon FROM dbo.SanPham
                                           WHERE TenSP LIKE @TenSP
                                           ORDER BY MaSP";
                using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                {
                    cmd.Parameters.AddWithValue("@TenSP", "%" + keyword + "%");

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtSanPham = new DataTable();
                    adapter.Fill(dtSanPham);

                    rptSanPham.DataSource = dtSanPham;
                    rptSanPham.DataBind();
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
                        querySearch = @"SELECT HinhSP, MaSP, TenSP, GiaBan, SoLuongTon FROM dbo.SanPham";
                    }
                    else
                    {
                        querySearch = @"SELECT HinhSP, MaSP, TenSP, GiaBan, SoLuongTon FROM dbo.SanPham
                                           WHERE TenSP LIKE @TenSP
                                           ORDER BY nsp.MaSP";
                    }

                    using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                    {
                        if (!string.IsNullOrEmpty(keyword))
                        {
                            cmd.Parameters.AddWithValue("@TenSP", "%" + keyword + "%");
                        }

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtSanPham = new DataTable();
                        adapter.Fill(dtSanPham);

                        // Tạo nội dung HTML cho Excel
                        StringBuilder sb = new StringBuilder();

                        //Thêm tiêu đề và thông tin khác vào file Excel
                        sb.Append("<h2 style='text-align: center; font-family: Times New Roman;'>DANH SÁCH SẢN PHẨM</h2>");
                        sb.Append("<p style='width: 800px; text-align: right; font-family: Times New Roman; font-size: 12pt; '>Ngày xuất: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "</p>");


                        sb.Append("<table border='1'>");
                        sb.Append("<tr style='font-weight: bold; background-color: #FFFF00; font-family: Times New Roman; font-size: 12pt;'>");
                        sb.Append("<th>Mã sản phẩm</th>");
                        sb.Append("<th style='width: 500; '>Tên sản phẩm</th>");
                        sb.Append("<th style='width: 200; '>Giá bán</th>");
                        sb.Append("<th>Số lượng tồn kho</th>");
                        sb.Append("</tr>");

                        foreach (DataRow row in dtSanPham.Rows)
                        {
                            sb.Append("<tr style='font-family: Times New Roman; font-size: 12pt;'>");
                            sb.AppendFormat("<td>'{0}</td>", row["MaSP"]);
                            sb.AppendFormat("<td style='width: 500; '>{0}</td>", row["TenSP"]);
                            sb.AppendFormat("<td style='width: 200px; text-align: right;'>{0}đ</td>", Convert.ToDecimal(row["GiaBan"]).ToString("N0"));
                            sb.AppendFormat("<td style='text-align: right;'>{0}</td>", row["SoLuongTon"]);
                            sb.Append("</tr>");
                        }

                        sb.Append("<tr style='font-family: Times New Roman; background-color: #E8E8E8;'>");
                        sb.Append("<td style='padding: 8px; text-align: center; font-weight: bold; '>Tổng cộng</td>");
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", dtSanPham.Rows.Count);
                        sb.Append("<td></td>");
                        sb.Append("<td></td>");
                        sb.Append("</tr>");

                        sb.Append("</table>");


                        // Thiết lập response để tải file Excel
                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment;filename=DanhSachSanPham.xls");
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

        protected void rptSanPham_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                string maSP = e.CommandArgument.ToString();
                System.Diagnostics.Debug.WriteLine($"ItemCommand: CommandName={e.CommandName}, MaSP={maSP}");

                if (e.CommandName == "EditItem")
                {
                    Response.Redirect($"UpdateSP.aspx?MaSP={maSP}");
                }
                else if (e.CommandName == "DeleteItem")
                {
                    if (!string.IsNullOrEmpty(maSP))
                    {
                        string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();
                            string deleteSQL = "DELETE FROM dbo.SanPham WHERE MaSP = @MaSP";
                            using (SqlCommand cmd = new SqlCommand(deleteSQL, conn))
                            {
                                cmd.Parameters.AddWithValue("@MaSP", maSP);
                                cmd.ExecuteNonQuery();
                            }
                            conn.Close();
                        }
                    }
                    LoadSP();
                }
                LoadSP();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in rptSanPham_ItemCommand: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"alert('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.Linq;

namespace FahasaWebsite.Admin
{
    public partial class NhomSP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNhomSP();
                ViewState["IsAdding"] = false;
            }
        }

        protected bool isAddingNewRow = false;

        public void LoadNhomSP()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Truy vấn danh sách nhóm sản phẩm
                    string queryNhomSP = @"SELECT nsp.MaNhomSP, nsp.TenNhomSP, COUNT(DISTINCT lsp.MaLoaiSP) as SoLoaiSanCo, COUNT(DISTINCT sp.MaSP) as SoSanPhamSanCo
                                           FROM dbo.NhomSP nsp
                                           LEFT JOIN dbo.LoaiSP lsp ON nsp.ID = lsp.MaNhomSP
                                           LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.ID 
                                           GROUP BY nsp.MaNhomSP, nsp.TenNhomSP 
                                           ORDER BY nsp.MaNhomSP";
                    SqlDataAdapter adapter = new SqlDataAdapter(queryNhomSP, conn);
                    DataTable dtNhomSP = new DataTable();
                    adapter.Fill(dtNhomSP);

                    if (isAddingNewRow)
                    {
                        DataRow newRow = dtNhomSP.NewRow();
                        dtNhomSP.Rows.InsertAt(newRow, 0);
                    }

                    // Gán dữ liệu vào Repeater
                    rptNhomSP.DataSource = dtNhomSP;
                    rptNhomSP.DataBind();
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
            isAddingNewRow = true;
            LoadNhomSP();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "focusTextbox", "focusTextbox('');", true);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string querySearch = @"SELECT nsp.MaNhomSP, nsp.TenNhomSP, COUNT(lsp.MaLoaiSP) as SoLoaiSanCo, COUNT(sp.MaSP) as SoSanPhamSanCo
                                           FROM dbo.NhomSP nsp
                                           LEFT JOIN dbo.LoaiSP lsp ON nsp.ID = lsp.MaNhomSP
                                           LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.ID 
                                           WHERE nsp.TenNhomSP LIKE @TenNhomSP
                                           GROUP BY nsp.MaNhomSP, nsp.TenNhomSP 
                                           ORDER BY nsp.MaNhomSP";
                using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                {
                    cmd.Parameters.AddWithValue("@TenNhomSP", "%" + keyword + "%");

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtNhomSP = new DataTable();
                    adapter.Fill(dtNhomSP);

                    rptNhomSP.DataSource = dtNhomSP;
                    rptNhomSP.DataBind();
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
                        querySearch = @"SELECT nsp.MaNhomSP, nsp.TenNhomSP, COUNT(lsp.MaLoaiSP) as SoLoaiSanCo, COUNT(sp.MaSP) as SoSanPhamSanCo
                                FROM dbo.NhomSP nsp
                                LEFT JOIN dbo.LoaiSP lsp ON nsp.ID = lsp.MaNhomSP
                                LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.ID 
                                GROUP BY nsp.MaNhomSP, nsp.TenNhomSP 
                                ORDER BY nsp.MaNhomSP";
                    }
                    else
                    {
                        querySearch = @"SELECT nsp.MaNhomSP, nsp.TenNhomSP, COUNT(lsp.MaLoaiSP) as SoLoaiSanCo, COUNT(sp.MaSP) as SoSanPhamSanCo
                                FROM dbo.NhomSP nsp
                                LEFT JOIN dbo.LoaiSP lsp ON nsp.ID = lsp.MaNhomSP
                                LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.ID 
                                WHERE nsp.TenNhomSP LIKE @TenNhomSP
                                GROUP BY nsp.MaNhomSP, nsp.TenNhomSP 
                                ORDER BY nsp.MaNhomSP";
                    }

                    using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                    {
                        if (!string.IsNullOrEmpty(keyword))
                        {
                            cmd.Parameters.AddWithValue("@TenNhomSP", "%" + keyword + "%");
                        }

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtNhomSP = new DataTable();
                        adapter.Fill(dtNhomSP);

                        int tongNhom = dtNhomSP.Rows.Count;
                        int tongLoai = dtNhomSP.AsEnumerable().Sum(row => row.Field<int>("SoLoaiSanCo"));
                        int tongSP = dtNhomSP.AsEnumerable().Sum(row => row.Field<int>("SoSanPhamSanCo"));

                        // Tạo nội dung HTML cho Excel
                        StringBuilder sb = new StringBuilder();

                        //Thêm tiêu đề và thông tin khác vào file Excel
                        sb.Append("<h2 style='text-align: center; font-family: Times New Roman;'>DANH SÁCH NHÓM SẢN PHẨM</h2>");
                        sb.Append("<p style='width: 800px; text-align: right; font-family: Times New Roman; font-size: 12pt; '>Ngày xuất: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "</p>");


                        sb.Append("<table border='1'>");
                        sb.Append("<tr style='font-weight: bold; background-color: #FFFF00; font-family: Times New Roman; font-size: 12pt;'>");
                        sb.Append("<th>Mã nhóm</th>");
                        sb.Append("<th>Tên nhóm</th>");
                        sb.Append("<th>Số loại sẵn có</th>");
                        sb.Append("<th>Số sản phẩm sẵn có</th>");
                        sb.Append("</tr>");

                        foreach (DataRow row in dtNhomSP.Rows)
                        {
                            sb.Append("<tr style='font-family: Times New Roman; font-size: 12pt;'>");
                            sb.AppendFormat("<td>'{0}</td>", row["MaNhomSP"]);
                            sb.AppendFormat("<td>{0}</td>", row["TenNhomSP"]);
                            sb.AppendFormat("<td style='text-align: right;'>{0}</td>", row["SoLoaiSanCo"]);
                            sb.AppendFormat("<td style='text-align: right;'>{0}</td>", row["SoSanPhamSanCo"]);
                            sb.Append("</tr>");
                        }

                        sb.Append("<tr style='font-family: Times New Roman; background-color: #E8E8E8;'>");
                        sb.Append("<td style='padding: 8px; text-align: center; font-weight: bold; '>Tổng cộng</td>");
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", tongNhom);
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", tongLoai);
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", tongSP);
                        sb.Append("</tr>");

                        sb.Append("</table>");


                        // Thiết lập response để tải file Excel
                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment;filename=DanhSachNhomSanPham.xls");
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

        protected void rptNhomSP_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                string maNhom = e.CommandArgument.ToString();
                System.Diagnostics.Debug.WriteLine($"ItemCommand: CommandName={e.CommandName}, MaNhom={maNhom}");

                if (e.CommandName == "EditItem")
                {
                    if (!string.IsNullOrEmpty(maNhom))
                    {
                        ViewState["EditingMaNhomSP"] = maNhom;
                        System.Diagnostics.Debug.WriteLine($"EditingMaNhomSP set to: {maNhom}");
                        LoadNhomSP();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "focusTextbox", $"focusTextbox('{maNhom}');", true);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Invalid MaNhomSP: {maNhom}");
                    }
                }
                else if (e.CommandName == "DeleteItem")
                {
                    if (!string.IsNullOrEmpty(maNhom))
                    {
                        string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();
                            string deleteSQL = "DELETE FROM dbo.NhomSP WHERE MaNhomSP = @MaNhomSP";
                            using (SqlCommand cmd = new SqlCommand(deleteSQL, conn))
                            {
                                cmd.Parameters.AddWithValue("@MaNhomSP", maNhom);
                                cmd.ExecuteNonQuery();
                            }
                            conn.Close();
                        }
                    }
                    LoadNhomSP();
                }
                else if (e.CommandName == "SaveItem")
                {
                    TextBox txtTenNhomMoi = (TextBox)e.Item.FindControl("txtTenNhomMoi");
                    if (txtTenNhomMoi != null)
                    {
                        string tenNhomMoi = txtTenNhomMoi.Text.Trim();
                        System.Diagnostics.Debug.WriteLine($"SaveItem: TenNhomMoi={tenNhomMoi}, MaNhom={maNhom}");

                        if (!string.IsNullOrEmpty(tenNhomMoi))
                        {
                            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                            using (SqlConnection conn = new SqlConnection(connectionString))
                            {
                                conn.Open();
                                if (string.IsNullOrEmpty(maNhom))
                                {
                                    string insertSQL = "INSERT INTO dbo.NhomSP(TenNhomSP) VALUES (@TenNhomSP)";
                                    using (SqlCommand cmd = new SqlCommand(insertSQL, conn))
                                    {
                                        cmd.Parameters.AddWithValue("@TenNhomSP", tenNhomMoi);
                                        cmd.ExecuteNonQuery();
                                    }
                                }
                                else
                                {
                                    string updateSQL = "UPDATE dbo.NhomSP SET TenNhomSP = @TenNhomSP WHERE MaNhomSP = @MaNhomSP";
                                    using (SqlCommand cmd = new SqlCommand(updateSQL, conn))
                                    {
                                        cmd.Parameters.AddWithValue("@TenNhomSP", tenNhomMoi);
                                        cmd.Parameters.AddWithValue("@MaNhomSP", maNhom);
                                        cmd.ExecuteNonQuery();
                                    }
                                }
                                conn.Close();
                            }
                        }
                    }
                    ViewState["EditingMaNhomSP"] = null;
                    LoadNhomSP();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in rptNhomSP_ItemCommand: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"alert('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Linq;
using System.Text;

namespace FahasaWebsite.Admin
{
    public partial class LoaiSP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLoaiSP();
                ViewState["IsAdding"] = false;
                rptLoaiSP.ItemDataBound += rptLoaiSP_ItemDataBound;
            }
        }

        protected bool isAddingNewRow = false;

        public void LoadLoaiSP()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string queryLoaiSP = @"SELECT lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, COUNT(sp.MaSP) AS SoSanPhamSanCo, nsp.TenNhomSP 
                                           FROM dbo.LoaiSP lsp 
                                           LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.MaLoaiSP 
                                           LEFT JOIN dbo.NhomSP nsp ON nsp.ID = lsp.MaNhomSP
                                           GROUP BY lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, nsp.TenNhomSP";
                    SqlDataAdapter adapter = new SqlDataAdapter(queryLoaiSP, conn);
                    DataTable dtLoaiSP = new DataTable();
                    adapter.Fill(dtLoaiSP);

                    if (isAddingNewRow)
                    {
                        DataRow newRow = dtLoaiSP.NewRow();
                        newRow["MaLoaiSP"] = DBNull.Value;
                        newRow["TenLoaiSP"] = DBNull.Value;
                        newRow["MaNhomSP"] = DBNull.Value;
                        newRow["SoSanPhamSanCo"] = 0;
                        newRow["TenNhomSP"] = DBNull.Value;
                        dtLoaiSP.Rows.InsertAt(newRow, 0);
                    }

                    rptLoaiSP.DataSource = dtLoaiSP;
                    rptLoaiSP.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error in LoadLoaiSP: {ex}");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                        $"alert('Lỗi khi tải dữ liệu: {ex.Message}');", true);
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        private void LoadNhomSP(DropDownList ddl)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ID, TenNhomSP FROM dbo.NhomSP";
                SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                System.Diagnostics.Debug.WriteLine("Số dòng nhóm SP: " + dt.Rows.Count);

                ddl.Items.Clear(); // Xóa hết các mục cũ

                if (dt.Rows.Count > 0)
                {
                    ddl.DataSource = dt;
                    ddl.DataTextField = "TenNhomSP";
                    ddl.DataValueField = "ID";
                    ddl.DataBind();

                    // Thêm dòng mặc định
                    ddl.Items.Insert(0, new ListItem("-- Chọn nhóm sản phẩm --", ""));
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Không có nhóm sản phẩm trong bảng NhomSP");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                        "alert('Không có nhóm sản phẩm nào để hiển thị. Vui lòng kiểm tra bảng NhomSP.');", true);
                    ddl.Items.Add(new ListItem("Không có nhóm sản phẩm", ""));
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string querySearch = @"SELECT lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, COUNT(sp.MaSP) AS SoSanPhamSanCo, nsp.TenNhomSP 
                                           FROM dbo.LoaiSP lsp 
                                           LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.MaLoaiSP 
                                           LEFT JOIN dbo.NhomSP nsp ON nsp.ID = lsp.MaNhomSP
                                           WHERE lsp.TenLoaiSP LIKE @TenLoaiSP
                                           GROUP BY lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, nsp.TenNhomSP
                                           ORDER BY lsp.MaLoaiSP";
                using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                {
                    cmd.Parameters.AddWithValue("@TenLoaiSP", "%" + keyword + "%");

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtLoaiSP = new DataTable();
                    adapter.Fill(dtLoaiSP);

                    rptLoaiSP.DataSource = dtLoaiSP;
                    rptLoaiSP.DataBind();
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
                        querySearch = @"SELECT lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, COUNT(sp.MaSP) AS SoSanPhamSanCo, nsp.TenNhomSP 
                                           FROM dbo.LoaiSP lsp 
                                           LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.MaLoaiSP 
                                           LEFT JOIN dbo.NhomSP nsp ON nsp.ID = lsp.MaNhomSP
                                           GROUP BY lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, nsp.TenNhomSP
                                           ORDER BY lsp.MaLoaiSP";
                    }
                    else
                    {
                        querySearch = @"SELECT lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, COUNT(sp.MaSP) AS SoSanPhamSanCo, nsp.TenNhomSP 
                                           FROM dbo.LoaiSP lsp 
                                           LEFT JOIN dbo.SanPham sp ON sp.MaLoaiSP = lsp.MaLoaiSP 
                                           LEFT JOIN dbo.NhomSP nsp ON nsp.ID = lsp.MaNhomSP
                                           WHERE lsp.TenLoaiSP LIKE @TenLoaiSP
                                           GROUP BY lsp.MaLoaiSP, lsp.TenLoaiSP, lsp.MaNhomSP, nsp.TenNhomSP
                                           ORDER BY lsp.MaLoaiSP";
                    }

                    using (SqlCommand cmd = new SqlCommand(querySearch, conn))
                    {
                        if (!string.IsNullOrEmpty(keyword))
                        {
                            cmd.Parameters.AddWithValue("@TenNhomSP", "%" + keyword + "%");
                        }

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtLoaiSP = new DataTable();
                        adapter.Fill(dtLoaiSP);

                        int tongLoai = dtLoaiSP.Rows.Count;
                        int tongSP = dtLoaiSP.AsEnumerable().Sum(row => row.Field<int>("SoSanPhamSanCo"));

                        // Tạo nội dung HTML cho Excel
                        StringBuilder sb = new StringBuilder();

                        //Thêm tiêu đề và thông tin khác vào file Excel
                        sb.Append("<h2 style='text-align: center; font-family: Times New Roman;'>DANH SÁCH LOẠI SẢN PHẨM</h2>");
                        sb.Append("<p style='width: 800px; text-align: right; font-family: Times New Roman; font-size: 12pt; '>Ngày xuất: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "</p>");


                        sb.Append("<table border='1'>");
                        sb.Append("<tr style='font-weight: bold; background-color: #FFFF00; font-family: Times New Roman; font-size: 12pt;'>");
                        sb.Append("<th>Mã loại</th>");
                        sb.Append("<th>Tên loại</th>");
                        sb.Append("<th>Số sản phẩm sẵn có</th>");
                        sb.Append("<th>Nhóm sản phẩm</th>");
                        sb.Append("</tr>");

                        foreach (DataRow row in dtLoaiSP.Rows)
                        {
                            sb.Append("<tr style='font-family: Times New Roman; font-size: 12pt;'>");
                            sb.AppendFormat("<td>'{0}</td>", row["MaLoaiSP"]);
                            sb.AppendFormat("<td>{0}</td>", row["TenLoaiSP"]);
                            sb.AppendFormat("<td style='text-align: right;'>{0}</td>", row["SoSanPhamSanCo"]);
                            sb.AppendFormat("<td>{0}</td>", row["TenNhomSP"]);
                            sb.Append("</tr>");
                        }

                        sb.Append("<tr style='font-family: Times New Roman; background-color: #E8E8E8;'>");
                        sb.Append("<td style='padding: 8px; text-align: center; font-weight: bold; '>Tổng cộng</td>");
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", tongLoai);
                        sb.AppendFormat("<td style='font-weight: bold; padding: 8px; text-align: right;'>{0}</td>", tongSP);
                        sb.Append("<td></td>");
                        sb.Append("</tr>");

                        sb.Append("</table>");


                        // Thiết lập response để tải file Excel
                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment;filename=DanhSachLoaiSanPham.xls");
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

        protected void rptLoaiSP_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddl = (DropDownList)e.Item.FindControl("ddlNhomSP");
                Label lblNhomSP = (Label)e.Item.FindControl("lblNhomSP");

                if (ddl != null && lblNhomSP != null)
                {
                    string maLoaiSP = DataBinder.Eval(e.Item.DataItem, "MaLoaiSP")?.ToString();
                    string editingMaLoaiSP = ViewState["EditingMaLoaiSP"]?.ToString() ?? "";

                    // Hiển thị DropDownList khi thêm mới hoặc chỉnh sửa
                    bool isNewOrEditing = string.IsNullOrEmpty(maLoaiSP) || maLoaiSP == editingMaLoaiSP;
                    ddl.Visible = isNewOrEditing;
                    lblNhomSP.Visible = !isNewOrEditing;

                    if (ddl.Visible)
                    {
                        System.Diagnostics.Debug.WriteLine($"DropDownList found for ItemIndex={e.Item.ItemIndex}");
                        LoadNhomSP(ddl);

                        // Chọn nhóm sản phẩm đã lưu (dựa trên MaNhomSP)
                        string selectedValue = DataBinder.Eval(e.Item.DataItem, "MaNhomSP")?.ToString();
                        if (!string.IsNullOrEmpty(selectedValue))
                        {
                            ListItem item = ddl.Items.FindByValue(selectedValue);
                            if (item != null)
                                item.Selected = true;
                        }
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"DropDownList or Label NOT found for ItemIndex={e.Item.ItemIndex}");
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            isAddingNewRow = true;
            LoadLoaiSP();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "focusTextbox", "focusTextbox('');", true);
        }

        protected void rptLoaiSP_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                string maLoai = e.CommandArgument.ToString();
                System.Diagnostics.Debug.WriteLine($"ItemCommand: CommandName={e.CommandName}, MaLoai={maLoai}");

                if (e.CommandName == "EditItem")
                {
                    if (!string.IsNullOrEmpty(maLoai))
                    {
                        ViewState["EditingMaLoaiSP"] = maLoai;
                        System.Diagnostics.Debug.WriteLine($"EditingMaLoaiSP set to: {maLoai}");
                        LoadLoaiSP();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "focusTextbox", $"focusTextbox('{maLoai}');", true);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Invalid MaLoaiSP: {maLoai}");
                    }
                }
                else if (e.CommandName == "DeleteItem")
                {
                    if (!string.IsNullOrEmpty(maLoai))
                    {
                        string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();
                            string deleteSQL = "DELETE FROM dbo.LoaiSP WHERE MaLoaiSP = @MaLoaiSP";
                            using (SqlCommand cmd = new SqlCommand(deleteSQL, conn))
                            {
                                cmd.Parameters.AddWithValue("@MaLoaiSP", maLoai);
                                cmd.ExecuteNonQuery();
                            }
                            conn.Close();
                        }
                    }
                    LoadLoaiSP();
                }
                else if (e.CommandName == "SaveItem")
                {
                    TextBox txtTenLoaiMoi = (TextBox)e.Item.FindControl("txtTenLoaiMoi");
                    DropDownList ddlNhomSP = (DropDownList)e.Item.FindControl("ddlNhomSP");

                    if (txtTenLoaiMoi != null && ddlNhomSP != null)
                    {
                        string tenLoaiMoi = txtTenLoaiMoi.Text.Trim();
                        string maNhomSP = ddlNhomSP.SelectedValue;

                        System.Diagnostics.Debug.WriteLine($"SaveItem: TenLoaiMoi={tenLoaiMoi}, MaNhomSP={maNhomSP}, MaLoai={maLoai}");

                        if (string.IsNullOrEmpty(tenLoaiMoi))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                "alert('Vui lòng nhập tên loại sản phẩm.');", true);
                        }
                        else if (string.IsNullOrEmpty(maNhomSP))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                "alert('Vui lòng chọn nhóm sản phẩm.');", true);
                        }
                        else
                        {
                            try
                            {
                                int maNhomSPValue;
                                if (!int.TryParse(maNhomSP, out maNhomSPValue))
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                        "alert('Mã nhóm sản phẩm không hợp lệ.');", true);
                                    return;
                                }

                                string connectionString = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString;
                                using (SqlConnection conn = new SqlConnection(connectionString))
                                {
                                    conn.Open();
                                    if (string.IsNullOrEmpty(maLoai))
                                    {
                                        string insertSQL = "INSERT INTO dbo.LoaiSP (TenLoaiSP, MaNhomSP) VALUES (@TenLoaiSP, @MaNhomSP)";
                                        using (SqlCommand cmd = new SqlCommand(insertSQL, conn))
                                        {
                                            cmd.Parameters.AddWithValue("@TenLoaiSP", tenLoaiMoi);
                                            cmd.Parameters.Add(new SqlParameter("@MaNhomSP", SqlDbType.Int) { Value = maNhomSPValue });
                                            int rowsAffected = cmd.ExecuteNonQuery();
                                            if (rowsAffected == 0)
                                            {
                                                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                                    "alert('Thêm loại sản phẩm không thành công.');", true);
                                            }
                                        }
                                    }
                                    else
                                    {
                                        int maLoaiSPValue;
                                        if (!int.TryParse(maLoai, out maLoaiSPValue))
                                        {
                                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                                "alert('Mã loại sản phẩm không hợp lệ.');", true);
                                            return;
                                        }

                                        string updateSQL = "UPDATE dbo.LoaiSP SET TenLoaiSP = @TenLoaiSP, MaNhomSP = @MaNhomSP WHERE MaLoaiSP = @MaLoaiSP";
                                        using (SqlCommand cmd = new SqlCommand(updateSQL, conn))
                                        {
                                            cmd.Parameters.AddWithValue("@TenLoaiSP", tenLoaiMoi);
                                            cmd.Parameters.Add(new SqlParameter("@MaNhomSP", SqlDbType.Int) { Value = maNhomSPValue });
                                            cmd.Parameters.Add(new SqlParameter("@MaLoaiSP", SqlDbType.VarChar, 3) { Value = maLoai });
                                            int rowsAffected = cmd.ExecuteNonQuery();
                                            if (rowsAffected == 0)
                                            {
                                                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                                    "alert('Cập nhật loại sản phẩm không thành công.');", true);
                                            }
                                        }
                                    }
                                    conn.Close();
                                }
                            }
                            catch (Exception ex)
                            {
                                System.Diagnostics.Debug.WriteLine($"Error in SaveItem: {ex.Message}");
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                                    $"alert('Lỗi khi lưu: {ex.Message}');", true);
                                return;
                            }
                        }
                    }
                    ViewState["EditingMaLoaiSP"] = null;
                    isAddingNewRow = false;
                    LoadLoaiSP();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in rptLoaiSP_ItemCommand: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                    $"alert('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FahasaWebsite.User
{
    public partial class GioHang : System.Web.UI.Page
    {
        DataTable dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void LoadData()
        {
            if (Session["GioHang"] != null)
            {
                dt = (DataTable)Session["GioHang"];
                grdGioHang.DataSource = dt;
                grdGioHang.DataBind();
                grdGioHang.Visible = true;
                pnlGioHangTrong.Visible = false;
                pnlDatHang.Visible = true;

                if (dt != null)
                {
                    double tong = TinhTongTien(dt);
                    Session["tong"] = tong;
                    lblTongTien.Text = String.Format("{0:0,000}", tong);
                }

                int soLuong = dt.Rows.Count;
                if (soLuong == 0)
                {
                    grdGioHang.Visible = false;
                    pnlGioHangTrong.Visible = true;
                    pnlDatHang.Visible = false;
                }
            }
            else
            {
                grdGioHang.Visible = false;
                pnlGioHangTrong.Visible = true;
                pnlDatHang.Visible = false;
            }
        }

        protected void grdGioHang_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dt = (DataTable)Session["GioHang"];
            GridViewRow row = grdGioHang.Rows[e.RowIndex];
            dt.Rows[row.DataItemIndex].Delete();
            grdGioHang.EditIndex = -1;
            Session["GioHang"] = dt;
            LoadData();
        }

        protected double TinhTongTien(DataTable dt)
        {
            if (dt == null)
                return 0;
            double sum = 0;
            foreach (DataRow row in dt.Rows)
                sum += Convert.ToDouble(row["ThanhTien"]);
            return sum;
        }

        protected void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            TextBox txtSoLuong = (TextBox)sender;
            GridViewRow row = (GridViewRow)txtSoLuong.NamingContainer;
            int index = row.RowIndex;

            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];
                int soLuongMoi;

                if (int.TryParse(txtSoLuong.Text, out soLuongMoi) && soLuongMoi > 0)
                {
                    dt.Rows[index]["SoLuong"] = soLuongMoi;
                    dt.Rows[index]["ThanhTien"] = soLuongMoi * Convert.ToInt32(dt.Rows[index]["GiaBan"]);
                    Session["GioHang"] = dt;
                }

                LoadData(); // Cập nhật lại giao diện
            }
        }

        protected void CapNhatSoLuong(object sender, CommandEventArgs e)
        {
            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];
                int index = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "TangSoLuong")
                {
                    dt.Rows[index]["SoLuong"] = Convert.ToInt32(dt.Rows[index]["SoLuong"]) + 1;
                }
                else if (e.CommandName == "GiamSoLuong" && Convert.ToInt32(dt.Rows[index]["SoLuong"]) > 1)
                {
                    dt.Rows[index]["SoLuong"] = Convert.ToInt32(dt.Rows[index]["SoLuong"]) - 1;
                }

                dt.Rows[index]["ThanhTien"] = Convert.ToInt32(dt.Rows[index]["SoLuong"]) * Convert.ToInt32(dt.Rows[index]["GiaBan"]);
                Session["GioHang"] = dt;

                LoadData(); // Cập nhật lại giao diện
            }
        }

    }
}
<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="UpdateKH.aspx.cs" Inherits="FahasaWebsite.Admin.UpdateKH" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Thông tin khách hàng</title>

    <style>
        .custom-file-input {
            display: none;
        }

        .custom-file-label {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.3s ease;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-7 align-self-center">
        <div class="d-flex align-items-center">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item"><a href="KhachHang.aspx">Khách hàng</a></li>
                    <li class="breadcrumb-item active">Thông tin khách hàng</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container-fluid" style="margin-top: 30px;">
        <div class="row">
            <div class="col-8">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="card-title mb-0" style="font-weight: bolder;">THÔNG TIN KHÁCH HÀNG</h2>
                        </div>

                        <div>
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Họ và tên lót</label>
                                            <asp:TextBox ID="txtHoKH" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Tên khách hàng</label>
                                            <asp:TextBox ID="txtTenKH" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <div class="form-group">
                                                <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Giới tính</label>
                                            <asp:DropDownList ID="ddlGioiTinhKH" runat="server" CssClass="form-control mr-sm-2">
                                                <asp:ListItem Text="Nữ" Value="Nữ" />
                                                <asp:ListItem Text="Nam" Value="Nam" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Số điện thoại</label>
                                            <asp:TextBox ID="txtSdtKH" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Email</label>
                                            <asp:TextBox ID="txtEmailKH" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Tỉnh/Thành phố</label>
                                            <asp:DropDownList ID="ddlTinh" runat="server" OnSelectedIndexChanged="ddlTinh_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control mr-sm-2">
                                                <asp:ListItem Text="Chọn tỉnh/thành phố" Value="0" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Quận/Huyện</label>
                                            <asp:DropDownList ID="ddlQuan" runat="server" OnSelectedIndexChanged="ddlQuan_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control mr-sm-2">
                                                <asp:ListItem Text="Chọn quận/huyện" Value="0" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Xã/Phường/Thị trấn</label>
                                            <asp:DropDownList ID="ddlPhuong" runat="server" CssClass="form-control mr-sm-2">
                                                <asp:ListItem Text="Chọn xã/phường/thị trấn" Value="0" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Địa chỉ</label>
                                            <asp:TextBox ID="txtDiaChiKH" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Avatar</label>
                                            <div class="col-md-12">
                                                <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="custom-file-input" />
                                                <label class="custom-file-label" id="labelUpload">Chọn hình ảnh</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="text-right" style="margin-top: 50px;">
                                    <asp:Button ID="btnLuu" runat="server" CssClass="btn btn-info" Text="Lưu" OnClick="btnLuu_Click" />
                                    <asp:Button ID="btnReset" runat="server" CssClass="btn btn-outline-primary" Text="Làm mới" OnClick="btnReset_Click" OnClientClick="resetFileUpload();" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <asp:Repeater ID="rptThongTinMuaHang" runat="server">
                <ItemTemplate>
                    <div class="col-sm-12 col-md-4">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="font-weight: bold; font-size: 22px; text-align: center;">Thông tin mua hàng</h4>
                                <hr />
                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-handbag"></i> Tổng số hóa đơn: 
                                <span><%# Eval("SoHoaDon") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-wallet"></i> Tổng số tiền: 
                                <span><%# String.Format("{0:#,##0}₫", Eval("TongSoTien")) %></span>
                                </div>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script type="text/javascript">
        function resetFileUpload() {
            document.getElementById("updateImage").value = "";
        }

        document.getElementById('<%= fileUploadImage.ClientID %>').addEventListener('change', function (e) {
            var fileName = e.target.files[0] ? e.target.files[0].name : 'Chọn hình ảnh';
            document.getElementById('labelUpload').innerText = fileName;
        });

        document.addEventListener('DOMContentLoaded', function () {
            var label = document.getElementById("labelUpload");
            var input = document.getElementById("<%= fileUploadImage.ClientID %>");

            label.addEventListener("click", function () {
                input.click(); // Kích hoạt chọn file
            });

            input.addEventListener("change", function () {
                if (input.files.length > 0) {
                    label.textContent = input.files[0].name; // Hiển thị tên file đã chọn
                }
            });
        });

    </script>
</asp:Content>

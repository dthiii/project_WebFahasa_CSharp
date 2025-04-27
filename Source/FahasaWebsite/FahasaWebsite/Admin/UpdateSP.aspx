<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="UpdateSP.aspx.cs" Inherits="FahasaWebsite.Admin.UpdateSP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Cập nhật sản phẩm</title>

    <style>
        .custom-file-input {
            display: none;
        }

        .custom-file-label {
            display: inline-block;
            padding: 10px 0px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.3s ease;
            margin-bottom: 20px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-7 align-self-center">
        <div class="d-flex align-items-center">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item"><a href="SanPham.aspx">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Cập nhật thông tin</li>
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
                            <h2 class="card-title mb-0" style="font-weight: bolder;">CẬP NHẬT SẢN PHẨM</h2>
                        </div>

                        <div>
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Tên sản phẩm</label>
                                            <asp:TextBox ID="txtTenSP" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Giá nhập</label>
                                            <asp:TextBox ID="txtGiaNhap" runat="server" CssClass="form-control" TextMode="Number" Text="100000" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Giá bán</label>
                                            <asp:TextBox ID="txtGiaBan" runat="server" CssClass="form-control" TextMode="Number" Text="100000" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Nhà xuất bản</label>
                                            <asp:TextBox ID="txtNhaXB" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Năm xuất bản</label>
                                            <asp:TextBox ID="txtNam" runat="server" CssClass="form-control" TextMode="Number" />
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Tác giả</label>
                                            <asp:TextBox ID="txtTacGia" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Mô tả</label>
                                            <asp:TextBox ID="txtMoTa" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Hình sản phẩm</label>
                                            <div class="col-md-12">
                                                <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="custom-file-input" />
                                                <label class="custom-file-label" id="labelUpload">Chọn hình sản phẩm</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 35px;">
                                <div class="col-md-9">
                                    <div class="form-group">
                                        <label>Nhà cung cấp</label>
                                        <asp:DropDownList ID="ddlNCC" runat="server" CssClass="form-control mr-sm-2">
                                            <asp:ListItem Text="Chọn nhà cung cấp" Value="0" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Số lượng nhập</label>
                                        <asp:TextBox ID="txtSoLuong" runat="server" CssClass="form-control" Text="100" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="text-right">
                                <asp:Button ID="btnLuu" runat="server" CssClass="btn btn-info" Text="Lưu" OnClick="btnLuu_Click" />
                                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-outline-primary" Text="Làm mới" OnClick="btnReset_Click" OnClientClick="resetFileUpload();" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-12 col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title" style="font-weight: bold; font-size: 22px;">Chọn Loại sản phẩm</h4>
                        <hr />
                        <asp:Repeater ID="rptLoaiSP" runat="server">
                            <ItemTemplate>
                                <fieldset class="radio">
                                    <label>
                                        <asp:RadioButton ID="rdoLoaiSP" runat="server" GroupName="LoaiSPGroup" Value='<%# Eval("ID") %>' />
                                        <%# Eval("TenLoaiSP") %>
                                    </label>
                                </fieldset>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        function resetFileUpload() {
            document.getElementById("updateImage").value = "";
        }

        document.addEventListener('DOMContentLoaded', function () {
            var label = document.getElementById("labelUpload");
            var input = document.getElementById("<%= fileUploadImage.ClientID %>");

        label.addEventListener("click", function () {
            input.click(); // Kích hoạt chọn file
        });

        input.addEventListener("change", function (e) {
            var fileName = e.target.files[0] ? e.target.files[0].name : 'Chọn hình ảnh';
            label.innerText = fileName; // Hiển thị tên file đã chọn
        });
    });
    </script>

</asp:Content>

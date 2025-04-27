<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="LoaiSP.aspx.cs" Inherits="FahasaWebsite.Admin.LoaiSP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Loại sản phẩm</title>

    <script type="text/javascript">
        window.onload = function () {
            feather.replace(); // load lại feather icon sau khi load page

            // Lấy các phần tử
            var searchBox = document.getElementById('<%= txtSearch.ClientID %>');
            var clearBtn = document.getElementById('<%= btnClear.ClientID %>');

            // Kiểm tra và hiển thị nút xóa nếu ô tìm kiếm có giá trị
            clearBtn.style.display = searchBox.value.trim() !== '' ? 'inline' : 'none';

            // Lắng nghe sự kiện nhập liệu trong ô tìm kiếm
            searchBox.addEventListener('input', function () {
                clearBtn.style.display = searchBox.value.trim() !== '' ? 'inline' : 'none';
            });
        };

        function clearSearch() {
            // Xóa nội dung ô tìm kiếm
            document.getElementById('<%= txtSearch.ClientID %>').value = '';
            // Ẩn nút xóa sau khi xóa ô tìm kiếm
            document.getElementById('<%= btnClear.ClientID %>').style.display = 'none';
            window.location.href = window.location.href;
        }

        $(document).ready(function () {
            $('.selectpicker').selectpicker();
        });

        function printTable() {
            var printContents = document.querySelector('.table-responsive').innerHTML;

            var printWindow = window.open('', '', 'height=700,width=1000');
            printWindow.document.write('<html><head><title>Danh sách loại sản phẩm</title>');

            // Style giống định dạng Excel
            printWindow.document.write('<style>');
            printWindow.document.write('body { font-family: "Times New Roman"; font-size: 12pt; }');
            printWindow.document.write('h2 { text-align: center; }');
            printWindow.document.write('p { text-align: right; margin-right: 20px; }');
            printWindow.document.write('table { width: 100%; border-collapse: collapse; margin-top: 20px; }');
            printWindow.document.write('th, td { border: 1px solid #000; padding: 8px; }');
            printWindow.document.write('th { background-color: #E8E8E8; font-weight: bold; text-align: center; }');
            printWindow.document.write('tr.total-row { background-color: #E8E8E8; font-weight: bold; }');

            printWindow.document.write('td:nth-child(1), th:nth-child(1) { text-align: center; font-weight: bold !important; }');
            printWindow.document.write('th:nth-child(3), th:nth-child(3) { width: 200px; padding-right: 0px; text-align: center !important; }');
            printWindow.document.write('td:nth-child(3), th:nth-child(3) { width: 200px; padding-right: 10px !important; }');
            printWindow.document.write('td:nth-child(4), th:nth-child(4) { width: 400px; !important; }');

            printWindow.document.write('</style>');

            printWindow.document.write('<style>');
            printWindow.document.write('@media print {');
            printWindow.document.write('  td:nth-child(5), th:nth-child(5),');
            printWindow.document.write('  td:nth-child(6), th:nth-child(6) { display: none; }');
            printWindow.document.write('}');
            printWindow.document.write('</style>');

            printWindow.document.write('</head><body>');

            // Tiêu đề và ngày giờ in
            printWindow.document.write('<h2>DANH SÁCH LOẠI SẢN PHẨM</h2>');
            printWindow.document.write('<p>Ngày xuất: ' + new Date().toLocaleString('vi-VN') + '</p>');

            // Nội dung bảng
            printWindow.document.write(printContents);

            printWindow.document.write('</body></html>');

            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }

    </script>

    <style>
        .form-control-icon {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            color: #999;
        }

        .search-icon {
            right: 10px;
        }

        .clear-icon {
            right: 40px;
            display: none;
        }

        .btn-add {
            background-color: #5F76E8;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-right: 100px;
        }

            .btn-add:hover {
                background-color: #3E59E3;
            }

        .text-success {
            color: #5F76E8 !important;
        }

        .btnExport {
            height: 37.6px;
            margin-right: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="margin-top: 30px;">
        <div class="container-fluid">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="card-title mb-0" style="font-weight: bolder;">LOẠI SẢN PHẨM</h2>
                            <div class="input-with-icon">
                                <div class="customize-input" style="position: relative; width: 300px;">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control custom-shadow custom-radius border-0 bg-white"
                                        placeholder="Nhập tên loại" AutoPostBack="false"></asp:TextBox>

                                    <!-- Nút xóa -->
                                    <asp:LinkButton ID="btnClear" runat="server" CssClass="form-control-icon clear-icon" OnClientClick="clearSearch(); return false;" ToolTip="Xóa ô tìm">
                                                <i data-feather="x"></i>
                                    </asp:LinkButton>

                                    <!-- Nút tìm kiếm -->
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="form-control-icon search-icon" OnClick="btnSearch_Click" ToolTip="Tìm kiếm">
                                                <i data-feather="search"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <div style="height: 37.6px; display: flex;">
                                <!-- Nút Print -->
                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../AdminTemplate/assets/images/printer.png"
                                    OnClientClick="printTable(); return false;"
                                    ToolTip="In"
                                    CssClass="btnExport" />

                                <!-- Nút Xuất file excel -->
                                <asp:ImageButton ID="btnExportExcel" runat="server"
                                    ImageUrl="../AdminTemplate/assets/images/sheets.png"
                                    OnClick="btnExportExcel_Click"
                                    ToolTip="Xuất Excel"
                                    CssClass="btnExport" />

                                <asp:Button ID="btnAdd" runat="server" Text="Thêm" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                            </div>
                        </div>

                        <div class="table-responsive" style="margin-top: 50px;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" style="font-weight: bolder; width: 100px;">Mã loại</th>
                                        <th scope="col" style="font-weight: bolder; width: 300px;">Tên loại</th>
                                        <th scope="col" style="font-weight: bolder; width: 300px; text-align: right; padding-right: 100px;">Số sản phẩm sẵn có</th>
                                        <th scope="col" style="font-weight: bolder; width: 300px;">Nhóm sản phẩm</th>
                                        <th scope="col" style="font-weight: bolder; width: 10px; text-align: right;"></th>
                                        <th scope="col" style="font-weight: bolder; width: 10px; text-align: right;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptLoaiSP" runat="server" OnItemCommand="rptLoaiSP_ItemCommand" OnItemDataBound="rptLoaiSP_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td scope="row" style="width: 100px;"><%# Eval("MaLoaiSP") %></td>

                                                <td style="width: 300px;">
                                                    <%# string.IsNullOrEmpty(Eval("MaLoaiSP").ToString()) || Eval("MaLoaiSP").ToString() == (ViewState["EditingMaLoaiSP"]?.ToString() ?? "") ? "" : Eval("TenLoaiSP").ToString() %>
                                                    <asp:TextBox ID="txtTenLoaiMoi" runat="server" CssClass="form-control"
                                                        Text='<%# Eval("TenLoaiSP") %>'
                                                        Visible='<%# string.IsNullOrEmpty(Eval("MaLoaiSP").ToString()) || Eval("MaLoaiSP").ToString() == (ViewState["EditingMaLoaiSP"]?.ToString() ?? "") %>'
                                                        data-ma-loai='<%# Eval("MaLoaiSP") %>' />
                                                </td>

                                                <td style="text-align: right; width: 300px; padding-right: 100px;"><%# Eval("SoSanPhamSanCo") %></td>

                                                <td>
                                                    <asp:Label ID="lblNhomSP" runat="server" Text='<%# Eval("TenNhomSP") %>'
                                                        Visible='<%# !string.IsNullOrEmpty(Eval("MaLoaiSP").ToString()) %>'>
                                                    </asp:Label>

                                                    <asp:DropDownList ID="ddlNhomSP" runat="server" CssClass="form-control">
                                                    </asp:DropDownList>

                                                </td>

                                                <td style="width: 10px;">
                                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditItem"
                                                        CommandArgument='<%# Eval("MaLoaiSP") %>'
                                                        CssClass="text-primary"
                                                        Visible='<%# !(string.IsNullOrEmpty(Eval("MaLoaiSP").ToString()) || Eval("MaLoaiSP").ToString() == (ViewState["EditingMaLoaiSP"]?.ToString() ?? "")) %>'>
                                                                <i class="icon-pencil"></i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnSave" runat="server" CommandName="SaveItem"
                                                        Text="Lưu" CssClass="text-success"
                                                        CommandArgument='<%# Eval("MaLoaiSP") %>'
                                                        Visible='<%# string.IsNullOrEmpty(Eval("MaLoaiSP").ToString()) || Eval("MaLoaiSP").ToString() == (ViewState["EditingMaLoaiSP"]?.ToString() ?? "") %>'>
                                                    </asp:LinkButton>
                                                </td>

                                                <td style="width: 10px;">
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteItem"
                                                        CommandArgument='<%# Eval("MaLoaiSP") %>'
                                                        CssClass="text-danger"
                                                        OnClientClick="return confirm('Vui lòng kiểm tra sản phẩm liên quan trước khi xóa loại sản phẩm này.');"
                                                        Visible='<%# !(string.IsNullOrEmpty(Eval("MaLoaiSP").ToString()) || Eval("MaLoaiSP").ToString() == (ViewState["EditingMaLoaiSP"]?.ToString() ?? "")) %>'>
                                                                <i class="icon-trash"></i>
                                                    </asp:LinkButton>
                                                </td>

                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

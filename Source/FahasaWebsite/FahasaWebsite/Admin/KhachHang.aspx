<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="KhachHang.aspx.cs" Inherits="FahasaWebsite.Admin.KhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Khách hàng</title>

    <script>
        window.onload = function () {
            feather.replace();

            var searchBox = document.getElementById('<%= txtSearch.ClientID %>');
            var clearBtn = document.getElementById('<%= btnClear.ClientID %>');

            clearBtn.style.display = searchBox.value.trim() !== '' ? 'inline' : 'none';

            searchBox.addEventListener('input', function () {
                clearBtn.style.display = searchBox.value.trim() !== '' ? 'inline' : 'none';
            });
        };

        function clearSearch() {
            document.getElementById('<%= txtSearch.ClientID %>').value = '';
            document.getElementById('<%= btnClear.ClientID %>').style.display = 'none';
            window.location.href = window.location.href;
        }

        function printTable() {
            var printContents = document.querySelector('.table-responsive').innerHTML;

            var printWindow = window.open('', '', 'height=700,width=1000');
            printWindow.document.write('<html><head><title>Danh sách khách hàng</title>');

            // Style giống định dạng Excel
            printWindow.document.write('<style>');
            printWindow.document.write('body { font-family: "Times New Roman"; font-size: 12pt; }');
            printWindow.document.write('h2 { text-align: center; }');
            printWindow.document.write('p { text-align: right; margin-right: 20px; }');
            printWindow.document.write('table { width: 100%; border-collapse: collapse; margin-top: 20px; }');
            printWindow.document.write('th, td { border: 1px solid #000; padding: 8px; text-align: left; }');
            printWindow.document.write('th { font-weight: bold; text-align: center; background-color: #B0B0B0 !important; }');

            printWindow.document.write('th:nth-child(3) { width: 100px; text-align: center; padding-right: 0px !important; }');
            printWindow.document.write('td:nth-child(3) { width: 100px; text-align: right; padding-right: 10px !important; }');
            printWindow.document.write('th:nth-child(5), th:nth-child(5) { width: 600px !important; }');

            printWindow.document.write('</style>');

            printWindow.document.write('<style>');
            printWindow.document.write('@media print {');
            printWindow.document.write('  @page { size: landscape; }');
            printWindow.document.write('  td:nth-child(6), th:nth-child(6) { display: none; }');
            printWindow.document.write('}');
            printWindow.document.write('</style>');

            printWindow.document.write('</head><body>');

            // Tiêu đề và ngày giờ in
            printWindow.document.write('<h2>DANH SÁCH KHÁCH HÀNG</h2>');
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
                            <h2 class="card-title mb-0" style="font-weight: bolder;">KHÁCH HÀNG</h2>
                            <div class="input-with-icon">
                                <div class="customize-input" style="position: relative; width: 300px;">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control custom-shadow custom-radius border-0 bg-white"
                                        placeholder="Nhập tên khách hàng" AutoPostBack="false"></asp:TextBox>

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
                                        <th scope="col" style="font-weight: bolder; width: 30px;"></th>
                                        <th scope="col" style="font-weight: bolder; width: 300px;">Tên khách hàng</th>
                                        <th scope="col" style="font-weight: bolder; width: 200px;">Số điện thoại</th>
                                        <th scope="col" style="font-weight: bolder; width: 250px;">Email</th>
                                        <th scope="col" style="font-weight: bolder; width: 550px; ">Địa chỉ</th>
                                        <th scope="col" style="font-weight: bolder; width: 10px; text-align: right;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptKhachHang" runat="server" OnItemCommand="rptKhachHang_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td scope="row" style="width: 30px;">
                                                    <img src='<%# Eval("AvatarKH") %>' style="width: 30px; height: 30px;" alt='<%# Eval("HoTenKH") %>'></td>
                                                <td scope="row" style="width: 300px;"><%# Eval("HoTenKH") %></td>
                                                <td scope="row" style="width: 200px;"><%# Eval("SdtKH") %></td>
                                                <td scope="row" style="width: 250px;"><%# Eval("EmailKH") %></td>
                                                <td scope="row" style="width: 550px; text-align: justify; "><%# Eval("DiaChi") %></td>

                                                <td style="width: 10px;">
                                                    <asp:LinkButton ID="btnMore" runat="server" CommandName="MoreItem"
                                                        CommandArgument='<%# Eval("MaKH") %>'
                                                        CssClass="text-primary">
                                                            <i class="icon-options"></i>
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

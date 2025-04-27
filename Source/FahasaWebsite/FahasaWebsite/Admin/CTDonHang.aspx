<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CTDonHang.aspx.cs" Inherits="FahasaWebsite.Admin.CTDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Chi tiết đơn hàng</title>
    <script>
        function printTable() {
            document.querySelector('.btnExport').style.display = 'none';
            
            var printContents = document.getElementById('printArea').innerHTML;

            var printWindow = window.open('', '', 'height=700,width=1000');
            printWindow.document.write('<html><head><title>Danh sách đơn hàng</title>');            

            // CSS in ra giống Excel
            printWindow.document.write('<style>');
            printWindow.document.write('body { font-family: "Times New Roman"; font-size: 12pt; }');
            printWindow.document.write('h2 { text-align: center; }');
            printWindow.document.write('p { text-align: right; margin-right: 20px; }');
            printWindow.document.write('table { width: 100%; border-collapse: collapse; margin-top: 20px; }');
            printWindow.document.write('th, td { border: 1px solid #000; padding: 8px; text-align: left; }');
            printWindow.document.write('th { font-weight: bold; text-align: center; background-color: #B0B0B0 !important; }');
            printWindow.document.write('td:nth-child(1) { text-align: center !important; }');
            printWindow.document.write('td:nth-child(3), td:nth-child(4) { text-align: right !important; }');
            printWindow.document.write('th:nth-child(3), th:nth-child(4) { text-align: center !important; }');
            printWindow.document.write('th:nth-child(5) { text-align: center !important; }');
            printWindow.document.write('.sl-icon { margin-bottom: 8px; display: flex; align-items: center; }');
            printWindow.document.write('</style>');


            printWindow.document.write('</head><body>');
            

            printWindow.document.write(printContents);

            printWindow.document.write('</body></html>');

            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            document.querySelector('.btnExport').style.display = 'inline-block';
            printWindow.close();
        }

    </script>

    <style>
        @media print {
            .btnExport {
                display: none !important;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-7 align-self-center">
        <div class="d-flex align-items-center">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item"><a href="DonHang.aspx">Đơn hàng</a></li>
                    <li class="breadcrumb-item active">Thông tin đơn hàng</li>
                </ol>
            </nav>
        </div>
    </div>

    <div id="printArea" class="container-fluid" style="margin-top: 30px;">
        <div class="row">
            <!-- Thông tin chi tiết đơn hàng -->
            <div class="col-8">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="card-title mb-0" style="font-weight: bolder;">THÔNG TIN ĐƠN HÀNG</h2>
                        </div>

                        <div class="table-responsive" style="margin-top: 50px;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" style="font-weight: bolder; width: 30px;"></th>
                                        <th scope="col" style="font-weight: bolder; width: 400px;">Tên sản phẩm</th>
                                        <th scope="col" style="font-weight: bolder; width: 200px; text-align: right;">Số lượng</th>
                                        <th scope="col" style="font-weight: bolder; width: 300px; text-align: right;">Đơn giá</th>
                                        <th scope="col" style="font-weight: bolder; width: 300px; text-align: right;">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptCTDonHang" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td scope="row" style="width: 30px;">
                                                    <img src='<%# Eval("HinhSP") %>' style="width: 30px; height: 30px;" alt='<%# Eval("TenSP") %>'>
                                                </td>
                                                <td scope="row" style="width: 400px;"><%# Eval("TenSP") %></td>
                                                <td scope="row" style="width: 200px; text-align: right;"><%# Eval("SoLuong") %></td>
                                                <td scope="row" style="width: 300px; text-align: right;"><%# String.Format("{0:#,##0}₫", Eval("GiaBan")) %></td>
                                                <td scope="row" style="width: 300px; text-align: right;"><%# String.Format("{0:#,##0}₫", Eval("ThanhTien")) %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" style="text-align: right; font-weight: bold;">Tổng tiền</td>
                                        <td style="width: 300px; text-align: right; font-weight: bold;">
                                            <asp:Label ID="lblTongTien" runat="server" />
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div style="height: 37.6px; display: flex;">
                            <!-- Nút Print -->
                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../AdminTemplate/assets/images/printer.png"
                                OnClientClick="printTable(); return false;"
                                ToolTip="In"
                                CssClass="btnExport"
                                Style="margin-left: auto; margin-right: 10px;" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thông tin người nhận hàng -->
            <asp:Repeater ID="rptThongTinMuaHang" runat="server">
                <ItemTemplate>
                    <div class="col-sm-12 col-md-4">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="font-weight: bold; font-size: 22px; text-align: center;">Thông tin nhận hàng</h4>
                                <hr />
                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-user" style="margin-right: 5px;"></i><span><%# Eval("TenNguoiNhan") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-phone" style="margin-right: 5px;"></i><span><%# Eval("SdtNguoiNhan") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon" style="min-height: 50px; display: flex; align-items: center;">
                                    <i class="icon-location-pin" style="margin-right: 5px;"></i>
                                    <span style="white-space: normal;"><%# Eval("DiaChiNhan") %></span>
                                </div>


                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon" style="min-height: 50px; display: flex; align-items: center;">
                                    <i class="icon-speech" style="margin-right: 5px;"></i>
                                    <span style="white-space: normal;"><%# Eval("GhiChu") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-calender" style="margin-right: 5px;"></i><span><%# Eval("NgayDatHang") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-calender" style="margin-right: 5px;"></i><span><%# Eval("NgayGiaoHang") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-basket" style="margin-right: 5px;"></i><span><%# Eval("PTVanChuyen") %></span>
                                </div>

                                <div class="col-sm-6 col-md-12 col-lg-12 sl-icon">
                                    <i class="icon-wallet" style="margin-right: 5px;"></i><span><%# Eval("PTTT") %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

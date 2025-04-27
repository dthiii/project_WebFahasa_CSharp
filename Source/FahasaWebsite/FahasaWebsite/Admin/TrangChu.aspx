<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="FahasaWebsite.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Trang chủ</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="margin-top: 30px;">
        <!-- Start First Cards -->
        <div class="card-group">
            <div class="card border-right">
                <div class="card-body">
                    <div class="d-flex d-lg-flex d-md-block align-items-center">
                        <div>
                            <div class="d-inline-flex align-items-center">
                                <h2 class="text-dark mb-1 font-weight-medium">
                                    <asp:Label ID="lbTongKhachHang" runat="server" Text="0"></asp:Label>
                                </h2>
                            </div>
                            <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Khách hàng</h6>
                        </div>
                        <div class="ml-auto mt-md-3 mt-lg-0">
                            <span class="opacity-7 text-muted"><i data-feather="user-plus"></i></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card border-right">
                <div class="card-body">
                    <div class="d-flex d-lg-flex d-md-block align-items-center">
                        <div>
                            <h2 class="text-dark mb-1 w-100 text-truncate font-weight-medium">
                                <asp:Label ID="lbDoanhThu" runat="server" Text="0"></asp:Label>
                            </h2>
                            <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Doanh thu</h6>
                        </div>
                        <div class="ml-auto mt-md-3 mt-lg-0">
                            <span class="opacity-7 text-muted"><i data-feather="dollar-sign"></i></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card border-right">
                <div class="card-body">
                    <div class="d-flex d-lg-flex d-md-block align-items-center">
                        <div>
                            <div class="d-inline-flex align-items-center">
                                <h2 class="text-dark mb-1 font-weight-medium">
                                    <asp:Label ID="lbDonHang" runat="server" Text="0"></asp:Label>
                                </h2>
                            </div>
                            <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Đơn hàng</h6>
                        </div>
                        <div class="ml-auto mt-md-3 mt-lg-0">
                            <span class="opacity-7 text-muted"><i data-feather="file-plus"></i></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="d-flex d-lg-flex d-md-block align-items-center">
                        <div>
                            <h2 class="text-dark mb-1 font-weight-medium">
                                <asp:Label ID="lbSanPham" runat="server" Text="0"></asp:Label>
                            </h2>
                            <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Sản phẩm</h6>
                        </div>
                        <div class="ml-auto mt-md-3 mt-lg-0">
                            <span class="opacity-7 text-muted"><i data-feather="globe"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End First Cards -->

        <!-- Start Top Leader Table -->
        <div class="row">
            <div class="col-6">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-4">
                            <h4 class="card-title">Top Loại sản phẩm được mua nhiều nhất</h4>
                        </div>
                        <div class="table-responsive">
                            <table class="table no-wrap v-middle mb-0">
                                <thead>
                                    <tr class="border-0">
                                        <th class="border-0 font-14 text-muted" style="text-align: center; font-weight: bold;">STT
                                                </th>
                                        <th class="border-0 font-14 text-muted px-2" style="text-align: left; font-weight: bold;">Tên loại sản phẩm
                                                </th>
                                        <th class="border-0 font-14 text-muted" style="text-align: right; font-weight: bold; padding-right: 50px;">Số lượt mua</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptTopLoai" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="border-top-0 text-muted px-2 py-4 font-14" style="text-align: center;"><%# Container.ItemIndex + 1 %></td>
                                                <td class="border-top-0 px-2 py-4 font-14"><%# Eval("TenLoaiSP") %></td>
                                                <td class="border-top-0 font-weight-medium text-muted" style="text-align: right; padding-right: 50px;"><%# Eval("SoLuotMua") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-6">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-4">
                            <h4 class="card-title">Top Khách hàng mua nhiều nhất</h4>
                        </div>
                        <div class="table-responsive">
                            <table class="table no-wrap v-middle mb-0">
                                <thead>
                                    <tr class="border-0">
                                        <th class="border-0 font-14 text-muted" style="text-align: center; font-weight: bold;">STT
                                                </th>
                                        <th class="border-0 font-14 text-muted px-2" style="text-align: left; font-weight: bold;">Tên khách hàng
                                                </th>
                                        <th class="border-0 font-14 text-muted" style="text-align: right; font-weight: bold; padding-right: 50px;">Số lượt mua</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptKhachHang" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="border-top-0 text-muted px-2 py-4 font-14" style="text-align: center;"><%# Container.ItemIndex + 1 %></td>
                                                <td class="border-top-0 px-2 py-4 font-14"><%# Eval("HoTenKH") %></td>
                                                <td class="border-top-0 font-weight-medium text-muted" style="text-align: right; padding-right: 50px;"><%# Eval("SoLuotMua") %></td>
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
        <!-- End Top Leader Table -->
    </div>
    <!-- End Container fluid  -->
</asp:Content>

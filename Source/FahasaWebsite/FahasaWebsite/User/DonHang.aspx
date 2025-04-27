<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="DonHang.aspx.cs" Inherits="FahasaWebsite.User.DonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Đơn hàng của bạn
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5" style="margin: 152px 0px 0px; padding: 48px 12px; background: url(../UserTemplate/img/banner3.png); background-position: center center; background-repeat: no-repeat; background-size: cover;">
        <h1 class="text-center text-white display-6">Thông tin đơn hàng</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="TrangChu.aspx">Trang chủ</a></li>
            <li class="breadcrumb-item active text-white">Đơn hàng</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Checkout Page Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <h1 class="mb-4">Thông tin đơn hàng</h1>
            <form action="#">
                <div class="row g-5" style="width: 1200px; margin: 0 auto;">
                    <div class="col-md-12 col-lg-6 col-xl-7" style="width: 550px;">
                        <div class="form-item">
                            <label class="form-label my-3">Họ và tên người nhận<sup>*</sup></label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" />

                        </div>
                        <div class="row">
                            <div class="col-md-12 col-lg-6">
                                <div class="form-item w-100">
                                    <label class="form-label my-3">Số điện thoại<sup>*</sup></label>
                                    <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-6">
                                <div class="form-item w-100">
                                    <label class="form-label my-3">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="form-item">
                            <label class="form-label my-3">Tỉnh/Thành phố<sup>*</sup></label>
                            <asp:DropDownList ID="ddlTinh" runat="server" OnSelectedIndexChanged="ddlTinh_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control mr-sm-2">
                                <asp:ListItem Text="Chọn tỉnh/thành phố" Value="0" />
                            </asp:DropDownList>

                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">Quận/Huyện<sup>*</sup></label>
                            <asp:DropDownList ID="ddlQuan" runat="server" OnSelectedIndexChanged="ddlQuan_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control mr-sm-2">
                                <asp:ListItem Text="Chọn quận/huyện" Value="0" />
                            </asp:DropDownList>

                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">Phường/Xã<sup>*</sup></label>
                            <asp:DropDownList ID="ddlPhuong" runat="server" CssClass="form-control mr-sm-2">
                                <asp:ListItem Text="Chọn xã/phường/thị trấn" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">Địa chỉ nhận hàng<sup>*</sup></label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" />

                        </div>

                        <div class="form-item">
                            <label class="form-label my-3">Phương thức vận chuyển<sup>*</sup></label>
                            <asp:DropDownList ID="ddlPTVanChuyen" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Chọn phương thức vận chuyển" Value="" Selected="True" />
                                <asp:ListItem Text="Giao hàng tiết kiệm (3-5 ngày): 32,000₫" Value="Giao hàng tiết kiệm (3-5 ngày): 32,000₫" />
                                <asp:ListItem Text="Giao hàng nhanh (1-2 ngày): 50,000₫" Value="Giao hàng nhanh (1-2 ngày): 50,000₫" />
                                <asp:ListItem Text="Nhận hàng tại cửa hàng" Value="Nhận hàng tại cửa hàng" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-item">
                            <label class="form-label my-3">Phương thức thanh toán<sup>*</sup></label>
                            <asp:DropDownList ID="ddlPTThanhToan" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Chọn phương thức thanh toán" Value="" Selected="True" />
                                <asp:ListItem Text="Ví Zalo Pay" Value="Ví Zalo Pay" />
                                <asp:ListItem Text="Ví VNPay" Value="Ví VNPay" />
                                <asp:ListItem Text="Ví Momo" Value="Ví Momo" />
                                <asp:ListItem Text="ATM/Internet Banking" Value="ATM/Internet Banking" />
                                <asp:ListItem Text="Visa/Master/JCB" Value="Visa/Master/JCB" />
                                <asp:ListItem Text="Thanh toán bằng tiền mặt" Value="Thanh toán bằng tiền mặt" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-item">
                            <asp:TextBox ID="txtGhiChu" runat="server" name="text" class="form-control" Style="margin-top: 15px;" spellcheck="false" cols="30" Rows="11" placeholder="Lời nhắn cho cửa hàng"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-12 col-lg-6 col-xl-5" style="width: 650px;">
                        <div class="table-responsive">
                            <asp:GridView ID="grdGioHang" runat="server" AutoGenerateColumns="False" CssClass="table text-center" GridLines="None">
                                <Columns>


                                    <asp:TemplateField HeaderText="" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <div class="d-flex align-items-center mt-2">
                                                <img src='<%# Eval("HinhSP") %>' class="img-fluid rounded-circle" style="width: 80px; height: 50px;" alt="Sản phẩm">
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="TenSP" HeaderText="Tên sản phẩm" ItemStyle-CssClass="py-5" HeaderStyle-Width="200px" ItemStyle-Width="200px" />

                                    <asp:TemplateField HeaderText="Giá" HeaderStyle-Width="150px" ItemStyle-Width="150px">
                                        <ItemTemplate>
                                            <div class="py-5"><%# String.Format("{0:#,##0}₫", Convert.ToInt32(Eval("GiaBan"))) %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Quantity" HeaderStyle-Width="100px" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <div class="quantity py-5" style="height: 120px;">
                                                <asp:TextBox ID="txtSoLuong" runat="server"
                                                    CssClass="form-control form-control-sm text-center border-0"
                                                    BackColor="#FFFFFF"
                                                    Style="padding: 0px"
                                                    Text='<%# Eval("SoLuong") %>'
                                                    AutoPostBack="true">
                                                </asp:TextBox>

                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Thành tiền" HeaderStyle-Width="150px" ItemStyle-Width="150px">
                                        <ItemTemplate>
                                            <div class="py-5"><%# String.Format("{0:#,##0}₫", Convert.ToInt32(Eval("ThanhTien"))) %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>

                            <asp:Panel runat="server" CssClass="d-flex justify-content-end">
                                <table class="table">
                                    <tr>
                                        <th scope="row"></th>
                                        <td class="py-5">
                                            <p class="mb-0 text-dark text-uppercase py-3" style="font-weight: 700;">Tổng tiền</p>
                                        </td>
                                        <td class="py-5"></td>
                                        <td class="py-5"></td>
                                        <td class="py-5">
                                            <div class="py-3 border-bottom border-top text-start">
                                                <p class="mb-0 text-dark" style="text-align: center; font-weight: 700;">
                                                    <asp:Label ID="lblTongTien" CssClass="payment-total" runat="server"></asp:Label>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>

                        <asp:Label ID="lblStatus" runat="server"></asp:Label>

                        <asp:Button ID="btnDatHang" runat="server" CssClass="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary"
                            Style="margin: 8px 0;" Text="Đặt hàng" OnClick="btnDatHang_Click" />
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Checkout Page End -->

</asp:Content>

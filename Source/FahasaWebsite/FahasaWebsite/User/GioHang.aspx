<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="FahasaWebsite.User.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Giỏ hàng của tôi
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5" style="margin: 152px 0px 0px; padding: 48px 12px; background: url(../UserTemplate/img/banner3.png); background-position: center center; background-repeat: no-repeat; background-size: cover;">
        <h1 class="text-center text-white display-6">Giỏ hàng của tôi</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="TrangChu.aspx">Trang chủ</a></li>
            <li class="breadcrumb-item active text-white">Giỏ hàng của tôi</li>
        </ol>
    </div>
    <!-- Single Page Header End -->


    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="table-responsive">
                <asp:GridView ID="grdGioHang" runat="server" class="cart" AutoGenerateColumns="False" OnRowDeleting="grdGioHang_RowDeleting" GridLines="None">
                    <columns>
                        <asp:TemplateField>
                            <itemtemplate>
                                <div class="d-flex align-items-center justify-content-center">
                                    <asp:CheckBox ID="chkChon" runat="server" />
                                </div>
                            </itemtemplate>
                            <headerstyle width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sản phẩm">
                            <itemtemplate>
                                <div class="d-flex align-items-center">
                                    <asp:Image ID="imgSanPham" runat="server" ImageUrl='<%# Eval("HinhSP") %>'
                                        CssClass="img-fluid me-5 rounded-circle" Width="80px" Height="80px" />
                                </div>
                            </itemtemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên sách">
                            <itemtemplate>
                                <div class="d-flex align-items-center" style="height: 80px; width: 300px;">
                                    <p class="mb-0 text-center"><%# Eval("TenSP") %></p>
                                </div>
                            </itemtemplate>
                            <itemstyle cssclass="align-middle" />
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Số lượng">
                            <itemtemplate>
                                <div class="d-flex align-items-center" style="height: 80px;">
                                    <div class="input-group quantity" style="width: 110px;">
                                        <div class="input-group-btn">
                                            <asp:Button ID="btnMinus" runat="server" CssClass="btn btn-sm btn-minus rounded-circle bg-light border" style="width: 30px;"
                                                CommandArgument='<%# Container.DataItemIndex %>' CommandName="GiamSoLuong"
                                                OnCommand="CapNhatSoLuong" Text="-" />
                                        </div>
                                        <asp:TextBox ID="txtSoLuong" runat="server"
                                            CssClass="form-control form-control-sm text-center border-0"
                                            BackColor="#FFFFFF" Width="50px"
                                            Style="padding: 5px;"
                                            Text='<%# Eval("SoLuong") %>'
                                            AutoPostBack="true" OnTextChanged="txtSoLuong_TextChanged">
                                        </asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:Button ID="btnPlus" runat="server" CssClass="btn btn-sm btn-plus rounded-circle bg-light border" style="width: 30px;"
                                                CommandArgument='<%# Container.DataItemIndex %>' CommandName="TangSoLuong"
                                                OnCommand="CapNhatSoLuong" Text="+" />
                                        </div>
                                    </div>
                                </div>
                            </itemtemplate>
                            <itemstyle cssclass="align-middle" />
                            <headerstyle width="200px" />
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Giá bán">
                            <itemtemplate>
                                <div class="d-flex align-items-center" style="height: 80px; width: 150px;">
                                    <p class="mb-0 text-center">
                                        <span class="price" data-price='<%# Eval("GiaBan") %>'>
                                            <%# String.Format("{0:#,##0}₫", Convert.ToInt32(Eval("GiaBan"))) %>
                                        </span>
                                    </p>
                                </div>
                            </itemtemplate>
                            <itemstyle cssclass="align-middle" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thành tiền">
                            <itemtemplate>
                                <div class="d-flex align-items-center" style="height: 80px; width: 200px;">
                                    <p class="mb-0 text-center">
                                        <span class="total">
                                            <%# String.Format("{0:#,##0}₫", Convert.ToInt32(Eval("SoLuong")) * Convert.ToInt32(Eval("GiaBan"))) %>
                                        </span>
                                    </p>
                                </div>
                            </itemtemplate>
                            <itemstyle cssclass="align-middle" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Xóa">
                            <itemtemplate>
                                <div class="d-flex align-items-center" style="height: 80px;">
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-md rounded-circle bg-light border"
                                        CommandName="Delete" OnClientClick="return confirm('Bạn có chắc muốn xóa không?');">
                                        <i class="fa fa-times text-danger"></i>
                                    </asp:LinkButton>
                                </div>
                            </itemtemplate>
                            <headerstyle width="60px" />
                            <itemstyle cssclass="text-center align-middle" />
                        </asp:TemplateField>

                    </columns>
                </asp:GridView>

                <asp:Panel ID="pnlGioHangTrong" runat="server" CssClass="cart-empty text-center">
                    <asp:Label ID="lblGioHangTrong" CssClass="cart-empty-text d-block mb-3" runat="server" Text="Chưa có sản phẩm trong giỏ hàng"></asp:Label>
                    <asp:HyperLink ID="lnkMuaNgay" CssClass="btn border-secondary rounded-pill px-4 py-3 text-primary fw-bold"
                        runat="server" NavigateUrl="SanPham.aspx">
                        Đặt hàng</asp:HyperLink>
                </asp:Panel>


                <asp:Panel ID="pnlDatHang" runat="server" CssClass="mt-5">
                    <div class="mt-5 d-flex align-items-center justify-content-between" style="margin-right: 36px; line-height: 60px;">
                        <h4 class="order-text mb-0" style="width: 500px; padding-left: 230px;">Tổng thanh toán:</h4>
                        <p class="mb-0 px-3" style="font-weight: 700; font-size: 20px; color: #81C408; margin-right: 10px;">
                            <asp:Label ID="lblTongTien" CssClass="order-price fw-bold" runat="server"></asp:Label>
                            <span class="order-text">₫</span>
                        </p>
                        <asp:HyperLink ID="HyperLink1" CssClass="btn border-secondary rounded-pill px-4 py-3 text-primary fw-bold"
                            runat="server" NavigateUrl="DonHang.aspx">
                            Đặt hàng</asp:HyperLink>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>


    <script>
        function render(quantityInput, quantity) {
            quantityInput.value = quantity;
        }

        function handlePlus(element) {
            var quantityInput = element.closest('.quantity-control').querySelector('.quantity-input');
            var quantity = parseInt(quantityInput.value);
            quantity++;
            render(quantityInput, quantity);
        }

        function handleMinus(element) {
            var quantityInput = element.closest('.quantity-control').querySelector('.quantity-input');
            var quantity = parseInt(quantityInput.value);
            if (quantity > 1) {
                quantity--;
                render(quantityInput, quantity);
            }
            else {
                //quantityInput.value = 0;
                alert("Số lượng sản phẩm tối thiểu là 1.");
            }
        }

        function thongBaoThemSPThanhCong() {
            var notify = document.getElementById("notify");
            notify.style.display = "flex";

            setTimeout(function () {
                notify.style.display = "none";
            }, 3000);
        }


        function handlePlus(btn) {
            var row = btn.closest(".quantity");
            var txtSoLuong = row.querySelector("input");
            var soLuong = parseInt(txtSoLuong.value, 10);

            if (!isNaN(soLuong)) {
                soLuong++;
                txtSoLuong.value = soLuong;
                updateTotal(row, soLuong);
            }
        }

        function handleMinus(btn) {
            var row = btn.closest(".quantity");
            var txtSoLuong = row.querySelector("input");
            var soLuong = parseInt(txtSoLuong.value, 10);

            if (!isNaN(soLuong) && soLuong > 1) {
                soLuong--;
                txtSoLuong.value = soLuong;
                updateTotal(row, soLuong);
            }
        }

        function updateTotal(row, soLuong) {
            var priceElement = row.closest("tr").querySelector(".price");
            var totalElement = row.closest("tr").querySelector(".total");

            var price = parseInt(priceElement.getAttribute("data-price"), 10);
            var total = soLuong * price;

            totalElement.innerText = total.toLocaleString("vi-VN") + "₫";
        }
    </script>
</asp:Content>

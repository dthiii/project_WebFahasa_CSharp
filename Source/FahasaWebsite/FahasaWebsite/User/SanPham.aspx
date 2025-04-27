<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="FahasaWebsite.User.SanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Danh mục sản phẩm
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5" style="margin: 152px 0px 0px; padding: 48px 12px; background: url(../UserTemplate/img/banner3.png); background-position: center center; background-repeat: no-repeat; background-size: cover;">
        <h1 class="text-center text-white display-6">Danh mục sản phẩm</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="TrangChu.aspx">Trang chủ</a></li>
            <li class="breadcrumb-item active text-white">Danh mục sản phẩm</li>
        </ol>
    </div>
    <!-- Single Page Header End -->


    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">
            <h1 class="mb-4">Tủ sách Fahasa</h1>
            <div class="row g-4">
                <div class="col-lg-12">
                    <div class="row g-4">
                        <div class="col-xl-3">
                            <div class="input-group w-100 mx-auto d-flex">
                                <input type="search" class="form-control p-3" placeholder="Tìm kiếm" aria-describedby="search-icon-1">
                                <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                            </div>
                        </div>
                        <div class="col-6"></div>
                        <div class="col-xl-3">
                            <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                <label for="fruits">Nhóm:</label>
                                <asp:DropDownList ID="ddlNhomSanPham" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlNhomSanPham_SelectedIndexChanged"
                                    CssClass="border-0 form-select-sm bg-light me-3">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row g-4">
                        <div class="col-lg-3">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <h4>Thể loại</h4>
                                        <ul class="list-unstyled fruite-categorie">
                                            <asp:Repeater ID="rptTheLoai" runat="server" OnItemCommand="rptTheLoai_ItemCommand">
                                                <ItemTemplate>
                                                    <li>
                                                        <div class="d-flex justify-content-between fruite-name">
                                                            <a href="SanPham.aspx?MaLoaiSP=<%# Eval("MaLoaiSP") %>">
                                                                <i class="fas fa-apple-alt me-2"></i><%# Eval("TenLoaiSP") %>
                                                            </a>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <h4 class="mb-2">Giá</h4>
                                        <input type="range" class="form-range w-100" id="rangeInput" name="rangeInput" min="0" max="500" value="0" oninput="amount.value=rangeInput.value">
                                        <output id="amount" name="amount" min-velue="0" max-value="500" for="rangeInput">0</output>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <h4>Nhà cung cấp</h4>
                                        <asp:Repeater ID="rptNhaCungCap" runat="server">
                                            <ItemTemplate>
                                                <div class="mb-2">
                                                    <input type="radio" class="me-2" id='<%# "Categories-" + Eval("MaNCC") %>'
                                                        name="Categories-1" value='<%# Eval("MaNCC") %>' />
                                                    <label for='<%# "Categories-" + Eval("MaNCC") %>'>
                                                        <%# Eval("TenNCC") %>
                                                    </label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <h4 class="mb-3">Sách nổi bật</h4>
                                    <asp:Repeater ID="rptSPNoiBat" runat="server">
                                        <ItemTemplate>
                                            <div class="d-flex align-items-center justify-content-start">
                                                <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                                    <div class="rounded me-4" style="width: 100px; height: 100px;">
                                                        <img src='<%# Eval("HinhSP") %>' class="img-fluid rounded" alt='<%# Eval("TenSP") %>'>
                                                    </div>
                                                </a>
                                                <div>
                                                    <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                                        <h6 class="mb-2"><%# Eval("TenSP") %></h6>
                                                    </a>
                                                    <div class="d-flex mb-2">
                                                        <%# RenderStars(Eval("DiemDanhGia")) %>
                                                    </div>
                                                    <div class="d-flex mb-2">
                                                        <h6 class="fw-bold me-2">
                                                            <%# String.Format("{0:#,##0}₫", Eval("GiaSauGiam")) %>
                                                        </h6>
                                                        <h6 class="text-danger text-decoration-line-through">
                                                            <%# String.Format("{0:#,##0}₫", Eval("GiaBan")) %>
                                                        </h6>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <div class="row g-4 justify-content-center">
                                <asp:Repeater ID="rptSanPham" runat="server">
                                    <ItemTemplate>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <!-- Nhấn vào hình ảnh sẽ chuyển đến ChiTietSP.aspx -->
                                                <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                                    <div class="fruite-img">
                                                        <img src="<%# Eval("HinhSP") %>" class="img-fluid w-100 rounded-top" alt="<%# Eval("TenSP") %>">
                                                    </div>
                                                </a>
                                                <!-- Hiển thị loại sản phẩm -->
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
                                                    <%# Eval("TenLoaiSP") %>
                                                </div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <!-- Tên sản phẩm -->
                                                    <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                                        <h5 style="height: 50px; font-weight: 700; text-align: center; color: #81C408">
                                                            <%# Eval("TenSP") %>
                                                        </h5>
                                                    </a>
                                                    <!-- Mô tả sản phẩm -->
                                                    <p style="text-align: justify; font-size: 13px;">
                                                        <%# Eval("MoTa").ToString().Length > 70 ? Eval("MoTa").ToString().Substring(0, 70) + "... " : Eval("MoTa") %>
                                                        <!-- Link "Xem thêm" -->
                                                        <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>' style='color: #FFB524;'>Xem thêm</a>
                                                    </p>
                                                    <!-- Giá và nút "Thêm vào giỏ" -->
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">
                                                            <%# String.Format("{0:#,##0}₫", Eval("GiaBan")) %>
                                                        </p>
                                                        <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>' class="btn border border-secondary rounded-pill px-3 text-primary" style="font-size: 13px;">
                                                            <i class="fa fa-shopping-bag me-2 text-primary"></i>Xem chi tiết
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <div class="col-12">
                                    <div id="pagination" runat="server" class="pagination d-flex justify-content-center mt-5"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Fruits Shop End-->


</asp:Content>

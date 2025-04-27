<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="FahasaWebsite.User.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Fahasa - Hệ thống nhà sách trực tuyến hàng đầu Việt Nam - FAHASA.COM
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Start -->
    <div class="container-fluid py-5 mb-5 hero-header">
        <div class="container py-5">
            <div class="row g-5 align-items-center">
                <div class="col-md-12 col-lg-7">
                    <h4 class="mb-3 text-secondary">Nhà sách chính hãng</h4>
                    <h1 class="mb-5 display-3 text-primary">Hội sách Online
                        <br />
                        Quà tặng mỗi ngày
                    </h1>
                    <div class="position-relative mx-auto">
                        <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="number" placeholder="Từ khoá">
                        <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">Tìm kiếm</button>
                    </div>
                </div>
                <div class="col-md-12 col-lg-5">
                    <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                        <div class="carousel-inner" role="listbox">
                            <div class="carousel-item active rounded">
                                <img src="../UserTemplate/img/banner1.jpg" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                <a href="#" class="btn px-4 py-2 text-white rounded" style="font-size: 22px;">Sách</a>
                            </div>
                            <div class="carousel-item rounded">
                                <img src="../UserTemplate/img/banner2.png" class="img-fluid w-100 h-100 rounded" alt="Second slide">
                                <a href="#" class="btn px-4 py-2 text-white rounded" style="font-size: 22px;">Văn phòng phẩm</a>
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Hero End -->


    <!-- Featurs Section Start -->
    <div class="container-fluid featurs py-5">
        <div class="container py-5">
            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="featurs-item text-center rounded bg-light p-4">
                        <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                            <i class="fas fa-car-side fa-3x text-white"></i>
                        </div>
                        <div class="featurs-content text-center">
                            <h5>Giao hàng miễn phí</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="featurs-item text-center rounded bg-light p-4">

                        <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                            <i class="fas fa-user-shield fa-3x text-white"></i>
                        </div>
                        <div class="featurs-content text-center">
                            <h5>Thanh toán an toàn</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="featurs-item text-center rounded bg-light p-4">
                        <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                            <i class="fas fa-exchange-alt fa-3x text-white"></i>
                        </div>
                        <div class="featurs-content text-center">
                            <h5>Hoàn trả trong 15 ngày</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="featurs-item text-center rounded bg-light p-4">
                        <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                            <i class="fa fa-phone-alt fa-3x text-white"></i>
                        </div>
                        <div class="featurs-content text-center">
                            <h5>Hỗ trợ 24/7</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Featurs Section End -->


    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">
            <div class="tab-class text-center">
                <div class="row g-4">
                    <div class="col-lg-4 text-start">
                        <h1>TỦ SÁCH FAHASA</h1>
                    </div>
                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <asp:LinkButton ID="btnAll" runat="server" CssClass="d-flex m-2 py-2 bg-light rounded-pill active" OnClick="LoadBooksByCategory" CommandArgument="All">
            <span class="text-dark" style="width: 130px;">Xem tất cả</span>
                                </asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="btnVanHoc" runat="server" CssClass="d-flex m-2 py-2 bg-light rounded-pill" OnClick="LoadBooksByCategory" CommandArgument="Văn học">
            <span class="text-dark" style="width: 130px;">Văn học</span>
                                </asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="btnKinhTe" runat="server" CssClass="d-flex m-2 py-2 bg-light rounded-pill" OnClick="LoadBooksByCategory" CommandArgument="Kinh tế">
            <span class="text-dark" style="width: 130px;">Kinh tế</span>
                                </asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="btnThieuNhi" runat="server" CssClass="d-flex m-2 py-2 bg-light rounded-pill" OnClick="LoadBooksByCategory" CommandArgument="Sách thiếu nhi">
            <span class="text-dark" style="width: 130px;">Sách thiếu nhi</span>
                                </asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="btnGiaoKhoa" runat="server" CssClass="d-flex m-2 py-2 bg-light rounded-pill" OnClick="LoadBooksByCategory" CommandArgument="Giáo khoa - Tham khảo">
            <span class="text-dark" style="width: 200px;">Giáo khoa - Tham khảo</span>
                                </asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4">
                                    <asp:Repeater ID="rptBooks" runat="server">
                                        <ItemTemplate>
                                            <div class="col-md-6 col-lg-4 col-xl-3">
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
                                                        <h5 style="height: 50px; font-weight: 700; text-align: center; color: #81C408">
                                                            <%# Eval("TenSP") %>
                                                        </h5>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Fruits Shop End-->


    <!-- Featurs Start -->
    <div class="container-fluid service py-5">
        <div class="container py-5">
            <div class="row g-4 justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <a href="ChiTietSP.aspx?MaSP=00000006">
                        <div class="service-item bg-secondary rounded border border-secondary">
                            <img src="../UserTemplate/img/HinhSP/002.png" class="img-fluid rounded-top w-100" alt="">
                            <div class="px-4 rounded-bottom">
                                <div class="service-content bg-primary text-center p-4 rounded">
                                    <h5 class="text-white">Nguyễn Nhật Ánh</h5>
                                    <h3 class="mb-0">Mua 5 tặng 1</h3>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-4">
                    <a href="ChiTietSP.aspx?MaSP=00000029">
                        <div class="service-item bg-dark rounded border border-dark">
                            <img src="../UserTemplate/img/HinhSP/025.png" class="img-fluid rounded-top w-100" alt="">
                            <div class="px-4 rounded-bottom">
                                <div class="service-content bg-light text-center p-4 rounded">
                                    <h5 class="text-primary">Sách giáo khoa</h5>
                                    <h3 class="mb-0">Free ship</h3>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-4">
                    <a href="ChiTietSP.aspx?MaSP=00000031">
                        <div class="service-item bg-primary rounded border border-primary">
                            <img src="../UserTemplate/img/HinhSP/026.png" class="img-fluid rounded-top w-100" alt="">
                            <div class="px-4 rounded-bottom">
                                <div class="service-content bg-secondary text-center p-4 rounded">
                                    <h5 class="text-white">Sách tiếng anh</h5>
                                    <h3 class="mb-0">Giảm giá 10%</h3>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Featurs End -->


    <!-- Vesitable Shop Start-->
    <div class="container-fluid vesitable py-5">
        <div class="container py-5">
            <h1 class="mb-0">XU HƯỚNG MUA SẮM</h1>
            <div class="owl-carousel vegetable-carousel justify-content-center">
                <asp:Repeater ID="rptSachXuHuong" runat="server">
                    <ItemTemplate>
                        <div class="border border-primary rounded position-relative vesitable-item">
                            <!-- Hình ảnh sản phẩm (click vào chuyển hướng) -->
                            <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                <div class="vesitable-img">
                                    <img src='<%# Eval("HinhSP") %>' class="img-fluid w-100 rounded-top" alt="<%# Eval("TenSP") %>">
                                </div>
                            </a>

                            <!-- Loại sản phẩm -->
                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">
                                <%# Eval("TenLoaiSP") %>
                            </div>

                            <!-- Nội dung sản phẩm -->
                            <div class="p-4 rounded-bottom">
                                <!-- Tên sản phẩm (click vào chuyển hướng) -->
                                <h5 style="height: 50px; font-weight: 700; text-align: center; color: #81C408">
                                    <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                        <%# Eval("TenSP") %>
                                    </a>
                                </h5>

                                <!-- Mô tả sản phẩm -->
                                <p style="text-align: justify; font-size: 13px;">
                                    <%# Eval("MoTa").ToString().Length > 70 ? Eval("MoTa").ToString().Substring(0, 70) + "... " : Eval("MoTa") %>
                                    <!-- Link "Xem thêm" -->
                                    <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>' style='color: #FFB524;'>Xem thêm</a>
                                </p>

                                <!-- Giá bán và nút thêm vào giỏ hàng -->
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
                    </ItemTemplate>
                </asp:Repeater>


            </div>
        </div>
    </div>
    <!-- Vesitable Shop End -->


    <!-- Banner Section Start-->
    <div class="container-fluid banner bg-secondary my-5">
        <div class="container py-5">
            <div class="row g-4 align-items-center">
                <div class="col-lg-6">
                    <div class="py-4">
                        <h1 class="display-3 text-white">CHÀO THÁNG BA</h1>
                        <p class="fw-normal display-3 text-dark mb-4">BAO LA ƯU ĐÃI</p>
                        <p class="mb-4 text-dark">Ghé Fahasa vào tháng ba để được nhận các phần quà và ưu đãi đặc biệt.</p>
                        <a href="SanPham.aspx" class="banner-btn btn border-2 border-white rounded-pill text-dark py-3 px-5">MUA NGAY</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="position-relative">
                        <img src="../UserTemplate/img/banner-section.png" class="img-fluid w-100 rounded" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Banner Section End -->


    <!-- Bestsaler Product Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-4">SẢN PHẨM BÁN CHẠY</h1>
            </div>
            <div class="row g-4">
                <asp:Repeater ID="rptBooksBestSeller" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <!-- Hình ảnh sản phẩm (click vào chuyển hướng) -->
                                    <div class="col-6">
                                        <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>'>
                                            <img src='<%# Eval("HinhSP") %>' class="img-fluid rounded-circle w-100" alt='<%# Eval("TenSP") %>' />
                                        </a>
                                    </div>

                                    <div class="col-6">
                                        <!-- Tên sản phẩm (click vào chuyển hướng) -->
                                        <h5 style="height: 50px; font-weight: 600;">
                                            <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>' style="text-decoration: none; color: inherit;">
                                                <%# Eval("TenSP") %>
                                            </a>
                                        </h5>

                                        <!-- Hiển thị số sao -->
                                        <div class="d-flex my-3">
                                            <%# RenderStars(Eval("SoSaoRandom")) %>
                                        </div>

                                        <!-- Giá bán -->
                                        <h4 class="mb-3">
                                            <%# String.Format("{0:#,##0}₫", Eval("GiaBan")) %>
                                        </h4>

                                        <!-- Nút Thêm vào giỏ hàng -->
                                        <a href='ChiTietSP.aspx?MaSP=<%# Eval("MaSP") %>' class="btn border border-secondary rounded-pill px-3 text-primary" style="font-size: 13px;">
                                            <i class="fa fa-shopping-bag me-2 text-primary"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>
    <!-- Bestsaler Product End -->


    <!-- Fact Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="bg-light p-5 rounded">
                <div class="row g-4 justify-content-center">
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="counter bg-white rounded p-5">
                            <i class="fa fa-users text-secondary"></i>
                            <h1>60</h1>
                            <h4 style="margin: 8px 0px 0px;">NHÀ SÁCH
                                <br />
                                TRÊN
                                <br />
                                TOÀN QUỐC</h4>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="counter bg-white rounded p-5">
                            <i class="fa fa-users text-secondary"></i>
                            <h1>TOP 10</h1>
                            <h4 style="margin: 8px 0px 0px;">NHÀ BÁN LẺ HÀNG ĐẦU VIỆT NAM</h4>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="counter bg-white rounded p-5">
                            <i class="fa fa-users text-secondary"></i>
                            <h1>> 5000</h1>
                            <h4 style="margin: 8px 0px 0px;">LƯỢT BÁN MỖI NGÀY</h4>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="counter bg-white rounded p-5">
                            <i class="fa fa-users text-secondary"></i>
                            <h1>TOP 50</h1>
                            <h4 style="margin: 8px 0px 0px;">NHÃN HIỆU NỔI TIẾNG</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Fact Start -->


    <!-- Tastimonial Start -->
    <div class="container-fluid testimonial py-5">
        <div class="container py-5">
            <div class="testimonial-header text-center">
                <h1 class="display-5 mb-5 text-dark">ĐÁNH GIÁ CỦA KHÁCH HÀNG</h1>
            </div>
            <div class="owl-carousel testimonial-carousel">
                <asp:Repeater ID="rptTestimonials" runat="server">
                    <ItemTemplate>
                        <div class="testimonial-item img-border-radius bg-light rounded p-4">
                            <div class="position-relative">
                                <i class="fa fa-quote-right fa-2x text-secondary position-absolute" style="bottom: 30px; right: 0;"></i>
                                <div class="mb-4 pb-4 border-bottom border-secondary">
                                    <p class="mb-0"><%# Eval("BinhLuan") %></p>
                                </div>
                                <div class="d-flex align-items-center flex-nowrap">
                                    <div class="bg-secondary rounded">
                                        <img src='<%# Eval("AvatarKH") %>' class="img-fluid rounded" style="width: 100px; height: 100px;" alt='<%# Eval("HoTenKH") %>' />
                                    </div>
                                    <div class="ms-4 d-block">
                                        <h4 class="text-dark"><%# Eval("HoTenKH") %></h4>
                                        <p class="m-0 pb-3"><%# Eval("ThoiGian") %></p>
                                        <div class="d-flex pe-5">
                                            <%# RenderStars(Eval("DiemDanhGia")) %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <!-- Tastimonial End -->

</asp:Content>

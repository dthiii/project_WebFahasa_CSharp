<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="ChiTietSP.aspx.cs" Inherits="FahasaWebsite.User.ChiTietSP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Thông tin sản phẩm
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5" style="margin: 152px 0px 0px; padding: 48px 12px; background: url(../UserTemplate/img/banner3.png); background-position: center center; background-repeat: no-repeat; background-size: cover;">
        <h1 class="text-center text-white display-6">Danh mục sản phẩm</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="TrangChu.aspx">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="SanPham.aspx">Danh mục sản phẩm</a></li>
            <li class="breadcrumb-item active text-white">Thông tin sản phẩm</li>
        </ol>
    </div>
    <!-- Single Page Header End -->



    <!-- Single Product Start -->
    <div class="container-fluid py-5 mt-5">
        <div class="container py-5">
            <div class="row g-4 mb-5">
                <div class="col-lg-8 col-xl-9">
                    <div class="row g-4">
                        <div class="container">
                            <div class="row">
                                <!-- Hình ảnh sản phẩm -->
                                <div class="col-lg-6">
                                    <img id="hinhSP" runat="server" class="img-fluid w-100 rounded" alt="Hình sản phẩm" />
                                </div>

                                <!-- Thông tin sản phẩm -->
                                <div class="col-lg-6">
                                    <h4 id="tenSP" runat="server" class="fw-bold mb-3"></h4>
                                    <p id="tenLoaiSP" runat="server" class="mb-3"></p>
                                    <h5 id="giaBan" runat="server" class="fw-bold mb-3"></h5>

                                    <div class="d-flex mb-4">
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star"></i>
                                    </div>

                                    

                                    <div class="input-group quantity mb-5" style="width: 100px;">
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-sm btn-minus rounded-circle bg-light border" onclick="updateQuantity(-1)">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                        <asp:TextBox ID="txtSoLuong" runat="server"
                                            CssClass="form-control form-control-sm text-center border-0"
                                            Style="padding: 5px; background-color: #FFFFFF;"
                                            Text="1">
                                        </asp:TextBox>
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-sm btn-plus rounded-circle bg-light border" onclick="updateQuantity(1)">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>



                                    <asp:LinkButton ID="btnThem" runat="server" CssClass="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
                                        OnClick="btnThem_Click">
                                            <i class="fa fa-shopping-bag me-2 text-primary"></i> Thêm vào giỏ hàng
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnMua" runat="server" CssClass="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
                                        OnClick="btnMua_Click">
                                            <i class="fa fa-shopping-bag me-2 text-primary"></i> Mua ngay
                                    </asp:LinkButton>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <nav>
                            <div class="nav nav-tabs mb-3">
                                <button class="nav-link active border-white border-bottom-0" type="button" role="tab"
                                    id="nav-about-tab" data-bs-toggle="tab" data-bs-target="#nav-about"
                                    aria-controls="nav-about" aria-selected="true">
                                    Mô tả</button>
                                <button class="nav-link border-white border-bottom-0" type="button" role="tab"
                                    id="nav-mission-tab" data-bs-toggle="tab" data-bs-target="#nav-mission"
                                    aria-controls="nav-mission" aria-selected="false">
                                    Bình luận</button>
                            </div>
                        </nav>
                        <div class="tab-content mb-5">
                            <div class="tab-pane active" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                                <p id="moTa" runat="server" class="mb-4" style="text-align: justify;"></p>
                                <div class="px-2">
                                    <div class="row g-4">
                                        <div class="col-6">
                                            <div class="row bg-light align-items-center text-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Nhà cung cấp</p>
                                                </div>
                                                <div class="col-6">
                                                    <p id="nhaCungCap" runat="server" class="mb-0"></p>
                                                </div>
                                            </div>
                                            <div class="row text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Nhà xuất bản</p>
                                                </div>
                                                <div class="col-6">
                                                    <p id="nhaXuatBan" runat="server" class="mb-0"></p>
                                                </div>
                                            </div>
                                            <div class="row bg-light text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Năm xuất bản</p>
                                                </div>
                                                <div class="col-6">
                                                    <p id="namXuatBan" runat="server" class="mb-0"></p>
                                                </div>
                                            </div>
                                            <div class="row text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Tác giả</p>
                                                </div>
                                                <div class="col-6">
                                                    <p id="tacGia" runat="server" class="mb-0"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="nav-mission" role="tabpanel" aria-labelledby="nav-mission-tab">
                                <asp:Repeater ID="rptDanhGia" runat="server">
                                    <ItemTemplate>
                                        <div class="d-flex mb-4">
                                            <!-- Ảnh đại diện mặc định -->
                                            <img src='<%# Eval("AvatarKH") %>' class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="Avatar">

                                            <!-- Nội dung đánh giá -->
                                            <div>
                                                <!-- Thời gian đánh giá -->
                                                <p class="mb-2" style="font-size: 14px;">
                                                    <%# Eval("ThoiGian", "{0:dd/MM/yyyy}") %>
                                                </p>

                                                <div class="d-flex justify-content-between">
                                                    <!-- Tên khách hàng -->
                                                    <h5><%# Eval("HoTenKH") %></h5>

                                                    <!-- Số sao -->
                                                    <div class="d-flex mb-3">
                                                        <%# RenderStars(Eval("DiemDanhGia")) %>
                                                    </div>
                                                </div>

                                                <!-- Nội dung bình luận -->
                                                <p style="text-align: justify;"><%# Eval("BinhLuan") %></p>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>

                    <!-- Form đánh giá sản phẩm -->
                    <form action="#" id="reviewForm">
                        <h4 class="mb-5 fw-bold">Đánh giá sản phẩm</h4>

                        <div class="row g-4">
                            <!-- Nhập tên -->
                            <div class="col-lg-6">
                                <div class="border-bottom rounded">
                                    <input type="text" id="reviewName" class="form-control border-0 me-4" placeholder="Tên của bạn *" required>
                                </div>
                            </div>

                            <!-- Nhập email -->
                            <div class="col-lg-6">
                                <div class="border-bottom rounded">
                                    <input type="email" id="reviewEmail" class="form-control border-0" placeholder="Email *" required>
                                </div>
                            </div>

                            <!-- Nhập nội dung đánh giá -->
                            <div class="col-lg-12">
                                <div class="border-bottom rounded my-4">
                                    <textarea id="reviewComment" class="form-control border-0" cols="30" rows="4" placeholder="Đánh giá *" spellcheck="false" required></textarea>
                                </div>
                            </div>

                            <!-- Xếp hạng sao -->
                            <div class="col-lg-12">
                                <div class="d-flex align-items-center py-3">
                                    <p class="mb-0 me-3">Xếp hạng sản phẩm:</p>
                                    <div id="starRating" class="d-flex" style="font-size: 20px; cursor: pointer;">
                                        <i class="fa fa-star text-muted" data-value="1"></i>
                                        <i class="fa fa-star text-muted" data-value="2"></i>
                                        <i class="fa fa-star text-muted" data-value="3"></i>
                                        <i class="fa fa-star text-muted" data-value="4"></i>
                                        <i class="fa fa-star text-muted" data-value="5"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút gửi đánh giá -->
                            <div class="col-lg-12">
                                <a href="#" id="submitReview" class="btn border border-secondary text-primary rounded-pill px-4 py-3">Gửi đánh giá</a>
                            </div>
                        </div>
                    </form>

                    <!-- Modal thông báo -->
                    <div id="ratingModal" class="modal fade" tabindex="-1" aria-labelledby="ratingModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Thông báo</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModal"></button>
                                </div>
                                <div class="modal-body">Vui lòng đợi kiểm duyệt.</div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="modalConfirm">Đã hiểu</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- jQuery và Bootstrap -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                    <script>
                        $(document).ready(function () {
                            let selectedStars = 0;

                            // Xử lý click chọn sao
                            $('#starRating i').click(function () {
                                selectedStars = $(this).data('value');

                                // Làm mới trạng thái sao
                                $('#starRating i').removeClass('text-warning').addClass('text-muted');

                                // Tô màu các sao đã chọn
                                $(this).prevAll().addBack().removeClass('text-muted').addClass('text-warning');
                            });

                            // Xử lý gửi đánh giá
                            $('#submitReview').click(function (e) {
                                e.preventDefault();

                                // Kiểm tra nhập liệu
                                const name = $('#reviewName');
                                const email = $('#reviewEmail');
                                const comment = $('#reviewComment');

                                if (!name.val().trim()) {
                                    alert("Vui lòng nhập tên của bạn.");
                                    name.focus();
                                    return;
                                }

                                if (!email.val().trim()) {
                                    alert("Vui lòng nhập email của bạn.");
                                    email.focus();
                                    return;
                                }

                                const emailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                                if (!emailPattern.test(email.val().trim())) {
                                    alert("Email không hợp lệ. Vui lòng nhập địa chỉ email kết thúc bằng @gmail.com.");
                                    email.focus();
                                    return;
                                }

                                if (!comment.val().trim()) {
                                    alert("Vui lòng nhập đánh giá của bạn.");
                                    comment.focus();
                                    return;
                                }

                                if (selectedStars === 0) {
                                    alert("Vui lòng chọn số sao đánh giá.");
                                    return;
                                }

                                // Hiển thị modal thông báo
                                const modal = new bootstrap.Modal(document.getElementById('ratingModal'));
                                modal.show();
                            });

                            // Xử lý khi đóng modal
                            $('#modalConfirm').click(function () {
                                // Reset form sau khi gửi
                                $('#reviewForm')[0].reset();
                                selectedStars = 0;
                                $('#starRating i').removeClass('text-warning').addClass('text-muted');
                            });
                        });
                    </script>
                </div>
                <div class="col-lg-4 col-xl-3">
                    <div class="row g-4 fruite">

                        <div class="col-lg-12">
                            <div class="input-group w-100 mx-auto d-flex mb-4">
                                <input type="search" class="form-control p-3" placeholder="Tìm kiếm" aria-describedby="search-icon-1">
                                <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
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
            </div>
        </div>
    </div>

    <script>
        function updateQuantity(change) {
            let quantityInput = document.getElementById('productQuantity');
            let currentValue = parseInt(quantityInput.value) || 0;

            // Cập nhật số lượng, đảm bảo không nhỏ hơn 1
            let newValue = currentValue;
            if (newValue < 1) newValue = 1;

            quantityInput.value = newValue;
        }
    </script>
</asp:Content>

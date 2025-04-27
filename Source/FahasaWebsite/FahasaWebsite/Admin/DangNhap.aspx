<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="FahasaWebsite.Admin.DangNhap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../AdminTemplate/assets/images/logo.png" />
    <!-- Custom CSS -->
    <link href="../AdminTemplate/dist/css/style.min.css" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-wrapper">
            <!-- Preloader - style you can find in spinners.css -->
            <div class="preloader">
                <div class="lds-ripple">
                    <div class="lds-pos"></div>
                    <div class="lds-pos"></div>
                </div>
            </div>
            <!-- Preloader - style you can find in spinners.css -->
            <!-- Login box.scss -->
            <div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative">
                <div class="auth-box row">
                    <div class="col-lg-6 col-md-5 modal-bg-img" style="background-image: url(../AdminTemplate/assets/images/logo.png);">
                    </div>
                    <div class="col-lg-6 col-md-7 bg-white">
                        <div class="p-3">

                            <h2 class="mt-3 text-center" style="margin-bottom: 10px;">Đăng nhập</h2>
                            <p class="text-center" style="font-size: 15px;">
                                Nhập Email và Mật khẩu
                                <br />
                                để đăng nhập tài khoản quản lý.
                            </p>

                            <form class="mt-4">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="text-dark" for="uname">Tên đăng nhập</label>
                                            <asp:TextBox ID="txtTenDangNhap" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="text-dark" for="pwd">Mật khẩu</label>
                                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" />
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                                    </div>

                                    <div class="col-lg-12 text-center" style="margin: 10px 0px 30px 0px;">
                                        <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" CssClass="btn btn-block btn-dark" OnClick="btnDangNhap_Click" />

                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Login box.scss -->
        </div>

        <script src="../AdminTemplate/assets/libs/jquery/dist/jquery.min.js "></script>
        <script src="../AdminTemplate/assets/libs/popper.js/dist/umd/popper.min.js "></script>
        <script src="../AdminTemplate/assets/libs/bootstrap/dist/js/bootstrap.min.js "></script>
        <script>
            $(".preloader ").fadeOut();
    </script>
    </form>
</body>
</html>

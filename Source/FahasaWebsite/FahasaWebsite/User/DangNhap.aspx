<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="FahasaWebsite.User.DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Đăng nhập tài khoản  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="../UserTemplate/css/dangnhap-dangky.css" />

    <div class="container-fluid fruite py-5" style="margin: 100px auto 0px auto;">
        <div class="container py-5" style="display: flex; justify-content: center;">
            <layouttemplate>
                <table cellpadding="0" style="width: 100%; border-spacing: 0 15px;">
                    <tr>
                        <td align="center" colspan="2" class="account_heading">
                            <h1 class="mb-5 display-3 text-primary">ĐĂNG NHẬP</h1>
                        </td>
                    </tr>

                    <tr class="form-item" style="height: 50px;">
                        <td style="width: 200px;">
                            <div style="display: flex; align-items: center; justify-content: space-between;">
                                <label class="text-dark" for="uname">Tên đăng nhập</label>
                            </div>
                        </td>
                        <td style="width: 420px;">
                            <asp:TextBox ID="txtTenDangNhap" runat="server" CssClass="form-control" />
                        </td>
                    </tr>

                    <tr class="form-item" style="height: 50px;">
                        <td style="width: 200px;">
                            <div style="display: flex; align-items: center; justify-content: space-between;">
                                <label class="text-dark" for="pwd">Mật khẩu</label>
                            </div>
                        </td>
                        <td style="width: 420px;">
                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" />
                        </td>
                    </tr>

                    <tr class="form-item" style="height: 50px;">
                        <td></td>
                        <td align="left" style="color: Red;">
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                        </td>
                    </tr>

                    <tr class="form-item" style="height: 50px;">
                        <td></td>
                        <td style="display: flex; justify-content: space-between; align-items: center;">
                            <asp:HyperLink ID="lnkDangKy" runat="server" NavigateUrl="DangKy.aspx"
                                CssClass="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
                                    <i class="fa fa-user-plus me-2 text-primary"></i> Đăng ký
                            </asp:HyperLink>

                            <asp:Button ID="btnDangNhap" runat="server" CommandName="Login" Text="Đăng nhập"
                                ValidationGroup="Login1" OnClick="btnDangNhap_Click"
                                CssClass="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" />
                        </td>
                    </tr>
                </table>
            </layouttemplate>
        </div>
    </div>
</asp:Content>

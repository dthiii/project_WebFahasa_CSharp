<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="FahasaWebsite.User.DangKy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Đăng ký tài khoản
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid fruite py-5" style="margin: 100px auto 0px auto;">
        <div class="container py-5" style="display: flex; justify-content: center;">
            <asp:CreateUserWizard ID="CreateUserWizard1" class="account" Style="width: 70%;" runat="server" DuplicateEmailErrorMessage="Địa chỉ email bạn nhập đã được sử dụng. Vui lòng nhập một địa chỉ email khác." DuplicateUserNameErrorMessage="Vui lòng nhập một tên người dùng khác nhau." InvalidAnswerErrorMessage="Vui lòng nhập câu trả lời bảo mật khác." InvalidEmailErrorMessage="Vui lòng nhập địa chỉ email hợp lệ." InvalidPasswordErrorMessage="Độ dài mật khẩu tối thiểu: {0}. Yêu cầu ký tự không phải chữ và số: {1}." InvalidQuestionErrorMessage="Vui lòng nhập một câu hỏi bảo mật khác." UnknownErrorMessage="Tài khoản của bạn chưa được tạo. Vui lòng thử lại." ContinueDestinationPageUrl="~/Login.aspx">
                <WizardSteps>
                    <asp:CreateUserWizardStep runat="server">
                        <ContentTemplate>
                            <table style="width: 100%;">
                                <tr>
                                    <td align="center" colspan="2" class="account_heading">
                                        <h1 class="mb-5 display-3 text-primary">ĐĂNG KÝ</h1>

                                    </td>
                                </tr>

                                <tr class="form-item">
                                    <td style="width: 50%; display: flex; align-items: center; justify-content: space-between; white-space: nowrap;">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName"
                                            Style="text-align: left; flex-shrink: 0; font-weight: bold;">Tên đăng nhập</asp:Label>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                            ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1"
                                            Style="color: red; margin-left: 5px; flex-shrink: 0;">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server"
                                            Style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr class="form-item">
                                    <td style="width: 50%; display: flex; align-items: center; justify-content: space-between; white-space: nowrap;">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password"
                                            Style="text-align: left; flex-shrink: 0; font-weight: bold;">Mật khẩu</asp:Label>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                            ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1"
                                            Style="color: red; margin-left: 5px; flex-shrink: 0;">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server"
                                            Style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr class="form-item">
                                    <td style="width: 50%; display: flex; align-items: center; justify-content: space-between; white-space: nowrap;">
                                        <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword"
                                            Style="text-align: left; flex-shrink: 0; font-weight: bold;">Nhập lại mật khẩu</asp:Label>
                                        <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                            ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1"
                                            Style="color: red; margin-left: 5px; flex-shrink: 0;">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ConfirmPassword" runat="server"
                                            Style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr class="form-item">
                                    <td style="width: 50%; display: flex; align-items: center; justify-content: space-between; white-space: nowrap;">
                                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email"
                                            Style="text-align: left; flex-shrink: 0; font-weight: bold;">Email</asp:Label>
                                        <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                            ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1"
                                            Style="color: red; margin-left: 5px; flex-shrink: 0;">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Email" runat="server"
                                            Style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr class="form-item">
                                    <td style="width: 50%; display: flex; align-items: center; justify-content: space-between; white-space: nowrap;">
                                        <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question"
                                            Style="text-align: left; flex-shrink: 0; font-weight: bold;">Câu hỏi bảo mật</asp:Label>
                                        <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                            ErrorMessage="Security question is required." ToolTip="Security question is required." ValidationGroup="CreateUserWizard1"
                                            Style="color: red; margin-left: 5px; flex-shrink: 0;">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Question" runat="server"
                                            Style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr class="form-item">
                                    <td style="width: 50%; display: flex; align-items: center; justify-content: space-between; white-space: nowrap;">
                                        <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer"
                                            Style="text-align: left; flex-shrink: 0; font-weight: bold;">Đáp án</asp:Label>
                                        <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                            ErrorMessage="Security answer is required." ToolTip="Security answer is required." ValidationGroup="CreateUserWizard1"
                                            Style="color: red; margin-left: 5px; flex-shrink: 0;">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Answer" runat="server"
                                            Style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="center" colspan="2" style="height: 16px; color: red; font-size: 1.6rem;">
                                        <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="Mật khẩu và mật khẩu xác nhận phải trùng khớp." ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <CustomNavigationTemplate>
                            <table border="0" cellspacing="5" style="width: 100%; height: 100%; border-spacing: 0;">
                                <tr>
                                    <td align="left" style="font-size: 1.4rem; color: #999;">Bạn đã có tài khoản?
                           
                                        <asp:HyperLink ID="lnkDangNhap" class="account_link" runat="server" NavigateUrl="DangNhap.aspx">Đăng nhập</asp:HyperLink>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Tạo tài khoản"
                                            ValidationGroup="CreateUserWizard1"
                                            CssClass="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" />
                                    </td>
                                </tr>
                            </table>
                        </CustomNavigationTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep runat="server">
                        <ContentTemplate>
                            <table >
                                <tr>
                                    <td class="account_heading" align="center">Đăng ký thành công</td>
                                </tr>
                                <tr>
                                    <td>
                                        <p class="account_text">Tài khoản của bạn đã được tạo thành công.</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="font-size: 1.4rem; color: #999;">Bạn đã có tài khoản?                          
                                        <asp:HyperLink ID="lnkDangNhap" class="account_link" runat="server" NavigateUrl="DangNhap.aspx">Đăng nhập</asp:HyperLink>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
            </asp:CreateUserWizard>
        </div>
    </div>
</asp:Content>

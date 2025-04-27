<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="GuiSP.aspx.cs" Inherits="FahasaWebsite.User.GuiSP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    Thông báo!
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid py-5">
        <div class="container py-5">
            <asp:Label ID="lblThongBao" runat="server" Style="font-size: 20px; line-height: 1.6;"></asp:Label>
        </div>
    </div>
</asp:Content>

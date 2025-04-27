<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="TroChuyen.aspx.cs" Inherits="FahasaWebsite.Admin.TroChuyen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="margin-top: 30px;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="row no-gutters">
                            <div class="col-lg-3 col-xl-2 border-right">
                                <div class="card-body border-bottom">
                                    <form>
                                        <input class="form-control" type="text" placeholder="Tìm kiếm">
                                    </form>
                                </div>
                                <div class="scrollable position-relative" style="height: calc(100vh - 111px);">
                                    <ul class="mailbox list-style-none">
                                        <li>
                                            <div class="message-center">
                                                <!-- Message -->
                                                <a href="javascript:void(0)"
                                                    class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                    <div class="user-img">
                                                        <img src="../UserTemplate/img/HinhKH/kh1.jpg"
                                                            alt="user" class="img-fluid rounded-circle"
                                                            width="40px">
                                                        <span
                                                            class="profile-status online float-right"></span>
                                                    </div>
                                                    <div class="w-75 d-inline-block v-middle pl-2">
                                                        <h6 class="message-title mb-0 mt-1">Nguyễn Văn Anh</h6>
                                                        <span
                                                            class="font-12 text-nowrap d-block text-muted text-truncate">Chủ nhật shop cũng mở bán bạn nhé.</span>
                                                        <span class="font-12 text-nowrap d-block text-muted">9:30
                                                                AM</span>
                                                    </div>
                                                </a>
                                                <!-- Message -->
                                                <a href="javascript:void(0)"
                                                    class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                    <div class="user-img">
                                                        <img src="../UserTemplate/img/HinhKH/kh2.jpg"
                                                            alt="user" class="img-fluid rounded-circle"
                                                            width="40px">
                                                        <span
                                                            class="profile-status busy float-right"></span>
                                                    </div>
                                                    <div class="w-75 d-inline-block v-middle pl-2">
                                                        <h6 class="message-title mb-0 mt-1">Trần Thị Bình</h6>
                                                        <span
                                                            class="font-12 text-nowrap d-block text-muted text-truncate">Chào shop!</span>
                                                        <span class="font-12 text-nowrap d-block text-muted">9:10
                                                                AM</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-lg-9  col-xl-10">
                                <div class="chat-box scrollable position-relative"
                                    style="height: calc(100vh - 111px);">
                                    <!--chat Row -->
                                    <ul class="chat-list list-style-none px-3 pt-3">
                                        <!--chat Row -->
                                        <li class="chat-item list-style-none mt-3">
                                            <div class="chat-img d-inline-block">
                                                <img
                                                    src="../UserTemplate/img/HinhKH/kh1.jpg" alt="user"
                                                    class="rounded-circle" width="45">
                                            </div>
                                            <div class="chat-content d-inline-block pl-3">
                                                <h6 class="font-weight-medium">Nguyễn Văn Anh</h6>
                                                <div class="msg p-2 d-inline-block mb-1">
                                                    Chủ nhật shop có mở cửa không ạ.
                                                </div>
                                            </div>
                                            <div class="chat-time d-block font-10 mt-1 mr-0 mb-3">
                                                10:56 am
                                               
                                            </div>
                                        </li>

                                        <!--chat Row -->
                                        <li class="chat-item odd list-style-none mt-3">
                                            <div class="chat-content text-right d-inline-block pl-3">
                                                <div class="box msg p-2 d-inline-block mb-1">
                                                    Chào bạn, cảm ơn bạn đã quan tâm đến Fahasa.
                                                </div>
                                                <br>
                                            </div>
                                        </li>
                                        <!--chat Row -->
                                        <li class="chat-item odd list-style-none mt-3">
                                            <div class="chat-content text-right d-inline-block pl-3">
                                                <div class="box msg p-2 d-inline-block mb-1 box">
                                                    Chủ nhật Fahasa cũng mở bán bạn nhé.
                                                </div>
                                                <br>
                                            </div>
                                            <div class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">
                                                10:59 am
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card-body border-top">
                                    <div class="row">
                                        <div class="col-9">
                                            <div class="input-field mt-0 mb-0">
                                                <input id="textarea1" placeholder="Nhập tin nhắn..."
                                                    class="form-control border-0" type="text">
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <a class="btn-circle btn-lg btn-cyan float-right text-white"
                                                href="javascript:void(0)"><i class="fas fa-paper-plane"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Container fluid  -->

    </div>
</asp:Content>

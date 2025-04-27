CREATE DATABASE Fahasa_Website
GO


USE Fahasa_Website
GO


CREATE TABLE TaiKhoan
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaTK AS RIGHT('00000' + CAST(ID AS VARCHAR(5)), 5) PERSISTED,
	TenDangNhap NVARCHAR(30) NOT NULL,
    MatKhau VARCHAR(30) NOT NULL,
	LoaiTK NVARCHAR(10)
		CONSTRAINT CK_TAIKHOAN_LOAITK CHECK (LoaiTK IN (N'Quản lý', N'Khách hàng')),
	MaKH INT  
		CONSTRAINT FK_KhachHang_MaKH FOREIGN KEY(MaKH) REFERENCES KhachHang(ID),
	MaNV INT  
		CONSTRAINT FK_NhanVien_MaNV FOREIGN KEY(MaNV) REFERENCES NhanVien(ID)
)
GO

CREATE TABLE KhachHang
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaKH AS RIGHT('0000000000' + CAST(ID AS VARCHAR(10)), 10) PERSISTED,
	HoKH NVARCHAR(30) NOT NULL,
    TenKH NVARCHAR(7) NOT NULL,
	NgSinhKH DATETIME,
	GioiTinhKH NVARCHAR(3)
		CONSTRAINT CK_KHACHHANG_GioiTinhKH CHECK (GioiTinhKH IN (N'Nam', N'Nữ')),
	SdtKH VARCHAR(10) NOT NULL,
	EmailKH VARCHAR(50) CHECK (EmailKH LIKE '%_@__%.__%'),
	TinhKH NVARCHAR(50),
	QuanKH NVARCHAR(50),
	PhuongKH NVARCHAR(50),
	DiaChiKH NVARCHAR(50),	
	Avatar VARCHAR(100) 
)
GO

CREATE TABLE ChiNhanh
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaCN AS RIGHT('00000' + CAST(ID AS VARCHAR(5)), 5) PERSISTED,
	TenCN NVARCHAR(50) NOT NULL,
	SdtCN VARCHAR(10) NOT NULL,
	DiaChiCN NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE KhuyenMai
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaKM AS RIGHT('0000' + CAST(ID AS VARCHAR(4)), 4) PERSISTED,
	TenKM NVARCHAR(100),
	TiLeGiam FLOAT,
	NgayApDung DATETIME,
	NgayKetThuc DATETIME,
	DieuKien NVARCHAR(100)
)
GO

CREATE TABLE NhaCungCap (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaNCC AS RIGHT('00000' + CAST(ID AS VARCHAR(5)), 5) PERSISTED,
	TenNCC NVARCHAR(100),
	DiaChiNCC NVARCHAR(200),
	SdtNCC VARCHAR(10),
	EmailNCC VARCHAR(100),
 	Website VARCHAR(200)
)
GO


CREATE TABLE NhanVien
(	
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaNV AS RIGHT('000000' + CAST(ID AS VARCHAR(6)), 6) PERSISTED,
	HoNV NVARCHAR(30) NOT NULL,
	TenNV NVARCHAR(7) NOT NULL,
	NgSinhNV DATE NOT NULL,
	GioiTinhNV NVARCHAR(3) NOT NULL
		CONSTRAINT CK_NHANVIEN_GioiTinhNV CHECK (GioiTinhNV IN (N'Nam', N'Nữ')), 
	CCCD CHAR(12) NOT NULL UNIQUE, 
	SdtNV VARCHAR(10) NOT NULL,
	EmailNV VARCHAR(50) NOT NULL CHECK (EmailNV LIKE '%_@__%.__%'),	
	TinhNV NVARCHAR(50) NOT NULL,
	QuanNV NVARCHAR(50) NOT NULL,
	PhuongNV NVARCHAR(50) NOT NULL,
	DiaChiNV NVARCHAR(50) NOT NULL,
	NgayVaoLam DATE NOT NULL
		CONSTRAINT CK_NHANVIEN_NgayVaoLam CHECK (NgayVaoLam <= GETDATE()),
	MaCN INT
		CONSTRAINT FK_NHANVIEN_MaCN FOREIGN KEY (MaCN) REFERENCES ChiNhanh(ID)
)
GO

CREATE TABLE NhomSP
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaNhomSP AS RIGHT('000' + CAST(ID AS VARCHAR(3)), 3) PERSISTED,
	TenNhomSP NVARCHAR(50) NOT NULL,
	GhiChu NVARCHAR(100)
)
GO

CREATE TABLE LoaiSP
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaLoaiSP AS RIGHT('000' + CAST(ID AS VARCHAR(3)), 3) PERSISTED,
	TenLoaiSP NVARCHAR(50) NOT NULL,
	GhiChu NVARCHAR(100),
	MaNhomSP INT  
		CONSTRAINT FK_LoaiSP_MaNhomSP FOREIGN KEY(MaNhomSP) REFERENCES NhomSP(ID)
)
GO

CREATE TABLE SanPham
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaSP AS RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED,
	TenSP NVARCHAR(100) NOT NULL,
	GiaNhap FLOAT NOT NULL,
	GiaBan FLOAT NOT NULL,
	NhaXuatBan NVARCHAR(100),
	NamXuatBan INT,
	TacGia NVARCHAR(50),
	TrongLuong NVARCHAR(30),
	KichThuoc NVARCHAR(30),
	HinhSP VARCHAR(100),
	NgayThem DATETIME,
	MoTa NVARCHAR(MAX),
	SoLuongTon INT,
	MaLoaiSP INT  
		CONSTRAINT FK_SanPham_MaLoaiSP FOREIGN KEY(MaLoaiSP) REFERENCES LoaiSP(ID),	
	MaKM INT
		CONSTRAINT FK_SanPham_MaKM FOREIGN KEY(MaKM) REFERENCES KhuyenMai(ID),	
	MaNCC INT
		CONSTRAINT FK_SanPham_MaNCC FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(ID)
)
GO

CREATE TABLE DonHang
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	MaDH AS RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED,
	NgayDatHang DATETIME NOT NULL,
	NgayGiaoHang DATETIME,
	PTVanChuyen NVARCHAR(100),
	PTTT NVARCHAR(50),
	TinhTrang NVARCHAR(30) CHECK (TinhTrang IN (N'Đang xử lý', N'Đang giao hàng', N'Giao hàng thành công')),
	MaKH INT REFERENCES KhachHang(ID),
	MaNV INT REFERENCES NhanVien(ID),
	MaCN INT REFERENCES ChiNhanh(ID),
	MaKM INT REFERENCES KhuyenMai(ID),
	TenNguoiNhan NVARCHAR(50) NOT NULL,
	SdtNguoiNhan VARCHAR(10) NOT NULL,
	EmailNguoiNhan VARCHAR(50) CHECK (EmailNguoiNhan LIKE '%_@__%.__%'),
	TinhNguoiNhan NVARCHAR(50),
	QuanNguoiNhan NVARCHAR(50),
	PhuongNguoiNhan NVARCHAR(50),
	DiaChiNhan NVARCHAR(50),
	GhiChu NVARCHAR(MAX)
)
GO


CREATE TABLE CTDonHang
(
	MaDH INT NOT NULL REFERENCES DonHang(ID),
	MaSP INT NOT NULL REFERENCES SanPham(ID),
	SoLuong INT NOT NULL,
	CONSTRAINT PK_CTDONHANG PRIMARY KEY (MaDH, MaSP)
)
GO

CREATE TABLE DanhGiaChung (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaKH INT NOT NULL REFERENCES KHACHHANG(ID),
    BinhLuan NVARCHAR(500),
    DiemDanhGia FLOAT,
	ThoiGian DATETIME
)
GO


CREATE TABLE DanhGiaSP (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaKH INT NOT NULL REFERENCES KhachHang(ID),
	MaSP INT NOT NULL REFERENCES SanPham(ID),
    BinhLuan NVARCHAR(MAX),
    DiemDanhGia FLOAT,
	ThoiGian DATETIME
)
GO



INSERT INTO KhachHang (HoKH, TenKH, GioiTinhKH, NgSinhKH, EmailKH, SdtKH, DiaChiKH, PhuongKH, QuanKH, TinhKH) VALUES
(N'Nguyễn Văn', N'Anh', N'Nam', '1990-01-15', N'nguyenvananh@email.com', N'0123456789', N'123 Đường Lê Lợi', N'Phường 1', N'Quận 5', N'TP. Hồ Chí Minh'),
(N'Trần Thị', N'Bình', N'Nữ', '1985-05-22', N'tranthibinh@email.com', N'0987654321', N'456 Đường Nguyễn Huệ', N'Phường 2', N'Quận 10', N'TP. Hồ Chí Minh'),
(N'Lê Văn', N'Cường', N'Nam', '1992-03-10', N'levancuong@email.com', N'0901234567', N'789 Đường Nam Kỳ Khởi Nghĩa', N'Phường 3', N'Quận 3', N'TP. Hồ Chí Minh'),
(N'Phạm Thị Diệu', N'Linh', N'Nữ', '1988-07-05', N'phamthidieulinh@email.com', N'0912345678', N'101 Đường Trần Hưng Đạo', N'Phường 4', N'Quận 1', N'TP. Hồ Chí Minh'),
(N'Huỳnh Văn', N'Đức', N'Nam', '1995-11-20', N'huynhvanduc@email.com', N'0876543210', N'202 Đường Cách Mạng Tháng Tám', N'Phường 5', N'Quận Bình Thạnh', N'TP. Hồ Chí Minh'),
(N'Đặng Thị Mai', N'Anh', N'Nữ', '1983-09-18', N'dangthimaianh@email.com', N'0956789012', N'303 Đường Nguyễn Văn Linh', N'Phường 6', N'Quận 7', N'TP. Hồ Chí Minh'),
(N'Trần Thị Kim', N'Oanh', N'Nữ', '1998-04-25', N'tranthikimoanh@email.com', N'0888777666', N'404 Đường Võ Văn Kiệt', N'Phường 7', N'Quận 4', N'TP. Hồ Chí Minh'),
(N'Mai Thị', N'Phương', N'Nữ', '1993-12-30', N'maithiphuong@email.com', N'0945454545', N'505 Đường Lý Thường Kiệt', N'Phường 8', N'Quận 6', N'TP. Hồ Chí Minh'),
(N'Võ Văn', N'Tuấn', N'Nam', '1989-06-08', N'vovantuan@email.com', N'0123456789', N'606 Đường 3 Tháng 2', N'Phường 9', N'Quận 10', N'TP. Hồ Chí Minh'),
(N'Nguyễn Thị Quỳnh', N'Anh', N'Nữ', '1984-02-14', N'nguyenthiquynhanh@email.com', N'0987654321', N'707 Đường Cộng Hòa', N'Phường 10', N'Quận Tân Bình', N'TP. Hồ Chí Minh'),
(N'Hoàng Văn', N'Nam', N'Nam', '1991-08-03', N'hoangvannam@email.com', N'0123456789', N'808 Đường Hòa Bình', N'Phường 11', N'Quận Gò Vấp', N'TP. Hồ Chí Minh'),
(N'Lê Thị Thùy', N'Trang', N'Nữ', '1986-10-12', N'lethithuytrang@email.com', N'0987654321', N'909 Đường Tân Bình', N'Phường 12', N'Quận Tân Phú', N'TP. Hồ Chí Minh'),
(N'Nguyễn Văn', N'Long', N'Nam', '1994-07-28', N'nguyenvanlong@email.com', N'0901234567', N'1010 Đường 3/2', N'Phường 13', N'Quận 3', N'TP. Hồ Chí Minh'),
(N'Trần Thị', N'Mai', N'Nữ', '1987-04-17', N'tranthimai@email.com', N'0912345678', N'1111 Đường Bình Thạnh', N'Phường 14', N'Quận Bình Thạnh', N'TP. Hồ Chí Minh'),
(N'Phan Văn', N'Hòa', N'Nam', '1997-01-09', N'phanvanhoa@email.com', N'0876543210', N'1212 Đường Phú Nhuận', N'Phường 15', N'Quận Phú Nhuận', N'TP. Hồ Chí Minh'),
(N'Hồ Thị', N'Thảo', N'Nữ', '1982-11-05', N'hothithao@email.com', N'0956789012', N'1313 Đường 30/4', N'Phường 16', N'Quận 8', N'TP. Hồ Chí Minh'),
(N'Lý Văn', N'Minh', N'Nam', '1988-06-21', N'lyvanminh@email.com', N'0888777666', N'1414 Đường 1/5', N'Phường 17', N'Quận 9', N'TP. Hồ Chí Minh'),
(N'Mai Thị', N'Hoài', N'Nữ', '1993-03-26', N'maithihoai@email.com', N'0945454545', N'1515 Đường 2/9', N'Phường 18', N'Quận 10', N'TP. Hồ Chí Minh'),
(N'Vương Văn', N'Phú', N'Nam', '1984-09-13', N'vuongvanphu@email.com', N'0123456789', N'1616 Đường 1/7', N'Phường 19', N'Quận 11', N'TP. Hồ Chí Minh'),
(N'Nguyễn Thị', N'Thu', N'Nữ', '1990-05-30', N'nguyenthithu@email.com', N'0987654321', N'1717 Đường 2/4', N'Phường 20', N'Quận 12', N'TP. Hồ Chí Minh');
GO


INSERT INTO KhuyenMai (TenKM, TiLeGiam, NgayApDung, NgayKetThuc) VALUES
(N'Khuyến mãi mùa hè', 15.5, '2023-06-01', '2023-08-31'),
(N'Ưu đãi cuối năm', 20, '2023-11-01', '2023-12-31'),
(N'Tiệc giảm giá tháng 5', 10, '2023-05-01', '2023-05-31'),
(N'Chào mừng năm mới', 25, '2024-01-01', '2024-01-31'),
(N'Khuyến mãi tựu trường', 18.5, '2023-09-15', '2023-10-15'),
(N'Giảm giá Black Friday', 30, '2023-11-25', '2023-11-27'),
(N'Ưu đãi sinh nhật', 15, '2023-03-10', '2023-03-15'),
(N'Khuyến mãi Valentine', 12, '2023-02-01', '2023-02-14'),
(N'Tiệc hóa trang Halloween', 22.5, '2023-10-28', '2023-10-31'),
(N'Khuyến mãi đặc biệt cuối năm', 18, '2023-12-15', '2023-12-31');
GO


INSERT INTO NhomSP(TenNhomSP) VALUES
(N'Văn học'),
(N'Kinh tế'),
(N'Tâm lý - Kỹ năng sống'),
(N'Sách thiếu nhi'),
(N'Giáo khoa - Tham khảo'),
(N'Sách học ngoại ngữ');
GO


INSERT INTO LoaiSP (TenLoaiSP, MaNhomSP) VALUES
(N'Tiểu thuyết', 1),
(N'Truyện ngắn - Tản văn', 1),
(N'Truyện trinh thám - Kiếm hiệp', 1),
(N'Ngôn tình', 1),
(N'Thơ ca', 1),
(N'Quản trị - Lãnh đạo', 2),
(N'Marketing - Bán hàng', 2),
(N'Khởi nghiệp - Làm giàu', 2),
(N'Phân tích kinh tế', 2),
(N'Tài chính - Ngân hàng', 2),
(N'Kỹ năng sống', 3),
(N'Tâm lý', 3),
(N'Rèn luyện nhân cách', 3),
(N'Hạt giống tâm hồn', 3),
(N'Manga - Comic', 4),
(N'Kiến thức bách khoa', 4),
(N'Sách giáo khoa', 5),
(N'Sách tham khảo', 5),
(N'Tiếng Anh', 6),
(N'Tiếng Nhật', 6),
(N'Tiếng Hàn', 6);
GO


INSERT INTO NhaCungCap (TenNCC) VALUES
(N'Nhã Nam'),
(N'NXB Trẻ'),
(N'Alpha Books'),
(N'Thái Hà'),
(N'Skybooks'),
(N'Cty Bán Lẻ Phương Nam');
GO



INSERT INTO SanPham (MaLoaiSP, TenSP, GiaBan, MaNCC, NhaXuatBan, NamXuatBan, TacGia, HinhSP, NgayThem, MaKM, MoTa) VALUES
(1, N'Cây Cam Ngọt Của Tôi', 108000, 1, N'NXB Hội Nhà Văn', 2020, 'José Mauro de Vasconcelos', '/UserTemplate/img/HinhSP/001.png', '2024-12-30', 5, N'“Vị chua chát của cái nghèo hòa trộn với vị ngọt ngào khi khám phá ra những điều khiến cuộc đời này đáng sống... một tác phẩm kinh điển của Brazil.” “Một cách nhìn cuộc sống gần như hoàn chỉnh từ con mắt trẻ thơ… có sức mạnh sưởi ấm và làm tan nát cõi lòng, dù người đọc ở lứa tuổi nào.”'),
(1, N'Ngày Xưa Có Một Chuyện Tình', 135000, 2, N'NXB Trẻ', 2024, 'Nguyễn Nhật Ánh', '/UserTemplate/img/HinhSP/002.png', '2024-12-30', 5, N'NGÀY XƯA CÓ MỘT CHUYỆN TÌNH là tác phẩm mới tinh thứ 2 trong năm 2016 của nhà văn Nguyễn Nhật Ánh dài hơn 300 trang, được coi là tập tiếp theo của tập truyện Mắt biếc. Có một tình yêu dữ dội, với em, của một người yêu em hơn chính bản thân mình - là anh. Ngày xưa có một chuyện tình có phải là một câu chuyện cảm động khi người ta yêu nhau, nỗi khát khao một hạnh phúc êm đềm ấm áp đến thế; hay đơn giản chỉ là chuyện ba người - anh, em, và người ấy…?'),
(1, N'Mùa Hè Không Tên', 130000, 2, N'NXB Trẻ', 2023, N'Nguyễn Nhật Ánh', '/UserTemplate/img/HinhSP/003.png', '2025-02-15', 3, N'“Mùa hè không tên” là truyện dài mới nhất của nhà văn Nguyễn Nhật Ánh, với những câu chuyện tuổi thơ với vô số trò tinh nghịch, những thoáng thinh thích hồi hộp cùng vô vàn kỷ niệm. Để rồi khi những tháng ngày trong sáng của tình bạn dần qua, bọn nhỏ trong mỗi gia đình bình dị lớn lên cùng chứng kiến những giây phút cảm động của câu chuyện tình thân, nỗi khát khao hạnh phúc êm đềm, cùng bỡ ngỡ bước vào tuổi lớn nhiều yêu thương mang cả màu va vấp.'),
(1, N'Có Hai Con Mèo Ngồi Bên Cửa Sổ', 100000, 2, N'NXB Trẻ', 2023, N'Nguyễn Nhật Ánh', '/UserTemplate/img/HinhSP/004.png', '2025-02-15', 4, N'CÓ HAI CON MÈO NGỒI BÊN CỬA SỔ là tác phẩm đầu tiên của nhà văn Nguyễn Nhật Ánh viết theo thể loại đồng thoại. Đặc biệt hơn nữa là viết về tình bạn của hai loài vốn là thù địch của nhau mèo và chuột. Đó là tình bạn giữa mèo Gấu và chuột Tí Hon.'),
(1, N'Mắt Biếc', 43000, 2, N'NXB Trẻ', 2022, N'Nguyễn Nhật Ánh', '/UserTemplate/img/HinhSP/005.png', '2022-08-15', 1, N'Bởi sự trong sáng của một tình cảm, bởi cái kết thúc rất, rất buồn khi suốt câu chuyện vẫn là những điều vui, buồn lẫn lộn (cái kết thúc không như mong đợi của mọi người). Cũng bởi, mắt biếc… năm xưa nay đâu (theo lời một bài hát)'),
(2, N'Hà Nội Nhớ Thương Của Tôi', 85000, 3, N'Hội Nhà Văn', 2024, N'Quan Thế Dân', '/UserTemplate/img/HinhSP/006.png', '2024-02-15', 6, N'Hà Nội Nhớ Thương Của Tôi là một hành trình đầy xúc cảm qua từng góc phố, từng mái nhà, và từng giai đoạn lịch sử của thủ đô Hà Nội. Cuốn sách là hồi ký sống động của tác giả Quan Thế Dân, kể lại những ký ức tuổi thơ, những biến cố lịch sử và xã hội đã làm nên diện mạo một Hà Nội đa sắc màu.'),
(2, N'Triệu Lá Thư Gửi Mẹ', 199000, 4, N'Công Thương', 2025, N'Mu Ye, You Ya', '/UserTemplate/img/HinhSP/007.png', '2025-02-16', 7, N'"Triệu Lá Thư Gửi Mẹ" là một tác phẩm đầy cảm xúc của nhà văn Mu Ye. Đây không chỉ là một cuốn sách, mà còn là một lời tri ân, một món quà tinh thần mà tác giả dành tặng cho mẹ mình – một người phụ nữ mù chữ chưa từng một ngày đến trường.'),
(2, N'Trốn Lên Mái Nhà Để Khóc', 76000, 5, N'Dân Trí', 2023, N'Lam', '/UserTemplate/img/HinhSP/008.png', '2025-02-16', 1, N'Những cơn gió heo may len lỏi vào từng góc phố nhỏ, mùa thu về gợi nhớ bao yêu thương đong đầy, bao xúc cảm dịu dàng của ký ức. Đó là nỗi nhớ đau đáu những hương vị quen thuộc của đồng nội, là hoài niệm bất chợt khi đi trên con đường cũ in dấu bao kỷ niệm... để rồi ta ước có một chuyến tàu kỳ diệu trở về những năm tháng ấy, trở về nơi nương náu bình yên sau những tháng ngày loay hoay để học cách trở thành một người lớn. Bạn sẽ được đắm mình trong những cảm xúc đẹp đẽ xen lẫn những tiếc nuối đầy lắng đọng trong “Trốn lên mái nhà đẻ khóc” của Lam. Có nhiều câu chuyện luôn nằm trong khảm sâu của ký ức… Ví như, hồi nhỏ vào ngày hạ sao giăng đầy trời, được nằm dưới hiên nhà cùng bà ngắm bầu trời đêm cùng chú cún cứ ve vẩy cái đuôi đến thích thú, Ví như khi lớn hơn một chút, cùng đám bạn nhỏ cùng làng rong ruổi khắp bờ đê thả diều nhảy dây dưới màu trời của hoàng hôn ấm áp, Ví như từng chiều nghe mùi cơm nếp thơm thoang thoảng cùng lời mẹ gọi về nơi đầu ngõ…'),
(2, N'Nếu Biết Trăm Năm Là Hữu Hạn', 119000, 6, N'Thế Giới', 2024, N'Phạm Lữ Ân', '/UserTemplate/img/HinhSP/009.png', '2025-01-07', 1, N'Nếu Biết Trăm Năm Là Hữu Hạn là tập hợp 40 bài viết nhẹ nhàng nhưng sâu sắc, giàu cảm xúc từ chuyên mục Cảm thức của Bán nguyệt san Sinh Viên Việt Nam. Cuốn sách dẫn dắt người đọc đi sâu vào những cảm nhận về cuộc đời, tình yêu, tình bạn và sự thành bại, đặt ra những câu hỏi mà ai cũng từng nghĩ đến nhưng ít ai dám đối diện:');
GO


INSERT INTO DanhGiaChung (MaKH, BinhLuan, DiemDanhGia, ThoiGian) VALUES 
('1', N'Nhân viên vui vẻ, hoà đồng. Sách thơm và mới.', 4.5, '2025-12-03'),
('2', N'Giao hàng nhanh. Có đa dạng sách.', 5, '2025-01-31'),
('3', N'Nhân viên vui vẻ, cởi mở.', 4, '2025-02-17');
GO

INSERT INTO DanhGiaSP (MaKH, MaSP, DiemDanhGia, ThoiGian, BinhLuan) VALUES 
('1', 5, 4.5, '2025-12-03', N'Quyển sách này đã khiến mình rơi nước mắt nhiều lần. Để nuôi dưỡng 1 đứa trẻ g cần thật nhiều bao dung, lắng nghe, chia sẻ và cần thật nhiều tình yêu chứ không phải là đòn roi và sự hờ hững, thiếu quan tâm. Thật may mắn cho Zeze khi trong đời em được gặp ông Bồ tốt bụng để em có thể sẻ chia mọi thứ và nhận được thật nhiều yêu thương và quan tâm để em được sống hồn nhiên với chính mình. Mình thích nhất là câu "Ai đã được sinh ra trên đời thì người đó đều xứng đáng" vì mình hồi nhỏ cũng đã từng rơi vào hoàn cảnh như vậy và cũng đã đặt câu hỏi "tại sao mình được sinh ra". Truyện ngọt ngào cảm động giúp nuôi dưỡng những cảm xúc về gia đình và cuộc sống.'),
('2', 7, 5, '2025-01-31', N'Hàng giao nhanh, đẹp, rẻ, hay, có chữ kí, có poster tranh, có bookmark siêu đẹp, cực kì nên mua, sách của Nguyễn Nhật Ánh rất hay'),
('3', 9, 4.5, '2025-02-17', N'Hà Lan là một cô gái đẹp Ngạn là một chàng trai si tình. Họ là người bạn của nhau từ bé qua năm tháng cái nhìn của Ngạn về Hà Lan cũng thay đổi dần trong mắt anh Hà Lan từ bao giờ đã lớn phổng phao trở thành một cô gái vô cùng xinh đẹp nhưng điều đấy không thu hút anh bằng đôi mắt của nàng. Cô nàng có đôi mắt biết đẹp đẽ có đôi mắt xanh tựa bầu trời có đôi mắt long lanh như vì sao đêm. Chàng yêu nàng nhưng chẳng dám nói hai người cùng nhau lên nên học trường cấp 3 trên huyện rời xa vòng tay gia đình hà lan dần thay đổi không còn trong sáng ngây thơ như trước cô yêu Dũng một chàng trai đã quyến rũ biết bao nhiêu cô gáirơi vào vòng vây ái tình chẳng mấy chốc Hà Lan có thai đó là một phần của sự việc nếu muốn biết cái cục như thế nào hãy nhớ đọc tiếp nhé cuốn sách này hay lắm đấy đừng bỏ lỡ à chất lượng sách siêu tốt luôn cả về nội dung và hình ảnh tuyệt vời');

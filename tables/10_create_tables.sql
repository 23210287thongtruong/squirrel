CREATE TABLE KhachHang (
    KhachHangID VARCHAR NOT NULL PRIMARY KEY ,
    HoTen VARCHAR,
    DiaChi VARCHAR,
    SoDienThoai VARCHAR,
    Email VARCHAR,
    SinhNhat DATE, 
	DoanhSo MONEY DEFAULT 0,
	LoaiKH VARCHAR
);
CREATE TABLE PhongBan (
    PhongBanID VARCHAR NOT NULL PRIMARY KEY,
    TenPB VARCHAR
);

CREATE TABLE NhanVien (
    NhanVienID VARCHAR NOT NULL PRIMARY KEY,
    HoTen VARCHAR,
    NgaySinh DATE,
    PhongBan VARCHAR,
    ChucVu VARCHAR,
    NgayVaoLam DATE,
    DiaChi VARCHAR,
    SoDienThoai VARCHAR,
    Email VARCHAR,
    CONSTRAINT fk_phongban FOREIGN KEY (PhongBan) REFERENCES PhongBan(PhongBanID)
);
CREATE TABLE Kho (
    KhoID VARCHAR NOT NULL PRIMARY KEY,
    TenKho VARCHAR,
    DiaChi VARCHAR,
    SoDienThoai VARCHAR,
    QuanLykhoID VARCHAR,
	CONSTRAINT fk_quanlykho FOREIGN KEY (QuanLykhoID) REFERENCES NhanVien(NhanVienID)
);

-- Tạo bảng cha HangHoa
CREATE TABLE HangHoa (
    HangHoaID VARCHAR NOT NULL PRIMARY KEY,
    TenHangHoa VARCHAR,
	NgayRaMat DATE,
    NhaSanXuat VARCHAR,
    MucThueGTGT INT,
    Gia MONEY,
    SoLuongTonKho INT,
    KhoID VARCHAR,
	CONSTRAINT fk_kho FOREIGN KEY (KhoID) REFERENCES Kho(KhoID) 
);

-- Tạo bảng con DienThoai
CREATE TABLE DienThoai (
    KichThuocManHinh DECIMAL(3, 1), 
    BoNhoTrong INT,
    RAM INT, 
    DungLuongPin INT,
    HeDieuHanh VARCHAR,
    ThongSoCamera VARCHAR 
) INHERITS (HangHoa);

-- Tạo bảng con Laptop
CREATE TABLE Laptop (
    KichThuocManHinh DECIMAL(3, 1),
    CPU VARCHAR,
    RAM INT,
    DungLuongLuuTru VARCHAR,
    CardDoHoa VARCHAR,
    HeDieuHanh VARCHAR 
) INHERITS (HangHoa);

-- Tạo bảng con DongHo
CREATE TABLE DongHo (
    KichThuocManHinh DECIMAL(3, 2),
    DungLuongPin INT,
    KhaNangChongNuoc VARCHAR,
    HeDieuHanh VARCHAR, 
    KetNoi VARCHAR, 
    ChucNangTheoDoiSucKhoe VARCHAR  
) INHERITS (HangHoa);

-- Tạo bảng con MayTinhBang
CREATE TABLE MayTinhBang (
    KichThuocManHinh DECIMAL(3, 2),
    DungLuongLuuTru VARCHAR,
    RAM INT,
    DungLuongPin INT,
    HeDieuHanh VARCHAR 
) INHERITS (HangHoa);

-- Tạo bảng con TaiNghe
CREATE TABLE TaiNghe (
    ThoiGianPin INT,
    CodayKhongDay VARCHAR,
    TinhNangDacBiet VARCHAR,
    KetNoi VARCHAR
) INHERITS (HangHoa);

CREATE TABLE CTGiamGia (
    MaCT VARCHAR NOT NULL PRIMARY KEY,
    HangHoaID VARCHAR NOT NULL,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    GiamGia INT  DEFAULT 0,
    CONSTRAINT fk_hanghoa FOREIGN KEY (HangHoaID) REFERENCES HangHoa(HangHoaID)
);

CREATE TABLE HoaDon (
    HoaDonID VARCHAR NOT NULL PRIMARY KEY,
    NgayLapHD DATE,
    KhachHangID VARCHAR DEFAULT NULL,
    NhanVienID VARCHAR,
    TongTien MONEY DEFAULT 0,
    CONSTRAINT fk_khachhang FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);

CREATE TABLE ChiTietHoaDon (
    HoaDonID VARCHAR NOT NULL,
    HangHoaID VARCHAR NOT NULL,
    MaCT VARCHAR,
    SoLuong INT,
    VoucherSinhNhat MONEY DEFAULT 0,
    ThanhTien MONEY,
    PRIMARY KEY (HoaDonID, HangHoaID),
    CONSTRAINT fk_mact FOREIGN KEY (MaCT) REFERENCES CTGiamGia(MaCT),
    CONSTRAINT fk_hoadon FOREIGN KEY (HoaDonID) REFERENCES HoaDon(HoaDonID),
    CONSTRAINT fk_hanghoa FOREIGN KEY (HangHoaID) REFERENCES HangHoa(HangHoaID)
);

CREATE TABLE ThongTinLuong (
    NgayHieuLuc DATE NOT NULL,
    NhanVienID VARCHAR NOT NULL,
    TruongNhom BOOLEAN,
    LuongCung MONEY DEFAULT 0,
    SoNguoiPhuThuoc INT DEFAULT 0,
    PRIMARY KEY (NgayHieuLuc, NhanVienID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);
CREATE TABLE LuongThang (
    KyLuong VARCHAR NOT NULL,
    NhanVienID VARCHAR NOT NULL,
    ThuongThamNien MONEY DEFAULT 0,
    PCSinhNhat MONEY DEFAULT 0,
    PCChucVu MONEY DEFAULT 0,
    NgayCong INT,
    ThuNhapChiuThue MONEY,
    ThuNhapTinhThue MONEY,
    ThueTNCN MONEY,
    BHXH MONEY,
    HoaHong MONEY DEFAULT 0,
    Phat MONEY DEFAULT 0,
    LuongThucNhan MONEY,
	PRIMARY KEY (KyLuong, NhanVienID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);

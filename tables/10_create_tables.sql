CREATE TABLE KhachHang
(
    KhachHangID VARCHAR NOT NULL PRIMARY KEY,
    HoTen       VARCHAR,
    DiaChi      VARCHAR,
    SoDienThoai VARCHAR,
    Email       VARCHAR,
    SinhNhat    DATE,
    DoanhSo     NUMERIC(15, 2) DEFAULT 0,
    LoaiKH      VARCHAR
);
CREATE TABLE PhongBan
(
    PhongBanID VARCHAR NOT NULL PRIMARY KEY,
    TenPB      VARCHAR
);

CREATE TABLE NhanVien
(
    NhanVienID  VARCHAR NOT NULL PRIMARY KEY,
    HoTen       VARCHAR,
    NgaySinh    DATE,
    PhongBan    VARCHAR,
    ChucVu      VARCHAR,
    NgayVaoLam  DATE,
    DiaChi      VARCHAR,
    SoDienThoai VARCHAR,
    Email       VARCHAR,
    CONSTRAINT fk_phongban FOREIGN KEY (PhongBan) REFERENCES PhongBan (PhongBanID)
);
CREATE TABLE Kho
(
    KhoID       VARCHAR NOT NULL PRIMARY KEY,
    TenKho      VARCHAR,
    DiaChi      VARCHAR,
    SoDienThoai VARCHAR,
    QuanLykhoID VARCHAR,
    CONSTRAINT fk_quanlykho FOREIGN KEY (QuanLykhoID) REFERENCES NhanVien (NhanVienID)
);

CREATE TABLE LoaiHangHoaCounter
(
    LoaiHangHoa   VARCHAR(50) PRIMARY KEY,
    Prefix        VARCHAR(2) NOT NULL,
    CurrentNumber INT DEFAULT 0
);

CREATE TABLE HangHoa
(
    HangHoaID     VARCHAR NOT NULL PRIMARY KEY,
    TenHangHoa    VARCHAR,
    NgayRaMat     DATE,
    NhaSanXuat    VARCHAR,
    MucThueGTGT   INT,
    Gia           NUMERIC(15, 2),
    SoLuongTonKho INT,
    KhoID         VARCHAR,
    LoaiHangHoa   VARCHAR,
    CONSTRAINT fk_kho FOREIGN KEY (KhoID) REFERENCES Kho (KhoID),
    CONSTRAINT fk_loaiHH FOREIGN KEY (LoaiHangHoa) REFERENCES LoaiHangHoaCounter (LoaiHangHoa)
);

CREATE TABLE CTGiamGia
(
    MaCT        VARCHAR NOT NULL PRIMARY KEY,
    HangHoaID   VARCHAR NOT NULL,
    NgayBatDau  DATE,
    NgayKetThuc DATE,
    GiamGia     INT DEFAULT 0,
    CONSTRAINT fk_hanghoa FOREIGN KEY (HangHoaID) REFERENCES HangHoa (HangHoaID)
);

CREATE TABLE HoaDon
(
    HoaDonID    VARCHAR NOT NULL PRIMARY KEY,
    NgayLapHD   DATE,
    KhachHangID VARCHAR        DEFAULT NULL,
    NhanVienID  VARCHAR,
    TongTien    NUMERIC(15, 2) DEFAULT 0,
    CONSTRAINT fk_khachhang FOREIGN KEY (KhachHangID) REFERENCES KhachHang (KhachHangID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien (NhanVienID)
);

CREATE TABLE ChiTietHoaDon
(
    HoaDonID  VARCHAR NOT NULL,
    HangHoaID VARCHAR NOT NULL,
    MaCT      VARCHAR,
    SoLuong   INT,
    ThanhTien NUMERIC(15, 2),
    PRIMARY KEY (HoaDonID, HangHoaID),
    CONSTRAINT fk_mact FOREIGN KEY (MaCT) REFERENCES CTGiamGia (MaCT),
    CONSTRAINT fk_hoadon FOREIGN KEY (HoaDonID) REFERENCES HoaDon (HoaDonID),
    CONSTRAINT fk_hanghoa FOREIGN KEY (HangHoaID) REFERENCES HangHoa (HangHoaID)
);

CREATE TABLE ThongTinLuong
(
    NgayHieuLuc     DATE    NOT NULL,
    NhanVienID      VARCHAR NOT NULL,
    TruongNhom      BOOLEAN,
    LuongCung       NUMERIC(15, 2) DEFAULT 0,
    SoNguoiPhuThuoc INT            DEFAULT 0,
    PRIMARY KEY (NgayHieuLuc, NhanVienID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien (NhanVienID)
);
CREATE TABLE LuongThang
(
    KyLuong         VARCHAR NOT NULL,
    NhanVienID      VARCHAR NOT NULL,
    ThuongThamNien  NUMERIC(15, 2) DEFAULT 0,
    PCSinhNhat      NUMERIC(15, 2) DEFAULT 0,
    PCChucVu        NUMERIC(15, 2) DEFAULT 0,
    NgayCong        INT,
    ThuNhapChiuThue NUMERIC(15, 2),
    ThuNhapTinhThue NUMERIC(15, 2),
    ThueTNCN        NUMERIC(15, 2),
    BHXH            NUMERIC(15, 2),
    HoaHong         NUMERIC(15, 2) DEFAULT 0,
    Phat            NUMERIC(15, 2) DEFAULT 0,
    LuongThucNhan   NUMERIC(15, 2),
    PRIMARY KEY (KyLuong, NhanVienID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien (NhanVienID)
);
create table kyluongNV (
	kyluong varchar primary key,
	tongluong numeric(15,2)
);
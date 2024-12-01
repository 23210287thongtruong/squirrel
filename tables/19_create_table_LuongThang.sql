CREATE TABLE LuongThang (
    KyLuong DATE NOT NULL, -- ChatGPT nói chỗ này ko set đc YYYY-MM
    NhanVienID VARCHAR NOT NULL,
    ThuongThamNien MONEY,
    PCSinhNhat MONEY,
    PCChucVu MONEY,
    NgayCong INT,
    ThuNhapChiuThue MONEY,
    ThuNhapTinhThue MONEY,
    ThueTNCN MONEY,
    BHXH MONEY,
    HoaHong MONEY,
    Phat MONEY,
    LuongThucNhan MONEY,
	PRIMARY KEY (KyLuong, NhanVienID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);


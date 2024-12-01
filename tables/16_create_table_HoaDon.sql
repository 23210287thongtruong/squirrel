CREATE TABLE HoaDon (
    HoaDonID VARCHAR NOT NULL PRIMARY KEY,
    NgayLapHD DATE,
    KhachHangID VARCHAR,
    NhanVienID VARCHAR,
    TongTien MONEY,
    CONSTRAINT fk_khachhang FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);


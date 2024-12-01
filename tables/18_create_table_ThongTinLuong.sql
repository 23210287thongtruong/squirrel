CREATE TABLE ThongTinLuong (
    NgayHieuLuc DATE NOT NULL,
    NhanVienID VARCHAR NOT NULL,
    TruongNhom BOOLEAN,
    LuongCung MONEY,
    SoNguoiPhuThuoc INT,
    PRIMARY KEY (NgayHieuLuc, NhanVienID),
    CONSTRAINT fk_nhanvien FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);
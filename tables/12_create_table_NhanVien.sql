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
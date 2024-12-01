CREATE TABLE ChiTietHoaDon (
    HoaDonID VARCHAR NOT NULL,
    HangHoaID VARCHAR NOT NULL,
    MaCT VARCHAR,
    SoLuong INT,
    VoucherSinhNhat MONEY,
    ThanhTien MONEY,
    PRIMARY KEY (HoaDonID, HangHoaID),
    CONSTRAINT fk_mact FOREIGN KEY (MaCT) REFERENCES CTGiamGia(MaCT),
    CONSTRAINT fk_hoadon FOREIGN KEY (HoaDonID) REFERENCES HoaDon(HoaDonID),
    CONSTRAINT fk_hanghoa FOREIGN KEY (HangHoaID) REFERENCES HangHoa(HangHoaID)
);
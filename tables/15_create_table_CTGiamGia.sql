CREATE TABLE CTGiamGia (
    MaCT VARCHAR NOT NULL PRIMARY KEY,
    HangHoaID VARCHAR NOT NULL,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    GiamGia INT,
    CONSTRAINT fk_hanghoa FOREIGN KEY (HangHoaID) REFERENCES HangHoa(HangHoaID)
);


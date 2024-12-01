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
CREATE TABLE DienThoai (
    KichThuocManHinh DECIMAL(3, 1), 
    BoNhoTrong INT,
    RAM INT, 
    DungLuongPin INT,
    HeDieuHanh VARCHAR,
    ThongSoCamera VARCHAR 
) INHERITS (HangHoa);
CREATE TABLE Laptop (
    KichThuocManHinh DECIMAL(3, 1),
    CPU VARCHAR,
    RAM INT,
    DungLuongLuuTru VARCHAR,
    CardDoHoa VARCHAR,
    HeDieuHanh VARCHAR 
) INHERITS (HangHoa);
CREATE TABLE DongHo (
    KichThuocManHinh DECIMAL(3, 2),
    DungLuongPin INT,
    KhaNangChongNuoc VARCHAR,
    HeDieuHanh VARCHAR, 
    KetNoi VARCHAR, 
    ChucNangTheoDoiSucKhoe VARCHAR  
) INHERITS (HangHoa);
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
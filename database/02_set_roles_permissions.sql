-- Giám đốc
CREATE ROLE GiamDoc WITH LOGIN SUPERUSER CREATEDB CREATEROLE;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO GiamDoc;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO GiamDoc;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO GiamDoc;
GRANT CREATE ON SCHEMA public TO GiamDoc;
CREATE USER nv01 WITH PASSWORD 'mk_nv01';
GRANT GiamDoc TO nv01;
-- Phó Giám đốc
CREATE ROLE PhoGiamDoc WITH LOGIN CREATEROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE KhachHang, NhanVien, CTGiamGia, HoaDon, ChiTietHoaDon, Kho, LoaiHangHoaCounter, PhongBan TO PhoGiamDoc;
GRANT SELECT ON TABLE ThongTinLuong, HangHoa, LuongThang TO PhoGiamDoc;
CREATE USER nv03 WITH PASSWORD 'mk_nv03';
GRANT PhoGiamDoc TO nv03;

-- Cửa hàng trưởng
CREATE ROLE CuaHangTruong WITH LOGIN;
GRANT SELECT ON TABLE KhachHang, HangHoa, CTGiamGia, HoaDon, ChiTietHoaDon, Kho TO CuaHangTruong;
GRANT INSERT, UPDATE, DELETE ON TABLE KhachHang, HoaDon, ChiTietHoaDon TO CuaHangTruong;
CREATE USER nv08 WITH PASSWORD 'mk_nv08';
GRANT CuaHangTruong TO nv08;
CREATE USER nv09 WITH PASSWORD 'mk_nv09';
GRANT CuaHangTruong TO nv09;
CREATE USER nv19 WITH PASSWORD 'mk_nv19';
GRANT CuaHangTruong TO nv19;
-- Nhân viên bán hàng
CREATE ROLE NhanVienBanHang WITH LOGIN;
GRANT SELECT ON TABLE KhachHang, HangHoa, CTGiamGia, HoaDon, ChiTietHoaDon, Kho TO NhanVienBanHang;
GRANT INSERT ON TABLE KhachHang, HoaDon, ChiTietHoaDon TO NhanVienBanHang;
GRANT UPDATE (HoTen, DiaChi, SoDienThoai, Email, SinhNhat) ON TABLE KhachHang TO NhanVienBanHang;
CREATE USER nv10 WITH PASSWORD 'mk_nv10';
GRANT NhanVienBanHang TO nv10;
CREATE USER nv11 WITH PASSWORD 'mk_nv11';
GRANT NhanVienBanHang TO nv11;
CREATE USER nv12 WITH PASSWORD 'mk_nv12';
GRANT NhanVienBanHang TO nv12;
CREATE USER nv13 WITH PASSWORD 'mk_nv13';
GRANT NhanVienBanHang TO nv13;
CREATE USER nv20 WITH PASSWORD 'mk_nv20';
GRANT NhanVienBanHang TO nv20;
CREATE USER nv23 WITH PASSWORD 'mk_nv23';
GRANT NhanVienBanHang TO nv23;
CREATE USER nv24 WITH PASSWORD 'mk_nv24';
GRANT NhanVienBanHang TO nv24;
CREATE USER nv25 WITH PASSWORD 'mk_nv25';
GRANT NhanVienBanHang TO nv25;
CREATE USER nv26 WITH PASSWORD 'mk_nv26';
GRANT NhanVienBanHang TO nv26;
CREATE USER nv29 WITH PASSWORD 'mk_nv29';
GRANT NhanVienBanHang TO nv29;
CREATE USER nv30 WITH PASSWORD 'mk_nv30';
GRANT NhanVienBanHang TO nv30;
CREATE USER nv31 WITH PASSWORD 'mk_nv31';
GRANT NhanVienBanHang TO nv31;
CREATE USER nv32 WITH PASSWORD 'mk_nv32';
GRANT NhanVienBanHang TO nv32;
CREATE USER nv33 WITH PASSWORD 'mk_nv33';
GRANT NhanVienBanHang TO nv33;
CREATE USER nv34 WITH PASSWORD 'mk_nv34';
GRANT NhanVienBanHang TO nv34;
CREATE USER nv35 WITH PASSWORD 'mk_nv35';
GRANT NhanVienBanHang TO nv35;
CREATE USER nv36 WITH PASSWORD 'mk_nv36';
GRANT NhanVienBanHang TO nv36;
CREATE USER nv37 WITH PASSWORD 'mk_nv37';
GRANT NhanVienBanHang TO nv37;
CREATE USER nv38 WITH PASSWORD 'mk_nv38';
GRANT NhanVienBanHang TO nv38;
CREATE USER nv39 WITH PASSWORD 'mk_nv39';
GRANT NhanVienBanHang TO nv39;
CREATE USER nv40 WITH PASSWORD 'mk_nv40';
GRANT NhanVienBanHang TO nv40;
CREATE USER nv45 WITH PASSWORD 'mk_nv45';
GRANT NhanVienBanHang TO nv45;
CREATE USER nv46 WITH PASSWORD 'mk_nv46';
GRANT NhanVienBanHang TO nv46;

-- Trưởng phòng kế toán
CREATE ROLE TruongPhongKeToan WITH LOGIN;
GRANT SELECT (NhanVienID, HoTen, NgaySinh, PhongBan, ChucVu, NgayVaoLam) ON TABLE NhanVien TO TruongPhongKeToan;
GRANT SELECT ON TABLE ThongTinLuong, CTGiamGia, HoaDon, ChiTietHoaDon, LuongThang TO TruongPhongKeToan;
GRANT SELECT (HangHoaID, TenHangHoa, MucThueGTGT, Gia) ON TABLE HangHoa TO TruongPhongKeToan;
GRANT UPDATE (MucThueGTGT) ON TABLE HangHoa TO TruongPhongKeToan;
GRANT INSERT, UPDATE, DELETE ON TABLE LuongThang TO TruongPhongKeToan;
CREATE USER nv04 WITH PASSWORD 'mk_nv04';
GRANT TruongPhongKeToan TO nv04;
-- Nhân viên kế toán
CREATE ROLE NhanVienKeToan WITH LOGIN;
GRANT SELECT (NhanVienID, HoTen, NgaySinh, PhongBan, ChucVu, NgayVaoLam) ON TABLE NhanVien TO NhanVienKeToan;
GRANT SELECT ON TABLE ThongTinLuong, CTGiamGia, HoaDon, ChiTietHoaDon, LuongThang TO NhanVienKeToan;
GRANT SELECT (HangHoaID, TenHangHoa, MucThueGTGT, Gia) ON TABLE HangHoa TO NhanVienKeToan;
GRANT UPDATE (MucThueGTGT) ON TABLE HangHoa TO NhanVienKeToan;
GRANT INSERT, UPDATE ON TABLE LuongThang TO NhanVienKeToan;
CREATE USER nv14 WITH PASSWORD 'mk_nv14';
GRANT NhanVienKeToan TO nv14;
CREATE USER nv47 WITH PASSWORD 'mk_nv47';
GRANT NhanVienKeToan TO nv47;

-- Trưởng phòng kỹ thuật
CREATE ROLE TruongPhongKyThuat WITH LOGIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE HangHoa, CTGiamGia TO TruongPhongKyThuat;
CREATE USER nv07 WITH PASSWORD 'mk_nv07';
GRANT TruongPhongKyThuat TO nv07;
-- Nhân viên kỹ thuật
CREATE ROLE NhanVienKyThuat WITH LOGIN;
GRANT SELECT (HangHoaID, TenHangHoa, NgayRaMat, NhaSanXuat, Gia, LoaiHangHoa) ON TABLE HangHoa TO NhanVienKyThuat;
GRANT UPDATE (TenHangHoa, NgayRaMat, NhaSanXuat, Gia) ON TABLE HangHoa TO NhanVienKyThuat;
GRANT SELECT ON TABLE CTGiamGia TO NhanVienKyThuat;
GRANT UPDATE (HangHoaID, NgayBatDau, NgayKetThuc, GiamGia) ON TABLE CTGiamGia TO NhanVienKyThuat;
CREATE USER nv15 WITH PASSWORD 'mk_nv15';
GRANT NhanVienKyThuat TO nv15;
CREATE USER nv48 WITH PASSWORD 'mk_nv48';
GRANT NhanVienKyThuat TO nv48;

-- Trưởng phòng nhân sự
CREATE ROLE TruongPhongNhanSu WITH LOGIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE NhanVien, ThongTinLuong TO TruongPhongNhanSu;
CREATE USER nv05 WITH PASSWORD 'mk_nv05';
GRANT TruongPhongNhanSu TO nv05;
-- Chuyên viên nhân sự
CREATE ROLE ChuyenVienNhanSu WITH LOGIN;
GRANT SELECT ON TABLE NhanVien, ThongTinLuong TO ChuyenVienNhanSu;
GRANT UPDATE (HoTen, NgaySinh, PhongBan, ChucVu, NgayVaoLam, DiaChi, SoDienThoai, Email) ON TABLE NhanVien TO ChuyenVienNhanSu;
GRANT UPDATE ON TABLE ThongTinLuong TO ChuyenVienNhanSu;
CREATE USER nv22 WITH PASSWORD 'mk_nv22';
GRANT ChuyenVienNhanSu TO nv22;

-- Trưởng phòng bảo vệ
CREATE ROLE TruongPhongBaoVe WITH LOGIN;
GRANT SELECT (NhanVienID, HoTen, PhongBan ChucVu) ON TABLE NhanVien TO TruongPhongBaoVe;
GRANT SELECT (HangHoaID, TenHangHoa, NhaSanXuat, KhoID) ON TABLE HangHoa TO TruongPhongBaoVe;
GRANT SELECT ON TABLE Kho TO TruongPhongBaoVe;
CREATE USER nv17 WITH PASSWORD 'mk_nv17';
GRANT TruongPhongBaoVe TO nv17;
-- Bảo vệ
CREATE ROLE BaoVe WITH LOGIN;
GRANT SELECT (NhanVienID) ON TABLE NhanVien TO BaoVe;
GRANT SELECT (HangHoaID, TenHangHoa, NhaSanXuat, KhoID) ON TABLE HangHoa TO BaoVe;
GRANT SELECT ON TABLE Kho TO BaoVe;
CREATE USER nv02 WITH PASSWORD 'mk_nv02';
GRANT BaoVe TO nv02;
CREATE USER nv27 WITH PASSWORD 'mk_nv27';
GRANT BaoVe TO nv27;
CREATE USER nv28 WITH PASSWORD 'mk_nv28';
GRANT BaoVe TO nv28;
CREATE USER nv41 WITH PASSWORD 'mk_nv41';
GRANT BaoVe TO nv41;
CREATE USER nv42 WITH PASSWORD 'mk_nv42';
GRANT BaoVe TO nv42;
CREATE USER nv44 WITH PASSWORD 'mk_nv44';
GRANT BaoVe TO nv44;
CREATE USER nv50 WITH PASSWORD 'mk_nv50';
GRANT BaoVe TO nv50;

-- Trưởng phòng quản lý Kho
CREATE ROLE TruongPhongQuanLyKho WITH LOGIN;
GRANT SELECT ON TABLE HangHoa, Kho TO TruongPhongQuanLyKho;
GRANT INSERT, UPDATE, DELETE ON TABLE HangHoa TO TruongPhongQuanLyKho;
GRANT SELECT (NgayLapHD, HoaDonID) ON TABLE HoaDon TO TruongPhongQuanLyKho;
GRANT SELECT (HoaDonID, HangHoaID, SoLuong) ON TABLE ChiTietHoaDon TO TruongPhongQuanLyKho;
CREATE USER nv06 WITH PASSWORD 'mk_nv06';
GRANT TruongPhongQuanLyKho TO nv06;
CREATE USER nv16 WITH PASSWORD 'mk_nv16';
GRANT TruongPhongQuanLyKho TO nv16;
-- Quản lý Kho
CREATE ROLE QuanLyKho WITH LOGIN;
GRANT SELECT (HangHoaID, TenHangHoa, NhaSanXuat, SoLuongTonKho, KhoID) ON TABLE HangHoa TO QuanLyKho;
GRANT UPDATE (SoLuongTonKho) ON TABLE HangHoa TO QuanLyKho;
GRANT SELECT (NgayLapHD, HoaDonID) ON TABLE HoaDon TO QuanLyKho;
GRANT SELECT (HoaDonID, HangHoaID, SoLuong) ON TABLE ChiTietHoaDon TO QuanLyKho;
GRANT SELECT ON TABLE Kho TO QuanLyKho;
CREATE USER nv18 WITH PASSWORD 'mk_nv18';
GRANT QuanLyKho TO nv18;
CREATE USER nv21 WITH PASSWORD 'mk_nv21';
GRANT QuanLyKho TO nv21;

-- Nhân viên pháp lý
CREATE ROLE NhanVienPhapLy WITH LOGIN;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO NhanVienPhapLy;
CREATE USER nv43 WITH PASSWORD 'mk_nv43';
GRANT NhanVienPhapLy TO nv43;
CREATE USER nv49 WITH PASSWORD 'mk_nv49';
GRANT NhanVienPhapLy TO nv49;

-- Hạn chế quyền truy cập PUBIC
REVOKE CONNECT ON DATABASE Nhom29 FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;

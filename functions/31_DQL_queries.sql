-- In ra danh sách các sản phẩm (HangHoaID, TenHangHoa) do Samsung sản xuất
SELECT HangHoaID, TenHangHoa
FROM HangHoa
WHERE NhaSanXuat = 'Samsung';

-- In ra danh sách các sản phẩm (HangHoaID, TenHangHoa) thuộc loại "Điện thoại" có giá từ 5 đến 10 triệu VND
SELECT HangHoaID, TenHangHoa
FROM HangHoa
WHERE LoaiHangHoa = 'Điện thoại'
AND Gia BETWEEN 5000000 AND 10000000;

-- In ra các hóa đơn, tổng tiền hóa đơn bán ra trong tháng 1/2024, sắp xếp theo ngày và tổng tiền giảm dần
SELECT HoaDonID, NgayLapHD, TongTien
FROM HoaDon
WHERE EXTRACT(MONTH FROM NgayLapHD) = 1
AND EXTRACT(YEAR FROM NgayLapHD) = 2024
ORDER BY NgayLapHD ASC, TongTien DESC;

-- In ra danh sách khách hàng (KhachHangID, HoTen) có tổng giá trị hóa đơn trên 20 triệu VND trong năm 2024
SELECT KH.KhachHangID, KH.HoTen, SUM(HD.TongTien) AS TongChiTieu
FROM KhachHang KH
JOIN HoaDon HD ON KH.KhachHangID = HD.KhachHangID
WHERE EXTRACT(YEAR FROM HD.NgayLapHD) = 2024
GROUP BY KH.KhachHangID, KH.HoTen
HAVING SUM(HD.TongTien) > 20000000;

-- In ra danh sách sản phẩm (HangHoaID, TenHangHoa) không bán được trong năm 2024
SELECT HH.HangHoaID, HH.TenHangHoa
FROM HangHoa HH
WHERE HH.HangHoaID NOT IN (
    SELECT DISTINCT CTHD.HangHoaID
    FROM ChiTietHoaDon CTHD
    JOIN HoaDon HD ON CTHD.HoaDonID = HD.HoaDonID
    WHERE EXTRACT(YEAR FROM HD.NgayLapHD) = 2024
);

-- Tìm hóa đơn có mua ít nhất 3 sản phẩm khác nhau
SELECT HoaDonID, COUNT(DISTINCT HangHoaID) AS SoSanPhamKhacNhau
FROM ChiTietHoaDon
GROUP BY HoaDonID
HAVING COUNT(DISTINCT HangHoaID) >= 3;

-- Tìm nhân viên (NhanVienID, HoTen) có số hóa đơn bán hàng nhiều nhất trong năm 2024
WITH SoHoaDon AS (
    SELECT NhanVienID, COUNT(*) AS TongSoHoaDon
    FROM HoaDon
    WHERE EXTRACT(YEAR FROM NgayLapHD) = 2024
    GROUP BY NhanVienID
)
SELECT NV.NhanVienID, NV.HoTen, SHD.TongSoHoaDon
FROM NhanVien NV
JOIN SoHoaDon SHD ON NV.NhanVienID = SHD.NhanVienID
WHERE SHD.TongSoHoaDon = (SELECT MAX(TongSoHoaDon) FROM SoHoaDon);

-- Tìm sản phẩm (HangHoaID, TenHangHoa) có tổng số lượng bán ra thấp nhất trong năm 2024
WITH SoLuongBan AS (
    SELECT HangHoaID, SUM(SoLuong) AS TongSoLuong
    FROM ChiTietHoaDon CTHD
    JOIN HoaDon HD ON CTHD.HoaDonID = HD.HoaDonID
    WHERE EXTRACT(YEAR FROM HD.NgayLapHD) = 2024
    GROUP BY HangHoaID
)
SELECT HH.HangHoaID, HH.TenHangHoa, COALESCE(SL.TongSoLuong, 0) AS TongSoLuong
FROM HangHoa HH
LEFT JOIN SoLuongBan SL ON HH.HangHoaID = SL.HangHoaID
WHERE COALESCE(SL.TongSoLuong, 0) = (
    SELECT MIN(COALESCE(TongSoLuong, 0))
    FROM SoLuongBan
);

-- Tính doanh thu bán hàng theo từng tháng trong năm 2024
SELECT
    EXTRACT(MONTH FROM NgayLapHD) AS Thang,
    SUM(TongTien) AS DoanhThu
FROM HoaDon
WHERE EXTRACT(YEAR FROM NgayLapHD) = 2024
GROUP BY EXTRACT(MONTH FROM NgayLapHD)
ORDER BY Thang;

-- Tìm 3 khách hàng có tổng giá trị hóa đơn cao nhất (xếp hạng)
WITH ChiTieuKhachHang AS (
    SELECT
        KH.KhachHangID,
        KH.HoTen,
        SUM(HD.TongTien) AS TongChiTieu,
        DENSE_RANK() OVER (ORDER BY SUM(HD.TongTien) DESC) AS XepHang
    FROM KhachHang KH
    JOIN HoaDon HD ON KH.KhachHangID = HD.KhachHangID
    GROUP BY KH.KhachHangID, KH.HoTen
)
SELECT KhachHangID, HoTen, TongChiTieu, XepHang
FROM ChiTieuKhachHang
WHERE XepHang <= 3;

-- Hiệu quả của nhân viên bán hàng
WITH ThongSoBanHang AS (
    SELECT 
        NV.NhanVienID,
        NV.HoTen,
        COUNT(DISTINCT HD.HoaDonID) AS SoDonHang,
        SUM(HD.TongTien) AS DoanhSo,
        AVG(HD.TongTien) AS AvgDonHang,
        COUNT(DISTINCT HD.KhachHangID) AS SoKHMoi
    FROM NhanVien NV
    LEFT JOIN HoaDon HD ON NV.NhanVienID = HD.NhanVienID
    WHERE NV.PhongBan = 'PB2'
    GROUP BY NV.NhanVienID, NV.HoTen
)
SELECT 
    *,
    RANK() OVER (ORDER BY DoanhSo DESC) AS RankDanhSo,
    RANK() OVER (ORDER BY SoKHMoi DESC) AS RankSoKHMoi
FROM ThongSoBanHang
ORDER BY DoanhSo DESC;

-- Hiệu quả của kho
SELECT 
    Kho.KhoID,
    Kho.TenKho,
    COUNT(DISTINCT HH.HangHoaID) AS SoMatHang,
    SUM(HH.SoLuongTonKho) AS TongTonKho,
    SUM(HH.SoLuongTonKho * HH.Gia) AS GiaTriTonKho,
    COUNT(DISTINCT CTHD.HoaDonID) AS SoDonHang,
    SUM(CTHD.ThanhTien) AS DoanhThu
FROM Kho
LEFT JOIN HangHoa HH ON Kho.KhoID = HH.KhoID
LEFT JOIN ChiTietHoaDon CTHD ON HH.HangHoaID = CTHD.HangHoaID
GROUP BY Kho.KhoID, Kho.TenKho
ORDER BY DoanhThu DESC;

-- Top sản phẩm bán chạy và đóng góp doanh thu
SELECT 
    HH.HangHoaID,
    HH.TenHangHoa,
    HH.LoaiHangHoa,
    SUM(CTHD.SoLuong) AS TongSoLuongBan,
    SUM(CTHD.ThanhTien) AS TongDoanhThu,
    ROUND(SUM(CTHD.ThanhTien) * 100.0 / (SELECT SUM(TongTien) FROM HoaDon), 2) AS PhanTramDoanhThu
FROM HangHoa HH
JOIN ChiTietHoaDon CTHD ON HH.HangHoaID = CTHD.HangHoaID
GROUP BY HH.HangHoaID, HH.TenHangHoa, HH.LoaiHangHoa
ORDER BY TongDoanhThu DESC
LIMIT 10;

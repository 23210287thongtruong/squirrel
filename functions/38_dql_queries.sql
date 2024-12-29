-- KHOA
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
WITH NV_SoHoaDon AS (
    SELECT NhanVienID, COUNT(*) AS TongSoHoaDon
    FROM HoaDon
    WHERE EXTRACT(YEAR FROM NgayLapHD) = 2024
    GROUP BY NhanVienID
)
SELECT NV.NhanVienID, NV.HoTen, SHD.TongSoHoaDon
FROM NhanVien NV
JOIN NV_SoHoaDon SHD ON NV.NhanVienID = SHD.NhanVienID
WHERE SHD.TongSoHoaDon = (SELECT MAX(TongSoHoaDon) FROM NV_SoHoaDon);

-- Tìm sản phẩm (HangHoaID, TenHangHoa) có tổng số lượng bán ra thấp nhất trong năm 2024
WITH HH_SoLuongBan AS (
    SELECT HangHoaID, SUM(SoLuong) AS TongSoLuong
    FROM ChiTietHoaDon CTHD
    JOIN HoaDon HD ON CTHD.HoaDonID = HD.HoaDonID
    WHERE EXTRACT(YEAR FROM HD.NgayLapHD) = 2024
    GROUP BY HangHoaID
)
SELECT HH.HangHoaID, HH.TenHangHoa, SL.TongSoLuong AS TongSoLuong
FROM HangHoa HH
LEFT JOIN HH_SoLuongBan SL ON HH.HangHoaID = SL.HangHoaID
WHERE SL.TongSoLuong = (
    SELECT MIN(TongSoLuong)
    FROM HH_SoLuongBan
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
WITH KH_ChiTieu AS (
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
FROM KH_ChiTieu
WHERE XepHang <= 3;

-- Hiệu quả của nhân viên bán hàng
WITH NV_TongDoanhSo AS (
    SELECT
        NV.NhanVienID,
        NV.HoTen,
        COUNT(DISTINCT HD.HoaDonID) AS SoDonHang,
        COALESCE(SUM(HD.TongTien), 0) AS DoanhSo,
        COUNT(DISTINCT HD.KhachHangID) AS SoKhachHangMoi
    FROM NhanVien NV
    LEFT JOIN HoaDon HD ON NV.NhanVienID = HD.NhanVienID
    WHERE NV.PhongBan = 'PB2'
    GROUP BY NV.NhanVienID, NV.HoTen
)
SELECT
    *,
    RANK() OVER (ORDER BY DoanhSo DESC) AS RankDanhSo,
    RANK() OVER (ORDER BY SoKhachHangMoi DESC) AS RankSoKhachHangMoi
FROM NV_TongDoanhSo
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

-- Top 10 sản phẩm đóng góp doanh thu cao nhất
SELECT
    HH.HangHoaID,
    HH.TenHangHoa,
    HH.LoaiHangHoa,
    SUM(CTHD.SoLuong) AS TongSoLuongBan,
    SUM(CTHD.ThanhTien) AS TongDoanhThu,
    ROUND(SUM(CTHD.ThanhTien) * 100.0 / NULLIF((SELECT SUM(TongTien) FROM HoaDon), 0), 2) AS PhanTramDoanhThu
FROM HangHoa HH
JOIN ChiTietHoaDon CTHD ON HH.HangHoaID = CTHD.HangHoaID
GROUP BY HH.HangHoaID, HH.TenHangHoa, HH.LoaiHangHoa
ORDER BY TongDoanhThu DESC
LIMIT 10;

-- Phân tích hành vi mua hàng theo sản phẩm
WITH KH_TongChiTieu AS (
    SELECT
        KH.KhachHangID,
        HH.LoaiHangHoa,
        COUNT(*) AS SoLanMua,
        SUM(CTHD.ThanhTien) AS TongChiTieu
    FROM KhachHang KH
    JOIN HoaDon HD ON KH.KhachHangID = HD.KhachHangID
    JOIN ChiTietHoaDon CTHD ON HD.HoaDonID = CTHD.HoaDonID
    JOIN HangHoa HH ON CTHD.HangHoaID = HH.HangHoaID
    GROUP BY KH.KhachHangID, HH.LoaiHangHoa
)
SELECT
    LoaiHangHoa,
    COUNT(DISTINCT KhachHangID) AS SoKhachHang,
    SUM(SoLanMua) AS TongSoLanMua,
    SUM(TongChiTieu) AS TongDoanhThu
FROM KH_TongChiTieu
GROUP BY LoaiHangHoa
ORDER BY TongDoanhThu DESC;

-- Phân tích RFM
WITH
    KH_RFM_BangGiaTri AS (
        SELECT
            KH.KhachHangID,
            KH.HoTen,
            KH.Email,
            CURRENT_DATE - MAX(HD.NgayLapHD) AS SoNgayTuLanMuaCuoi,
            COUNT(HD.HoaDonID) AS SoLanMua,
            SUM(HD.TongTien) AS TongChiTieu
        FROM KHACHHANG KH
        JOIN HOADON HD ON KH.KhachHangID = HD.KhachHangID
        GROUP BY KH.KhachHangID, KH.HoTen, KH.Email
),
    KH_RFM_BangPhanTram AS (
        SELECT
            *,
            PERCENT_RANK() OVER (ORDER BY SoNgayTuLanMuaCuoi) AS R_PhanTram,
            PERCENT_RANK() OVER (ORDER BY SoLanMua) AS F_PhanTram,
            PERCENT_RANK() OVER (ORDER BY TongChiTieu) AS M_PhanTram
        FROM KH_RFM_BangGiaTri
),
    KH_RFM AS (
        SELECT
            *,
            CASE
                WHEN R_PhanTram <= 0.2 THEN 5
                WHEN R_PhanTram <= 0.4 THEN 4
                WHEN R_PhanTram <= 0.6 THEN 3
                WHEN R_PhanTram <= 0.8 THEN 2
                ELSE 1
            END AS R,
            CASE
                WHEN F_PhanTram <= 0.2 THEN 1
                WHEN F_PhanTram <= 0.4 THEN 2
                WHEN F_PhanTram <= 0.6 THEN 3
                WHEN F_PhanTram <= 0.8 THEN 4
                ELSE 5
            END AS F,
            CASE
                WHEN M_PhanTram <= 0.2 THEN 1
                WHEN M_PhanTram <= 0.4 THEN 2
                WHEN M_PhanTram <= 0.6 THEN 3
                WHEN M_PhanTram <= 0.8 THEN 4
                ELSE 5
            END AS M
        FROM KH_RFM_BangPhanTram
)
SELECT KhachHangID, HoTen, Email, SoNgayTuLanMuaCuoi, SoLanMua, TongChiTieu, CONCAT(R, F, M) AS RFM,
    CASE
        WHEN R >= 4 AND F >= 4 AND M >= 4 THEN 'Khách hàng chiến lược'
        WHEN R >= 3 AND F >= 3 AND M >= 3 THEN 'Khách hàng trung thành'
        WHEN R >= 2 AND F >= 2 AND M >= 2 THEN 'Khách hàng tiềm năng'
	WHEN R >= 2 OR F >= 2 OR M >= 2 THEN 'Khách hàng nguy hiểm'
        ELSE 'Khách hàng ít hoạt động'
    END AS XepLoai
FROM KH_RFM
ORDER BY TongChiTieu DESC;

-- TRÍ
-- 1. Tìm tất cả các hóa đơn có tổng tiền lớn hơn 20 triệu đồng.
SELECT HoaDonID, TongTien
FROM (
    SELECT HoaDonID, SUM(Gia * SoLuong) AS TongTien
    FROM ChiTietHoaDon
    INNER JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
    GROUP BY HoaDonID
) AS HoaDonTong
WHERE TongTien > 20000000;
-- 2. Tìm khách hàng đã thực hiện hóa đơn có giá trị cao nhất.
SELECT KhachHang.HoTen, KhachHang.KhachHangID, MAX(HOADONTONG.TongTien) AS GiaTriCaoNhat
FROM HoaDon
INNER JOIN (
    SELECT HoaDonID, SUM(Gia * SoLuong) AS TongTien
    FROM ChiTietHoaDon
    INNER JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
    GROUP BY HoaDonID
) AS HoaDonTong ON HoaDon.HoaDonID = HoaDonTong.HoaDonID
JOIN KhachHang ON HoaDon.KhachHangID = KhachHang.KhachHangID
GROUP BY KhachHang.HoTen, KhachHang.KhachHangID
ORDER BY GiaTriCaoNhat DESC
LIMIT 1;
-- 3. Tìm nhân viên lập hóa đơn nhiều nhất.
SELECT NhanVienID, COUNT(HoaDonID) AS SoHoaDon
FROM HoaDon
GROUP BY NhanVienID
ORDER BY SoHoaDon DESC
LIMIT 1;
-- 4. Tính doanh thu của từng nhà sản xuất.
SELECT HangHoa.NhaSanXuat, SUM(ChiTietHoaDon.SoLuong * HangHoa.Gia) AS DoanhThu
FROM ChiTietHoaDon
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
GROUP BY HangHoa.NhaSanXuat;
-- 5. Lấy thông tin khách hàng mua sản phẩm từ nhà sản xuất "Apple".
SELECT DISTINCT KhachHang.HoTen, KhachHang.DiaChi
FROM HoaDon
JOIN ChiTietHoaDon ON HoaDon.HoaDonID = ChiTietHoaDon.HoaDonID
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
JOIN KhachHang ON HoaDon.KhachHangID = KhachHang.KhachHangID
WHERE HangHoa.NhaSanXuat = 'Apple';
-- 6. Tìm sản phẩm bán chạy nhất.
SELECT HangHoa.TenHangHoa, SUM(ChiTietHoaDon.SoLuong) AS TongSoLuong
FROM ChiTietHoaDon
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
GROUP BY HangHoa.TenHangHoa
ORDER BY TongSoLuong DESC
LIMIT 1;
-- 7. Lấy thông tin về hóa đơn với sản phẩm được mua trong tháng 2 năm 2020.
SELECT DISTINCT HoaDon.HoaDonID, HoaDon.NgayLapHD, KhachHang.HoTen
FROM HoaDon
JOIN ChiTietHoaDon ON HoaDon.HoaDonID = ChiTietHoaDon.HoaDonID
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
JOIN KhachHang ON HoaDon.KhachHangID = KhachHang.KhachHangID
WHERE EXTRACT(MONTH FROM HoaDon.NgayLapHD) = 2 AND EXTRACT(YEAR FROM HoaDon.NgayLapHD) = 2020;
-- 8. Xác định sản phẩm nào mang lại doanh thu cao nhất cho từng nhà sản xuất.
SELECT HangHoa.NhaSanXuat, HangHoa.TenHangHoa, SUM(ChiTietHoaDon.SoLuong * HangHoa.Gia) AS DoanhThu
FROM ChiTietHoaDon
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
GROUP BY HangHoa.NhaSanXuat, HangHoa.TenHangHoa
ORDER BY DoanhThu DESC;
-- 9. Tìm khách hàng mua nhiều loại sản phẩm nhất.
SELECT KhachHang.HoTen, COUNT(DISTINCT HangHoa.LoaiHangHoa) AS SoLoaiSanPham
FROM HoaDon
JOIN ChiTietHoaDon ON HoaDon.HoaDonID = ChiTietHoaDon.HoaDonID
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
JOIN KhachHang ON HoaDon.KhachHangID = KhachHang.KhachHangID
GROUP BY KhachHang.HoTen
ORDER BY SoLoaiSanPham DESC
LIMIT 1;
-- 10. Tìm tổng doanh thu theo từng tháng trong năm 2020.
SELECT EXTRACT(MONTH FROM HoaDon.NgayLapHD) AS Thang, SUM(ChiTietHoaDon.SoLuong * HangHoa.Gia) AS TongDoanhThu
FROM HoaDon
JOIN ChiTietHoaDon ON HoaDon.HoaDonID = ChiTietHoaDon.HoaDonID
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
WHERE EXTRACT(YEAR FROM HoaDon.NgayLapHD) = 2020
GROUP BY Thang
ORDER BY Thang;
-- 11. Tìm tất cả hóa đơn có chứa sản phẩm "iPhone 11".
SELECT HoaDon.HoaDonID, HoaDon.NgayLapHD, KhachHang.HoTen
FROM HoaDon
JOIN ChiTietHoaDon ON HoaDon.HoaDonID = ChiTietHoaDon.HoaDonID
JOIN HangHoa ON ChiTietHoaDon.HangHoaID = HangHoa.HangHoaID
JOIN KhachHang ON HoaDon.KhachHangID = KhachHang.KhachHangID
WHERE HangHoa.TenHangHoa = 'iPhone 11';

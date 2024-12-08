
-- Hàm tính HoaHong:

CREATE FUNCTION CalculateHoaHong (v_NhanVienID VARCHAR, v_KyLuong DATE)
RETURNS MONEY
BEGIN
    DECLARE v_HoaHong MONEY DEFAULT 0;
    DECLARE v_DoanhSoTotal MONEY DEFAULT 0;

    -- Lấy tổng doanh thu bán hàng của nhân viên trong kỳ tính lương
    SELECT SUM(TongTien) INTO v_DoanhSoTotal
    FROM HoaDon
    WHERE NhanVienID = v_NhanVienID AND MONTH(NgayLapHD) = MONTH(v_KyLuong) AND YEAR(NgayLapHD) = YEAR(v_KyLuong);

    -- Tính hoa hồng theo các mức doanh thu
    IF v_DoanhSoTotal BETWEEN 20000000 AND 39999999 THEN
        SET v_HoaHong = v_DoanhSoTotal * 0.1;
    ELSEIF v_DoanhSoTotal BETWEEN 40000000 AND 59999999 THEN
        SET v_HoaHong = 20000000 * 0.1 + (v_DoanhSoTotal - 20000000) * 0.15;
    ELSEIF v_DoanhSoTotal BETWEEN 60000000 AND 99999999 THEN
        SET v_HoaHong = 20000000 * 0.1 + 20000000 * 0.15 + (v_DoanhSoTotal - 40000000) * 0.2;
    ELSEIF v_DoanhSoTotal >= 100000000 THEN
        SET v_HoaHong = 20000000 * 0.1 + 20000000 * 0.15 + 40000000 * 0.2 + (v_DoanhSoTotal - 60000000) * 0.25;
    END IF;

    RETURN v_HoaHong;
END;

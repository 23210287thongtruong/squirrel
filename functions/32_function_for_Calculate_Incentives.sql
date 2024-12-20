<<<<<<< Updated upstream
<<<<<<< Updated upstream

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
=======
=======
>>>>>>> Stashed changes


CREATE OR REPLACE FUNCTION CalculateHoaHong(v_NhanVienID VARCHAR, v_KyLuong VARCHAR)
RETURNS MONEY
LANGUAGE plpgsql
AS $$
DECLARE
    v_HoaHong MONEY := 0;
    v_DoanhSoTotal MONEY := 0;
    v_KyLuongDate DATE;
BEGIN
    -- Convert v_KyLuong to DATE
    v_KyLuongDate := TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD');

    -- Calculate total sales of the employee within the salary period
    SELECT COALESCE(SUM(TongTien::MONEY), 0::MONEY) INTO v_DoanhSoTotal
    FROM HoaDon
    WHERE NhanVienID = v_NhanVienID 
      AND EXTRACT(MONTH FROM NgayLapHD) = EXTRACT(MONTH FROM v_KyLuongDate) 
      AND EXTRACT(YEAR FROM NgayLapHD) = EXTRACT(YEAR FROM v_KyLuongDate);

    -- Calculate commission based on total sales
    IF v_DoanhSoTotal BETWEEN 20000000::MONEY AND 39999999::MONEY THEN
        v_HoaHong := v_DoanhSoTotal * 0.1;
    ELSIF v_DoanhSoTotal BETWEEN 40000000::MONEY AND 59999999::MONEY THEN
        v_HoaHong := 20000000::MONEY * 0.1 + (v_DoanhSoTotal - 20000000::MONEY) * 0.15;
    ELSIF v_DoanhSoTotal BETWEEN 60000000::MONEY AND 99999999::MONEY THEN
        v_HoaHong := 20000000::MONEY * 0.1 + 20000000::MONEY * 0.15 + (v_DoanhSoTotal - 40000000::MONEY) * 0.2;
    ELSIF v_DoanhSoTotal >= 100000000::MONEY THEN
        v_HoaHong := 20000000::MONEY * 0.1 + 20000000::MONEY * 0.15 + 40000000::MONEY * 0.2 + (v_DoanhSoTotal - 60000000::MONEY) * 0.25;
    END IF;

    -- Return the calculated commission
    RETURN v_HoaHong;
END;
<<<<<<< Updated upstream
$$;
>>>>>>> Stashed changes
=======
$$;
>>>>>>> Stashed changes

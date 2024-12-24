-- Hàm tính HoaHong
CREATE OR REPLACE FUNCTION CalculateHoaHong(v_NhanVienID VARCHAR, v_KyLuong VARCHAR)
RETURNS NUMERIC(15, 2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_HoaHong NUMERIC(15, 2) := 0;
    v_DoanhSoTotal NUMERIC(15, 2) := 0;
    v_KyLuongDate DATE;
BEGIN
    -- Đổi v_KyLuong thành DATE
    v_KyLuongDate := TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD');

    -- Tính tổng doanh số bán hàng của nhân viên trong kỳ lương
    SELECT COALESCE(SUM(TongTien), 0) INTO v_DoanhSoTotal
    FROM HoaDon
    WHERE NhanVienID = v_NhanVienID 
      AND EXTRACT(MONTH FROM NgayLapHD) = EXTRACT(MONTH FROM v_KyLuongDate) 
      AND EXTRACT(YEAR FROM NgayLapHD) = EXTRACT(YEAR FROM v_KyLuongDate);

    -- Tính hoa hồng dựa trên tổng doanh số
    IF v_DoanhSoTotal BETWEEN 20000000 AND 39999999 THEN
        v_HoaHong := v_DoanhSoTotal * 0.1;
    ELSIF v_DoanhSoTotal BETWEEN 40000000 AND 59999999 THEN
        v_HoaHong := 20000000 * 0.1 + (v_DoanhSoTotal - 20000000) * 0.15;
    ELSIF v_DoanhSoTotal BETWEEN 60000000 AND 99999999 THEN
        v_HoaHong := 20000000 * 0.1 + 20000000 * 0.15 + (v_DoanhSoTotal - 40000000) * 0.2;
    ELSIF v_DoanhSoTotal >= 100000000 THEN
        v_HoaHong := 20000000 * 0.1 + 20000000 * 0.15 + 40000000 * 0.2 + (v_DoanhSoTotal - 60000000) * 0.25;
    END IF;

    RETURN v_HoaHong;
END;
$$;

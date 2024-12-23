-- Hàm tính phụ cấp thâm niên
-- >= 730 ngày làm việc: 300.000, >= 1095 ngày làm việc: 500.000, >= 1460 ngày làm việc: 700.000.

CREATE OR REPLACE FUNCTION CalculateThuongThamNien(v_KyLuong VARCHAR, v_NhanVienID VARCHAR)
RETURNS NUMERIC(15, 2) AS $$
DECLARE
    v_SeniorityAllowance NUMERIC(15, 2) := 0;
    v_NgayLamViec INT := 0;
    v_NgayCuoiThang DATE;
BEGIN
    -- Tính ngày cuối cùng của kỳ lương
    v_NgayCuoiThang := TO_DATE(v_KyLuong || '-01', 'YYYY-MM') + INTERVAL '1 month' - INTERVAL '1 day';

    -- Lấy số ngày làm việc của nhân viên
    SELECT (v_NgayCuoiThang - NgayVaoLam) INTO v_NgayLamViec
    FROM NhanVien
    WHERE NhanVienID = v_NhanVienID;

    -- Tính phụ cấp thâm niên dựa trên số ngày làm việc
    IF v_NgayLamViec >= 1460 THEN
        v_SeniorityAllowance := 700000;
    ELSIF v_NgayLamViec >= 1095 THEN
        v_SeniorityAllowance := 500000;
    ELSIF v_NgayLamViec >= 730 THEN
        v_SeniorityAllowance := 300000;
    END IF;

    -- Trả về phụ cấp thâm niên
    RETURN v_SeniorityAllowance;
END;
$$ LANGUAGE plpgsql;

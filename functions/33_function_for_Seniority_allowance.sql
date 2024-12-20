
--Hàm tính phụ cấp thâm niên theo quy tắc sau:
--  >= 730 ngày làm việc: 300.000, >= 1095 ngày làm việc: 500.000, >= 1460 ngày làm việc: 700.000.

CREATE OR REPLACE FUNCTION CalculateThuongThamNien(v_KyLuong VARCHAR, v_NhanVienID VARCHAR)
RETURNS MONEY AS $$
DECLARE
    v_SeniorityAllowance MONEY := 0;
    v_NgayLamViec INT := 0;
    v_NgayCuoiThang DATE;
BEGIN
    -- Calculate the last day of the salary month
    v_NgayCuoiThang := (v_KyLuong || '-01')::DATE + INTERVAL '1 month' - INTERVAL '1 day';

    -- Get the number of working days of the employee
    SELECT EXTRACT(DAY FROM v_NgayCuoiThang - NgayVaoLam) INTO v_NgayLamViec
    FROM NhanVien
    WHERE NhanVienID = v_NhanVienID;

    -- Calculate seniority allowance based on the number of working days
    IF v_NgayLamViec >= 1460 THEN
        v_SeniorityAllowance := 700000;
    ELSIF v_NgayLamViec >= 1095 THEN
        v_SeniorityAllowance := 500000;
    ELSIF v_NgayLamViec >= 730 THEN
        v_SeniorityAllowance := 300000;
    END IF;

    -- Return the seniority allowance
    RETURN v_SeniorityAllowance;
END;
$$ LANGUAGE plpgsql;
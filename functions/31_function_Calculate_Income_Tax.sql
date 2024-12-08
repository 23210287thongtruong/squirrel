
-- Hàm Tính Thuế TNCN

CREATE FUNCTION CalculateTNCN(ThuNhapTinhThue MONEY) RETURNS MONEY AS
$$
DECLARE
    v_TNCN MONEY := 0;
BEGIN
    -- Tính thuế lũy tiến từng phần
    IF ThuNhapTinhThue <= 5000000 THEN
        v_TNCN := ThuNhapTinhThue * 0.05;  -- 5%
    ELSIF ThuNhapTinhThue <= 10000000 THEN
        v_TNCN := 5000000 * 0.05 + (ThuNhapTinhThue - 5000000) * 0.10;  -- 10%
    ELSIF ThuNhapTinhThue <= 18000000 THEN
        v_TNCN := 5000000 * 0.05 + 5000000 * 0.10 + (ThuNhapTinhThue - 10000000) * 0.15;  -- 15%
    ELSIF ThuNhapTinhThue <= 32000000 THEN
        v_TNCN := 5000000 * 0.05 + 5000000 * 0.10 + 8000000 * 0.15 + (ThuNhapTinhThue - 18000000) * 0.20;  -- 20%
    ELSIF ThuNhapTinhThue <= 52000000 THEN
        v_TNCN := 5000000 * 0.05 + 5000000 * 0.10 + 8000000 * 0.15 + 14000000 * 0.20 + (ThuNhapTinhThue - 32000000) * 0.25;  -- 25%
    ELSIF ThuNhapTinhThue <= 80000000 THEN
        v_TNCN := 5000000 * 0.05 + 5000000 * 0.10 + 8000000 * 0.15 + 14000000 * 0.20 + 20000000 * 0.25 + (ThuNhapTinhThue - 52000000) * 0.30;  -- 30%
    ELSE
        v_TNCN := 5000000 * 0.05 + 5000000 * 0.10 + 8000000 * 0.15 + 14000000 * 0.20 + 20000000 * 0.25 + 28000000 * 0.30 + (ThuNhapTinhThue - 80000000) * 0.35;  -- 35%
    END IF;

    RETURN v_TNCN;
END;
$$ LANGUAGE plpgsql;


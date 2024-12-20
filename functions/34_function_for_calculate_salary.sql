
CREATE OR REPLACE FUNCTION TinhLuong(v_KyLuong VARCHAR)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_NhanVienID VARCHAR;
    v_PCSinhNhat MONEY;
    v_PCChucVu MONEY;
    v_ThuongThamNien MONEY;
    v_NgayCong INT;
    v_ThuNhapChiuThue MONEY;
    v_ThuNhapTinhThue MONEY;
    v_ThueTNCN MONEY;
    v_BHXH MONEY;
    v_HoaHong MONEY;
    v_Phat MONEY;
    v_LuongThucNhan MONEY;
    v_LuongCung MONEY;
    done BOOLEAN := FALSE;
    cur CURSOR FOR 
        SELECT NhanVienID
        FROM NhanVien
        WHERE NgayVaoLam <= TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD');
BEGIN
    OPEN cur;

    FETCH cur INTO v_NhanVienID;

    -- Loop through all employees
    WHILE NOT done LOOP
        -- Check if the salary period already exists in the LuongThang table
        IF NOT EXISTS (SELECT 1 FROM LuongThang WHERE KyLuong = v_KyLuong AND NhanVienID = v_NhanVienID) THEN
            -- Fetch LuongCung from ThongTinLuong
            SELECT LuongCung INTO v_LuongCung
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            -- Calculate values
            SELECT INTO v_PCSinhNhat 
                CASE WHEN EXTRACT(MONTH FROM NgaySinh) = EXTRACT(MONTH FROM TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD')) THEN 100000::MONEY ELSE 0::MONEY END
            FROM NhanVien
            WHERE NhanVienID = v_NhanVienID;

            SELECT INTO v_PCChucVu 
                CASE WHEN TruongNhom THEN 750000::MONEY ELSE 0::MONEY END
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID AND NgayHieuLuc <= TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD')
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            v_ThuongThamNien := CalculateThuongThamNien(v_KyLuong, v_NhanVienID);
            v_NgayCong := 0;  -- Default to 0, can be updated manually

            v_HoaHong := CalculateHoaHong(v_NhanVienID, v_KyLuong);
            v_Phat := 0::MONEY;  -- Default to 0, can be updated manually

            SELECT INTO v_BHXH, v_ThuNhapChiuThue
                (v_LuongCung / 26 * v_NgayCong * 0.105)::MONEY,
                (v_LuongCung / 26 * v_NgayCong + v_HoaHong + v_PCSinhNhat + v_PCChucVu + v_ThuongThamNien - v_Phat)::MONEY
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            IF v_BHXH > 3744000::MONEY THEN
                v_BHXH := 3744000::MONEY;
            END IF;

            SELECT INTO v_ThuNhapTinhThue
                (v_ThuNhapChiuThue - SoNguoiPhuThuoc * 4400000::MONEY - 11000000::MONEY - v_BHXH)::MONEY
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            v_ThueTNCN := CalculateTNCN(v_ThuNhapTinhThue);
            v_LuongThucNhan := (v_ThuNhapChiuThue - v_BHXH - v_ThueTNCN)::MONEY;

            -- Ensure all monetary values are non-negative
            IF v_PCSinhNhat < 0::MONEY THEN v_PCSinhNhat := 0::MONEY; END IF;
            IF v_PCChucVu < 0::MONEY THEN v_PCChucVu := 0::MONEY; END IF;
            IF v_ThuongThamNien < 0::MONEY THEN v_ThuongThamNien := 0::MONEY; END IF;
            IF v_ThuNhapChiuThue < 0::MONEY THEN v_ThuNhapChiuThue := 0::MONEY; END IF;
            IF v_ThuNhapTinhThue < 0::MONEY THEN v_ThuNhapTinhThue := 0::MONEY; END IF;
            IF v_ThueTNCN < 0::MONEY THEN v_ThueTNCN := 0::MONEY; END IF;
            IF v_BHXH < 0::MONEY THEN v_BHXH := 0::MONEY; END IF;
            IF v_HoaHong < 0::MONEY THEN v_HoaHong := 0::MONEY; END IF;
            IF v_Phat < 0::MONEY THEN v_Phat := 0::MONEY; END IF;
            IF v_LuongThucNhan < 0::MONEY THEN v_LuongThucNhan := 0::MONEY; END IF;

            -- Insert into LuongThang table
            INSERT INTO LuongThang (KyLuong, NhanVienID, ThuongThamNien, PCSinhNhat, PCChucVu, NgayCong, ThuNhapChiuThue, ThuNhapTinhThue, ThueTNCN, BHXH, HoaHong, Phat, LuongThucNhan)
            VALUES (v_KyLuong, v_NhanVienID, v_ThuongThamNien, v_PCSinhNhat, v_PCChucVu, v_NgayCong, v_ThuNhapChiuThue, v_ThuNhapTinhThue, v_ThueTNCN, v_BHXH, v_HoaHong, v_Phat, v_LuongThucNhan);
        END IF;

        FETCH cur INTO v_NhanVienID;
        IF NOT FOUND THEN
            done := TRUE;
        END IF;
    END LOOP;

    CLOSE cur;
END;
$$;

-- xóa dữ liệu cũ trong bảng LuongThang
DELETE FROM LuongThang;
-- xóa function TinhLuong nếu tồn tại
DROP FUNCTION IF EXISTS TinhLuong(VARCHAR);
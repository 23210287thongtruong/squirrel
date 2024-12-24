CREATE OR REPLACE FUNCTION TinhLuong(v_KyLuong VARCHAR)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_NhanVienID VARCHAR;
    v_PCSinhNhat NUMERIC(15, 2);
    v_PCChucVu NUMERIC(15, 2);
    v_ThuongThamNien NUMERIC(15, 2);
    v_NgayCong INT;
    v_ThuNhapChiuThue NUMERIC(15, 2);
    v_ThuNhapTinhThue NUMERIC(15, 2);
    v_ThueTNCN NUMERIC(15, 2);
    v_BHXH NUMERIC(15, 2);
    v_HoaHong NUMERIC(15, 2);
    v_Phat NUMERIC(15, 2);
    v_LuongThucNhan NUMERIC(15, 2);
    v_LuongCung NUMERIC(15, 2);
    done BOOLEAN := FALSE;
    cur CURSOR FOR 
        SELECT NhanVienID
        FROM NhanVien
        WHERE NgayVaoLam <= TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD');
BEGIN
    OPEN cur;

    FETCH cur INTO v_NhanVienID;

    -- Lặp qua tất cả nhân viên
    WHILE NOT done LOOP
        -- Kiểm tra xem kỳ lương đã tồn tại trong bảng LuongThang chưa
        IF NOT EXISTS (SELECT 1 FROM LuongThang WHERE KyLuong = v_KyLuong AND NhanVienID = v_NhanVienID) THEN
            -- Lấy LuongCung từ bảng ThongTinLuong
            SELECT LuongCung INTO v_LuongCung
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            -- Tính toán các giá trị
            SELECT INTO v_PCSinhNhat 
                CASE WHEN EXTRACT(MONTH FROM NgaySinh) = EXTRACT(MONTH FROM TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD')) THEN 100000 ELSE 0 END
            FROM NhanVien
            WHERE NhanVienID = v_NhanVienID;

            SELECT INTO v_PCChucVu 
                CASE WHEN TruongNhom THEN 750000 ELSE 0 END
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID AND NgayHieuLuc <= TO_DATE(v_KyLuong || '-01', 'YYYY-MM-DD')
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            v_ThuongThamNien := CalculateThuongThamNien(v_KyLuong, v_NhanVienID);
            v_NgayCong := 26;  -- Mặc định là 26 ngày, có thể cập nhật thủ công

            v_HoaHong := CalculateHoaHong(v_NhanVienID, v_KyLuong);
            v_Phat := 0;  -- Mặc định là 0, có thể cập nhật thủ công

            SELECT INTO v_BHXH, v_ThuNhapChiuThue
                (v_LuongCung / 26 * v_NgayCong * 0.105),
                (v_LuongCung / 26 * v_NgayCong + v_HoaHong + v_PCSinhNhat + v_PCChucVu + v_ThuongThamNien - v_Phat)
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            -- Giới hạn mức BHXH tối đa
            IF v_BHXH > 3744000 THEN
                v_BHXH := 3744000;
            END IF;

            SELECT INTO v_ThuNhapTinhThue
                (v_ThuNhapChiuThue - SoNguoiPhuThuoc * 4400000 - 11000000 - v_BHXH)
            FROM ThongTinLuong
            WHERE NhanVienID = v_NhanVienID
            ORDER BY NgayHieuLuc DESC LIMIT 1;

            v_ThueTNCN := CalculateTNCN(v_ThuNhapTinhThue);
            v_LuongThucNhan := (v_ThuNhapChiuThue - v_BHXH - v_ThueTNCN);

            -- Đảm bảo tất cả các giá trị tiền đều không âm
            IF v_PCSinhNhat < 0 THEN v_PCSinhNhat := 0; END IF;
            IF v_PCChucVu < 0 THEN v_PCChucVu := 0; END IF;
            IF v_ThuongThamNien < 0 THEN v_ThuongThamNien := 0; END IF;
            IF v_ThuNhapChiuThue < 0 THEN v_ThuNhapChiuThue := 0; END IF;
            IF v_ThuNhapTinhThue < 0 THEN v_ThuNhapTinhThue := 0; END IF;
            IF v_ThueTNCN < 0 THEN v_ThueTNCN := 0; END IF;
            IF v_BHXH < 0 THEN v_BHXH := 0; END IF;
            IF v_HoaHong < 0 THEN v_HoaHong := 0; END IF;
            IF v_Phat < 0 THEN v_Phat := 0; END IF;
            IF v_LuongThucNhan < 0 THEN v_LuongThucNhan := 0; END IF;

            -- Chèn dữ liệu vào bảng LuongThang
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

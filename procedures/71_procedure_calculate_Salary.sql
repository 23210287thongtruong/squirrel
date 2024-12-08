
-- 4.3 Tính toán bảng Luongthang
CREATE PROCEDURE TinhLuong(
    IN v_KyLuong VARCHAR
)
BEGIN
    DECLARE v_NhanVienID VARCHAR;
    DECLARE v_PCSinhNhat MONEY;
    DECLARE v_PCChucVu MONEY;
    DECLARE v_ThuongThamNien MONEY;
    DECLARE v_NgayCong INT;
    DECLARE v_ThuNhapChiuThue MONEY;
    DECLARE v_ThuNhapTinhThue MONEY;
    DECLARE v_ThueTNCN MONEY;
    DECLARE v_BHXH MONEY;
    DECLARE v_HoaHong MONEY;
    DECLARE v_Phat MONEY;
    DECLARE v_LuongThucNhan MONEY;

    -- Khởi tạo con trỏ để lấy tất cả nhân viên cần tính lương
    DECLARE cur CURSOR FOR 
    SELECT NhanVienID
    FROM NhanVien
    WHERE NgayVaoLam <= STR_TO_DATE(CONCAT(v_KyLuong, '-01'), '%Y-%m-%d');

    OPEN cur;

    FETCH cur INTO v_NhanVienID;

    -- Lặp qua tất cả nhân viên
    WHILE FOUND DO
        -- Kiểm tra xem kỳ lương đã có trong bảng LuongThang chưa
        IF NOT EXISTS (SELECT 1 FROM LuongThang WHERE KyLuong = v_KyLuong AND NhanVienID = v_NhanVienID) THEN
            -- Tính toán các giá trị
            SET v_PCSinhNhat = IF(MONTH(NhanVien.NgaySinh) = MONTH(STR_TO_DATE(CONCAT(v_KyLuong, '-01'), '%Y-%m-%d')), 100000, 0);
            SET v_PCChucVu = (SELECT IF(ThongTinLuong.TruongNhom, 750000, 0) 
                              FROM ThongTinLuong 
                              WHERE ThongTinLuong.NhanVienID = v_NhanVienID AND ThongTinLuong.NgayHieuLuc = STR_TO_DATE(CONCAT(v_KyLuong, '-01'), '%Y-%m-%d'));
            SET v_ThuongThamNien = CalculateThuongThamNien(v_KyLuong, v_NhanVienID);
            SET v_NgayCong = 0;  -- Mặc định là 0, có thể cập nhật thủ công
            SET v_ThuNhapChiuThue = ThongTinLuong.LuongCung / 26 * v_NgayCong + v_HoaHong + v_PCSinhNhat + v_PCChucVu + v_ThuongThamNien - v_Phat;
            SET v_ThuNhapTinhThue = v_ThuNhapChiuThue - ThongTinLuong.SoNguoiPhuThuoc * 4400000 - 11000000 - v_BHXH;
            SET v_ThueTNCN = CalculateTNCN(v_ThuNhapTinhThue);
            SET v_BHXH = (ThongTinLuong.LuongCung / 26 * v_NgayCong * 0.105);
            IF v_BHXH > 3744000 THEN
                SET v_BHXH = 3744000;
            END IF;
            SET v_HoaHong = CalculateHoaHong(v_NhanVienID, v_KyLuong);
            SET v_Phat = 0;  -- Mặc định là 0, có thể cập nhật thủ công
            SET v_LuongThucNhan = v_ThuNhapChiuThue - v_BHXH - v_ThueTNCN;

            -- Thực hiện cập nhật vào bảng LuongThang
            INSERT INTO LuongThang (KyLuong, NhanVienID, ThuongThamNien, PCSinhNhat, PCChucVu, NgayCong, ThuNhapChiuThue, ThuNhapTinhThue, ThueTNCN, BHXH, HoaHong, Phat, LuongThucNhan)
            VALUES (v_KyLuong, v_NhanVienID, v_ThuongThamNien, v_PCSinhNhat, v_PCChucVu, v_NgayCong, v_ThuNhapChiuThue, v_ThuNhapTinhThue, v_ThueTNCN, v_BHXH, v_HoaHong, v_Phat, v_LuongThucNhan);
        END IF;

        FETCH cur INTO v_NhanVienID;
    END WHILE;

    CLOSE cur;
END;
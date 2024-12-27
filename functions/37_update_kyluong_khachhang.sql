--Tính doanh số từng khách hàng
CREATE OR REPLACE FUNCTION update_doanhso_khachhang()
RETURNS TRIGGER AS $$
BEGIN
    -- Cập nhật tổng doanh số cho khách hàng
    UPDATE KhachHang
    SET DoanhSo = (
        SELECT COALESCE(SUM(hd.TongTien), 0)
        FROM HoaDon hd
        WHERE hd.KhachHangID = NEW.KhachHangID
    )
    WHERE KhachHangID = NEW.KhachHangID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Tính tổng lương của cả công ty hàng tháng
CREATE OR REPLACE FUNCTION update_tongluong_congty()
RETURNS TRIGGER AS $$
BEGIN
    -- Cập nhật tổng lương của công ty trong bảng kyluongNV
    UPDATE kyluongNV
    SET tongluong = (
        SELECT COALESCE(SUM(LuongThucNhan), 0)
        FROM LuongThang
        WHERE KyLuong = NEW.KyLuong
    )
    WHERE KyLuong = NEW.KyLuong;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Phân loại khách hàng (Doanh số > 100 triệulà khách hàng VIP)
CREATE OR REPLACE FUNCTION update_loai_khachhang()
RETURNS TRIGGER AS $$
BEGIN
    -- Cập nhật loại khách hàng thành 'VIP' nếu doanh số > 100 triệu
    UPDATE KhachHang
    SET LoaiKH = CASE
        WHEN DoanhSo > 100000000 THEN 'VIP'
        ELSE NULL -- Loại khách hàng khác nếu không phải VIP
    END
    WHERE KhachHangID = NEW.KhachHangID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
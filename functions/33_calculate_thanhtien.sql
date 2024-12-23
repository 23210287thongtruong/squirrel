CREATE OR REPLACE FUNCTION calculate_thanhtien() RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
DECLARE
    v_gia NUMERIC; -- Renamed to avoid conflict
    v_muc_thue FLOAT;
    v_giam_gia FLOAT DEFAULT 0;
    v_voucher NUMERIC DEFAULT 0;
    v_khach_hang_id VARCHAR;
BEGIN
    -- Fetch product price and tax
    SELECT hh.Gia, hh.MucThueGTGT INTO v_gia, v_muc_thue
    FROM HangHoa hh
    WHERE hh.HangHoaID = NEW.HangHoaID;

    -- Debug
    RAISE NOTICE 'Gia: %, MucThue: %', v_gia, v_muc_thue;

    -- Fetch discount (if applicable)
    SELECT COALESCE(avg(ct.GiamGia), 0) INTO v_giam_gia
    FROM CTGiamGia ct
    WHERE ct.HangHoaID = NEW.HangHoaID
      AND CURRENT_DATE BETWEEN ct.NgayBatDau AND ct.NgayKetThuc;

    -- Debug
    RAISE NOTICE 'GiamGia: %', v_giam_gia;

    -- Fetch associated KhachHangID from HoaDon
    SELECT hd.KhachHangID INTO v_khach_hang_id
    FROM HoaDon hd
    WHERE hd.HoaDonID = NEW.HoaDonID;

    -- Check for birthday voucher
    IF v_khach_hang_id IS NOT NULL THEN
        SELECT CASE
                   WHEN EXTRACT(MONTH FROM kh.SinhNhat) = EXTRACT(MONTH FROM CURRENT_DATE) THEN 200000
                   ELSE 0
                   END INTO v_voucher
        FROM KhachHang kh
        WHERE kh.KhachHangID = v_khach_hang_id;
    END IF;

    -- Debug
    RAISE NOTICE 'Voucher: %', v_voucher;

    -- Calculate ThanhTien
    NEW.ThanhTien := (v_gia * NEW.SoLuong * (1 - v_giam_gia / 100)) * (1 + v_muc_thue / 100) - v_voucher;

    -- Debug calculated ThanhTien
    RAISE NOTICE 'ThanhTien: %', NEW.ThanhTien;

    RETURN NEW;
END;
$$;

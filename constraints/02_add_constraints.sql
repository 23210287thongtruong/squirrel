-- Kiểm tra số lượng tồn kho >= 0
ALTER TABLE HangHoa
ADD CONSTRAINT ck_soluongtonkho CHECK (SoLuongTonKho >= 0);

-- Kiểm tra NgayLap không lớn hơn ngày hiện tại và TongTien > 0
ALTER TABLE HoaDon
ADD CONSTRAINT ck_ngaylaphd CHECK (NgayLapHD <= CURRENT_DATE),
ADD CONSTRAINT ck_tongtien CHECK (TongTien > 0::money);

-- Function kiểm tra phòng ban của nhân viên là 'PB2'
CREATE OR REPLACE FUNCTION check_phongban_pb2()
RETURNS TRIGGER AS $$
BEGIN
    -- Kiểm tra phòng ban của NhanVienID
    IF (SELECT PhongBan FROM NhanVien WHERE NhanVienID = NEW.NhanVienID) != 'PB2' THEN
        RAISE EXCEPTION 'NhanVienID % không thuộc phòng ban PB2', NEW.NhanVienID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_phongban_pb2
BEFORE INSERT OR UPDATE ON HoaDon
FOR EACH ROW
EXECUTE FUNCTION check_phongban_pb2();

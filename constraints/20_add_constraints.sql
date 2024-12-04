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

CREATE OR REPLACE FUNCTION check_ngay_tao_hoa_don() RETURNS TRIGGER AS $$
DECLARE
  ngay_vao_lam DATE;
  ngay_ra_mat DATE;
BEGIN
  SELECT NgayVaoLam INTO ngay_vao_lam FROM NhanVien WHERE NhanVienID = NEW.NhanVienID;
  SELECT NgayRaMat INTO ngay_ra_mat FROM HangHoa WHERE HangHoaID = NEW.HangHoaID;

  IF NEW.NgayLapHD < ngay_vao_lam OR NEW.NgayLapHD < ngay_ra_mat THEN
    RAISE EXCEPTION 'Ngày tạo hóa đơn phải lớn hơn ngày ra mắt sản phẩm và ngày vào làm của nhân viên tạo hóa đơn!';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ngay_tao_hoa_don_trigger
  BEFORE INSERT OR UPDATE ON HoaDon
  FOR EACH ROW
  EXECUTE FUNCTION check_ngay_tao_hoa_don();

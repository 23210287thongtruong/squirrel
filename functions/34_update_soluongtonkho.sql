CREATE OR REPLACE FUNCTION update_soluongtonkho()
    RETURNS TRIGGER AS $$
BEGIN
UPDATE HangHoa
SET SoLuongTonKho = SoLuongTonKho - NEW.SoLuong
WHERE HangHoaID = NEW.HangHoaID;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_soluongtonkho
    AFTER INSERT ON ChiTietHoaDon
    FOR EACH ROW
    EXECUTE FUNCTION update_soluongtonkho();

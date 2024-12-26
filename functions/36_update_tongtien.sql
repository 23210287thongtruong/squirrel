CREATE OR REPLACE FUNCTION update_tongtien()
    RETURNS TRIGGER AS $$
BEGIN
UPDATE HoaDon
SET TongTien = (
    SELECT SUM(ThanhTien)
    FROM ChiTietHoaDon
    WHERE ChiTietHoaDon.HoaDonID = NEW.HoaDonID
)
WHERE HoaDonID = NEW.HoaDonID;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_tongtien
    AFTER INSERT OR UPDATE ON ChiTietHoaDon
                        FOR EACH ROW
                        EXECUTE FUNCTION update_tongtien();


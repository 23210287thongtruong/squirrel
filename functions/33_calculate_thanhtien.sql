create function calculate_thanhtien() returns trigger
    language plpgsql
as
$$
DECLARE
gia MONEY;
    muc_thue FLOAT;
    giam_gia FLOAT;
    voucher INT DEFAULT 0;
BEGIN
    -- Lấy giá và thuế từ bảng HangHoa
SELECT Gia, MucThueGTGT INTO gia, muc_thue
FROM HangHoa
WHERE HangHoaID = NEW.HangHoaID;

-- Lấy giảm giá từ bảng CTGiamGia
SELECT COALESCE(GiamGia, 0) INTO giam_gia
FROM CTGiamGia
WHERE HangHoaID = NEW.HangHoaID;

-- Kiểm tra VoucherSinhNhat
SELECT CASE
           WHEN EXTRACT(MONTH FROM SinhNhat) = EXTRACT(MONTH FROM CURRENT_DATE) THEN 200000
           ELSE 0
           END INTO voucher
FROM KhachHang
WHERE KhachHangID = NEW.KhachHangID;

-- Tính ThanhTien
NEW.ThanhTien := (gia * (1 - giam_gia / 100)) * (1 + muc_thue / 100) - voucher;

RETURN NEW;
END;
$$;

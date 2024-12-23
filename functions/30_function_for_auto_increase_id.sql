-- Tạo Function cho Trigger KhachHangID tự động tăng theo dạng "KHxxx" bảng KhachHang
CREATE SEQUENCE khach_hang_seq START 1;
CREATE OR REPLACE FUNCTION create_khach_hang_id()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.KhachHangID := 'KH' || LPAD(nextval('khach_hang_seq')::TEXT, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger NhanVienID tự động tăng theo dạng "NVxxx" bảng NhanVien
CREATE SEQUENCE nhan_vien_seq START 1;
CREATE OR REPLACE FUNCTION create_nhan_vien_id()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.NhanVienID := 'NV' || LPAD(nextval('nhan_vien_seq')::TEXT, 2, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Tạo Function HangHoa tự động tăng
CREATE OR REPLACE FUNCTION GenerateHangHoaID()
    RETURNS TRIGGER AS $$
DECLARE
    prefix VARCHAR(2);
    next_number INT;
    new_id VARCHAR(10);
BEGIN
    -- Lấy prefix từ bảng LoaiHangHoaCounter
    SELECT lc.Prefix, lc.CurrentNumber + 1
    INTO prefix, next_number
    FROM LoaiHangHoaCounter lc
    WHERE lc.LoaiHangHoa = NEW.LoaiHangHoa;

    -- Sinh mã mới
    new_id := prefix || LPAD(next_number::TEXT, 3, '0');

    -- Cập nhật CurrentNumber trong LoaiHangHoaCounter
    UPDATE LoaiHangHoaCounter
    SET CurrentNumber = next_number
    WHERE LoaiHangHoa = NEW.LoaiHangHoa;

    -- Gán mã mới cho HangHoaID
    NEW.HangHoaID := new_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger HoaDonID tự động tăng theo dạng "HDxxxx" bảng HoaDon
CREATE SEQUENCE hoa_don_seq START 1;
CREATE OR REPLACE FUNCTION create_hoa_don_id()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.HoaDonID := 'HD' || LPAD(nextval('hoa_don_seq')::TEXT, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

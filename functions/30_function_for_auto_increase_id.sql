-- Tạo Function cho Trigger KhachHangID tự động tăng theo dạng "KHxxx" bảng KhachHang
CREATE SEQUENCE khach_hang_seq START 1;
CREATE OR REPLACE FUNCTION create_khach_hang_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.KhachHangID := 'KH' || LPAD(nextval('khach_hang_seq')::TEXT, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger NhanVienID tự động tăng theo dạng "NVxx" bảng NhanVien
CREATE SEQUENCE nhan_vien_seq START 1;
CREATE OR REPLACE FUNCTION create_nhan_vien_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.NhanVienID := 'NV' || LPAD(nextval('nhan_vien_seq')::TEXT, 2, '0');
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

-- Tạo Function cho Trigger HangHoaID tự động tăng theo dạng "DTxxx" bảng DienThoai
CREATE SEQUENCE dien_thoai_seq START 1;
CREATE OR REPLACE FUNCTION create_dien_thoai_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.HangHoaID := 'DT' || LPAD(nextval('dien_thoai_seq')::TEXT, 3, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger HangHoaID tự động tăng theo dạng "LTxxx" bảng Laptop
CREATE SEQUENCE laptop_seq START 1;
CREATE OR REPLACE FUNCTION create_laptop_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.HangHoaID := 'LT' || LPAD(nextval('laptop_seq')::TEXT, 3, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger HangHoaID tự động tăng theo dạng "DHxxx" bảng DongHo
CREATE SEQUENCE dong_ho_seq START 1;
CREATE OR REPLACE FUNCTION create_dong_ho_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.HangHoaID := 'DH' || LPAD(nextval('dong_ho_seq')::TEXT, 3, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger HangHoaID tự động tăng theo dạng "MTxxx" bảng MayTinhBang
CREATE SEQUENCE may_tinh_bang_seq START 1;
CREATE OR REPLACE FUNCTION create_may_tinh_bang_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.HangHoaID := 'MT' || LPAD(nextval('may_tinh_bang_seq')::TEXT, 3, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo Function cho Trigger HangHoaID tự động tăng theo dạng "TNxxx" bảng TaiNghe
CREATE SEQUENCE tai_nghe_seq START 1;
CREATE OR REPLACE FUNCTION create_tai_nghe_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.HangHoaID := 'TN' || LPAD(nextval('tai_nghe_seq')::TEXT, 3, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

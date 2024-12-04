-- Tạo Trigger KhachHangID tự động tăng theo dạng "KHxxx" bảng KhachHang
CREATE TRIGGER auto_increase_khach_hang_id
BEFORE INSERT ON KhachHang
FOR EACH ROW
EXECUTE FUNCTION create_khach_hang_id();

-- Tạo Trigger NhanVienID tự động tăng theo dạng "NVxxx" bảng NhanVien
CREATE TRIGGER auto_increase_nhan_vien_id
BEFORE INSERT ON NhanVien
FOR EACH ROW
EXECUTE FUNCTION create_nhan_vien_id();

-- Tạo Trigger HoaDonID tự động tăng theo dạng "HDxxxx" bảng HoaDon
CREATE TRIGGER auto_increase_hoa_don_id
BEFORE INSERT ON HoaDon
FOR EACH ROW
EXECUTE FUNCTION create_hoa_don_id();

-- Tạo Trigger HangHoaID tự động tăng theo dạng "DTxxx" bảng DienThoai
CREATE TRIGGER auto_increase_dien_thoai_id
BEFORE INSERT ON DienThoai
FOR EACH ROW
EXECUTE FUNCTION create_dien_thoai_id();

-- Tạo Trigger HangHoaID tự động tăng theo dạng "LTxxx" bảng Laptop
CREATE TRIGGER auto_increase_laptop_id
BEFORE INSERT ON Laptop
FOR EACH ROW
EXECUTE FUNCTION create_laptop_id();

-- Tạo Trigger HangHoaID tự động tăng theo dạng "DHxxx" bảng DongHo
CREATE TRIGGER auto_increase_dong_ho_id
BEFORE INSERT ON DongHo
FOR EACH ROW
EXECUTE FUNCTION create_dong_ho_id();

-- Tạo Trigger HangHoaID tự động tăng theo dạng "MTxxx" bảng MayTinhBang
CREATE TRIGGER auto_increase_may_tinh_bang_id
BEFORE INSERT ON MayTinhBang
FOR EACH ROW
EXECUTE FUNCTION create_may_tinh_bang_id();

-- Tạo Trigger HangHoaID tự động tăng theo dạng "TNxxx" bảng TaiNghe
CREATE TRIGGER auto_increase_tai_nghe_id
BEFORE INSERT ON TaiNghe
FOR EACH ROW
EXECUTE FUNCTION create_tai_nghe_id();

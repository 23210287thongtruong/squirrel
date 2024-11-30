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

-- Tạo Trigger HangHoaID tự động tăng theo loại sản phẩmbảng HangHoa
CREATE TRIGGER TriggerGenerateHangHoaID
BEFORE INSERT ON HangHoa
FOR EACH ROW
WHEN (NEW.HangHoaID IS NULL) -- Chỉ chạy khi HangHoaID không được cung cấp
EXECUTE FUNCTION GenerateHangHoaID();

-- Tạo Trigger HoaDonID tự động tăng theo dạng "HDxxxx" bảng HoaDon
CREATE TRIGGER auto_increase_hoa_don_id
BEFORE INSERT ON HoaDon
FOR EACH ROW
EXECUTE FUNCTION create_hoa_don_id();

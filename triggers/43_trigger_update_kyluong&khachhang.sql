-- Trigger kích hoạt sau khi thêm hoặc cập nhật hóa đơn
CREATE TRIGGER trg_update_doanhso_khachhang
AFTER INSERT OR UPDATE OR DELETE ON HoaDon
FOR EACH ROW
EXECUTE FUNCTION update_doanhso_khachhang();

-- Trigger kích hoạt sau khi thêm hoặc cập nhật dữ liệu lương tháng
CREATE TRIGGER trg_update_tongluong_congty
AFTER INSERT OR UPDATE OR DELETE ON LuongThang
FOR EACH ROW
EXECUTE FUNCTION update_tongluong_congty();

-- Trigger kích hoạt sau khi cập nhật doanh số của khách hàng
CREATE TRIGGER trg_update_loai_khachhang
AFTER INSERT OR UPDATE OR DELETE ON HoaDon
FOR EACH ROW
EXECUTE FUNCTION update_loai_khachhang();
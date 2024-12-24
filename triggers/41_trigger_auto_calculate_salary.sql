-- Trigger function
CREATE OR REPLACE FUNCTION after_kyluong_change()
RETURNS TRIGGER AS $$
BEGIN
    -- Gọi hàm TinhLuong cho kỳ lương vừa được thêm/cập nhật
    PERFORM TinhLuong(NEW.kyluong);

    -- Kiểm tra kết quả
    PERFORM * FROM LuongThang WHERE KyLuong = NEW.kyluong;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_after_kyluong_change
AFTER INSERT OR UPDATE
ON kyluongNV
FOR EACH ROW
EXECUTE FUNCTION after_kyluong_change();

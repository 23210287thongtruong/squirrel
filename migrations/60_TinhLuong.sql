DO $$
DECLARE
    record_kyluong RECORD;
BEGIN
    -- Lặp qua tất cả các kỳ lương trong bảng kyluongNV
    FOR record_kyluong IN
        SELECT kyluong FROM kyluongNV
    LOOP
        -- Gọi hàm TinhLuong cho từng kỳ lương
        PERFORM TinhLuong(record_kyluong.kyluong);

        -- Kiểm tra kết quả
        PERFORM * FROM LuongThang WHERE KyLuong = record_kyluong.kyluong;
    END LOOP;
END;
$$;
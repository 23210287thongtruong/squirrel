create or replace trigger calculatethanhtien
    before insert
    on chitiethoadon
    for each row
    execute function calculate_thanhtien();


create trigger calculatethanhtien
    before insert
    on chitiethoadon
    for each row
    execute procedure calculate_thanhtien();


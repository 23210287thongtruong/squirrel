--BẢNG NHÂN VIÊN VÀ THÔNG TIN LƯƠNG

--Thêm dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (HoTen, NgaySinh, PhongBan, ChucVu, NgayVaoLam, DiaChi, SoDienThoai, Email)
VALUES
    ('Đỗ Thanh Nam', '1985-8-10', 'PB1', 'Giám đốc', '2019-10-1', 'Số 815 đường 18, quận Tân Phú', '+84 830 954 331', 'nam.do283@gmail.com'),
    ('Vũ Thanh Cường', '1994-1-3', 'PB6', 'Bảo vệ', '2019-11-1', 'Số 258 đường 26, quận 2', '+84 621 100 847', 'cuong.vu421@gmail.com'),
    ('Hoàng Anh Trang', '1997-8-27', 'PB1', 'Phó giám đốc', '2019-11-1', 'Số 639 đường 8, quận 2', '+84 214 401 997', 'trang.hoang277@gmail.com'),
    ('Hoàng Hữu Nam', '1997-5-22', 'PB3', 'Trưởng phòng kế toán', '2019-11-1', 'Số 949 đường 42, quận 2', '+84 654 973 614', 'nam.hoang848@gmail.com'),
    ('Vũ Hải Cường', '1999-3-19', 'PB5', 'Trưởng phòng nhân sự', '2019-11-1', 'Số 70 đường 2, quận 2', '+84 758 968 448', 'cuong.vu451@gmail.com'),
    ('Đỗ Thị Hùng', '1997-3-1', 'PB7', 'Trưởng phòng quản lý Kho', '2019-11-1', 'Số 855 đường 35, quận 2', '+84 936 794 749', 'hung.do504@gmail.com'),
    ('Đặng Anh Tuấn', '2000-1-9', 'PB4', 'Trưởng phòng kỹ thuật', '2019-11-15', 'Số 61 đường 41, quận 7', '+84 889 483 222', 'tuan.dang704@gmail.com'),
    ('Nguyễn Hữu Trang', '1986-10-9', 'PB2', 'Cửa hàng trưởng', '2020-1-1', 'Số 67 đường 2, quận 1', '+84 234 651 323', 'trang.nguyen250@gmail.com'),
    ('Đặng Hải Trang', '1991-10-30', 'PB2', 'Cửa hàng trưởng', '2020-1-1', 'Số 973 đường 29, quận Tân Phú', '+84 551 609 917', 'trang.dang246@gmail.com'),
    ('Phạm Minh Bình', '1998-8-26', 'PB2', 'Nhân viên bán hàng', '2020-1-1', 'Số 694 đường 1, quận 3', '+84 771 627 977', 'binh.pham544@gmail.com'),
    ('Nguyễn Minh Bình', '1996-4-23', 'PB2', 'Nhân viên bán hàng', '2020-1-1', 'Số 126 đường 19, quận 2', '+84 525 205 125', 'binh.nguyen866@gmail.com'),
    ('Phạm Hữu Tuấn', '1998-8-2', 'PB2', 'Nhân viên bán hàng', '2020-1-1', 'Số 789 đường 50, quận Tân Phú', '+84 861 107 338', 'tuan.pham183@gmail.com'),
    ('Phan Thị Hoa', '1996-11-7', 'PB2', 'Nhân viên bán hàng', '2020-1-1', 'Số 918 đường 33, quận Tân Phú', '+84 290 429 718', 'hoa.phan404@gmail.com'),
    ('Trần Anh Lan', '1999-9-27', 'PB3', 'Nhân viên kế toán', '2020-1-1', 'Số 161 đường 34, quận Bình Thạnh', '+84 925 198 922', 'lan.tran772@gmail.com'),
    ('Trần Xuân Nam', '1998-7-11', 'PB4', 'Nhân viên kỹ thuật', '2020-1-1', 'Số 969 đường 49, quận Bình Thạnh', '+84 949 381 358', 'nam.tran406@gmail.com'),
    ('Phạm Hữu Nam', '1991-3-5', 'PB7', 'Trưởng phòng quản lý Kho', '2020-1-1', 'Số 458 đường 4, quận Bình Thạnh', '+84 126 564 895', 'nam.pham516@gmail.com'),
    ('Nguyễn Hữu Cường', '1984-6-7', 'PB6', 'Trưởng phòng bảo vệ', '2020-1-1', 'Số 625 đường 49, quận 2', '+84 458 874 583', 'cuong.nguyen503@gmail.com'),
    ('Vũ Thị Nam', '1994-9-28', 'PB7', 'Quản lý Kho', '2020-1-1', 'Số 408 đường 40, quận 2', '+84 515 685 681', 'nam.vu915@gmail.com'),
    ('Nguyễn Kim Nam', '1998-6-11', 'PB2', 'Cửa hàng trưởng', '2020-1-15', 'Số 747 đường 16, quận 1', '+84 218 554 913', 'nam.nguyen846@gmail.com'),
    ('Phạm Hữu Hùng', '1997-2-2', 'PB2', 'Nhân viên bán hàng', '2020-1-15', 'Số 768 đường 17, quận 2', '+84 417 956 736', 'hung.pham517@gmail.com'),
    ('Vũ Huy Linh', '1989-11-17', 'PB6', 'Quản lý Kho', '2020-1-15', 'Số 786 đường 22, quận 7', '+84 230 966 560', 'linh.vu332@gmail.com'),
    ('Lê Anh Trang', '1998-2-12', 'PB5', 'Chuyên viên nhân sự', '2020-2-1', 'Số 88 đường 23, quận Tân Phú', '+84 231 933 556', 'trang.le23@gmail.com'),
    ('Lê Thị Hùng', '1997-5-3', 'PB2', 'Nhân viên bán hàng', '2020-6-1', 'Số 296 đường 32, quận Bình Thạnh', '+84 883 195 822', 'hung.le423@gmail.com'),
    ('Phan Văn Nam', '1999-12-6', 'PB2', 'Nhân viên bán hàng', '2020-6-1', 'Số 158 đường 45, quận 7', '+84 741 105 369', 'nam.phan363@gmail.com'),
    ('Vũ Minh Hưởng', '1995-12-7', 'PB2', 'Nhân viên bán hàng', '2020-6-1', 'Số 390 đường 39, quận 3', '+84 655 852 524', 'huong.vu715@gmail.com'),
    ('Bùi Hải Nam', '1996-4-29', 'PB2', 'Nhân viên bán hàng', '2020-6-1', 'Số 689 đường 37, quận 1', '+84 689 460 907', 'nam.bui754@gmail.com'),
    ('Đặng Xuân Hùng', '2000-1-31', 'PB7', 'Bảo vệ', '2020-6-1', 'Số 936 đường 20, quận 1', '+84 208 295 840', 'hung.dang805@gmail.com'),
    ('Nguyễn Văn Bình', '1987-4-12', 'PB6', 'Bảo vệ', '2021-2-1', 'Số 929 đường 3, quận 7', '+84 639 730 991', 'binh.nguyen804@gmail.com'),
    ('Vũ Thanh Linh', '1996-1-27', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 189 đường 25, quận 1', '+84 616 536 726', 'linh.vu203@gmail.com'),
    ('Bùi Kim Hoa', '1995-10-5', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 926 đường 6, quận 2', '+84 524 185 715', 'hoa.bui876@gmail.com'),
    ('Phan Thanh Hùng', '1996-1-13', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 675 đường 9, quận 2', '+84 722 584 806', 'hung.phan785@gmail.com'),
    ('Phạm Anh Bình', '1999-4-7', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 502 đường 38, quận Tân Phú', '+84 805 581 861', 'binh.pham950@gmail.com'),
    ('Bùi Hữu Hùng', '1997-4-3', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 992 đường 28, quận 2', '+84 478 594 865', 'hung.bui899@gmail.com'),
    ('Vũ Hải Nam', '1999-4-30', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 999 đường 2, quận 3', '+84 335 448 688', 'nam.vu356@gmail.com'),
    ('Hoàng Anh Linh', '1999-12-16', 'PB2', 'Nhân viên bán hàng', '2021-3-1', 'Số 901 đường 46, quận 3', '+84 408 689 130', 'linh.hoang103@gmail.com'),
    ('Hoàng Huy Trang', '1997-9-7', 'PB2', 'Nhân viên bán hàng', '2021-5-1', 'Số 264 đường 26, quận 3', '+84 537 623 328', 'trang.hoang262@gmail.com'),
    ('Trần Kim Nam', '1997-8-5', 'PB2', 'Nhân viên bán hàng', '2021-5-1', 'Số 721 đường 48, quận Tân Phú', '+84 508 394 439', 'nam.tran862@gmail.com'),
    ('Phạm Hải Lan', '1995-3-31', 'PB2', 'Nhân viên bán hàng', '2021-5-1', 'Số 404 đường 13, quận Tân Phú', '+84 921 428 233', 'lan.pham452@gmail.com'),
    ('Đỗ Anh Trang', '1995-7-2', 'PB2', 'Nhân viên bán hàng', '2021-5-1', 'Số 326 đường 13, quận 3', '+84 252 531 231', 'trang.do766@gmail.com'),
    ('Bùi Hải Hùng', '1998-3-17', 'PB2', 'Nhân viên bán hàng', '2021-5-15', 'Số 593 đường 17, quận 3', '+84 961 116 152', 'hung.bui44@gmail.com'),
    ('Phạm Thanh Tuấn', '1997-4-21', 'PB6', 'Bảo vệ', '2021-6-1', 'Số 78 đường 35, quận 2', '+84 431 442 745', 'tuan.pham846@gmail.com'),
    ('Đỗ Kim Hùng', '1996-2-1', 'PB7', 'Bảo vệ', '2021-6-1', 'Số 456 đường 13, quận 7', '+84 788 995 134', 'hung.do749@gmail.com'),
    ('Bùi Thanh Lan', '1997-1-8', 'PB8', 'Nhân viên pháp lý', '2021-7-1', 'Số 794 đường 50, quận 7', '+84 850 474 312', 'lan.bui508@gmail.com'),
    ('Vũ Hữu Nam', '1998-11-16', 'PB6', 'Bảo vệ', '2021-8-1', 'Số 879 đường 40, quận Bình Thạnh', '+84 822 998 520', 'nam.vu394@gmail.com'),
    ('Phan Văn Hưởng', '1999-6-12', 'PB2', 'Nhân viên bán hàng', '2022-3-1', 'Số 717 đường 5, quận Tân Phú', '+84 478 439 501', 'huong.phan770@gmail.com'),
    ('Nguyễn Thị Lan', '1998-2-15', 'PB2', 'Nhân viên bán hàng', '2022-3-1', 'Số 123 đường 10, quận Bình Thạnh', '+84 913 456 789', 'lan.nguyen123@gmail.com'),
    ('Đỗ Anh Hùng', '1991-1-13', 'PB3', 'Nhân viên kế toán', '2022-7-1', 'Số 818 đường 5, quận 7', '+84 414 934 141', 'hung.do409@gmail.com'),
    ('Đỗ Văn Trang', '1999-12-14', 'PB4', 'Nhân viên kỹ thuật', '2022-7-1', 'Số 750 đường 29, quận 3', '+84 709 700 568', 'trang.do57@gmail.com'),
    ('Nguyễn Hải Tuấn', '1992-7-29', 'PB8', 'Nhân viên pháp lý', '2023-4-1', 'Số 491 đường 23, quận Tân Phú', '+84 339 734 175', 'tuan.nguyen588@gmail.com'),
    ('Nguyễn Hữu Bình', '1989-12-14', 'PB6', 'Bảo vệ', '2023-5-1', 'Số 609 đường 22, quận 2', '+84 488 843 159', 'binh.nguyen137@gmail.com');

--Thêm dữ liệu vào bảng ThongTinLuong
INSERT INTO ThongTinLuong (NgayHieuLuc, NhanVienID, TruongNhom, LuongCung, SoNguoiPhuThuoc)
VALUES
    ('2019-10-1', 'NV01', FALSE, 45000000, 3), 
    ('2019-11-1', 'NV02', TRUE, 7000000, 0), 
    ('2019-11-1', 'NV03', FALSE, 32000000, 0), 
    ('2019-11-1', 'NV04', FALSE, 17000000, 0), 
    ('2019-11-1', 'NV05', FALSE, 16500000, 0), 
    ('2019-11-1', 'NV06', FALSE, 13000000, 0), 
    ('2019-11-15', 'NV07', FALSE, 15000000, 0), 
    ('2020-1-1', 'NV08', FALSE, 12000000, 1), 
    ('2020-1-1', 'NV09', FALSE, 12000000, 0), 
    ('2020-1-1', 'NV10', FALSE, 8000000, 0), 
    ('2020-1-1', 'NV11', FALSE, 8000000, 0), 
    ('2020-1-1', 'NV12', FALSE, 8000000, 0), 
    ('2020-1-1', 'NV13', FALSE, 8000000, 2), 
    ('2020-1-1', 'NV14', FALSE, 12000000, 2), 
    ('2020-1-1', 'NV15', TRUE, 11000000, 0), 
    ('2020-1-1', 'NV16', FALSE, 13000000, 1), 
    ('2020-1-1', 'NV17', FALSE, 8500000, 0), 
    ('2020-1-1', 'NV18', TRUE, 8500000, 0), 
    ('2020-1-15', 'NV19', FALSE, 12000000, 0), 
    ('2020-1-15', 'NV20', FALSE, 8000000, 0), 
    ('2020-1-15', 'NV21', FALSE, 8500000, 0), 
    ('2020-2-1', 'NV22', FALSE, 11000000, 0), 
    ('2020-6-1', 'NV23', FALSE, 8000000, 0), 
    ('2020-6-1', 'NV24', FALSE, 8000000, 0), 
    ('2020-6-1', 'NV25', FALSE, 8000000, 0), 
    ('2020-6-1', 'NV26', FALSE, 8000000, 0), 
    ('2020-6-1', 'NV27', FALSE, 7000000, 0), 
    ('2021-2-1', 'NV28', FALSE, 7000000, 0), 
    ('2021-3-1', 'NV29', TRUE, 8000000, 0), 
    ('2021-3-1', 'NV30', FALSE, 8000000, 0), 
    ('2021-3-1', 'NV31', FALSE, 8000000, 0), 
    ('2021-3-1', 'NV32', FALSE, 8000000, 0), 
    ('2021-3-1', 'NV33', FALSE, 8000000, 0), 
    ('2021-3-1', 'NV34', FALSE, 8000000, 0), 
    ('2021-3-1', 'NV35', FALSE, 8000000, 0), 
    ('2021-5-1', 'NV36', FALSE, 8000000, 1), 
    ('2021-5-1', 'NV37', FALSE, 8000000, 0), 
    ('2021-5-1', 'NV38', TRUE, 8000000, 0), 
    ('2021-5-1', 'NV39', TRUE, 8000000, 0), 
    ('2021-5-15', 'NV40', FALSE, 8000000, 0), 
    ('2021-6-1', 'NV41', FALSE, 7000000, 0), 
    ('2021-6-1', 'NV42', FALSE, 7000000, 0), 
    ('2021-7-1', 'NV43', FALSE, 12000000, 0), 
    ('2021-8-1', 'NV44', FALSE, 7000000, 0), 
    ('2022-3-1', 'NV45', TRUE, 8000000, 0), 
    ('2022-3-1', 'NV46', FALSE, 8000000, 0), 
    ('2022-7-1', 'NV47', FALSE, 12000000, 0), 
    ('2022-7-1', 'NV48', FALSE, 11000000, 0), 
    ('2023-4-1', 'NV49', TRUE, 12000000, 0), 
    ('2023-5-1', 'NV50', TRUE, 7000000, 2);
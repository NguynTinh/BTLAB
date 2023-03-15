--LAB8
--1. SP spTangLuong:

CREATE PROCEDURE spTangLuong
AS
BEGIN
    UPDATE NHANVIEN
    SET Luong = Luong*1.1;
END


--2. SP spNghiHuu:

CREATE PROCEDURE spNghiHuu
AS
BEGIN
    UPDATE NHANVIEN
    SET NgayNghiHuu = DATEADD(year, CASE WHEN GioiTinh = N'Nam' THEN 60 ELSE 55 END, NgaySinh) + 100
    WHERE DATEDIFF(year, NgaySinh, GETDATE()) >= CASE WHEN GioiTinh = N'Nam' THEN 60 ELSE 55 END;
END


--3. SP spXemDeAn:

CREATE PROCEDURE spXemDeAn (@DiaDiem NVARCHAR(50))
AS
BEGIN
    SELECT * FROM DEAN
    WHERE DiaDiemDeAn = @DiaDiem;
END


--4. SP spCapNhatDeAn:

CREATE PROCEDURE spCapNhatDeAn (@DiaDiemCu NVARCHAR(50), @DiaDiemMoi NVARCHAR(50))
AS
BEGIN
    UPDATE DEAN
    SET DiaDiemDeAn = @DiaDiemMoi
    WHERE DiaDiemDeAn = @DiaDiemCu;
END


--5. SP spThemDeAn:

CREATE PROCEDURE spThemDeAn (@MaDA NVARCHAR(10), @TenDA NVARCHAR(50), @DiaDiem NVARCHAR(50),
                              @NgayBD DATETIME, @NgayKT DATETIME, @MaPB NVARCHAR(10))
AS
BEGIN
    INSERT INTO DEAN (MaDA, TenDA, DiaDiemDeAn, NgayBD, NgayKT, MaPB)
    VALUES (@MaDA, @TenDA, @DiaDiem, @NgayBD, @NgayKT, @MaPB);
END


--6. Cập nhật SP spThemDeAn để thỏa mãn ràng buộc:

CREATE PROCEDURE spThemDeAn (@MaDA NVARCHAR(10), @TenDA NVARCHAR(50), @DiaDiem NVARCHAR(50),
                              @NgayBD DATETIME, @NgayKT DATETIME, @MaPB NVARCHAR(10))
AS
BEGIN
    IF EXISTS (SELECT * FROM DEAN WHERE MaDA = @MaDA)
        RAISERROR('Mã đề án đã tồn tại, đề nghị chọn mã đề án khác.', 16, 1);
    ELSE IF NOT EXISTS (SELECT * FROM PHONGBAN WHERE MaPB = @MaPB)
        RAISERROR('Mã phòng không tồn tại.', 16, 1);
    ELSE
        INSERT INTO DEAN (MaDA, TenDA, DiaDiemDeAn, NgayBD, NgayKT, MaPB)
        VALUES (@MaDA, @TenDA, @DiaDiem, @NgayBD, @NgayKT, @MaPB);
END


--7. SP spXoaDeAn:

CREATE PROCEDURE spXoaDeAn (@MaDA NVARCHAR(10))
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
        RAISERROR('Mã đề án còn tồn tại ở bảng PHANCONG, không thể xóa dữ liệu.', 16, 1);
    ELSE
        DELETE FROM DEAN WHERE MaDA = @MaDA;
END


--8. Cập nhật SP spXoaDeAn:

CREATE PROCEDURE spXoaDeAn (@MaDA NVARCHAR(10))
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
        DELETE FROM PHANCONG WHERE MaDA = @MaDA;
    DELETE FROM DEAN WHERE MaDA = @MaDA;
END


--9. SP spTongGioLamViec:

CREATE PROCEDURE spTongGioLamViec (@MaNV NVARCHAR(10), @TongThoiGian INT OUTPUT)
AS
BEGIN
    SELECT @TongThoiGian = SUM(DATEDIFF(hour, NgayBatDau, NgayKetThuc))
    FROM PHANCONG
    WHERE MaNV = @MaNV;
END


--10. SP spTongTien:

CREATE PROCEDURE spTongTien (@MaNV NVARCHAR(10))
AS
BEGIN
    DECLARE @TongLuong INT, @TongTien INT;
    SELECT @TongLuong = Luong FROM NHANVIEN WHERE MaNV = @MaNV;
    SELECT @TongTien = @TongLuong + SUM(ThoiGian*100000)
    FROM PHANCONG
    WHERE MaNV = @MaNV;
    PRINT 'Tổng tiền phải trả cho nhân viên '''+@MaNV+''' là '+CAST(@TongTien AS NVARCHAR)+' đồng.';
END


--11. SP spThemPhanCong:

CREATE PROCEDURE spThemPhanCong (@MaDA NVARCHAR(10), @MaNV NVARCHAR(10), @ThoiGian INT)
AS
BEGIN
    IF (@ThoiGian <= 0)
        RAISERROR('Thời gian phải là một số dương.', 16, 1);
    ELSE IF NOT EXISTS (SELECT * FROM DEAN WHERE MaDA = @MaDA)
        RAISERROR('Mã đề án không tồn tại ở bảng DEAN.', 16, 1);
    ELSE IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MaNV = @MaNV)
        RAISERROR('Mã nhân viên không tồn tại ở bảng NHANVIEN.', 16, 1);
    ELSE
        INSERT INTO PHANCONG (MaDA, MaNV, ThoiGian, NgayBatDau, NgayKetThuc)
        VALUES (@MaDA, @MaNV, @ThoiGian, GETDATE(), DATEADD(hour, @ThoiGian, GETDATE()));
END
--LAB9
--1. Trigger để hạn chế việc cập nhật trường "TenNV" trên bảng "NHANVIEN":

CREATE TRIGGER restrict_update_TenNV 
ON NHANVIEN
FOR UPDATE AS
    IF UPDATE(TenNV)
    BEGIN
        RAISERROR('Không được phép cập nhật', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END


--2. Trigger để tính lại trường "TongGio" trên bảng "NHANVIEN" khi có thao tác INSERT, UPDATE, DELETE trên bảng "PHANCONG":

CREATE TRIGGER update_TongGio 
ON PHANCONG
FOR INSERT, UPDATE, DELETE AS
    IF @@ROWCOUNT = 0
        RETURN

    DECLARE @MaNV INT, @TongGio INT
    IF (SELECT COUNT(*) FROM INSERTED) > 0 
        BEGIN
            SELECT @MaNV = MaNV FROM INSERTED
            SELECT @TongGio = SUM(DATEDIFF(HH, NgayBatDau, NgayKetThuc)) FROM PHANCONG WHERE MaNV = @MaNV
        END
    ELSE 
        BEGIN
            SELECT @MaNV = MaNV FROM DELETED
            SELECT @TongGio = SUM(DATEDIFF(HH, NgayBatDau, NgayKetThuc)) FROM PHANCONG WHERE MaNV = @MaNV
        END
    UPDATE NHANVIEN SET TongGio = @TongGio WHERE MaNV = @MaNV


--3. Trigger để kiểm tra ràng buộc liên thuộc tính giữa "NgSinh" và "NgayBatDau" trên bảng "NHANVIEN":

CREATE TRIGGER check_NgSinh_and_NgayBatDau 
ON NHANVIEN
FOR UPDATE AS
    IF (DATEDIFF(YY, INSERTED.NgSinh, INSERTED.NgayBatDau) < 18)
    BEGIN
        RAISERROR ('NgayBatDau phai sau khi nguoi do 18 tuoi', 16, 1);
        ROLLBACK TRANSACTION
    END


--4. Trigger để kiểm tra ràng buộc trên bảng "THANNHAN":

CREATE TRIGGER check_so_luong_ThanNhan 
ON THANNHAN
FOR INSERT, UPDATE AS 
    IF (SELECT COUNT(*) FROM THANNHAN WHERE MaNV = INSERTED.MaNV) > 5
    BEGIN
        RAISERROR ('So luong than nhan khong duoc vuot qua 5', 16, 1);
        ROLLBACK TRANSACTION
    END


--5. Trigger để hạn chế việc xóa mẩu tin trên bảng "DEAN" khi còn mẩu tin trên bảng "PHANCONG":

CREATE TRIGGER restrict_delete_DEAN 
ON DEAN
FOR DELETE AS
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA IN (SELECT MaDA FROM DELETED))
    BEGIN
        RAISERROR ('Khong the xoa vi da co du lieu tren PHANCONG', 16, 1)
        ROLLBACK TRANSACTION
        RETURN 
    END


--6. Trigger để hệ thống dữ liệu đồng bộ khi có thay đổi trên bảng phòng ban "PHONGBAN":

CREATE TRIGGER sync_all_tables 
ON PHONGBAN
FOR UPDATE AS
    IF UPDATE(MaPhong)
    BEGIN
        UPDATE NHANVIEN SET MaPhong = INSERTED.MaPhong FROM NHANVIEN INNER JOIN INSERTED ON NHANVIEN.MaPhong = DELETED.MaPhong
        UPDATE PHANCONG SET MaPhong = INSERTED.MaPhong FROM PHANCONG INNER JOIN INSERTED ON PHANCONG.MaPhong = DELETED.MaPhong
    END
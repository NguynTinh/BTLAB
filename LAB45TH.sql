create database QLDA1
Create	table NHANVIEN
(
	HOVN	nvarchar(15),
	TENLOT	nvarchar(15),
	TENNV	nvarchar(15) not null,
	MANV	char	(9) not null,
	NGSINH	Datetime,
	DCHI	nvarchar(30),
	PHAI	nvarchar(3),
	LUONG	float,
	MA_NQL	char(9),
	PHG	int,
	constraint PK_NHANVIEN primary key(MANV),
	
)

Create	table PHONGBAN
(
	TENPHG	nvarchar(15),
	MAPHG	int not null,
	TRPHG	char(9),
	NG_NHANCHUC Datetime
	constraint PK_PHONGBAN primary key(MAPHG)
)


Create table DIADIEM_PHG
(
	MAPHG	int,
	DIADIEM nvarchar(50)
	constraint PK_DIADIEM_PHG primary key (MAPHG, DIADIEM)
)

Create table DEAN
(
	TENDA	nvarchar(15),
	MADA	int,
	DDIEM_DA nvarchar(50),
	PHONG	int,
	constraint PK_DEAN primary key(MADA)
)

Create table PHANCONG
(
	MA_NVIEN char(9),
	MADA	 int,
	THOIGIAN float,
	constraint PK_PHANCONG primary key (MA_NVIEN, MADA)
)

Create	table THANNHAN
(
	MA_NVIEN char(9),
	TENTN	 nvarchar(15),
	PHAI	 nvarchar(3),
	NGSINH	Datetime,
	QUANHE 	nvarchar(15),
	constraint PK_THANNHAN primary key (MA_NVIEN, TENTN) 
)


----------------------------------*tao khoa ngoai*---------------------------
--tao khoa ngoai cho bang NHANVIEN
alter table NHANVIEN
add 
constraint FK_NHANVIEN_NHANVIEN foreign key(MA_NQL) references NHANVIEN(MANV),
constraint FK_NHANVIEN_PHONGBAN foreign key(PHG) references PHONGBAN(MAPHG)
--tao khoa ngoai cho bang PHONGBAN
alter table PHONGBAN
add
constraint FK_PHONGBAN_NHANVIEN foreign key(TRPHG) references NHANVIEN(MANV)
--tao khoa ngoai cho bang DIADIEM_PHG
alter table DIADIEM_PHG
add
constraint FK_DIADIEMPHG_PHONGBAN foreign key(MAPHG) references PHONGBAN(MAPHG)
--tao khoa ngoai cho bang DEAN
alter table DEAN
add
constraint FK_DEAN_PHONGBAN foreign key(PHONG) references PHONGBAN(MAPHG)
--tao khoa ngoai cho PHANCONG
alter table PHANCONG
add
constraint FK_PHANCONG_CONGVIEC foreign key(MADA, STT) references CONGVIEC(MADA, STT)
--tao khoa ngoai cho THANNHAN
alter table THANNHAN
add
*/
alter table PHANCONG
add
constraint FK_PHANCONG_DEAN foreign key(MADA) references DEAN(MADA),
constraint FK_PHANCONG_NHANVIEN foreign key(MA_NVIEN) references NHANVIEN(MANV)
alter table THANNHAN
add constraint FK_THANNHAN_NHANVIEN foreign key(MA_NVIEN) references NHANVIEN(MANV)
--------------------------Chen du lieu -------------------------------------------
set dateformat dmy
select * from nhanvien
delete  nhanvien
insert into NHANVIEN values(N'Vương', N'Ngọc', N'Quyền', 
'006', '01/01/1965', N'45 Trưng Vương Hà Nội', N'Nữ', 55000, null, null)

insert into NHANVIEN values(N'Nguyễn', N'Thanh', N'Tùng', 
'005', '20/08/1962', N'222 Nguyễn Văn Cừ TPHCM', N'Nam', 40000, NULL, null) /*006*/

insert into NHANVIEN values(N'Lê', N'Thị', N'Nhàn', 
'001', '01/02/1967', N'291 Hồ Văn Huê TPHCM', N'Nữ', 43000, NULL, null)/*006*/

insert into NHANVIEN values(N'Nguyễn', N'Mạnh', N'Hùng', 
'004', '04/03/1967', N'95 Bà Rịa Vũng Tàu', N'Nam', 38000, NULL, null)/*005*/

insert into NHANVIEN values(N'Trần', N'Thanh', N'Tâm', 
'003', '04/05/1957', N'34 Mai Thị Lựu TPHCM', N'Nam', 25000, NULL, null) /*005*/

insert into NHANVIEN values(N'Bùi', N'Thúy', N'Bư', 
'007', '11/03/1954', N'332 Nguyễn Thái Học TPHCM', N'Nam', 25000, NULL, null)/*001*/

insert into NHANVIEN values(N'Trần', N'Hồng', N'Quang', 
'008', '01/09/1967', N'80 Lê Hồng Phong TPHCM', N'Nam', 25000, NULL, null) /*001*/

insert into NHANVIEN values(N'Đinh', N'Bá', N'Tiến', 
'009', '12/01/1960', N'119 Cống Quỳnh TPHCM', N'Nam', 30000, NULL, null) /*005*/

select *
from NHANVIEN

-- nhap du lieu cho PHONGBAN

insert into PHONGBAN values(N'Nghiên Cứu', 5, '005', '22/05/1987')
insert into PHONGBAN values(N'Diều Hành', 4, '008', '01/01/1985')
insert into PHONGBAN values(N'Quản Lý', 1, '006', '19/06/1971')
SELECT * FROM PHONGBAN
--cap nhat lai du lieu PHONG cho nhan vien

update NHANVIEN
set    PHG = 5
where  MANV = '009'

update NHANVIEN
set    PHG = 5
where  MANV = '005'

update NHANVIEN
set    PHG = 4
where  MANV = '007'

update NHANVIEN
set    PHG = 4
where  MANV = '001'

update NHANVIEN
set    PHG = 5
where  MANV = '003'

update NHANVIEN
set    PHG = 5
where  MANV = '004'

update NHANVIEN
set    PHG = 4
where  MANV = '008'

update NHANVIEN
set    PHG = 1
where  MANV = '006'

update NHANVIEN
set    PHG = 5
where  MANV = '009'

select *
from NHANVIEN

--cap nhat du lieu cho bang DIADIEM_PHG

insert into DIADIEM_PHG values(1, 'TP HCM')
insert into DIADIEM_PHG values(4, 'HA NOI')
insert into DIADIEM_PHG values(5, 'VUNG TAU')

select *
from DIADIEM_PHG

--cap nhat du lieu cho bang DEAN
insert into DEAN values(N'Sản phẩm X', 1, 'VUNG TAU', 5)
insert into DEAN values(N'Sản phẩm Y', 2, 'NHA TRANG', 5)
insert into DEAN values(N'Sản phẩm Z', 3, 'TP HCM', 5)
insert into DEAN values(N'Tin học hóa', 10, 'HA NOI', 4)
insert into DEAN values(N'Cap Quang', 20, 'TP HCM', 1)
insert into DEAN values(N'Đào Tạo', 30, 'HA NOI', 4)

select *
from DEAN
--cap nhat du lieu cho bang THANNHAN
insert into THANNHAN values('005', N'Quang', N'Nữ', '05/04/1976', N'Con gái')
insert into THANNHAN values('005', N'Khang', N'Nam', '25/10/1973', N'Con trai')
insert into THANNHAN values('005', N'Dương', N'Nữ', '03/05/1948', N'Vợ chồng')
insert into THANNHAN values('001', N'Đăng', N'Nam', '19/02/1932', N'Vợ chồng')
insert into THANNHAN values('009', N'Duy', N'Nam', '01/01/1978', N'Con trai')
insert into THANNHAN values('009', N'Châu', N'Nữ', '30/12/1978', N'Con gái')
insert into THANNHAN values('009', N'Phương', N'Nữ', '05/05/1957', N'Vợ chồng')

select *
from THANNHAN

--chen du lieu cho bang PHANCONG
insert into PHANCONG values('009', 1, 32)
insert into PHANCONG values('009', 2, 8)
insert into PHANCONG values('004', 3, 40)
insert into PHANCONG values('003', 1, 20)
insert into PHANCONG values('003', 2, 20)
insert into PHANCONG values('008', 10,35)
insert into PHANCONG values('008', 30,5)
insert into PHANCONG values('001', 30,20)
insert into PHANCONG values('001', 20,15)
insert into PHANCONG values('006', 20,30)
insert into PHANCONG values('005', 3, 10)
insert into PHANCONG values('005', 10,10)
insert into PHANCONG values('005', 20,10)
insert into PHANCONG values('007', 30,30)
insert into PHANCONG values('007', 10,10)

select *
from	PHANCONG
--Câu 1:
select *
from NHANVIEN
--Câu 2:
select MANV, HOVN, TENLOT, TENNV
from NHANVIEN 
where PHG = 5
--Câu 3:
select MANV, HOVN, TENLOT, TENNV, LUONG, PHG
from NHANVIEN 
where LUONG > 6000000
--Câu 4:
select MANV, HOVN, TENLOT, TENNV, LUONG, PHG
from NHANVIEN 
where LUONG > 6500000 and PHG = 1 or LUONG > 5000000 and PHG = 4
--câu 5:
select MANV, HOVN, TENLOT, TENNV
from NHANVIEN , DIADIEM_PHG
where NHANVIEN.PHG = DIADIEM_PHG.MAPHG and DIADIEM_PHG.DIADIEM = 'QUANG NGAI'

select *
from NHANVIEN
--Câu 6:
select HOVN + ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên'
from NHANVIEN
where NHANVIEN.HOVN like N'N%'
-----7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền
SELECT NHANVIEN.NGSINH, NHANVIEN.DCHI
FROM NHANVIEN
WHERE NHANVIEN.HOVN = N'Cao' AND
		  NHANVIEN.TENLOT = N'Thanh' AND
		  NHANVIEN.TENNV = N'Huyền'
--câu 8:
SELECT * FROM NHANVIEN
WHERE NGSINH BETWEEN 1955 AND 1975;
-- câu 9:
Select HOVN + ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên' , YEAR(NGSINH) as 'Năm Sinh'
from NHANVIEN
-----10. Cho biết họ tên và tuổi của tất cả các nhân viên

select HOVN+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', (2023 - YEAR(NGSINH)) as 'Tuổi' from NHANVIEN

-----11. Tìm tên những người trưởng phòng của từng phòng ban

select HOVN+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên Trưởng Phòng' from PHONGBAN,NHANVIEN
where PHONGBAN.TRPHG = NHANVIEN.MANV

-----12.Tìm tên và địa chỉ của tất cả các nhân viên của phòng 'Điều hành'

select HOVN+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', DCHI from NHANVIEN inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
where PHONGBAN.MAPHG = 4

-----13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.

select TENDA, TENPHG, HOVN+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', NG_NHANCHUC 
from NHANVIEN inner join PHONGBAN 
ON NHANVIEN.PHG = PHONGBAN.MAPHG 
inner join DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
where PHONGBAN.TRPHG = NHANVIEN.MANV and DCHI like '%Tp Quảng Ngãi'

-----14. Tìm tên những nữ nhân viên và tên người thân của họ

select HOVN+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', TENTN as 'Tên người thân' 
from NHANVIEN inner join THANNHAN ON NHANVIEN.MANV = THANNHAN.MA_NVIEN
where NHANVIEN.PHAI = N'Nữ'

-----15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc.

select NV.HOVN + ' ' + NV.TENLOT + ' ' + NV.TENNV as 'Họ và tên nhân viên', QL.HOVN+ ' ' + QL.TENLOT + ' ' + QL.TENNV as 'Họ và tên quản lí'
	from NHANVIEN NV,NHANVIEN QL
	where NV.MA_NQL = QL.MANV

-----16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản"

select HOVN+ ' ' + TENLOT + ' ' + TENNV as 'Họ và tên' 
from NHANVIEN inner join DEAN ON NHANVIEN.PHG = DEAN.PHONG
where DEAN.TENDA= 'Xây dựng nhà máy chế biến thủy sản'

-----17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia.

select TENDA as 'Tên đề án'
from NHANVIEN inner join DEAN ON NHANVIEN.PHG = DEAN.PHONG
where NHANVIEN.HOVN = N'Trần' and NHANVIEN.TENLOT = N'Thanh' and NHANVIEN.TENNV = N'Tâm'
--18  Cho biết số lượng đề án của công ty
select count(*)
	from dean
go
--19 Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án
select TENPHG,count(*)
	from PHONGBAN,DEAN
	where maphg=phong
	group by TENPHG
	--dean
	select*
	from DEAN
--20 Cho biết số lượng các phòng ban có tham gia chủ trì các đề án
select TENPHG,COUNT(*) as 'Số lượng phòng ban làm việc'
	from PHONGBAN,DEAN
	where MAPHG=PHONG
	group by TENDA
--21 Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì
	select count(*)
	from PHONGBAN,DEAN
	where PHONG=MAPHG and TENPHG like N'Nghiên cứu'
	--dean
	select *
	from dean
	--phancong
	select *
	from PHANCONG
	--nhanvien
	select*
	from NHANVIEN

go
--22  Cho biết lương trung bình của các nữ nhân viên
	select avg(LUONG) as 'Lương Trung Bình của các NV nữ'
	from NHANVIEN
	where phai like N'Nữ'
go
--23 Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'
	select count(*) as 'Số thân nhân của tiến'
	from NHANVIEN,THANNHAN
	where MANV=MA_NVIEN and HONV = N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'
go
--25 Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
	select dean.MADA,sum(PHANCONG.THOIGIAN) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.MADA 
--26 Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.

	select dean.TENDA,sum(PHANCONG.THOIGIAN) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.TENDA 
--27 Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó
	select MADA, count(*)
	from PHANCONG,NHANVIEN
	where MANV=MA_NVIEN
	group by MADA

go
--28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
go
	select HONV+' '+TENNV as 'Họ Và Tên',count(*) as 'Số lượng thân nhân'
	from NHANVIEN,THANNHAN
	where MANV = MA_NVIEN
	group by HONV,TENNV

go
--29 Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
go
	select honv,tennv,count(*)
	from NHANVIEN,PHANCONG
	where MANV=MA_NVIEN
	group by honv,tennv
go
--30 Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
	select TENPHG,AVG(LUONG)
		from PHONGBAN,NHANVIEN
		where maphg=PHG
		group by TENPHG
	go
--31 Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
go
	select TENPHG,COUNT(*) as 'Số lượng nhân viên làm việc'
	from PHONGBAN,NHANVIEN
	where MAPHG=PHG
	group by TENPHG
	having avg(LUONG)>5200000
go
--32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
go	
	select TENPHG,count(*)
	from PHONGBAN,DEAN
	where maphg=phong
	group by TENPHG
	--dean
	select*
	from DEAN
go
--33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì
go
select TENPHG,HONV,TENLOT,TENNV,count(*) as 'Số lượng đề án'
	from PHONGBAN,NHANVIEN,DEAN
	where MANV=TRPHG and MAPHG=PHONG
	group by TENPHG,HONV,TENLOT,TENNV
go
--34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên của đề án
--này.
go
	select DEAN.TENDA,count(TENNV) as 'Số lượng NV'
	from DEAN,NHANVIEN
	where dean.MADA = NHANVIEN.MANV
	group by DEAN.TENDA
go
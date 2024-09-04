Use Quan_Ly_Sinh_Vien
GO

-- Functions --
-- 1. Với 1 mã sinh viên và 1 mã khoa, kiểm tra xem sinh viên có thuộc khóa này không?

CREATE FUNCTION KF_CHECK_SV_IN_KHOA
(
	@masv varchar(10),
	@makhoa varchar(10)
)
RETURNS VARCHAR(5)
AS
begin
DECLARE @ketqua varchar(5)
set @ketqua = 'False'
if (exists 
		(SELECT * FROM Sinh_Vien
		LEFT JOIN Lop ON Lop.Ma_Lop = Sinh_Vien.Ma_Lop
		LEFT JOIN Khoa ON Khoa.Ma_Khoa = Lop.Ma_Khoa
		WHERE Sinh_Vien.MaSV = @masv AND Khoa.Ma_Khoa = @makhoa
		)
	)
	set @ketqua = 'True'
else
	set @ketqua = 'False'
return @ketqua
-- print @ketqua
END

SELECT dbo.KF_CHECK_SV_IN_KHOA('0212003', 'CNTT')
SELECT dbo.KF_CHECK_SV_IN_KHOA('0212002', 'CNTT')
SELECT dbo.KF_CHECK_SV_IN_KHOA('0212004', 'VL')

-- Tính điểm thi sau cùng của 1 sinh viên trong một môn học cụ thể


-- CREATE FUNCTION KF_LAST_SCORE
ALTER FUNCTION KF_LAST_SCORE --Cập nhật
(
	@masv varchar(10),
	@mamh varchar(10)
)
RETURNS float
AS
begin
	declare @diem float;
	set @diem = 0;
	SELECT TOP 1 @diem = Ket_Qua.Diem_Thi FROM Ket_Qua
	WHERE @masv = MaSV AND MaMH = @mamh
	ORDER BY Ket_Qua.Lan_Thi DESC
	return @diem;
end
go

SELECT MaMH From Mon_Hoc

SELECT dbo.KF_LAST_SCORE ('0212002' ,'THCS01')
SELECT dbo.KF_LAST_SCORE ('0212003' ,'THT01')
SELECT dbo.KF_LAST_SCORE ('0212003' ,'THT02')
Go

-- 3. Tính điểm trung bình của một sinh viên  dựa vào câu 2



CREATE FUNCTION KF_LAST_AVG_SCORE
(
	@masv varchar(10)
)
RETURNS float
AS
begin
	declare @mamh varchar(10)
	declare @ketqua float

	SELECT @ketqua = AVG(dbo.KF_LAST_SCORE(@masv,Ket_Qua.MaMH)) FROM Ket_Qua
	WHERE Ket_Qua.MaSV = @masv

--	print @ketqua
	return @ketqua
end 
go
SELECT sv.MaSV, kq.Diem_Thi  FROM Sinh_Vien as sv, Ket_Qua as kq
WHERE sv.MaSV = kq.MaSV
go
SELECT dbo.KF_LAST_AVG_SCORE('0212002')
GO
SELECT dbo.KF_LAST_AVG_SCORE('0212003')
GO
SELECT dbo.KF_LAST_AVG_SCORE('0212001')
GO

-- 4.Nhập vào 1 sinh viên và 1 môn học, trả về các điểm thi của sinh viên trong các lần 
-- thi của môn học đó.


CREATE FUNCTION KF_LIST_SCORE_OF_SV
(
	@masv varchar(10),
	@mamh varchar(10)
)
RETURNS TABLE --TRẢ GIÁ TRỊ LÀ DANH SÁCH -- "RETURN TABLE" KHÔNG SỬ DỤNG BEGIN VÀ END
RETURN	
	SELECT Ket_Qua.Lan_Thi, Ket_Qua.Diem_Thi FROM Ket_Qua
	WHERE Ket_Qua.MaSV = @masv AND Ket_Qua.MaMH = @mamh
go

SELECT * FROM dbo.KF_LIST_SCORE_OF_SV('0212002','THCS01')



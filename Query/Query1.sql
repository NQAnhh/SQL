Use Quan_Ly_Sinh_Vien
GO

-- Cho biết sinh viên thi không đậu (Diem < 5) môn cấu trúc dữ  liệu 1 nhưng chưa thi lại. --
-- Lấy ra các sinh viên thi môn cấu trúc dữ liệu 1 mà không phải lần 1

-- Truy vấn lồng
SELECT * FROM Sinh_Vien
LEFT JOIN Ket_Qua ON Sinh_Vien.MaSV = Ket_Qua.MaSV
LEFT JOIN Mon_Hoc ON Ket_Qua.MaMH = Mon_Hoc.MaMH
WHERE Mon_Hoc.TenMH LIKE  N'Cấu trúc dữ liệu 1'
AND Ket_Qua.Lan_Thi = 1
AND Ket_Qua.Diem_Thi < 5
AND Sinh_Vien.MaSV not in (SELECT * FROM Sinh_Vien
							LEFT JOIN Ket_Qua ON Sinh_Vien.MaSV = Ket_Qua.MaSV
							LEFT JOIN Mon_Hoc ON Ket_Qua.MaMH = Mon_Hoc.MaMH
							WHERE Mon_Hoc.TenMH LIKE  N'Cấu trúc dữ liệu 1'
							AND Ket_Qua.Lan_Thi > 1)

-- Với mỗi lớp thuộc khoa CNTT, cho biết mã lớp, mã khóa học, tên chương trình và số sinh viên thuộc lớp đó.
-- 
SELECT Lop.Ma_Lop, Lop.Ma_Khoa_Hoc, Chuong_Trinh_Hoc.Ten_CT, COUNT(Sinh_Vien.MaSV) AS [Số sinh viên] FROM Lop
LEFT JOIN Chuong_Trinh_Hoc ON Lop.Ma_CT = Chuong_Trinh_Hoc.Ma_CT
LEFT JOIN Sinh_Vien ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Khoa.Ma_Khoa = Lop.Ma_Khoa
WHERE Khoa.Ma_Khoa = 'CNTT'
GROUP BY Lop.Ma_Lop, Lop.Ma_Khoa_Hoc, Chuong_Trinh_Hoc.Ten_CT

-- Cho biết điểm trung bình của sinh viên có mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên)
-- 
SELECT AVG(Ket_Qua.Diem_Thi) AS [Điểm trung bình] from Ket_Qua
LEFT JOIN
(SELECT MaMH, MAX(Lan_Thi) AS [Lần thi cuối] from Ket_Qua
WHERE Ket_Qua.MaSV = '0212003'
GROUP BY MaMH) table2
ON Ket_Qua.MaMH = table2.MaMH and Ket_Qua.Lan_Thi = table2.[Lần thi cuối]
WHERE MaSV = '0212003'
and Ket_Qua.Lan_Thi = table2.[Lần thi cuối]

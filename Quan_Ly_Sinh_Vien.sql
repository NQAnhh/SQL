-- Create database
CREATE DATABASE Quan_Ly_Sinh_Vien;
GO

-- Use the created database
USE Quan_Ly_Sinh_Vien;
GO

-- Create table Khoa
CREATE TABLE Khoa
(
    Ma_Khoa VARCHAR(10) PRIMARY KEY, 
    Ten_Khoa NVARCHAR(100), 
    Nam_Thanh_Lap INT
);
GO

-- Create table Khoa_Hoc
CREATE TABLE Khoa_Hoc
(
    Ma_Khoa_Hoc VARCHAR(10) PRIMARY KEY, 
    Nam_Bat_Dau INT,
    Nam_Ket_Thuc INT
);
GO

-- Create table Chuong_Trinh_Hoc
CREATE TABLE Chuong_Trinh_Hoc
(
    Ma_CT VARCHAR(10) PRIMARY KEY,
    Ten_CT NVARCHAR(100)
);
GO

-- Create table Lop
CREATE TABLE Lop
(
    Ma_Lop VARCHAR(10) PRIMARY KEY,
    Ma_Khoa VARCHAR(10) NOT NULL,
    Ma_Khoa_Hoc VARCHAR(10) NOT NULL,
    Ma_CT VARCHAR(10) NOT NULL,
    STT INT,

    FOREIGN KEY(Ma_Khoa) REFERENCES Khoa(Ma_Khoa),
    FOREIGN KEY(Ma_Khoa_Hoc) REFERENCES Khoa_Hoc(Ma_Khoa_Hoc),
    FOREIGN KEY(Ma_CT) REFERENCES Chuong_Trinh_Hoc(Ma_CT)
);
GO

-- Create table Sinh_Vien
CREATE TABLE Sinh_Vien
(
    MaSV VARCHAR(10) PRIMARY KEY,
    Ho_Ten NVARCHAR(100),
    Nam_Sinh INT,
    Dan_Toc NVARCHAR(20),
    Ma_Lop VARCHAR(10) NOT NULL,

    FOREIGN KEY(Ma_Lop) REFERENCES Lop(Ma_Lop)
);
GO

-- Create table Mon_Hoc
CREATE TABLE Mon_Hoc
(
    MaMH VARCHAR(10) PRIMARY KEY,
    Ma_Khoa VARCHAR(10) NOT NULL,
    TenMH NVARCHAR(100),

    FOREIGN KEY(Ma_Khoa) REFERENCES Khoa(Ma_Khoa)
);
GO

-- Create table Ket_Qua
CREATE TABLE Ket_Qua
(
    MaSV VARCHAR(10) NOT NULL,
    MaMH VARCHAR(10) NOT NULL,    
    Lan_Thi INT NOT NULL,
    Diem_Thi FLOAT,

    PRIMARY KEY(MaSV, MaMH, Lan_Thi),

    FOREIGN KEY(MaSV) REFERENCES Sinh_Vien(MaSV),
    FOREIGN KEY(MaMH) REFERENCES Mon_Hoc(MaMH)
);
GO

-- Create table Giang_Khoa
CREATE TABLE Giang_Khoa
(
    Ma_CT VARCHAR(10) NOT NULL,
    Ma_Khoa VARCHAR(10) NOT NULL,    
    MaMH VARCHAR(10) NOT NULL,
    Nam_Hoc INT NOT NULL,
    Hoc_Ky INT,
    STLT INT,
    STTH INT,
    So_Tin_Chi INT,

    PRIMARY KEY(Ma_CT, Ma_Khoa, MaMH, Nam_Hoc),

    FOREIGN KEY(Ma_CT) REFERENCES Chuong_Trinh_Hoc(Ma_CT),
    FOREIGN KEY(Ma_Khoa) REFERENCES Khoa(Ma_Khoa),
    FOREIGN KEY(MaMH) REFERENCES Mon_Hoc(MaMH)
);
GO

-- Insert data into Khoa
INSERT INTO Khoa(Ma_Khoa, Ten_Khoa, Nam_Thanh_Lap) 
VALUES ('CNTT', N'Công nghệ thông tin', 1995),
       ('VL', N'Vật Lý', 1970);
GO

-- Insert data into Khoa_Hoc
INSERT INTO Khoa_Hoc(Ma_Khoa_Hoc, Nam_Bat_Dau, Nam_Ket_Thuc) 
VALUES ('K2002', 2002, 2006),
       ('K2003', 2003, 2007),
       ('K2004', 2004, 2008);
GO

-- Insert data into Chuong_Trinh_Hoc
INSERT INTO Chuong_Trinh_Hoc(Ma_CT, Ten_CT) 
VALUES ('CQ', N'Chính Quy');
GO

-- Insert data into Lop
INSERT INTO Lop(Ma_Lop, Ma_Khoa, Ma_Khoa_Hoc, Ma_CT, STT) 
VALUES ('TH2002/01', 'CNTT', 'K2002', 'CQ', 1),
       ('TH2002/02', 'CNTT', 'K2002', 'CQ', 2),
       ('TH2003/01', 'VL', 'K2003', 'CQ', 1);
GO

-- Insert data into Sinh_Vien
INSERT INTO Sinh_Vien(MaSV, Ho_Ten, Nam_Sinh, Dan_Toc, Ma_Lop) 
VALUES ('0212001', N'Nguyễn Vĩnh An', 1984, N'Kinh', 'TH2002/01'),
       ('0212002', N'Nguyễn Thanh Bình', 1985, N'Kinh', 'TH2002/01'),
       ('0212003', N'Nguyễn Thanh Cường', 1984, N'Kinh', 'TH2002/02'),
       ('0212004', N'Nguyễn Quốc Duy', 1983, N'Kinh', 'TH2002/02'),
       ('0311001', N'Phan Tuấn Anh', 1985, N'Kinh', 'TH2003/01'),
       ('0311002', N'Huỳnh Thanh Sang', 1984, N'Kinh', 'TH2003/01');
GO

-- Insert data into Mon_Hoc
INSERT INTO Mon_Hoc(MaMH, Ma_Khoa, TenMH) 
VALUES ('THT01', 'CNTT', N'Toán cao cấp A1'),
       ('VLT01', 'VL', N'Toán cao cấp A1'),
       ('THT02', 'CNTT', N'Toán rời rạc'),
       ('THCS01', 'CNTT', N'Cấu trúc dữ liệu 1'),
       ('THCS02', 'CNTT', N'Hệ điều hành');
GO

-- Insert data into Ket_Qua
INSERT INTO Ket_Qua(MaSV, MaMH, Lan_Thi, Diem_Thi) 
VALUES ('0212001', 'THT01', 1, 4),
       ('0212001', 'THT01', 2, 7),
       ('0212002', 'THT01', 1, 8),
       ('0212003', 'THT01', 1, 6),
       ('0212004', 'THT01', 1, 9),
       ('0212001', 'THT02', 1, 8),
       ('0212002', 'THT02', 1, 5.5),
       ('0212003', 'THT02', 1, 4),
       ('0212003', 'THT02', 2, 6),
       ('0212001', 'THCS01', 1, 6.5),
       ('0212002', 'THCS01', 1, 4),
       ('0212003', 'THCS01', 1, 7);
GO

-- Insert data into Giang_Khoa
INSERT INTO Giang_Khoa(Ma_CT, Ma_Khoa, MaMH, Nam_Hoc, Hoc_Ky, STLT, STTH, So_Tin_Chi) 
VALUES ('CQ', 'CNTT', 'THT01', 2003, 1, 60, 30, 5),
       ('CQ', 'CNTT', 'THT02', 2003, 2, 45, 30, 4),
       ('CQ', 'CNTT', 'THCS01', 2004, 1, 45, 30, 4);
GO


SELECT * FROM Chuong_Trinh_Hoc

SELECT * FROM Ket_Qua

SELECT* FROM Sinh_Vien, Khoa , Khoa_Hoc, Lop 
WHERE Sinh_Vien.Ma_Lop = Lop.Ma_Lop
AND Lop.Ma_Khoa = Khoa.Ma_Khoa
AND Khoa.Ma_Khoa = 'CNTT'
AND Khoa_Hoc.Ma_Khoa_Hoc = 'K2002'


SELECT * FROM Khoa_Hoc


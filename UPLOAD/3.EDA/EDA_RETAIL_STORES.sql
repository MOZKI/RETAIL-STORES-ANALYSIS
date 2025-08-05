-- ==============================================
# EDA (Exploratory Data Analysis) 
-- ==============================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Memahami Struktur Data
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 1. Menghitung Jumlah Data (How Much Records or Rows ?) Dan Sample Data
SELECT COUNT(*) AS 'Jumlah Baris'
FROM clean_dataset;

SELECT *
FROM clean_dataset
LIMIT 5;

-- 2. Cek Duplikat 
SELECT `Transaction ID`, COUNT(*) AS 'Jumlah Duplikat'
FROM clean_dataset
GROUP BY 1
HAVING COUNT(*) > 1;

-- 3. Cek Missing Value (NULL)
SELECT
	SUM(CASE WHEN `Transaction ID` IS NULL THEN 1 ELSE 0 END) AS 'Missing Transaction ID',
	SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS 'Missing Customer ID',
	SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) AS 'Missing Category',
    SUM(CASE WHEN `Item` IS NULL THEN 1 ELSE 0 END) AS 'Missing Item',
	SUM(CASE WHEN `Price Per Unit` IS NULL THEN 1 ELSE 0 END) AS 'Missing Price Per Unit',
    SUM(CASE WHEN `Quantity` IS NULL THEN 1 ELSE 0 END) AS 'Missing Quantity',
    SUM(CASE WHEN `Total Spent` IS NULL THEN 1 ELSE 0 END) AS 'Missing Total Spent',
    SUM(CASE WHEN `Payment Method` IS NULL THEN 1 ELSE 0 END) AS 'Missing Payment Method',
    SUM(CASE WHEN `Location` IS NULL THEN 1 ELSE 0 END) AS 'Missing Location',
    SUM(CASE WHEN `Transaction Date` IS NULL THEN 1 ELSE 0 END) AS 'Missing Transaction Date'
FROM clean_dataset;

-- 4. Nilai Unik Per Kolom (Untuk Field Kategorikal)
SELECT DISTINCT `Customer ID`
FROM clean_dataset;

SELECT DISTINCT `Category`
FROM clean_dataset;

SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Food'
ORDER BY 2 ASC;

SELECT DISTINCT `Payment Method`
FROM clean_dataset;

SELECT DISTINCT `Location`
FROM clean_dataset;

-- 5. Cek Tipe Data (Apakah Sudah Sesuai)
DESCRIBE clean_dataset;
-- ==============================================
#							Memahami Struktur Data
-- 1. Dataset terdiri dari 11.971 baris dan 10 kolom
-- 2. Tidak ada transaksi yang terduplikat 
-- 3. Setiap field juga sudah tidak ada NULL 
-- 4. Terdapat 22 Customer ID, Produk dibagi menjadi 8 kategori dan tiap kategori mencakup 25 produk, Ada 3 payment method yang digunakan, dan untuk lokasi pemesanan hanya online dan in-store
-- 5. Tipe data sudah sesuai 
-- ==============================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Distribusi Awal / Statistik Deskriptif
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 1. Distribusi Waktu (Periode Dataset)
SELECT MIN(`Transaction Date`) AS Dari, MAX(`Transaction Date`) AS Sampai
FROM clean_dataset;

SELECT
	DATE_FORMAT(`Transaction Date`, '%Y-%m') AS 'Tahun-Bulan',
    COUNT(*) AS 'Jumlah Transaksi',
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;

-- 2. Jumlah Transaksi Per Customer ID
SELECT 
	`Customer ID`, 
    COUNT(*) AS 'Jumlah Transaksi',
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;

-- 3. Jumlah Transaksi Per Category
SELECT 
	`Category`, 
    COUNT(*) AS 'Jumlah Transaksi',
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;

-- 4. Jumlah Transaksi Per Item
SELECT 
	`Item`, 
    COUNT(*) AS 'Jumlah Transaksi',
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;

-- 5. Jumlah Transaksi Per Payment Method
SELECT 
	`Payment Method`, 
    COUNT(*) AS 'Jumlah Transaksi',
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;

-- 6. Jumlah Transaksi Per Location
SELECT 
	`Location`, 
	COUNT(*) AS 'Jumlah Transaksi',
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;
-- ==============================================
#							Distribusi Awal / Statistik Deskriptif
-- 1. Dataset berlaku dari 1 Januari 2022 sampai 18 Januari 2025. Dan jumlah transaksi terbanyak terdapat pada Januari 2022
-- 2. Customer 24 merupakan customer dengan jumlah transaksi terbanyak (519 transaksi)
-- 3. Furniture menjadi kategori produk dengan jumlah transaksi terbanyak (1.525 transaksi)
-- 4. Item 2 Beverages menjadi jumlah transaksi terbanyak (128 transaksi) 
-- 5. Cash menjadi metode pembayaran yang diminati (4.103 transaksi)
-- 6. Pelanggan cenderung melakukan pembelian secara Online (6.068 transaksi)
-- ==============================================

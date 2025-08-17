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
# Distribusi Awal
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
#							Distribusi Awal 
-- 1. Dataset berlaku dari 1 Januari 2022 sampai 18 Januari 2025. Dan jumlah transaksi terbanyak terdapat pada Januari 2022
-- 2. Customer 24 merupakan customer dengan jumlah transaksi terbanyak (519 transaksi)
-- 3. Furniture menjadi kategori produk dengan jumlah transaksi terbanyak (1.525 transaksi)
-- 4. Item 2 Beverages menjadi jumlah transaksi terbanyak (128 transaksi) 
-- 5. Cash menjadi metode pembayaran yang diminati (4.103 transaksi)
-- 6. Pelanggan cenderung melakukan pembelian secara Online (6.068 transaksi)
-- ==============================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Statistik Deskriptif 
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 1. Statistik deskrpitif total pemasukan
SELECT 
    COUNT(*) AS total_transactions,
    ROUND(AVG(`Total Spent`), 2) AS avg_spending,
    ROUND(MIN(`Total Spent`), 2) AS min_spending,
    ROUND(MAX(`Total Spent`), 2) AS max_spending,
    ROUND(STDDEV(`Total Spent`), 2) AS std_dev_spending,
    CONCAT(ROUND(STDDEV(`Total Spent`) / AVG(`Total Spent`) * 100, 2), '%') AS coefficient_of_variation
FROM clean_dataset;

-- 2. Kategori produk: rata-rata pemasukan dan konsistensi sebaran data
SELECT
	`Category`,
	ROUND(AVG(`Total Spent`), 2) AS avg_spending,
	ROUND(STDDEV(`Total Spent`), 2) AS std_dev_spending,
    CONCAT(ROUND(STDDEV(`Total Spent`) / AVG(`Total Spent`) * 100, 2), '%') AS coefficient_of_variation
FROM clean_dataset
GROUP BY 1
ORDER BY 4 ASC;
-- ==============================================
#							# Statistik Deskriptif 
-- 1.) STD DEV $94.75 menunjukkan sebaran data cukup besar, 
--    Coefficient of variation 73.08% mengindikasikan tingkat variabilitas tinggi dalam pola spending
-- 	  CV > 50% menunjukkan customer behavior yang tidak konsisten dan sulit diprediksi

-- 2.) Computers and electric accessories paling konsisten (CV 68.67%), sementara Milk Products paling volatil (CV 77.99%)
--    Butchers kategori dengan rata-rata spending tertinggi ($139.12), Milk Products terendah ($119.04)
--    Semua kategori menunjukkan CV > 65%, mengkonfirmasi high variability di seluruh kategori produk
-- ==============================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Quartile Distribution
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 1. Distribusi Spending: Analisis Batas Quartile Q1, Q2(Median), Q3. Menentukan range spending untuk setiap quartile group
WITH quartiles AS (
    SELECT 
        `Total Spent`,
        NTILE(4) OVER (ORDER BY `Total Spent`) AS quartile_group
    FROM clean_dataset
)
SELECT 
	MIN(`Total Spent`),
    ROUND(MIN(CASE WHEN quartile_group = 1 THEN `Total Spent` END), 2) AS Q1_min_max,
    ROUND(MIN(CASE WHEN quartile_group = 2 THEN `Total Spent` END), 2) AS Median_min_max,
    ROUND(MIN(CASE WHEN quartile_group = 3 THEN `Total Spent` END), 2) AS Q3_min_max,
    MAX(`Total Spent`)
FROM quartiles
UNION ALL
SELECT 
	MIN(`Total Spent`),
    ROUND(MAX(CASE WHEN quartile_group = 1 THEN `Total Spent` END), 2) AS Q1_max,
    ROUND(MAX(CASE WHEN quartile_group = 2 THEN `Total Spent` END), 2) AS Q2_max,
    ROUND(MAX(CASE WHEN quartile_group = 3 THEN `Total Spent` END), 2) AS Q3_max,
    MAX(`Total Spent`)
FROM quartiles;

-- 2. Customer segmentation with quartile
WITH spending_quartiles AS (
    SELECT 
        `Customer ID`,
        SUM(`Total Spent`) AS total_customer_spending,
        NTILE(4) OVER (ORDER BY SUM(`Total Spent`)) AS spending_quartile
    FROM clean_dataset 
    GROUP BY `Customer ID`
)
SELECT 
    spending_quartile,
    `Customer ID`,
    total_customer_spending,
    CASE 
        WHEN spending_quartile = 1 THEN 'Low Value'
        WHEN spending_quartile = 2 THEN 'Medium-Low Value' 
        WHEN spending_quartile = 3 THEN 'Medium-High Value'
        WHEN spending_quartile = 4 THEN 'High Value'
    END AS customer_segment
FROM spending_quartiles
ORDER BY spending_quartile, total_customer_spending ASC;
-- ==============================================
#			Quartile Distribution
-- 1.) Customer tersegmentasi jelas: Low spenders ($5-$51), Medium ($51-$108.5), High spenders ($108.5-$192)
--    Gap besar Q3 ($192.0) dengan max value ($410.0) mengkonfirmasi adanya outliers/extreme high spenders
--    Mayoritas customer (75%) spending di bawah $192, dengan segmen premium yang distinct dan berpotensi tinggi

-- 2.) 25% customer terendah ($57K-$60K) - Low Value segment untuk retention strategy
--    50% customer tengah ($60K-$63K) - Medium segments untuk upselling opportunities  
--    25% customer tertinggi ($64K-$68K) - High Value segment untuk VIP treatment
-- ==============================================
SELECT * FROM clean_dataset
LIMIT 15000;

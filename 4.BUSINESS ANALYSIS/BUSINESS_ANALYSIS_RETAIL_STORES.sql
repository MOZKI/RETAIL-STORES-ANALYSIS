-- ==============================================
# Analisa Lanjutan (Untuk Menjawab Pertanyaan Bisnis Yang Possible Muncul)
-- ==============================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# 1. Sales Performance & Trends
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 1.1 Bagaimana tren revenue per tahun ?
SELECT 
	DATE_FORMAT(`Transaction Date`, '%Y') AS 'Tahun',
    ROUND(SUM(`Total Spent`), 0) AS 'Revenue',
    COUNT(*) AS 'Jumlah Transaksi',
    ROUND(AVG(`Total Spent`), 2) AS 'AOV'
FROM clean_dataset
GROUP BY 1
ORDER BY 1 ASC;
-- Insights: 
-- Tahun 2024 mencatat rekor revenue tertinggi mencapai $524.881 dengan 4.036 jumlah transaksi.
-- Terjadi penurunan growth rate di 2023 sebesar -3,7% (dari 2022), namun recovery dengan baik di 2024 dengan kenaikkan growth rate sebesar 6,8% (dari 2023).
-- Jumlah transaksi menjadi faktor utama kenaikkan revenue sebanyak 228 transaksi bertambah dari sebelumnya dibandingkan AOV yang cenderung stabil.

-- Business Takeaway:
-- Strategi pertumbuhan: Fokus pada akuisisi pelanggan (terbukti efektif 2024)
-- Pertahankan konsistensi AOV sambil scaling volume transaksi
-- Monitor sustainability tren untuk keberlangsungan 2025

-- 1.2 Lalu bagaimana tren revenue per bulan untuk tahun 2024 ? (tahun dengan revenue terbanyak) 
SELECT 
	CONCAT(DATE_FORMAT(`Transaction Date`, '%m'), ' ', MONTHNAME(`Transaction Date`)) AS 'Bulan',
    ROUND(SUM(`Total Spent`), 0) AS 'Revenue',
    COUNT(*) AS 'Jumlah Transaksi',
    ROUND(AVG(`Total Spent`), 2) AS 'AOV'
FROM clean_dataset
WHERE YEAR(`Transaction Date`) = '2024%'
GROUP BY 1
ORDER BY 1 ASC;
-- Insights: 
-- Desemeber menjadi bulan dengan revenue tertinggi sebesar $48.467 dengan 357 transaksi.
-- Diikuti Januari ($47.909) dengan 363 transaksi
-- Desember menjadi yang tertinggi karena AOV-nya lebih besar dibanding Januari, walaupun Januari punya lebih banyak transaksi
-- AOV tertinggi jatuh di bulan April (most efficient month) 
-- Februari memiliki performa terburuk untuk revenue hanya mencapai $37.145 dengan 304 transaksi

-- Business Takeaway: 
-- Seasonal peak natal dan tahun baru Desember - Januari (Maksimalkan ketersediaan untuk high-demand categories)
-- April memiliki AOV tertinggi karena fewer customers + higher spending per customer (Promosi high value item di bulan lain ?)
-- Februari mengindikasikan low volume transaction + lower AOV purchases (Bundle promotions ?)

-- 1.3 Hari apa dalam seminggu yang menghasilkan revenue tertinggi?
SELECT 
    DAYNAME(`Transaction Date`) AS 'Hari',
    ROUND(SUM(`Total Spent`), 0) AS 'Revenue',
    COUNT(*) AS 'Jumlah Transaksi',
    ROUND(AVG(`Total Spent`), 2) AS 'AOV'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;
-- Insights:
-- Jum'at menjadi hari dengan revenue tertinggi mencapai $232.786 dengan 1.729 transaksi
-- Diikuti Minggu $225.991 dengan 1.736 transaksi (more volume, lower AOV)
-- Senin performa terburuk (low volume transaction + lower AOV purchases)
 
-- Business Takeaway: 
-- End of week pattern terlihat jelas Jum'at-Minggu (Maksimalkan ketersediaan yang mungkin diminati)
-- Senin low transaction + lower AOV purchases (Adakan bundle promotions ?)

-- 1.4 Payment method apa yang paling diminati ?
SELECT 
    `Payment Method`,
    ROUND(SUM(`Total Spent`), 0) AS 'Revenue',
    ROUND(AVG(`Total Spent`), 2) AS 'AOV',
    COUNT(*) AS 'Jumlah Transaksi',
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;
-- Insight:
-- Cash menjadi payment method yang paling diminati dengan 4.103 transaksi ($537.710)

-- Business Takeaway:
-- Maksimalkan digital wallet untuk transformasi digital (Adakan discount untuk pembelian tertentu menggunakan digital wallet)

-- 1.5 Lokasi pembelian yang diminati ? 
SELECT 
    `Location`,
    ROUND(SUM(`Total Spent`), 0) AS 'Revenue',
    ROUND(AVG(`Total Spent`), 2) AS 'AOV',
    COUNT(*) AS 'Jumlah Transaksi',
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_dataset), 2) AS 'Persentase'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;
-- Insight:
-- Untuk lokasi pembelian online lebih diminati dengan 6.068 transaksi ($791.401) dibandingkan in-store.

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# 2.) Customer 
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 2.1 Siapa customer yang paling valuable (highest spending, most frequent purchases)?
SELECT 
	`Customer ID`, 
    ROUND(SUM(`Total Spent`), 0) AS `Total Spending`,
	COUNT(*) AS `Jumlah Transaksi`,
    ROUND(AVG(`Total Spent`), 2) AS 'AOV'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;
-- Insights:
-- CUST 24 menjadi most valuable customer (top spending + most frequent purchases) dengan total spent sebesar $68.452 (519 transaksi) 

-- Business Takeaway:
-- Focus retention efforts pada CUST 24 (VIP member, Special Discounts/offers)

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# 3.) Category 
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 3.1 Kategori produk mana yang menghasilkan revenue terbanyak ?
SELECT
	`Category`,
    ROUND(SUM(`Total Spent`), 0) AS 'Total Revenue',
    SUM(`Quantity`) AS 'Total Terjual',
	ROUND( ROUND(SUM(`Total Spent`), 0) /  SUM(`Quantity`), 2) AS 'Revenue per Item'
FROM clean_dataset
GROUP BY 1
ORDER BY 2 DESC;
-- Insights:
-- Butchers = revenue leader ($208.118) dengan 8.206 item terjual
-- Furniture = volume leader (8.462 item terjual) 

-- Business Takeaway:
-- Butchers high revenue + good volume (Improve quality)  
-- Furniture high demand + good revenue (Optimalkan ketersediaan)

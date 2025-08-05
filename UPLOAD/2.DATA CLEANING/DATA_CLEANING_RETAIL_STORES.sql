-- ==============================================
# DATA CLEANING 
-- ==============================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT *
FROM retail_dataset
LIMIT 15000;
SELECT COUNT(*) AS 'Jumlah Rows'
FROM retail_dataset;
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#1. Membuat Tabel Baru Untuk Proses Cleaning Data
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
CREATE TABLE clean_dataset
LIKE retail_dataset;

INSERT clean_dataset
SELECT * FROM retail_dataset;

SELECT *
FROM clean_dataset
LIMIT 15000;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#2. Update Blank Values Di Tiap Field Menjadi NULL
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Transaction ID
SELECT *
FROM clean_dataset
WHERE `Transaction ID` = '';

-- Customer ID
SELECT *
FROM clean_dataset
WHERE `Customer ID` = '';

-- Category
SELECT *
FROM clean_dataset
WHERE `Category` = '';

-- Item
SELECT *
FROM clean_dataset
WHERE `Item` = '';
UPDATE clean_dataset
SET `Item` = NULL
WHERE `Item` = '';

-- Price Per Unit
SELECT *
FROM clean_dataset
WHERE `Price Per Unit` = '';
UPDATE clean_dataset
SET `Price Per Unit` = NULL
WHERE `Price Per Unit` = '';

-- Quantity
SELECT *
FROM clean_dataset
WHERE `Quantity` = '';
UPDATE clean_dataset
SET `Quantity` = NULL
WHERE `Quantity` = '';

-- Total Spent
SELECT *
FROM clean_dataset
WHERE `Total Spent` = '';
UPDATE clean_dataset
SET `Total Spent` = NULL
WHERE `Total Spent` = '';

-- Payment Method
SELECT *
FROM clean_dataset
WHERE `Payment Method` = '';

-- Location
SELECT *
FROM clean_dataset
WHERE `Location` = '';

-- Transaction Date
SELECT *
FROM clean_dataset
WHERE `Transaction Date` = '';

-- Discount Applied
SELECT *
FROM clean_dataset
WHERE `Discount Applied` = '';
UPDATE clean_dataset
SET `Discount Applied` = NULL
WHERE `Discount Applied` = '';

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#3. Menyesuaikan Tipe Data Sesuai Dengan Field (Semua Field Masih Dalam Tipe Data Text)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
DESCRIBE clean_dataset;

-- Quantity
ALTER TABLE clean_dataset
MODIFY COLUMN `Quantity` INT;

-- Price Per Unit
ALTER TABLE clean_dataset
MODIFY COLUMN `Price Per Unit` DECIMAL(3,1);

-- Total Spent
ALTER TABLE clean_dataset
MODIFY COLUMN `Total Spent` DECIMAL(4,1);

-- Transaction Date
ALTER TABLE clean_dataset
MODIFY COLUMN `Transaction Date` DATE;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#4. Menghapus Duplikat Rows (Jika Ada)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Transaction ID`, `Customer ID`, `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`, `Payment Method`, `Location`, `Transaction Date`, `Discount Applied`) AS ROW_NUM
FROM clean_dataset
LIMIT 15000;

WITH duplikat_rows AS (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY `Transaction ID`, `Customer ID`, `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`, `Payment Method`, `Location`, `Transaction Date`, `Discount Applied`) AS ROW_NUM
	FROM clean_dataset
)
SELECT *
FROM duplikat_rows
WHERE ROW_NUM > 1;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#5. Temukan dan Perbaiki Typo/Penggunaan Kata Tidak Efektif (Jika Ada)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Category
SELECT DISTINCT `Category`
FROM clean_dataset;

-- Item
SELECT DISTINCT `Item`
FROM clean_dataset;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#6. Membersihkan Rows Yang Terdapat Banyak Null 
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Field Category berkaitan dengan field Item, setiap Category mencakup 25 Item.
-- Item berkaitan juga dengan Price Per Unit (harga satuan)
-- Price Per Unit berkaitan dengan Quantity dan Total Spent (Total Spent = Price Per Unit x Quantity)
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- Cleaning Per Category --

-- >> Patisserie << -- 
-- 1. Mengupdate Harga Satuan Yang NULL 
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Patisserie' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Patisserie' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 
	`Category` = 'Patisserie'
    AND `Price Per Unit` IS NULL
    AND `Total Spent` IS NOT NULL
    AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL
SELECT *
FROM clean_dataset
WHERE `Category` = 'Patisserie' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 5.0 THEN 'Item_1_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 6.5 THEN 'Item_2_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 8.0 THEN 'Item_3_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 9.5 THEN 'Item_4_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 11.0 THEN 'Item_5_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 12.5 THEN 'Item_6_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 14.0 THEN 'Item_7_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 15.5 THEN 'Item_8_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 17.0 THEN 'Item_9_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 18.5 THEN 'Item_10_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 20.0 THEN 'Item_11_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 21.5 THEN 'Item_12_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 23.0 THEN 'Item_13_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 24.5 THEN 'Item_14_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 26.0 THEN 'Item_15_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 27.5 THEN 'Item_16_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 29.0 THEN 'Item_17_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 30.5 THEN 'Item_18_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 32.0 THEN 'Item_19_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 33.5 THEN 'Item_20_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 35.0 THEN 'Item_21_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 36.5 THEN 'Item_22_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 38.0 THEN 'Item_23_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 39.5 THEN 'Item_24_PAT'
    WHEN `Category` = 'Patisserie' AND `Price Per Unit` = 41.0 THEN 'Item_25_PAT'
END
WHERE `Category` = 'Patisserie'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus Pointless Rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE 	
	`Category` = 'Patisserie' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
        
DELETE FROM clean_dataset
WHERE 	
	`Category` = 'Patisserie' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
-- =================================
SELECT * FROM clean_dataset
WHERE `Category` = 'Patisserie';
-- =================================

-- >> Milk Products << -- 
-- 1. Mengupdate Harga Satuan Yang NULL
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Milk Products' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Milk Products' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 
	`Category` = 'Milk Products'
    AND `Price Per Unit` IS NULL
    AND `Total Spent` IS NOT NULL
    AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL
SELECT *
FROM clean_dataset
WHERE `Category` = 'Milk Products' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 5.0 THEN 'Item_1_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 6.5 THEN 'Item_2_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 8.0 THEN 'Item_3_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 9.5 THEN 'Item_4_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 11.0 THEN 'Item_5_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 12.5 THEN 'Item_6_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 14.0 THEN 'Item_7_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 15.5 THEN 'Item_8_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 17.0 THEN 'Item_9_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 18.5 THEN 'Item_10_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 20.0 THEN 'Item_11_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 21.5 THEN 'Item_12_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 23.0 THEN 'Item_13_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 24.5 THEN 'Item_14_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 26.0 THEN 'Item_15_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 27.5 THEN 'Item_16_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 29.0 THEN 'Item_17_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 30.5 THEN 'Item_18_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 32.0 THEN 'Item_19_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 33.5 THEN 'Item_20_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 35.0 THEN 'Item_21_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 36.5 THEN 'Item_22_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 38.0 THEN 'Item_23_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 39.5 THEN 'Item_24_MILK'
    WHEN `Category` = 'Milk Products' AND `Price Per Unit` = 41.0 THEN 'Item_25_MILK'
END
WHERE `Category` = 'Milk Products'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus Pointless Rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE 	
	`Category` = 'Milk Products' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
        
DELETE FROM clean_dataset
WHERE 
	`Category` = 'Milk Products' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
    
-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Milk Products';
-- =================================

-- >> Butchers << -- 
-- 1. Mengupdate Harga Satuan Yang NULL
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Butchers' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Butchers' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 
	`Category` = 'Butchers'
    AND `Price Per Unit` IS NULL
    AND `Total Spent` IS NOT NULL
    AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL
SELECT *
FROM clean_dataset
WHERE `Category` = 'Butchers' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 5.0 THEN 'Item_1_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 6.5 THEN 'Item_2_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 8.0 THEN 'Item_3_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 9.5 THEN 'Item_4_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 11.0 THEN 'Item_5_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 12.5 THEN 'Item_6_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 14.0 THEN 'Item_7_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 15.5 THEN 'Item_8_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 17.0 THEN 'Item_9_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 18.5 THEN 'Item_10_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 20.0 THEN 'Item_11_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 21.5 THEN 'Item_12_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 23.0 THEN 'Item_13_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 24.5 THEN 'Item_14_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 26.0 THEN 'Item_15_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 27.5 THEN 'Item_16_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 29.0 THEN 'Item_17_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 30.5 THEN 'Item_18_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 32.0 THEN 'Item_19_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 33.5 THEN 'Item_20_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 35.0 THEN 'Item_21_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 36.5 THEN 'Item_22_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 38.0 THEN 'Item_23_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 39.5 THEN 'Item_24_BUT'
    WHEN `Category` = 'Butchers' AND `Price Per Unit` = 41.0 THEN 'Item_25_BUT'
END
WHERE `Category` = 'Butchers'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);


-- 3. Menghapus Pointless Rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE 	
	`Category` = 'Butchers' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
    
DELETE FROM clean_dataset
WHERE 	
	`Category` = 'Butchers' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Butchers';
-- =================================

-- >> Beverages << -- 
-- 1. Mengupdate Harga Satuan Yang NULL
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Beverages' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Beverages' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 
	`Category` = 'Beverages'
    AND `Price Per Unit` IS NULL
    AND `Total Spent` IS NOT NULL
    AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL
SELECT *
FROM clean_dataset
WHERE `Category` = 'Beverages' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 5.0 THEN 'Item_1_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 6.5 THEN 'Item_2_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 8.0 THEN 'Item_3_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 9.5 THEN 'Item_4_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 11.0 THEN 'Item_5_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 12.5 THEN 'Item_6_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 14.0 THEN 'Item_7_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 15.5 THEN 'Item_8_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 17.0 THEN 'Item_9_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 18.5 THEN 'Item_10_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 20.0 THEN 'Item_11_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 21.5 THEN 'Item_12_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 23.0 THEN 'Item_13_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 24.5 THEN 'Item_14_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 26.0 THEN 'Item_15_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 27.5 THEN 'Item_16_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 29.0 THEN 'Item_17_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 30.5 THEN 'Item_18_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 32.0 THEN 'Item_19_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 33.5 THEN 'Item_20_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 35.0 THEN 'Item_21_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 36.5 THEN 'Item_22_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 38.0 THEN 'Item_23_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 39.5 THEN 'Item_24_BEV'
    WHEN `Category` = 'Beverages' AND `Price Per Unit` = 41.0 THEN 'Item_25_BEV'
END
WHERE `Category` = 'Beverages'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus Pointless Rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE 	
	`Category` = 'Beverages' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
    
DELETE FROM clean_dataset
WHERE 	
	`Category` = 'Beverages' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Beverages';
-- =================================

-- >> Food << -- 
-- 1. Mengupdate Harga Satuan (Untuk Data Yang NULL)
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Food' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Food' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 	
	`Category` = 'Food' 
	AND `Price Per Unit` IS NULL 
	AND `Total Spent` IS NOT NULL 
	AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item (Untuk Data Yang NULL)
SELECT *
FROM clean_dataset
WHERE `Category` = 'Food' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Food' AND `Price Per Unit` = 5.0 THEN 'Item_1_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 6.5 THEN 'Item_2_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 8.0 THEN 'Item_3_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 9.5 THEN 'Item_4_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 11.0 THEN 'Item_5_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 12.5 THEN 'Item_6_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 14.0 THEN 'Item_7_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 15.5 THEN 'Item_8_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 17.0 THEN 'Item_9_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 18.5 THEN 'Item_10_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 20.0 THEN 'Item_11_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 21.5 THEN 'Item_12_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 23.0 THEN 'Item_13_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 24.5 THEN 'Item_14_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 26.0 THEN 'Item_15_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 27.5 THEN 'Item_16_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 29.0 THEN 'Item_17_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 30.5 THEN 'Item_18_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 32.0 THEN 'Item_19_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 33.5 THEN 'Item_20_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 35.0 THEN 'Item_21_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 36.5 THEN 'Item_22_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 38.0 THEN 'Item_23_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 39.5 THEN 'Item_24_FOOD'
    WHEN `Category` = 'Food' AND `Price Per Unit` = 41.0 THEN 'Item_25_FOOD'
END
WHERE `Category` = 'Food'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus pointless rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE
	`Category` = 'Food' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

DELETE FROM clean_dataset
WHERE
	`Category` = 'Food' 
	AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
    
-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Food';
-- =================================

-- >> Furniture << -- 
-- 1. Mengupdate Harga Satuan Yang NULL
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Furniture' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Furniture' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 	`Category` = 'Furniture' 
		AND `Price Per Unit` IS NULL 
		AND `Total Spent` IS NOT NULL 
		AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL 
SELECT *
FROM clean_dataset
WHERE `Category` = 'Furniture' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 5.0 THEN 'Item_1_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 6.5 THEN 'Item_2_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 8.0 THEN 'Item_3_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 9.5 THEN 'Item_4_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 11.0 THEN 'Item_5_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 12.5 THEN 'Item_6_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 14.0 THEN 'Item_7_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 15.5 THEN 'Item_8_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 17.0 THEN 'Item_9_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 18.5 THEN 'Item_10_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 20.0 THEN 'Item_11_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 21.5 THEN 'Item_12_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 23.0 THEN 'Item_13_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 24.5 THEN 'Item_14_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 26.0 THEN 'Item_15_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 27.5 THEN 'Item_16_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 29.0 THEN 'Item_17_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 30.5 THEN 'Item_18_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 32.0 THEN 'Item_19_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 33.5 THEN 'Item_20_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 35.0 THEN 'Item_21_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 36.5 THEN 'Item_22_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 38.0 THEN 'Item_23_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 39.5 THEN 'Item_24_FUR'
    WHEN `Category` = 'Furniture' AND `Price Per Unit` = 41.0 THEN 'Item_25_FUR'
END
WHERE `Category` = 'Furniture'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus pointless rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE
	`Category` = 'Furniture' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

DELETE FROM clean_dataset
WHERE
	`Category` = 'Furniture' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Furniture';
-- =================================

-- >> Electric household essentials << -- 
-- 1. Mengupdate Harga Satuan Yang NULL
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Electric household essentials' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Electric household essentials' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 	
	`Category` = 'Electric household essentials' 
	AND `Price Per Unit` IS NULL 
	AND `Total Spent` IS NOT NULL 
	AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL
SELECT *
FROM clean_dataset
WHERE `Category` = 'Electric household essentials' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 5.0 THEN 'Item_1_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 6.5 THEN 'Item_2_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 8.0 THEN 'Item_3_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 9.5 THEN 'Item_4_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 11.0 THEN 'Item_5_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 12.5 THEN 'Item_6_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 14.0 THEN 'Item_7_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 15.5 THEN 'Item_8_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 17.0 THEN 'Item_9_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 18.5 THEN 'Item_10_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 20.0 THEN 'Item_11_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 21.5 THEN 'Item_12_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 23.0 THEN 'Item_13_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 24.5 THEN 'Item_14_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 26.0 THEN 'Item_15_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 27.5 THEN 'Item_16_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 29.0 THEN 'Item_17_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 30.5 THEN 'Item_18_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 32.0 THEN 'Item_19_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 33.5 THEN 'Item_20_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 35.0 THEN 'Item_21_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 36.5 THEN 'Item_22_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 38.0 THEN 'Item_23_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 39.5 THEN 'Item_24_EHE'
    WHEN `Category` = 'Electric household essentials' AND `Price Per Unit` = 41.0 THEN 'Item_25_EHE'
END
WHERE `Category` = 'Electric household essentials'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus Pointless Rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE
	`Category` = 'Electric household essentials' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

DELETE FROM clean_dataset
WHERE
	`Category` = 'Electric household essentials' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;
    
-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Electric household essentials';
-- =================================

-- >> Computers and electric accessories << -- 
-- 1. Mengupdate Harga Satuan Yang NULL
SELECT DISTINCT `Item`, `Price Per Unit`
FROM clean_dataset
WHERE `Category` = 'Computers and electric accessories' AND `Item` IS NOT NULL
ORDER BY 2 ASC;

SELECT *
FROM clean_dataset
WHERE `Category` = 'Computers and electric accessories' AND `Price Per Unit` IS NULL;

UPDATE clean_dataset
SET `Price Per Unit` = `Total Spent` / `Quantity`
WHERE 	
	`Category` = 'Computers and electric accessories' 
	AND `Price Per Unit` IS NULL 
	AND `Total Spent` IS NOT NULL 
	AND `Quantity` IS NOT NULL;

-- 2. Mengupdate Item Yang NULL
SELECT *
FROM clean_dataset
WHERE `Category` = 'Computers and electric accessories' AND `Item` IS NULL;

UPDATE clean_dataset
SET `Item` = CASE 
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 5.0 THEN 'Item_1_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 6.5 THEN 'Item_2_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 8.0 THEN 'Item_3_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 9.5 THEN 'Item_4_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 11.0 THEN 'Item_5_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 12.5 THEN 'Item_6_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 14.0 THEN 'Item_7_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 15.5 THEN 'Item_8_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 17.0 THEN 'Item_9_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 18.5 THEN 'Item_10_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 20.0 THEN 'Item_11_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 21.5 THEN 'Item_12_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 23.0 THEN 'Item_13_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 24.5 THEN 'Item_14_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 26.0 THEN 'Item_15_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 27.5 THEN 'Item_16_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 29.0 THEN 'Item_17_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 30.5 THEN 'Item_18_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 32.0 THEN 'Item_19_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 33.5 THEN 'Item_20_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 35.0 THEN 'Item_21_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 36.5 THEN 'Item_22_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 38.0 THEN 'Item_23_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 39.5 THEN 'Item_24_CEA'
    WHEN `Category` = 'Computers and electric accessories' AND `Price Per Unit` = 41.0 THEN 'Item_25_CEA'
END
WHERE `Category` = 'Computers and electric accessories'
  AND `Price Per Unit` IN (
    5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5, 17.0, 18.5,
    20.0, 21.5, 23.0, 24.5, 26.0, 27.5, 29.0, 30.5, 32.0,
    33.5, 35.0, 36.5, 38.0, 39.5, 41.0
);

-- 3. Menghapus Pointless Rows
SELECT `Category`, `Item`, `Price Per Unit`, `Quantity`, `Total Spent`
FROM clean_dataset
WHERE
	`Category` = 'Computers and electric accessories' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

DELETE FROM clean_dataset
WHERE
	`Category` = 'Computers and electric accessories' 
    AND `Quantity` IS NULL 
    AND `Total Spent` IS NULL;

-- =================================
SELECT *
FROM clean_dataset
WHERE `Category` = 'Computers and electric accessories';
-- =================================

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#7. Menghapus Field Yang Kurang Penting
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ALTER TABLE clean_dataset
DROP COLUMN `Discount Applied`;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Hasil Akhir Cleaning Data
SELECT *
FROM clean_dataset
LIMIT 15000;

SELECT COUNT(*) AS 'Jumlah Rows'
FROM clean_dataset;

SELECT 
  COUNT(*) AS total_baris,
  SUM(CASE WHEN `Item` IS NULL THEN 1 ELSE 0 END) AS null_item,
  SUM(CASE WHEN `Price Per Unit` IS NULL THEN 1 ELSE 0 END) AS null_price,
  SUM(CASE WHEN `Quantity` IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN `Total Spent` IS NULL THEN 1 ELSE 0 END) AS null_total
FROM clean_dataset;
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

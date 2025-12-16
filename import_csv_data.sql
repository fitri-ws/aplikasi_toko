-- Import data dari CSV Smartphone(1jt-2jt).csv ke database
-- Jalankan script ini setelah database.sql

USE smartphone_store;

-- Hapus data lama jika ada
TRUNCATE TABLE reviews;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE cart;
TRUNCATE TABLE smartphones;

-- Insert data smartphones dari CSV dengan path gambar lokal
INSERT INTO smartphones (name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock) VALUES
('Alcatel 1S', 'Alcatel', 1599000, 'MediaTek MT6761 Helio A22 Quad-core', 3, 32, 6.2, 5.7, 4.8, 5.5, 5.9, 
 'https://www.tokopedia.com/mygadgetholic/alcatel-1s-5028y-smartphone-3-32gb-garansi-resmi-green', 
 'assets/alcatel_1S.jpg', 
 'Entry-level smartphone dengan performa yang cukup untuk kebutuhan sehari-hari', 
 'Android 9 Pie, HD+ 720 x 1520 pixels, 13MP + 2MP dual camera, 3060mAh battery', 
 15),

('Alcatel 1SE', 'Alcatel', 1599000, 'UNISOC SC9863A Octa-core', 4, 64, 6.22, 5.4, 4.9, 5.4, 5.7, 
 'https://www.tokopedia.com/mygadgetholic/alcatel-1se-5030u-smartphone-4-64gb-garansi-resmi-green', 
 'assets/Alcatel 1SE.jpg', 
 'Budget smartphone dengan quad-camera setup dan baterai tahan lama', 
 'Android 10, HD+ 720 x 1560 pixels, 13MP quad camera, 4000mAh battery', 
 12),

('ASUS Zenfone 4 Max', 'ASUS', 1699000, 'Qualcomm Snapdragon 430 Octa-core', 3, 32, 5.5, 4.5, 3.7, 5.7, 7.7, 
 'https://www.tokopedia.com/mygadgetholic/asus-zenfone-4-max-zc554kl-smartphone-ram-3gb-rom-32gb-gold', 
 'assets/Zenfone 4 Max.webp', 
 'Smartphone dengan baterai jumbo 5000mAh untuk penggunaan seharian', 
 'Android 7.1.1 Nougat, Full HD 1080 x 1920 pixels, Dual 13MP + 5MP camera, 5000mAh battery', 
 8),

('Infinix Hot 10 Play', 'Infinix', 1259000, 'MediaTek Helio G35 Octa-core', 2, 32, 6.82, 5.7, 4.6, 6.7, 8.8, 
 'https://www.tokopedia.com/mygadgetholic/infinix-hot-10-play-x688c-smartphone-2gb-32gb-garansi-resmi-morandi-green', 
 'assets/Infinix Hot 10 Play.jpg', 
 'Smartphone layar besar dengan baterai 6000mAh untuk gaming dan multimedia', 
 'Android 10, HD+ 720 x 1640 pixels, 13MP dual camera, 6000mAh battery, 12nm processor', 
 20),

('Nokia C3', 'Nokia', 1499000, 'Unisoc SC7731E Quad-core', 2, 16, 5.99, 4.3, 3.5, 3.5, 4.4, 
 'https://www.tokopedia.com/nokia-mobile/nokia-c3-2-16gb-nordic-blue', 
 'assets/Nokia C3.png', 
 'Pure Android experience dengan build quality Nokia yang terpercaya', 
 'Android 10 (One Year Update Promise), HD+ 720 x 1440 pixels, 8MP camera', 
 10),

('OPPO A11', 'OPPO', 1399000, 'MediaTek Helio P35 Octa-core', 2, 32, 6.5, 5.4, 4.5, 4.5, 6.8, 
 'https://www.tokopedia.com/oppo/oppo-a11k-smartphone-2gb-32gb-garansi-resmi-biru', 
 'assets/Oppo A11.jpg', 
 'Desain stylish dengan layar Waterdrop notch dan AI camera', 
 'Android 9 (ColorOS 6.1), HD+ 720 x 1600 pixels, 13MP + 2MP dual camera', 
 18),

('OPPO A15', 'OPPO', 1799000, 'MediaTek Helio P35 Octa-core', 3, 32, 6.52, 5.9, 4.7, 5.9, 6.9, 
 'https://www.tokopedia.com/pvblicone/smartphone-oppo-a15-ram-3gb-internal-32gb-garansi-resmi-indonesia-hitam', 
 'assets/Oppo A15.jpg', 
 'Smartphone dengan triple AI camera dan layar HD+ yang jernih', 
 'Android 10 (ColorOS 7), HD+ 720 x 1600 pixels, 13MP + 2MP + 2MP triple camera', 
 14),

('OPPO A11K', 'OPPO', 1699000, 'MediaTek Helio P35 Octa-core', 2, 32, 6.5, 5.4, 4.5, 4.5, 6.8, 
 'https://www.tokopedia.com/supergadgettt/oppo-a11k-2-32-gb-galaxy-smartphone-ram-2gb-rom-32gb-murah-resmi-black', 
 'assets/Oppo A11K.jpg', 
 'Varian A11 dengan spesifikasi yang sama dan harga lebih terjangkau', 
 'Android 9 (ColorOS 6.1), HD+ 720 x 1600 pixels, 13MP + 2MP camera', 
 16),

('POCO M3', 'POCO', 1799000, 'Qualcomm Snapdragon 662 Octa-core', 4, 64, 6.53, 6.7, 6.8, 7.0, 8.9, 
 'https://www.tokopedia.com/xiaomi/xiaomi-official-poco-m3-4-64gb-snapdragon-662-mi-smartphone-power-black', 
 'assets/Poco M3.jpg', 
 'Performance beast dengan Snapdragon 662 dan baterai 6000mAh', 
 'Android 10 (MIUI 12), Full HD+ 1080 x 2340 pixels, 48MP triple camera, 6000mAh battery', 
 25),

('Realme C20', 'Realme', 1249000, 'MediaTek Helio G35 Octa-core', 2, 32, 6.5, 5.8, 3.4, 5.6, 8.1, 
 'https://www.tokopedia.com/mygadgetholic/realme-c20-smartphone-ram-2gb-rom-32gb-garansi-resmi-iron-grey', 
 'assets/Realme C20.jpg', 
 'Budget smartphone dengan baterai 5000mAh dan layar besar', 
 'Android 11 (Realme UI 2.0), HD+ 720 x 1600 pixels, 8MP camera, 5000mAh battery', 
 22),

('Realme C11', 'Realme', 1429000, 'MediaTek Helio G35 Octa-core', 2, 32, 6.5, 5.8, 4.4, 5.1, 7.9, 
 'https://www.tokopedia.com/mygadgetholic/realme-c11-smartphone-2-32gb-garansi-resmi-realme-green', 
 'assets/Realme C11.jpg', 
 'Smartphone dengan dual camera dan desain geometric art', 
 'Android 10 (Realme UI), HD+ 720 x 1600 pixels, 13MP + 2MP dual camera, 5000mAh battery', 
 19),

('Realme C21', 'Realme', 1700000, 'MediaTek Helio G35 Octa-core', 3, 32, 6.5, 5.9, 4.7, 5.3, 8.1, 
 'https://www.tokopedia.com/wijaya/realme-c21-smartphone-3-32gb-garansi-resmi', 
 'assets/Realme C21.jpg', 
 'Upgrade dari C20 dengan triple AI camera dan RAM lebih besar', 
 'Android 11 (Realme UI), HD+ 720 x 1600 pixels, 13MP + 2MP + 2MP triple camera, 5000mAh battery', 
 17),

('Samsung Galaxy A02s', 'Samsung', 1999000, 'Qualcomm Snapdragon 450 Octa-core', 4, 64, 6.5, 5.4, 5.0, 5.2, 7.9, 
 'https://www.tokopedia.com/global-teleshop/samsung-galaxy-a02s-smartphone-4-64gb-garansi-resmi-blue', 
 'assets/Samsung Galaxy.jpg', 
 'Budget Samsung dengan triple camera dan layar Infinity-V', 
 'Android 11 (One UI 3.1), HD+ 720 x 1600 pixels, 13MP + 2MP + 2MP triple camera, 5000mAh battery', 
 30),

('Sharp Aquos V', 'Sharp', 1874000, 'Qualcomm Snapdragon 630 Octa-core', 4, 64, 5.9, 6.2, 5.5, 5.8, 4.8, 
 'https://www.tokopedia.com/didik-electronic/promo-sharp-aquos-v-sh-c02-shc02-smartphone-64gb-ram-4gb-murah', 
 'assets/Sharp Aquos V.jpg', 
 'Smartphone Sharp dengan layar IGZO dan performa yang solid', 
 'Android 8.0 Oreo, Full HD+ 1080 x 2040 pixels, 13MP camera, 2700mAh battery', 
 8),

('Vivo Y20', 'Vivo', 1900000, 'Qualcomm Snapdragon 460 Octa-core', 3, 64, 6.51, 6.3, 4.8, 5.2, 8.2, 
 'https://www.tokopedia.com/supergadgettt/vivo-y20-smartphone-3gb-64gb-garansi-resmi-dawn-white', 
 'assets/Vivo Y20.jpg', 
 'Smartphone dengan triple AI camera dan baterai 5000mAh', 
 'Android 10 (Funtouch OS 11), HD+ 720 x 1600 pixels, 13MP + 2MP + 2MP triple camera, 5000mAh battery', 
 20),

('Vivo Y12S', 'Vivo', 1899000, 'MediaTek Helio P35 Octa-core', 3, 32, 6.51, 5.7, 4.5, 5.5, 7.9, 
 'https://www.tokopedia.com/prismaroxy/vivo-y1s-2-32gb-smartphone', 
 'assets/Vivo Y12S.png', 
 'Budget Vivo dengan dual camera dan layar Halo FullView', 
 'Android 10 (Funtouch OS 11), HD+ 720 x 1544 pixels, 13MP + 2MP dual camera, 5000mAh battery', 
 15),

('Vivo Y91C', 'Vivo', 1599000, 'MediaTek Helio P22 Octa-core', 2, 32, 6.22, 5.1, 3.8, 4.0, 5.9, 
 'https://www.tokopedia.com/andalascellularb/vivo-smartphone-y91c-2-32gb-6-2-inch-garansi-resmi-hitam', 
 'assets/Vivo Y91C.png', 
 'Entry-level Vivo dengan layar Halo FullView dan AI camera', 
 'Android 8.1 Oreo (Funtouch OS 4.5), HD+ 720 x 1520 pixels, 13MP camera, 4030mAh battery', 
 12),

('Xiaomi Redmi 9A', 'Xiaomi', 1209000, 'MediaTek Helio G25 Octa-core', 2, 32, 6.53, 6.3, 6.0, 7.6, 8.9, 
 'https://www.tokopedia.com/global-teleshop/xiaomi-redmi-9a-smartphone-2-32gb-gray', 
 'assets/Redmi 9A.jpg', 
 'Entry-level Xiaomi dengan layar besar dan baterai 5000mAh', 
 'Android 10 (MIUI 11), HD+ 720 x 1600 pixels, 13MP camera, 5000mAh battery', 
 28),

('Xiaomi Redmi 9C', 'Xiaomi', 1550000, 'MediaTek Helio G35 Octa-core', 3, 32, 6.53, 5.8, 4.7, 6.1, 7.8, 
 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9c-smartphone-3-32gb-garansi-resmi-tam', 
 'assets/Redmi 9C.jpg', 
 'Budget Xiaomi dengan triple camera dan desain modern', 
 'Android 10 (MIUI 11), HD+ 720 x 1600 pixels, 13MP + 2MP + 2MP triple camera, 5000mAh battery', 
 24),

('Xiaomi Redmi 9T', 'Xiaomi', 2000000, 'Qualcomm Snapdragon 662 Octa-core', 4, 64, 6.53, 6.6, 7.1, 7.5, 8.9, 
 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9t-smartphone-4-64gb-garansi-resmi', 
 'assets/Redmi 9T.jpg', 
 'Premium budget phone dengan quad camera 48MP dan baterai 6000mAh', 
 'Android 10 (MIUI 12), Full HD+ 1080 x 2340 pixels, 48MP + 8MP + 2MP + 2MP quad camera, 6000mAh battery', 
 32);

-- Verify data
SELECT id, name, brand, price, ram, memory, stock FROM smartphones ORDER BY brand, name;

SELECT COUNT(*) as total_smartphones FROM smartphones;

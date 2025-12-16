-- Update image URLs dengan gambar yang lebih baik
-- Jalankan script ini di MySQL untuk update gambar smartphone

USE smartphone_store;

-- Update gambar dengan URL yang lebih representatif
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400' WHERE name LIKE '%Alcatel 1S%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400' WHERE name LIKE '%Alcatel 1SE%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1585060544812-6b45742d762f?w=400' WHERE name LIKE '%ASUS Zenfone%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=400' WHERE name LIKE '%Infinix Hot 10%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400' WHERE name LIKE '%Nokia C3%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400' WHERE name LIKE '%OPPO A11%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=400' WHERE name LIKE '%OPPO A15%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1585060544812-6b45742d762f?w=400' WHERE name LIKE '%POCO M3%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400' WHERE name LIKE '%Realme C20%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400' WHERE name LIKE '%Realme C11%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=400' WHERE name LIKE '%Realme C21%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400' WHERE name LIKE '%Samsung Galaxy A02s%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1585060544812-6b45742d762f?w=400' WHERE name LIKE '%Xiaomi Redmi 9A%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400' WHERE name LIKE '%Xiaomi Redmi 9C%';
UPDATE smartphones SET image_url = 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400' WHERE name LIKE '%Xiaomi Redmi 9T%';

-- Verifikasi update
SELECT id, name, brand, image_url FROM smartphones ORDER BY brand, name;

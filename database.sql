-- Database: smartphone_store
-- Create database
CREATE DATABASE IF NOT EXISTS smartphone_store;
USE smartphone_store;

-- Table: users
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  role ENUM('user', 'admin') DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: smartphones
CREATE TABLE IF NOT EXISTS smartphones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  brand VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  processor VARCHAR(50),
  ram INT,
  memory INT,
  screen DECIMAL(3, 1),
  performance DECIMAL(3, 1),
  camera DECIMAL(3, 1),
  connectivity DECIMAL(3, 1),
  battery DECIMAL(3, 1),
  link TEXT,
  image_url VARCHAR(255),
  description TEXT,
  stock INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: orders
CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
  shipping_address TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table: order_items
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  smartphone_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (smartphone_id) REFERENCES smartphones(id) ON DELETE CASCADE
);

-- Table: cart
CREATE TABLE IF NOT EXISTS cart (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  smartphone_id INT NOT NULL,
  quantity INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (smartphone_id) REFERENCES smartphones(id) ON DELETE CASCADE
);

-- Table: reviews
CREATE TABLE IF NOT EXISTS reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  smartphone_id INT NOT NULL,
  rating INT CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (smartphone_id) REFERENCES smartphones(id) ON DELETE CASCADE
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@smartphonestore.com', '$2a$10$8szey3UZEUgBrB5zQVQXQOKZ3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Zu', 'Administrator', 'admin');

-- Insert smartphones data from CSV
INSERT INTO smartphones (name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock) VALUES
('Alcatel 1S', 'Alcatel', 1599000, 'Mediatek', 3, 32, 4.1, 5.7, 4.8, 5.5, 5.9, 'https://www.tokopedia.com/mygadgetholic/alcatel-1s-5028y-smartphone-3-32gb-garansi-resmi-green', 'alcatel_1S.jpg', 15),
('Alcatel 1SE', 'Alcatel', 1599000, 'Unisoc', 4, 64, 3.6, 5.4, 4.9, 5.4, 5.7, 'https://www.tokopedia.com/mygadgetholic/alcatel-1se-5030u-smartphone-4-64gb-garansi-resmi-green', 'Alcatel 1SE.jpg', 12),
('Zenfone 4 Max', 'Asus', 1699000, 'Snapdragon', 3, 32, 4.1, 4.5, 3.7, 5.7, 7.7, 'https://www.tokopedia.com/mygadgetholic/asus-zenfone-4-max-zc554kl-smartphone-ram-3gb-rom-32gb-gold', 'Zenfone 4 Max.webp', 8),
('Infinix Hot 10 Play', 'Infinix', 1259000, 'Mediatek', 2, 32, 4.3, 5.7, 4.6, 6.7, 8.8, 'https://www.tokopedia.com/mygadgetholic/infinix-hot-10-play-x688c-smartphone-2gb-32gb-garansi-resmi-morandi-green', 'Infinix Hot 10 Play.jpg', 20),
('Nokia C3', 'Nokia', 1499000, 'Unisoc', 2, 16, 3.7, 4.3, 3.5, 3.5, 4.4, 'https://www.tokopedia.com/nokia-mobile/nokia-c3-2-16gb-nordic-blue', 'Nokia C3.png', 10),
('Oppo A11', 'Oppo', 1399000, 'Mediatek', 2, 32, 3.9, 5.4, 4.5, 4.5, 6.8, 'https://www.tokopedia.com/oppo/oppo-a11k-smartphone-2gb-32gb-garansi-resmi-biru', 'Oppo A11.jpg', 18),
('Oppo A15', 'Oppo', 1799000, 'Mediatek', 3, 32, 6.4, 5.9, 4.7, 5.9, 6.9, 'https://www.tokopedia.com/pvblicone/smartphone-oppo-a15-ram-3gb-internal-32gb-garansi-resmi-indonesia-hitam', 'Oppo A15.jpg', 14),
('Oppo A11K', 'Oppo', 1699000, 'Mediatek', 2, 32, 3.9, 5.4, 4.5, 4.5, 6.8, 'https://www.tokopedia.com/supergadgettt/oppo-a11k-2-32-gb-galaxy-smartphone-ram-2gb-rom-32gb-murah-resmi-black', 'Oppo A11K.jpg', 16),
('Poco M3', 'Poco', 1799000, 'Snapdragon', 4, 64, 7.0, 6.7, 6.8, 7.0, 8.9, 'https://www.tokopedia.com/xiaomi/xiaomi-official-poco-m3-4-64gb-snapdragon-662-mi-smartphone-power-black', 'Poco M3.jpg', 25),
('Realme C20', 'Realme', 1249000, 'Mediatek', 2, 32, 5.8, 5.8, 3.4, 5.6, 8.1, 'https://www.tokopedia.com/mygadgetholic/realme-c20-smartphone-ram-2gb-rom-32gb-garansi-resmi-iron-grey', 'Realme C20.jpg', 22),
('Realme C11', 'Realme', 1429000, 'Mediatek', 2, 32, 6.3, 5.8, 4.4, 5.1, 7.9, 'https://www.tokopedia.com/mygadgetholic/realme-c11-smartphone-2-32gb-garansi-resmi-realme-green', 'Realme C11.jpg', 19),
('Realme C21', 'Realme', 1700000, 'Mediatek', 3, 32, 5.1, 5.9, 4.7, 5.3, 8.1, 'https://www.tokopedia.com/wijaya/realme-c21-smartphone-3-32gb-garansi-resmi', 'Realme C21.jpg', 17),
('Samsung Galaxy A02s', 'Samsung', 1999000, 'Snapdragon', 4, 64, 3.6, 5.4, 5.0, 5.2, 7.9, 'https://www.tokopedia.com/global-teleshop/samsung-galaxy-a02s-smartphone-4-64gb-garansi-resmi-blue', 'Samsung Galaxy.jpg', 30),
('Samsung Galaxy A10s', 'Samsung', 1335000, 'Mediatek', 2, 32, 3.6, 5.2, 4.8, 5.0, 5.8, 'https://www.kimovil.com/en/where-to-buy-samsung-galaxy-a10s', 'Samsung Galaxy.jpg', 12),
('Samsung Galaxy A11', 'Samsung', 1456000, 'Snapdragon', 3, 32, 3.6, 5.3, 5.1, 4.8, 6.2, 'https://www.tokopedia.com/prismaroxy/samsung-galaxy-a11-3-32gb-smartphone-garansi-resmi-putih', 'Samsung Galaxy.jpg', 15),
('Samsung Galaxy M11', 'Samsung', 1495000, 'Snapdragon', 3, 32, 3.2, 5.4, 5.1, 5.7, 7.9, 'https://www.tokopedia.com/prismaroxy/samsung-galaxy-m11-3-32gb-smartphone-garansi-resmi-sein-hitam', 'Samsung Galaxy.jpg', 13),
('Samsung Galaxy J7', 'Samsung', 1999000, 'Exynos', 2, 16, 4.0, 4.7, 4.3, 5.9, 5.5, 'https://www.tokopedia.com/mygadgetholic/samsung-galaxy-j7-j710-smartphone-2gb-16gb-rom-hitam', 'Samsung Galaxy.jpg', 8),
('Sharp Aquos V SH-C02', 'Sharp', 1874000, 'Snapdragon', 4, 64, 6.7, 6.2, 5.5, 5.8, 4.8, 'https://www.tokopedia.com/didik-electronic/promo-sharp-aquos-v-sh-c02-shc02-smartphone-64gb-ram-4gb-murah', 'Sharp Aquos V.jpg', 10),
('Vivo Y20', 'Vivo', 1900000, 'Snapdragon', 3, 64, 3.6, 6.3, 4.8, 5.2, 8.2, 'https://www.tokopedia.com/supergadgettt/vivo-y20-smartphone-3gb-64gb-garansi-resmi-dawn-white', 'Vivo Y20.jpg', 20),
('Vivo Y12S', 'Vivo', 1899000, 'Snapdragon', 2, 32, 3.6, 5.7, 4.5, 5.5, 7.9, 'https://www.tokopedia.com/prismaroxy/vivo-y1s-2-32gb-smartphone', 'Vivo Y12S.png', 18),
('Vivo Y91C', 'Vivo', 1599000, 'Mediatek', 2, 32, 5.6, 5.1, 3.8, 4.0, 5.9, 'https://www.tokopedia.com/andalascellularb/vivo-smartphone-y91c-2-32gb-6-2-inch-garansi-resmi-hitam', 'Vivo Y91C.png', 14),
('Redmi 9A', 'Xiaomi', 1209000, 'Mediatek', 2, 32, 6.5, 6.3, 6.0, 7.6, 8.9, 'https://www.tokopedia.com/global-teleshop/xiaomi-redmi-9a-smartphone-2-32gb-gray', 'Redmi 9A.jpg', 28),
('Redmi 9C', 'Xiaomi', 1550000, 'Mediatek', 3, 32, 4.5, 5.8, 4.7, 6.1, 7.8, 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9c-smartphone-3-32gb-garansi-resmi-tam', 'Redmi 9C.jpg', 24),
('Redmi 9T', 'Xiaomi', 2000000, 'Snapdragon', 4, 64, 7.0, 6.6, 7.1, 7.5, 8.9, 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9t-smartphone-4-64gb-garansi-resmi', 'Redmi 9T.jpg', 32);

-- Insert sample reviews
INSERT INTO reviews (user_id, smartphone_id, rating, comment) VALUES
(1, 9, 5, 'Excellent phone for the price! Battery life is amazing.'),
(1, 22, 5, 'Best budget phone! Highly recommended.'),
(1, 24, 5, 'Great value for money. Performance is solid.');

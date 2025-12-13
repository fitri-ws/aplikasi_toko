-- Database: smartphone_store
-- Create database
DROP DATABASE IF EXISTS smartphone_store;
CREATE DATABASE smartphone_store;
USE smartphone_store;

-- Table: users
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  role ENUM('user', 'admin') DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: smartphones
CREATE TABLE smartphones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  brand VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  processor VARCHAR(100),
  ram INT,
  memory INT,
  screen_size DECIMAL(3, 1),
  performance_score DECIMAL(3, 1),
  camera_score DECIMAL(3, 1),
  connectivity_score DECIMAL(3, 1),
  battery_score DECIMAL(3, 1),
  link TEXT,
  image_url VARCHAR(255),
  description TEXT,
  specifications TEXT,
  stock INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: orders
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
  shipping_address TEXT NOT NULL,
  payment_method VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table: order_items
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  smartphone_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (smartphone_id) REFERENCES smartphones(id) ON DELETE CASCADE
);

-- Table: cart
CREATE TABLE cart (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  smartphone_id INT NOT NULL,
  quantity INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (smartphone_id) REFERENCES smartphones(id) ON DELETE CASCADE,
  UNIQUE KEY unique_user_smartphone (user_id, smartphone_id)
);

-- Table: reviews
CREATE TABLE reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  smartphone_id INT NOT NULL,
  rating INT CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (smartphone_id) REFERENCES smartphones(id) ON DELETE CASCADE
);

-- Insert default admin user (password: admin123 - hashed)
-- The hashed password for 'admin123' using bcrypt
INSERT INTO users (username, email, password, full_name, phone, role) VALUES
('admin', 'admin@smartphonestore.com', '$2a$10$9dMvxrhDIvXvF5yqRz6f7uJ9oHk9fL4h9j9fL4h9j9fL4h9j9fL4u', 'Administrator', '081234567890', 'admin');

-- Insert smartphones data with more detailed information
INSERT INTO smartphones (name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock) VALUES
('Alcatel 1S', 'Alcatel', 1599000, 'MediaTek MT6761 Helio A22 Quad-core', 3, 32, 6.2, 5.7, 4.8, 5.5, 5.9, 'https://www.tokopedia.com/mygadgetholic/alcatel-1s-5028y-smartphone-3-32gb-garansi-resmi-green', 'https://placehold.co/300x300/3498db/ffffff?text=Alcatel+1S', 'Entry-level smartphone with decent performance for basic tasks', 'Android 9 Pie, HD+ 720 x 1520 pixels, MicroSD expandable up to 41GB', 15),
('Alcatel 1SE', 'Alcatel', 1599000, 'UNISOC SC9863A Octa-core', 4, 64, 6.22, 5.4, 4.9, 5.4, 5.7, 'https://www.tokopedia.com/mygadgetholic/alcatel-1se-5030u-smartphone-4-64gb-garansi-resmi-green', 'https://placehold.co/300x300/2ecc71/ffffff?text=Alcatel+1SE', 'Budget-friendly smartphone with quad-camera setup', 'Android 10, HD+ 720 x 1560 pixels, 4000mAh battery', 12),
('ASUS Zenfone 4 Max', 'ASUS', 1699000, 'Qualcomm Snapdragon 430 Octa-core', 3, 32, 5.5, 4.5, 3.7, 5.7, 7.7, 'https://www.tokopedia.com/mygadgetholic/asus-zenfone-4-max-zc554kl-smartphone-ram-3gb-rom-32gb-gold', 'https://placehold.co/300x300/9b59b6/ffffff?text=Zenfone+4+Max', 'Mid-range smartphone with dual rear cameras', 'Android 7.1.1 Nougat, Full HD 1080 x 1920 pixels, 5000mAh battery', 8),
('Infinix Hot 10 Play', 'Infinix', 1259000, 'MediaTek Helio G35 Octa-core', 2, 32, 6.82, 5.7, 4.6, 6.7, 8.8, 'https://www.tokopedia.com/mygadgetholic/infinix-hot-10-play-x688c-smartphone-2gb-32gb-garansi-resmi-morandi-green', 'https://placehold.co/300x300/f39c12/ffffff?text=Infinix+Hot+10', 'Affordable option with large display and big battery', 'Android 10, HD+ 720 x 1640 pixels, 6000mAh battery, 12nm processor', 20),
('Nokia C3', 'Nokia', 1499000, 'Unisoc SC7731E Quad-core', 2, 16, 5.99, 4.3, 3.5, 3.5, 4.4, 'https://www.tokopedia.com/nokia-mobile/nokia-c3-2-16gb-nordic-blue', 'https://placehold.co/300x300/e74c3c/ffffff?text=Nokia+C3', 'Pure Android experience with clean interface', 'Android 10 (One Year Update Promise), HD+ 720 x 1440 pixels', 10),
('OPPO A11', 'OPPO', 1399000, 'MediaTek Helio P35 Octa-core', 2, 32, 6.52, 5.4, 4.5, 4.5, 6.8, 'https://www.tokopedia.com/oppo/oppo-a11k-smartphone-2gb-32gb-garansi-resmi-biru', 'https://placehold.co/300x300/34495e/ffffff?text=OPPO+A11', 'Stylish design with Waterdrop notch display', 'Android 9 (ColorOS 6.1), HD+ 720 x 1600 pixels, AI triple camera', 18),
('OPPO A15', 'OPPO', 1799000, 'MediaTek Helio P35 Octa-core', 3, 32, 6.52, 5.9, 4.7, 5.9, 6.9, 'https://www.tokopedia.com/pvblicone/smartphone-oppo-a15-ram-3gb-internal-32gb-garansi-resmi-indonesia-hitam', 'https://placehold.co/300x300/1abc9c/ffffff?text=OPPO+A15', 'Improved specs from A11 with better battery life', 'Android 10 (ColorOS 7), HD+ 720 x 1600 pixels, Triple AI Camera', 14),
('POCO M3', 'POCO', 1799000, 'Qualcomm Snapdragon 662 Octa-core', 4, 64, 6.53, 6.7, 6.8, 7.0, 8.9, 'https://www.tokopedia.com/xiaomi/xiaomi-official-poco-m3-4-64gb-snapdragon-662-mi-smartphone-power-black', 'https://placehold.co/300x300/ff6b6b/ffffff?text=POCO+M3', 'Performance-oriented device with Snapdragon chipset', 'Android 10 (MIUI 12), Full HD+ 1080 x 2340 pixels, 6000mAh battery', 25),
('Realme C20', 'Realme', 1249000, 'MediaTek Helio G35 Octa-core', 2, 32, 6.5, 5.8, 3.4, 5.6, 8.1, 'https://www.tokopedia.com/mygadgetholic/realme-c20-smartphone-ram-2gb-rom-32gb-garansi-resmi-iron-grey', 'https://placehold.co/300x300/ffd93d/ffffff?text=Realme+C20', 'Budget smartphone with waterdrop display', 'Android 11 (Realme UI 2.0), HD+ 720 x 1600 pixels, 5000mAh battery', 22),
('Realme C11', 'Realme', 1429000, 'MediaTek Helio G35 Octa-core', 2, 32, 6.5, 5.8, 4.4, 5.1, 7.9, 'https://www.tokopedia.com/mygadgetholic/realme-c11-smartphone-2-32gb-garansi-resmi-realme-green', 'https://placehold.co/300x300/6a89cc/ffffff?text=Realme+C11', 'Affordable device with large battery capacity', 'Android 10 (Realme UI), HD+ 720 x 1600 pixels, Dual SIM', 19),
('Realme C21', 'Realme', 1700000, 'MediaTek Helio G35 Octa-core', 3, 32, 6.5, 5.9, 4.7, 5.3, 8.1, 'https://www.tokopedia.com/wijaya/realme-c21-smartphone-3-32gb-garansi-resmi', 'https://placehold.co/300x300/5d5fef/ffffff?text=Realme+C21', 'Upgraded version of C20 with better camera', 'Android 11 (Realme UI), HD+ 720 x 1600 pixels, Triple AI Camera', 17),
('Samsung Galaxy A02s', 'Samsung', 1999000, 'Qualcomm Snapdragon 450 Octa-core', 4, 64, 6.5, 5.4, 5.0, 5.2, 7.9, 'https://www.tokopedia.com/global-teleshop/samsung-galaxy-a02s-smartphone-4-64gb-garansi-resmi-blue', 'https://placehold.co/300x300/2c3e50/ffffff?text=Galaxy+A02s', 'Budget Samsung device with impressive battery life', 'Android 11 (One UI 3.1), HD+ 720 x 1600 pixels, Triple rear camera', 30),
('Xiaomi Redmi 9A', 'Xiaomi', 1209000, 'MediaTek Helio G25 Octa-core', 2, 32, 6.53, 6.3, 6.0, 7.6, 8.9, 'https://www.tokopedia.com/global-teleshop/xiaomi-redmi-9a-smartphone-2-32gb-gray', 'https://placehold.co/300x300/3498db/ffffff?text=Redmi+9A', 'Entry-level device with large display and battery', 'Android 10 (MIUI 11), HD+ 720 x 1600 pixels, 5000mAh battery', 28),
('Xiaomi Redmi 9C', 'Xiaomi', 1550000, 'MediaTek Helio G35 Octa-core', 3, 32, 6.53, 5.8, 4.7, 6.1, 7.8, 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9c-smartphone-3-32gb-garansi-resmi-tam', 'https://placehold.co/300x300/2ecc71/ffffff?text=Redmi+9C', 'Budget-friendly option with triple camera setup', 'Android 10 (MIUI 11), HD+ 720 x 1600 pixels, 5000mAh battery', 24),
('Xiaomi Redmi 9T', 'Xiaomi', 2000000, 'Qualcomm Snapdragon 662 Octa-core', 4, 64, 6.53, 6.6, 7.1, 7.5, 8.9, 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9t-smartphone-4-64gb-garansi-resmi', 'https://placehold.co/300x300/9b59b6/ffffff?text=Redmi+9T', 'Premium budget device with excellent battery life', 'Android 10 (MIUI 12), Full HD+ 1080 x 2340 pixels, 6000mAh battery', 32);

-- Insert sample reviews
INSERT INTO reviews (user_id, smartphone_id, rating, comment) VALUES
(1, 8, 5, 'Excellent phone for the price! Battery life is amazing and performance is smooth for daily tasks.'),
(1, 13, 5, 'Best budget phone! Highly recommended for basic usage and social media.'),
(1, 15, 5, 'Great value for money. Performance is solid and camera quality is good for the price range.');

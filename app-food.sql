DROP DATABASE IF EXISTS restaurant_db;
CREATE DATABASE IF NOT EXISTS restaurant_db;
USE restaurant_db;
CREATE TABLE `user` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(255),
  `email` VARCHAR(255),
  `password` VARCHAR(255)
);
INSERT INTO `user` (full_name, email, password) VALUES
('Alice Johnson', 'alice.j@example.com', 'alicepass'),
('Bob Smith', 'bob.s@example.com', 'bobpass'),
('Carol White', 'carol.w@example.com', 'carolpass'),
('David Brown', 'david.b@example.com', 'davidpass'),
('Eve Davis', 'eve.d@example.com', 'evepass');
CREATE TABLE `restaurant` (
  `res_id` INT AUTO_INCREMENT PRIMARY KEY,
  `res_name` VARCHAR(255),
  `Image` VARCHAR(255),
  `desc` VARCHAR(255)
);
INSERT INTO `restaurant` (res_name, Image, `desc`) VALUES
('Gourmet Steakhouse', 'steakhouse.jpg', 'The finest steaks in town'),
('Oceans Catch', 'seafood.jpg', 'Fresh seafood and ocean views'),
('Bella Pasta', 'pasta.jpg', 'Authentic Italian pasta dishes'),
('Sizzle BBQ', 'bbq.jpg', 'Barbecue and grill specialties'),
('Green Garden', 'salad.jpg', 'Healthy salads and vegan options');
CREATE TABLE `food_type` (
  `type_id` INT AUTO_INCREMENT PRIMARY KEY,
  `type_name` VARCHAR(255)
);
INSERT INTO `food_type` (type_name) VALUES
('Steak'),
('Seafood'),
('Italian'),
('Barbecue'),
('Salad');
CREATE TABLE `food` (
  `food_id` INT AUTO_INCREMENT PRIMARY KEY,
  `food_name` VARCHAR(255),
  `image` VARCHAR(255),
  `price` FLOAT,
  `desc` VARCHAR(255),
  `type_id` INT,
  FOREIGN KEY (`type_id`) REFERENCES `food_type`(`type_id`)
);
INSERT INTO `food` (food_name, image, price, `desc`, type_id) VALUES
('Ribeye Steak', 'ribeye.jpg', 25.99, 'Prime ribeye steak with herbs', 1),
('Grilled Salmon', 'salmon.jpg', 19.99, 'Grilled wild salmon with lemon butter', 2),
('Spaghetti Bolognese', 'spaghetti.jpg', 14.99, 'Classic spaghetti with meat sauce', 3),
('Pulled Pork Sandwich', 'pulledpork.jpg', 12.99, 'Slow-cooked pulled pork with BBQ sauce', 4),
('Caesar Salad', 'caesar.jpg', 9.99, 'Fresh romaine with Caesar dressing', 5);

CREATE TABLE `sub_food` (
  `sub_id` INT AUTO_INCREMENT PRIMARY KEY,
  `sub_name` VARCHAR(255),
  `sub_price` FLOAT,
  `food_id` INT,
  FOREIGN KEY (`food_id`) REFERENCES `food`(`food_id`)
);
INSERT INTO `sub_food` (sub_name, sub_price, food_id) VALUES
('Extra Cheese', 2.50, 1),  -- Assuming 1 is the ID for Ribeye Steak
('Soy Sauce', 0.50, 2),     -- Assuming 2 is the ID for Grilled Salmon
('Pesto Sauce', 1.00, 3),   -- Assuming 3 is the ID for Spaghetti Bolognese
('Spicy Rub', 0.75, 4),     -- Assuming 4 is the ID for Pulled Pork Sandwich
('Garlic Croutons', 0.50, 5);  -- Assuming 5 is the ID for Caesar Salad
CREATE TABLE `order` (
  `user_id` INT,
  `food_id` INT,
  `amount` INT,
  `code` VARCHAR(255),
  `arr_sub_id` VARCHAR(255),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`food_id`) REFERENCES `food`(`food_id`)
);
-- Assuming that the users and foods have been inserted with IDs 1 through 5
INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id) VALUES
(1, 1, 1, 'DISC01', '1'),
(2, 2, 2, 'DISC02', '2'),
(3, 3, 3, 'DISC03', '3'),
(4, 4, 4, 'DISC04', '4'),
(5, 5, 5, 'DISC05', '5');
CREATE TABLE `rate_res` (
  `user_id` INT,
  `res_id` INT,
  `amount` INT,
  `date_rate` DATETIME,
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`res_id`) REFERENCES `restaurant`(`res_id`)
);
-- Assuming that the users and restaurants have been inserted with IDs 1 through 5
INSERT INTO `rate_res` (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2023-11-01 19:00:00'),
(2, 2, 4, '2023-11-02 19:00:00'),
(3, 3, 3, '2023-11-03 19:00:00'),
(4, 4, 2, '2023-11-04 19:00:00'),
(5, 5, 1, '2023-11-05 19:00:00');

CREATE TABLE `like_res` (
  `user_id` INT,
  `res_id` INT,
  `date_like` DATETIME,
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`res_id`) REFERENCES `restaurant`(`res_id`)
);
-- Assuming that the users and restaurants have been inserted with IDs 1 through 5
INSERT INTO `like_res` (user_id, res_id, date_like) VALUES
(1, 5, '2023-11-01 20:00:00'),
(2, 4, '2023-11-02 20:00:00'),
(3, 3, '2023-11-03 20:00:00'),
(4, 2, '2023-11-04 20:00:00');

-- Tìm 5 người đã like nhà hàng nhiều nhất.
SELECT u.user_id,u.full_name, COUNT(lr.res_id) AS total_likes
FROM `user` u
JOIN `like_res` lr ON u.user_id = lr.user_id
GROUP BY u.user_id
ORDER BY total_likes DESC
LIMIT 5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất.
SELECT r.res_id, r.res_name, COUNT(lr.user_id) AS total_likes
FROM  `restaurant` r
JOIN `like_res` lr ON r.res_id = lr.res_id
GROUP BY r.res_id
ORDER BY total_likes DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất.
SELECT u.user_id,u.full_name,COUNT(o.food_id) AS total_orders
FROM `user` u
JOIN `order` o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY total_orders DESC
LIMIT 1;

-- Tìm người dùng không hoạt động trong hệ thống 
SELECT u.user_id,u.full_name
FROM  `user` u
LEFT JOIN  `order` o ON u.user_id = o.user_id
LEFT JOIN  `like_res` lr ON u.user_id = lr.user_id
LEFT JOIN  `rate_res` rr ON u.user_id = rr.user_id
WHERE o.user_id IS NULL AND lr.user_id IS NULL AND rr.user_id IS NULL;

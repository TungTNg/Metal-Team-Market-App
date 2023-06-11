-- MySQL Workbench Settings

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- -----------------------------------------------------
-- Schema metal_team_marketplace
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `metal_team_marketplace`;
CREATE SCHEMA IF NOT EXISTS `metal_team_marketplace` DEFAULT CHARACTER SET utf8mb3 ;
USE `metal_team_marketplace` ;

-- -----------------------------------------------------
-- Table `metal_team_marketplace`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metal_team_marketplace`.`Product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_name_UNIQUE` (`product_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `metal_team_marketplace`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metal_team_marketplace`.`Inventory` (
  `inventory_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_Invetory_Product_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory_Product`
    FOREIGN KEY (`product_id`)
    REFERENCES `metal_team_marketplace`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `metal_team_marketplace`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metal_team_marketplace`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(45) NOT NULL,
  `shipping_address` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `metal_team_marketplace`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metal_team_marketplace`.`Order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `transaction_date` DATE NOT NULL,
  `purchase_quantity` INT NOT NULL,
  `total_cost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Order_Product_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_Order_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Product`
    FOREIGN KEY (`product_id`)
    REFERENCES `metal_team_marketplace`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `metal_team_marketplace`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `metal_team_marketplace`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metal_team_marketplace`.`Review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `user_comment` VARCHAR(45) NULL DEFAULT NULL,
  `review_date` DATE NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_Order_Product_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_Order_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Review_Product`
    FOREIGN KEY (`product_id`)
    REFERENCES `metal_team_marketplace`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Review_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `metal_team_marketplace`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `metal_team_marketplace`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `metal_team_marketplace`;

INSERT INTO `metal_team_marketplace`.`User` 
(`user_id`, `full_name`, `shipping_address`, `username`, `email`, `password`) 
VALUES 
(1, 'John Doe', '123 Main St, New York, NY 10001', 'john_doe', 'johndoe@gmail.com', 'password1'),
(2, 'Jane Smith', '456 Maple St, Los Angeles, CA 90001', 'jane_smith', 'janesmith@gmail.com', 'password2'),
(3, 'Alice Johnson', '789 Pine St, Chicago, IL 60601', 'alice_johnson', 'alicejohnson@gmail.com', 'password3'),
(4, 'Bob Williams', '321 Oak St, Houston, TX 77001', 'bob_williams', 'bobwilliams@gmail.com', 'password4'),
(5, 'Charlie Brown', '654 Elm St, Philadelphia, PA 19101', 'charlie_brown', 'charliebrown@gmail.com', 'password5'),
(6, 'David Davis', '987 Walnut St, Phoenix, AZ 85001', 'david_davis', 'daviddavis@gmail.com', 'password6'),
(7, 'Emily Evans', '123 Cherry St, San Antonio, TX 78201', 'emily_evans', 'emilyevans@gmail.com', 'password7'),
(8, 'Frank Foster', '456 Chestnut St, San Diego, CA 92101', 'frank_foster', 'frankfoster@gmail.com', 'password8'),
(9, 'Grace Green', '789 Birch St, Dallas, TX 75201', 'grace_green', 'gracegreen@gmail.com', 'password9'),
(10, 'Harry Hall', '321 Cedar St, San Jose, CA 95101', 'harry_hall', 'harryhall@gmail.com', 'password10'),
(11, 'Irene Ivory', '654 Dogwood St, Austin, TX 78701', 'irene_ivory', 'ireneivory@gmail.com', 'password11'),
(12, 'Jack Jones', '987 Fir St, Jacksonville, FL 32099', 'jack_jones', 'jackjones@gmail.com', 'password12'),
(13, 'Kathy King', '123 Ash St, San Francisco, CA 94101', 'kathy_king', 'kathyking@gmail.com', 'password13'),
(14, 'Larry Lee', '456 Poplar St, Indianapolis, IN 46201', 'larry_lee', 'larrylee@gmail.com', 'password14'),
(15, 'Mary Martinez', '789 Palm St, Columbus, OH 43201', 'mary_martinez', 'marymartinez@gmail.com', 'password15'),
(16, 'Norman Nixon', '321 Pine St, Fort Worth, TX 76101', 'norman_nixon', 'normannixon@gmail.com', 'password16'),
(17, 'Olive Olsen', '654 Redwood St, Charlotte, NC 28201', 'olive_olsen', 'oliveolsen@gmail.com', 'password17'),
(18, 'Peter Peterson', '987 Rose St, Seattle, WA 98101', 'peter_peterson', 'peterpeterson@gmail.com', 'password18'),
(19, 'Quincy Quinn', '123 Sunflower St, Denver, CO 80201', 'quincy_quinn', 'quincyquinn@gmail.com', 'password19'),
(20, 'Rita Roberts', '456 Tulip St, El Paso, TX 79901', 'rita_roberts', 'ritaroberts@gmail.com', 'password20'),
(21, 'Steve Smith', '789 Violet St, Detroit, MI 48201', 'steve_smith', 'stevesmith@gmail.com', 'password21'),
(22, 'Tina Thompson', '321 Willow St, Washington, DC 20001', 'tina_thompson', 'tinathompson@gmail.com', 'password22'),
(23, 'Ursula Underwood', '654 Yucca St, Boston, MA 02101', 'ursula_underwood', 'ursulaunderwood@gmail.com', 'password23'),
(24, 'Victor Vaughn', '987 Zinnia St, Memphis, TN 38101', 'victor_vaughn', 'victorvaughn@gmail.com', 'password24'),
(25, 'Wanda White', '123 Acacia St, Nashville, TN 37201', 'wanda_white', 'wandawhite@gmail.com', 'password25'),
(26, 'Xavier Xylophone', '456 Bamboo St, Portland, OR 97201', 'xavier_xylophone', 'xavierxylophone@gmail.com', 'password26'),
(27, 'Yolanda Young', '789 Camellia St, Oklahoma City, OK 73101', 'yolanda_young', 'yolandayoung@gmail.com', 'password27'),
(28, 'Zachary Zephyr', '321 Dahlia St, Las Vegas, NV 89101', 'zachary_zephyr', 'zacharyzephyr@gmail.com', 'password28'),
(29, 'Anna Apple', '654 Elder St, Baltimore, MD 21201', 'anna_apple', 'annaapple@gmail.com', 'password29'),
(30, 'Brian Banana', '987 Fuchsia St, Louisville, KY 40201', 'brian_banana', 'brianbanana@gmail.com', 'password30'),
(31, 'Carla Cherry', '123 Grevillea St, Milwaukee, WI 53201', 'carla_cherry', 'carlacherry@gmail.com', 'password31'),
(32, 'Dennis Durian', '456 Hydrangea St, Albuquerque, NM 87101', 'dennis_durian', 'dennisdurian@gmail.com', 'password32'),
(33, 'Eva Elderberry', '789 Iris St, Tucson, AZ 85701', 'eva_elderberry', 'evaelderberry@gmail.com', 'password33'),
(34, 'Fred Fig', '321 Jasmine St, Fresno, CA 93701', 'fred_fig', 'fredfig@gmail.com', 'password34'),
(35, 'Gina Grape', '654 Kingcup St, Sacramento, CA 94203', 'gina_grape', 'ginagrape@gmail.com', 'password35'),
(36, 'Helen Huckleberry', '987 Lotus St, Kansas City, MO 64101', 'helen_huckleberry', 'helenhuckleberry@gmail.com', 'password36'),
(37, 'Ivan Iceberg', '123 Mallow St, Mesa, AZ 85201', 'ivan_iceberg', 'ivaniceberg@gmail.com', 'password37'),
(38, 'Julia Juniper', '456 Nettle St, Atlanta, GA 30301', 'julia_juniper', 'juliajuniper@gmail.com', 'password38'),
(39, 'Kevin Kiwi', '789 Orchid St, Omaha, NE 68101', 'kevin_kiwi', 'kevinkiwi@gmail.com', 'password39'),
(40, 'Linda Lychee', '321 Pansy St, Miami, FL 33101', 'linda_lychee', 'lindalychee@gmail.com', 'password40'),
(41, 'Mike Mango', '654 Quince St, Tulsa, OK 74101', 'mike_mango', 'mikemango@gmail.com', 'password41'),
(42, 'Nina Nectarine', '987 Rose St, Cleveland, OH 44101', 'nina_nectarine', 'ninanectarine@gmail.com', 'password42'),
(43, 'Oscar Orange', '123 Sunflower St, Minneapolis, MN 55401', 'oscar_orange', 'oscarorange@gmail.com', 'password43'),
(44, 'Paula Pineapple', '456 Tulip St, Wichita, KS 67201', 'paula_pineapple', 'paulapineapple@gmail.com', 'password44'),
(45, 'Quentin Quince', '789 Violet St, Arlington, TX 76001', 'quentin_quince', 'quentinquince@gmail.com', 'password45'),
(46, 'Rita Raspberry', '321 Willow St, Tampa, FL 33601', 'rita_raspberry', 'ritaraspberry@gmail.com', 'password46'),
(47, 'Sam Strawberry', '654 Yucca St, Honolulu, HI 96801', 'sam_strawberry', 'samstrawberry@gmail.com', 'password47'),
(48, 'Tina Tangerine', '987 Zinnia St, Anaheim, CA 92801', 'tina_tangerine', 'tinatangerine@gmail.com', 'password48'),
(49, 'Ursula Ugli', '123 Acacia St, Aurora, CO 80010', 'ursula_ugli', 'ursulaugli@gmail.com', 'password49'),
(50, 'Victor Vanilla', '456 Bamboo St, Santa Ana, CA 92701', 'victor_vanilla', 'victorvanilla@gmail.com', 'password50'),
(51, 'Wanda Walnut', '789 Camellia St, St. Louis, MO 63101', 'wanda_walnut', 'wandawalnut@gmail.com', 'password51'),
(52, 'Xavier Xigua', '321 Dahlia St, Pittsburgh, PA 15201', 'xavier_xigua', 'xavierxigua@gmail.com', 'password52'),
(53, 'Yolanda Yuzu', '654 Elder St, Cincinnati, OH 45201', 'yolanda_yuzu', 'yolandayuzu@gmail.com', 'password53'),
(54, 'Alexa Apricot', '111 Gorse St, Buffalo, NY 14201', 'alexa_apricot', 'alexaapricot@gmail.com', 'password55'),
(55, 'Brandon Blueberry', '222 Holly St, Raleigh, NC 27601', 'brandon_blueberry', 'brandonblueberry@gmail.com', 'password56'),
(56, 'Cindy Cranberry', '333 Ivy St, Lexington, KY 40507', 'cindy_cranberry', 'cindycranberry@gmail.com', 'password57'),
(57, 'David Dragonfruit', '444 Jasmine St, Anchorage, AK 99501', 'david_dragonfruit', 'daviddragonfruit@gmail.com', 'password58'),
(58, 'Ella Elderberry', '555 Kalmia St, Plano, TX 75074', 'ella_elderberry', 'ellaelderberry@gmail.com', 'password59'),
(59, 'Frank Fig', '666 Laurel St, Lincoln, NE 68508', 'frank_fig', 'frankfig@gmail.com', 'password60'),
(60, 'Grace Grape', '777 Marigold St, Orlando, FL 32801', 'grace_grape', 'gracegrape@gmail.com', 'password61'),
(61, 'Henry Huckleberry', '888 Nasturtium St, Irvine, CA 92602', 'henry_huckleberry', 'henryhuckleberry@gmail.com', 'password62'),
(62, 'Iris Iceberg', '999 Orchid St, Newark, NJ 07101', 'iris_iceberg', 'irisiceberg@gmail.com', 'password63'),
(63, 'Jack Juniper', '1010 Pansy St, Durham, NC 27701', 'jack_juniper', 'jackjuniper@gmail.com', 'password64'),
(64, 'Kelly Kiwi', '1111 Quince St, Chula Vista, CA 91910', 'kelly_kiwi', 'kellykiwi@gmail.com', 'password65'),
(65, 'Liam Lychee', '1212 Rose St, Fort Wayne, IN 46802', 'liam_lychee', 'liamlychee@gmail.com', 'password66'),
(66, 'Mia Mango', '1313 Sunflower St, Jersey City, NJ 07302', 'mia_mango', 'miamango@gmail.com', 'password67'),
(67, 'Noah Nectarine', '1414 Tulip St, St. Petersburg, FL 33701', 'noah_nectarine', 'noahnectarine@gmail.com', 'password68'),
(68, 'Olivia Orange', '1515 Violet St, Laredo, TX 78040', 'olivia_orange', 'oliviaorange@gmail.com', 'password69'),
(69, 'Peter Pineapple', '1616 Willow St, Madison, WI 53703', 'peter_pineapple', 'peterpineapple@gmail.com', 'password70'),
(70, 'Queenie Quince', '1717 Yucca St, Lubbock, TX 79401', 'queenie_quince', 'queeniequince@gmail.com', 'password71'),
(71, 'Ryan Raspberry', '1818 Zinnia St, Gilbert, AZ 85234', 'ryan_raspberry', 'ryanraspberry@gmail.com', 'password72'),
(72, 'Sophie Strawberry', '1919 Acacia St, Norfolk, VA 23510', 'sophie_strawberry', 'sophiestrawberry@gmail.com', 'password73'),
(73, 'John Milton', '123 Peachtree St, Atlanta, GA', 'jmilton76', 'jmilton76@example.com', 'password74'),
(74, 'Sarah Connor', '456 Oak St, San Francisco, CA', 'sconnor77', 'sconnor77@example.com', 'password75'),
(75, 'Jane Austen', '789 Maple St, Austin, TX', 'jausten78', 'jausten78@example.com', 'password76');

COMMIT;

-- -----------------------------------------------------
-- Data for table `metal_team_marketplace`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `metal_team_marketplace`;

INSERT INTO `metal_team_marketplace`.`Product`
(`product_id`, `product_name`, `description`, `price`)
VALUES
(1, 'T-Shirt', 'Comfortable cotton t-shirt', 19.99),
(2, 'Jeans', 'Classic denim jeans', 49.99),
(3, 'Sneakers', 'Sports shoes for casual wear', 79.99),
(4, 'Watch', 'Elegant wristwatch with leather strap', 129.99),
(5, 'Backpack', 'Spacious backpack for everyday use', 39.99),
(6, 'Headphones', 'High-quality over-ear headphones', 89.99),
(7, 'Smartphone', 'Latest smartphone with advanced features', 699.99),
(8, 'Laptop', 'Powerful laptop for work and entertainment', 999.99),
(9, 'Camera', 'Professional DSLR camera', 1499.99),
(10, 'Gaming Console', 'Popular gaming console with wireless controllers', 399.99),
(11, 'Fitness Tracker', 'Activity tracker for monitoring health and fitness', 79.99),
(12, 'Smart TV', 'Large-screen smart TV with 4K resolution', 799.99),
(13, 'Bluetooth Speaker Luxury', 'Luxurious speaker with wireless connectivity', 149.99),
(14, 'Coffee Maker', 'Automatic coffee maker for brewing delicious coffee', 49.99),
(15, 'Air Fryer', 'Kitchen appliance for healthy frying without oil', 79.99),
(16, 'Blender', 'Versatile blender for making smoothies and sauces', 39.99),
(17, 'Vacuum Cleaner', 'Powerful vacuum cleaner for efficient cleaning', 149.99),
(18, 'Electric Toothbrush', 'Advanced electric toothbrush for oral care', 29.99),
(19, 'Hair Dryer', 'Professional hair dryer for fast and precise drying', 69.99),
(20, 'Electric Shaver', 'Gentle electric shaver for smooth shaving experience', 59.99),
(21, 'Smart Watch', 'Feature-packed smartwatch with fitness tracking', 149.99),
(22, 'Wireless Earbuds', 'True wireless earbuds with noise cancellation', 129.99),
(23, 'Tablet', 'Portable tablet for browsing and multimedia', 299.99),
(24, 'Printer', 'All-in-one printer for printing, scanning, and copying', 199.99),
(25, 'Gaming Mouse', 'High-precision gaming mouse with customizable buttons', 49.99),
(26, 'Keyboard', 'Mechanical keyboard with RGB backlighting', 89.99),
(27, 'External Hard Drive', 'Portable storage for backing up files', 79.99),
(28, 'Power Bank', 'Compact power bank for charging devices on the go', 29.99),
(29, 'Bluetooth Earphones', 'Wireless earphones with long battery life', 69.99),
(30, 'Smart Thermostat', 'Intelligent thermostat for efficient temperature control', 149.99),
(31, 'Wireless Router', 'High-speed wireless router for home networking', 79.99),
(32, 'Portable Projector', 'Mini projector for enjoying movies and presentations', 199.99),
(33, 'Digital Camera', 'Compact digital camera for capturing memories', 249.99),
(34, 'Smart Scale', 'Digital scale for tracking weight and body composition', 39.99),
(35, 'Electric Kettle', 'Quick-boiling electric kettle for tea and coffee', 24.99),
(36, 'Robot Vacuum', 'Smart robot vacuum for automated cleaning', 299.99),
(37, 'Fitness Smartwatch', 'Fitness-oriented smartwatch with heart rate monitoring', 199.99),
(38, 'Bluetooth Speaker', 'Waterproof portable speaker for outdoor adventures', 79.99),
(39, 'Wireless Charging Pad', 'Qi-enabled wireless charging pad for smartphones', 34.99),
(40, 'Bluetooth Headset', 'Wireless headset for hands-free communication', 59.99),
(41, 'Digital Watch', 'Digital wristwatch with multiple functions', 59.99),
(42, 'Wireless Mouse', 'Ergonomic wireless mouse for comfortable use', 29.99),
(43, 'USB Flash Drive', 'Portable storage device with high-speed data transfer', 19.99),
(44, 'Bluetooth Keyboard', 'Compact keyboard for wireless typing', 39.99),
(45, 'External SSD', 'High-performance external solid-state drive', 149.99),
(46, 'Gaming Headset', 'Immersive gaming headset with surround sound', 89.99),
(47, 'Webcam', 'HD webcam for video conferencing and streaming', 49.99),
(48, 'Smart Plug', 'Wi-Fi enabled smart plug for home automation', 24.99),
(49, 'Wireless Speaker', 'Portable speaker with wireless connectivity', 49.99),
(50, 'Wireless Charger', 'Fast wireless charger for compatible devices', 39.99),
(51, 'Wireless Gaming Controller', 'Gamepad for wireless gaming on PC and consoles', 49.99),
(52, 'Bluetooth Car Kit', 'Hands-free Bluetooth car kit for safe driving', 39.99),
(53, 'USB-C Hub', 'Multi-port USB-C hub for expanding connectivity', 59.99),
(54, 'Wireless Keyboard and Mouse Combo', 'Wireless keyboard and mouse set', 69.99),
(55, 'Bluetooth Tracker', 'Bluetooth-enabled tracker for locating lost items', 19.99),
(56, 'Portable Bluetooth Printer', 'Compact printer for printing photos on the go', 99.99),
(57, 'Wireless Noise-Canceling Headphones', 'Headphones with active noise cancellation', 149.99),
(58, 'Smart LED Light Bulb', 'Wi-Fi enabled LED bulb with adjustable colors', 24.99),
(59, 'Bluetooth FM Transmitter', 'FM transmitter for streaming music in the car', 29.99),
(60, 'Wireless Gaming Mouse', 'Gaming mouse with customizable DPI settings', 59.99),
(61, 'Bluetooth Sports Earphones', 'Wireless earphones for sports and workouts', 49.99),
(62, 'Smart Home Security Camera', 'Wireless camera for home surveillance', 79.99),
(63, 'Wireless Charging Stand', 'Charging stand for smartphones with wireless charging', 34.99),
(64, 'Portable Bluetooth Keyboard', 'Foldable keyboard for convenient typing on the go', 39.99),
(65, 'Wireless Gaming Headset', 'Gaming headset with wireless connectivity', 99.99),
(66, 'USB-C Docking Station', 'Docking station for expanding connectivity on USB-C devices', 89.99),
(67, 'Bluetooth Noise-Canceling Earbuds', 'Wireless earbuds with active noise cancellation', 99.99),
(68, 'Smart Wi-Fi Plug', 'Wi-Fi enabled smart plug for remote control of devices', 19.99),
(69, 'USB Microphone', 'High-quality USB microphone for recording and streaming', 69.99),
(70, 'Wireless Ergonomic Mouse', 'Ergonomic mouse with wireless connectivity', 39.99),
(71, 'Smart Video Doorbell', 'Video doorbell with two-way audio and motion detection', 149.99),
(72, 'Portable Power Station', 'Compact power station for camping and emergencies', 199.99),
(73, 'Wireless Bluetooth Adapter', 'Bluetooth adapter for adding wireless capability to devices', 24.99),
(74, 'Smart Wi-Fi Bulb', 'Wi-Fi enabled LED bulb with remote control and scheduling', 19.99),
(75, 'Wireless Presenter', 'Presentation remote for professional presentations', 29.99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `metal_team_marketplace`.`Order`
-- -----------------------------------------------------
START TRANSACTION;
USE `metal_team_marketplace`;

INSERT INTO `Order`
(`order_id`, `user_id`, `product_id`, `purchase_quantity`, `total_cost`, `transaction_date`)
VALUES
(1, 5, 1, 3, 59.97, '2022-02-15'),
(2, 10, 5, 2, 79.98, '2022-04-26'),
(3, 15, 9, 4, 5999.96, '2022-01-09'),
(4, 20, 13, 7, 1049.93, '2023-03-05'),
(5, 3, 17, 6, 899.94, '2022-06-21'),
(6, 7, 21, 5, 749.95, '2023-01-28'),
(7, 13, 25, 9, 449.91, '2022-09-07'),
(8, 2, 29, 8, 559.92, '2022-11-12'),
(9, 6, 33, 7, 1749.93, '2023-04-15'),
(10, 1, 37, 1, 199.99, '2022-03-31'),
(11, 11, 41, 2, 119.98, '2023-02-03'),
(12, 16, 45, 10, 1499.90, '2023-05-22'),
(13, 19, 49, 6, 299.94, '2022-12-19'),
(14, 12, 53, 3, 179.97, '2022-07-04'),
(15, 4, 57, 4, 599.96, '2023-06-01'),
(16, 9, 61, 5, 249.95, '2022-05-06'),
(17, 8, 65, 6, 599.94, '2022-08-30'),
(18, 14, 69, 7, 489.93, '2023-02-20'),
(19, 17, 73, 8, 199.92, '2022-10-11'),
(20, 18, 75, 9, 269.91, '2023-03-14'),
(21, 3, 2, 6, 299.94, '2022-02-21'),
(22, 9, 6, 7, 629.93, '2022-03-25'),
(23, 17, 10, 2, 799.98, '2022-04-18'),
(24, 14, 14, 8, 399.92, '2022-05-20'),
(25, 12, 18, 3, 89.97, '2022-06-19'),
(26, 6, 22, 4, 519.96, '2022-07-15'),
(27, 4, 26, 5, 449.95, '2022-08-10'),
(28, 8, 30, 6, 899.94, '2022-09-23'),
(29, 18, 34, 7, 279.93, '2022-10-12'),
(30, 16, 38, 8, 639.92, '2022-11-07'),
(31, 7, 42, 9, 269.91, '2022-12-17'),
(32, 1, 46, 10, 899.90, '2023-01-20'),
(33, 5, 50, 5, 199.95, '2023-02-21'),
(34, 20, 54, 6, 419.94, '2023-03-25'),
(35, 2, 58, 7, 174.93, '2023-04-18'),
(36, 10, 62, 8, 639.92, '2023-05-20'),
(37, 11, 66, 9, 899.91, '2023-02-19'),
(38, 19, 70, 10, 399.90, '2023-01-15'),
(39, 15, 74, 3, 59.97, '2023-03-10'),
(40, 13, 75, 4, 119.96, '2023-04-23'),
(41, 5, 4, 2, 99.98, '2022-02-22'),
(42, 8, 7, 3, 2099.97, '2022-03-15'),
(43, 12, 11, 4, 319.96, '2022-04-30'),
(44, 15, 15, 5, 399.95, '2022-05-23'),
(45, 2, 19, 6, 419.94, '2022-06-25'),
(46, 6, 23, 7, 2099.93, '2022-07-16'),
(47, 9, 27, 8, 639.92, '2022-08-31'),
(48, 1, 31, 9, 1349.91, '2022-09-20'),
(49, 11, 35, 10, 249.90, '2022-10-15'),
(50, 3, 39, 2, 69.98, '2022-11-28'),
(51, 17, 43, 3, 59.97, '2022-12-29'),
(52, 14, 47, 4, 199.96, '2023-01-21'),
(53, 7, 51, 5, 249.95, '2023-02-22'),
(54, 20, 55, 6, 119.94, '2023-03-19'),
(55, 19, 59, 7, 209.93, '2023-04-18'),
(56, 4, 63, 8, 279.92, '2023-05-14'),
(57, 10, 67, 9, 899.91, '2023-02-27'),
(58, 13, 71, 10, 1499.90, '2023-01-11'),
(59, 18, 75, 5, 149.95, '2023-03-05'),
(60, 16, 1, 6, 119.94, '2023-04-27'),
(61, 13, 26, 4, 359.96, '2022-02-12'),
(62, 19, 36, 7, 2099.93, '2022-03-27'),
(63, 2, 46, 3, 269.97, '2022-04-08'),
(64, 9, 56, 8, 799.92, '2022-05-16'),
(65, 14, 66, 9, 899.91, '2022-06-05'),
(66, 18, 75, 2, 59.98, '2022-07-14'),
(67, 1, 14, 5, 249.95, '2022-08-25'),
(68, 7, 24, 6, 1199.94, '2022-09-15'),
(69, 17, 34, 7, 279.93, '2022-10-30'),
(70, 6, 44, 8, 319.92, '2022-11-12'),
(71, 16, 54, 2, 139.98, '2022-12-28'),
(72, 10, 64, 3, 119.97, '2023-01-10'),
(73, 5, 74, 4, 79.96, '2023-02-20'),
(74, 20, 8, 5, 4999.95, '2023-03-15'),
(75, 4, 18, 6, 179.94, '2023-04-25'),
(76, 8, 28, 7, 559.93, '2023-05-17'),
(77, 12, 38, 8, 639.92, '2023-02-04'),
(78, 3, 48, 9, 224.91, '2023-01-22'),
(79, 15, 58, 10, 249.90, '2023-03-07'),
(80, 11, 68, 6, 119.94, '2023-04-29');

COMMIT;

-- -----------------------------------------------------
-- Data for table `metal_team_marketplace`.`Review`
-- -----------------------------------------------------
START TRANSACTION;
USE `metal_team_marketplace`;

INSERT INTO `Review`
(`review_id`, `product_id`, `user_id`, `rating`, `user_comment`, `review_date`)
VALUES
(1, 26, 13, 4, 'Great product!', '2022-02-26'),
(2, 36, 19, 5, 'Loved it!', '2022-04-10'),
(3, 46, 2, 3, 'Decent quality.', '2022-04-22'),
(4, 56, 9, 4, 'Fast delivery!', '2022-05-30'),
(5, 66, 14, 2, 'Expected better.', '2022-06-19'),
(6, 75, 18, 5, 'Amazing quality!', '2022-07-28'),
(7, 14, 1, 3, 'Good, but not great.', '2022-09-08'),
(8, 24, 7, 4, 'Will order again.', '2022-09-29'),
(9, 34, 17, 1, 'Not satisfied.', '2022-11-13'),
(10, 44, 6, 5, 'Exceeded expectations!', '2022-11-26'),
(11, 54, 16, 4, 'Worth the price.', '2023-01-11'),
(12, 64, 10, 3, 'Satisfactory.', '2023-01-24'),
(13, 74, 5, 2, 'Could be better.', '2023-03-06'),
(14, 8, 20, 5, 'Superb!', '2023-03-29'),
(15, 18, 4, 4, 'Good purchase.', '2023-05-09'),
(16, 28, 8, 3, 'Decent product.', '2023-05-31'),
(17, 38, 12, 2, 'Not as described.', '2023-02-18'),
(18, 48, 3, 1, 'Very disappointed.', '2023-02-05'),
(19, 58, 15, 5, 'Excellent service.', '2023-03-21'),
(20, 68, 11, 4, 'Happy with my purchase.', '2023-05-13'),
(21, 75, 18, 3, 'Good quality', '2023-03-29'),
(22, 1, 16, 4, 'Very good', '2023-05-11'),
(23, 26, 13, 5, 'Excellent', '2022-02-26'),
(24, 36, 19, 4, 'Good service', '2022-04-10'),
(25, 46, 2, 3, 'Satisfactory', '2022-04-30'),
(26, 56, 9, 4, 'Nice packaging', '2022-05-30'),
(27, 66, 14, 5, 'Very good', '2022-06-19'),
(28, 75, 18, 3, 'Can be better', '2022-07-28'),
(29, 14, 1, 4, 'Great quality', '2022-09-09'),
(30, 24, 7, 5, 'Awesome service', '2022-09-29'),
(31, 34, 17, 4, 'Worth the price', '2022-11-13'),
(32, 44, 6, 3, 'Good', '2022-11-26'),
(33, 54, 16, 4, 'Great', '2023-01-11'),
(34, 64, 10, 5, 'Impressive', '2023-01-24'),
(35, 74, 5, 4, 'Loved it', '2023-03-06'),
(36, 8, 20, 3, 'Okay', '2023-03-29'),
(37, 18, 4, 4, 'Fast delivery', '2023-05-09'),
(38, 28, 8, 5, 'Excellent', '2023-05-31'),
(39, 38, 12, 4, 'Very good', '2023-02-18'),
(40, 48, 3, 3, 'Good', '2023-02-05'),
(41, 58, 15, 4, 'Worth the price', '2023-03-24'),
(42, 68, 11, 5, 'Impressive quality', '2023-05-13'),
(43, 4, 5, 4, 'Great service', '2022-03-08'),
(44, 7, 8, 3, 'Can be better', '2022-03-29'),
(45, 11, 12, 5, 'Awesome product', '2022-05-14'),
(46, 15, 15, 3, 'Good for the price', '2022-06-06'),
(47, 19, 2, 4, 'Fast delivery', '2022-07-09'),
(48, 23, 6, 5, 'Loved the quality', '2022-07-30'),
(49, 27, 9, 4, 'Nice packaging', '2022-09-14'),
(50, 31, 1, 3, 'Can be better', '2022-10-04'),
(51, 35, 11, 4, 'Good quality', '2022-10-29'),
(52, 39, 3, 5, 'Excellent service', '2022-12-12'),
(53, 43, 17, 3, 'Satisfactory', '2023-01-12'),
(54, 47, 14, 4, 'Good product', '2023-02-04'),
(55, 51, 7, 5, 'Great quality', '2023-03-10'),
(56, 55, 20, 3, 'Okay', '2023-04-02'),
(57, 59, 19, 4, 'Good service', '2023-05-02'),
(58, 63, 4, 5, 'Excellent', '2023-05-28'),
(59, 67, 10, 4, 'Very good', '2023-03-13'),
(60, 71, 13, 3, 'Satisfactory', '2023-01-25');

COMMIT;

-- -----------------------------------------------------
-- Data for table `metal_team_marketplace`.`Inventory`
-- -----------------------------------------------------
START TRANSACTION;
USE `metal_team_marketplace`;
INSERT INTO `Inventory`
(`inventory_id`, `product_id`, `quantity`)
VALUES
(1, 1, 3245),
(2, 2, 5678),
(3, 3, 2345),
(4, 4, 8765),
(5, 5, 3456),
(6, 6, 9876),
(7, 7, 4567),
(8, 8, 2345),
(9, 9, 7654),
(10, 10, 5678),
(11, 11, 2456),
(12, 12, 6789),
(13, 13, 3457),
(14, 14, 7890),
(15, 15, 4568),
(16, 16, 1234),
(17, 17, 5679),
(18, 18, 2346),
(19, 19, 6780),
(20, 20, 3458),
(21, 21, 8912),
(22, 22, 7683),
(23, 23, 1234),
(24, 24, 9467),
(25, 25, 3246),
(26, 26, 5879),
(27, 27, 4312),
(28, 28, 8923),
(29, 29, 7654),
(30, 30, 3012),
(31, 31, 4567),
(32, 32, 9823),
(33, 33, 3425),
(34, 34, 7123),
(35, 35, 4568),
(36, 36, 9134),
(37, 37, 5679),
(38, 38, 2346),
(39, 39, 6780),
(40, 40, 3458),
(41, 41, 8723),
(42, 42, 3219),
(43, 43, 7832),
(44, 44, 9123),
(45, 45, 4571),
(46, 46, 3012),
(47, 47, 5864),
(48, 48, 7293),
(49, 49, 1254),
(50, 50, 9082),
(51, 51, 5431),
(52, 52, 7129),
(53, 53, 4532),
(54, 54, 8971),
(55, 55, 6543),
(56, 56, 2846),
(57, 57, 7319),
(58, 58, 1234),
(59, 59, 8092),
(60, 60, 5643),
(61, 61, 2741),
(62, 62, 8296),
(63, 63, 1972),
(64, 64, 5543),
(65, 65, 4189),
(66, 66, 3231),
(67, 67, 1723),
(68, 68, 8946),
(69, 69, 6423),
(70, 70, 5801),
(71, 71, 3164),
(72, 72, 7896),
(73, 73, 5324),
(74, 74, 2856),
(75, 75, 4369);

COMMIT;

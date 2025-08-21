-- Create database
CREATE DATABASE hotel_reservation;

USE hotel_reservation;

-- Table for room types
CREATE TABLE room_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL
);

-- Table for rooms
CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES room_types(id)
);

-- Table for guests
CREATE TABLE guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- Table for reservations
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

INSERT INTO room_types (type_name, description, price) VALUES 
('Single Room', 'A room with a single bed.', 50.00),
('Double Room', 'A room with a double bed.', 80.00),
('Suite', 'A luxurious room with a king-size bed and extra amenities.', 150.00);

INSERT INTO rooms (room_number, type_id) VALUES 
('101', 1),  -- Single Room
('102', 1),  -- Single Room
('201', 2),  -- Double Room
('202', 2),  -- Double Room
('301', 3), -- Suite
('302',5);--Suite
INSERT INTO guests (first_name, last_name, email, phone) VALUES 
('John', 'Doe', 'john.doe@example.com', '555-1234'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555-8765');

INSERT INTO reservations (guest_id, room_id, check_in, check_out) VALUES 
(1, 1, '2024-08-01', '2024-08-05'),
(2, 3, '2024-08-10', '2024-08-15'),
(3, 5, '2024-08-20', '2024-08-25');

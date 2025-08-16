-- ALX Book Store schema
CREATE DATABASE IF NOT EXISTS alx_book_store
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE alx_book_store;

-- AUTHORS table
CREATE TABLE IF NOT EXISTS Authors (
  author_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(215) NOT NULL,
  PRIMARY KEY (author_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CUSTOMERS table
CREATE TABLE IF NOT EXISTS Customers (
  customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_name VARCHAR(215),
  email VARCHAR(215),
  address TEXT,
  PRIMARY KEY (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- BOOKS table
CREATE TABLE IF NOT EXISTS Books (
  book_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(130),
  author_id INT UNSIGNED,
  price DOUBLE,
  publication_date DATE,
  PRIMARY KEY (book_id),
  FOREIGN KEY (author_id) REFERENCES Authors (author_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDERS table
CREATE TABLE IF NOT EXISTS Orders (
  order_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id INT UNSIGNED,
  order_date DATE,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDER_DETAILS table
CREATE TABLE IF NOT EXISTS Order_Details (
  orderdetailid INT UNSIGNED NOT NULL AUTO_INCREMENT,
  order_id INT UNSIGNED,
  book_id INT UNSIGNED,
  quantity DOUBLE,
  PRIMARY KEY (orderdetailid),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES Books(book_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

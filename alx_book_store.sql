-- ALX Book Store schema
CREATE DATABASE IF NOT EXISTS alx_book_store
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE alx_book_store;

-- AUTHORS table
CREATE TABLE IF NOT EXISTS "Authors" (
  "author_id" INT UNSIGNED NOT NULL AUTO_INCREMENT,
  "author_name" VARCHAR(215) NOT NULL,
  PRIMARY KEY ("author_id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CUSTOMERS table
CREATE TABLE IF NOT EXISTS "Customers" (
  "customer_id" INT UNSIGNED NOT NULL AUTO_INCREMENT,
  "customer_name" VARCHAR(215) NOT NULL,
  "email" VARCHAR(215) NOT NULL,
  "address" TEXT,
  PRIMARY KEY ("customer_id"),
  UNIQUE KEY "ux_customers_email" ("email")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- BOOKS table
CREATE TABLE IF NOT EXISTS "Books" (
  "book_id" INT UNSIGNED NOT NULL AUTO_INCREMENT,
  "title" VARCHAR(130) NOT NULL,
  "author_id" INT UNSIGNED NOT NULL,
  "price" DOUBLE NOT NULL,
  "publication_date" DATE,
  PRIMARY KEY ("book_id"),
  KEY "ix_books_author_id" ("author_id"),
  CONSTRAINT "fk_books_author"
    FOREIGN KEY ("author_id") REFERENCES "Authors" ("author_id")
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDERS table
CREATE TABLE IF NOT EXISTS "Orders" (
  "order_id" INT UNSIGNED NOT NULL AUTO_INCREMENT,
  "customer_id" INT UNSIGNED NOT NULL,
  "order_date" DATE NOT NULL,
  PRIMARY KEY ("order_id"),
  KEY "ix_orders_customer_id" ("customer_id"),
  CONSTRAINT "fk_orders_customer"
    FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id")
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDER_DETAILS table
CREATE TABLE IF NOT EXISTS "Order_Details" (
  "orderdetailid" INT UNSIGNED NOT NULL AUTO_INCREMENT,
  "order_id" INT UNSIGNED NOT NULL,
  "book_id" INT UNSIGNED NOT NULL,
  "quantity" DOUBLE NOT NULL,
  PRIMARY KEY ("orderdetailid"),
  KEY "ix_order_details_order_id" ("order_id"),
  KEY "ix_order_details_book_id" ("book_id"),
  CONSTRAINT "fk_order_details_order"
    FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id")
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT "fk_order_details_book"
    FOREIGN KEY ("book_id") REFERENCES "Books" ("book_id")
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
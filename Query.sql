-- 1. CREATE USERS TABLE
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role VARCHAR(20)  NOT NULL,
    phone_number VARCHAR(20),

    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT chk_users_role CHECK (role IN ('Ticket Manager', 'Football Fan'))
);

-- 2. CREATE MATCHES TABLE
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(100) NOT NULL,
    base_ticket_price NUMERIC(10, 2) NOT NULL,
    match_status VARCHAR(20) NOT NULL,

    CONSTRAINT chk_matches_price CHECK (base_ticket_price >= 0),
    CONSTRAINT chk_matches_status CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- 3. CREATE BOOKINGS TABLE
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    match_id INT NOT NULL,
    seat_number VARCHAR(10),
    payment_status VARCHAR(20),
    total_cost NUMERIC(10, 2) NOT NULL,

    CONSTRAINT fk_bookings_user
        FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_bookings_match
        FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    CONSTRAINT chk_bookings_cost CHECK (total_cost >= 0),
    CONSTRAINT chk_bookings_status CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);
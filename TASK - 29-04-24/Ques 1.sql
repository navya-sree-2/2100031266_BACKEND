-- create a table
CREATE TABLE countries (
    country_id VARCHAR(2) PRIMARY KEY,
    country_name VARCHAR(25) NOT NULL,
    region_id INTEGER NOT NULL
);

INSERT INTO countries VALUES ('AR', 'Argentina', 2), ('AU', 'Australia', 3),
    ('BE', 'Belgium', 1), ('BR', 'Brazil', 2), ('CA', 'Canada', 2),
    ('CH', 'Switzerland', 1), ('CN', 'China', 3), ('DE', 'Germany', 1),
    ('IT', 'Italy', 3), ('JP', 'Japan', 1), ('US', 'America', 2);


CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    street_address VARCHAR(25) NOT NULL,
    postal_code VARCHAR(25) NOT NULL,
    city VARCHAR(25) NOT NULL,
    state_province VARCHAR(25),
    country_id VARCHAR(2) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

INSERT INTO locations(location_id, street_address, postal_code, city, country_id) VALUES (1000, '1297 Via Cola di Rie', '989', 'Roma', 'IT'), (1100, '93091 Calle della Te', '10934', 'Venice', 'IT');
INSERT INTO locations VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefectu', 'JP');
INSERT INTO locations(location_id, street_address, postal_code, city, country_id) VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', 'JP');
INSERT INTO locations VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'), 
    (1500, '2011 Interiors Blvd', '99236', 'South San', 'California', 'US'),
    (1600, '2007 Zagora St', '50090', 'South Brun', 'New Jersey', 'US'), 
    (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
    (1800, '147 Spadina Ave', 'MSV 2L7', 'Toronto', 'Ontario', 'CA');

-- FIND ADDRESS OF CANADA USING JOIN

SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM locations l
JOIN countries c ON l.country_id = c.country_id
WHERE c.country_name = 'Canada';

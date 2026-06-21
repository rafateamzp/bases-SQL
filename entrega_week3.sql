DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
create database library;
use library;
select database();
create table categories (
id int AUTO_INCREMENT primary key,
name varchar(50) unique not null,
description text
);

INSERT INTO categories (name, description) 
VALUES
    ('Fiction',    'Novels and fiction stories'),
    ('Science',    'Scientific and technical books'),
    ('History',    'History books and biographies'),
    ('Children',   'Literature for children'),
    ('Technology', 'Programming, Development, AI');

create table authors (
id int AUTO_INCREMENT primary key,
name varchar(150) not null,
country varchar(50),
birth_date date,
biography text
);

INSERT into authors (name, country, birth_date)
values 
	('Gabriel García Márquez', 'Colombia',       '1927-03-06'),   -- 1
    ('Isabel Allende',         'Chile',          '1942-08-02'),   -- 2
    ('Stephen Hawking',        'United Kingdom', '1942-01-08'),   -- 3
    ('J.K. Rowling',           'United Kingdom', '1965-07-31'),   -- 4
    ('Yuval Noah Harari',      'Israel',         '1976-02-24'),   -- 5
    ('Roald Dahl',             'United Kingdom', '1916-09-13'),   -- 6
    ('Andrew S. Tanenbaum',    'United States',  '1944-03-16'),   -- 7
    ('Ian Goodfellow',         'United States',  '1985-01-01'),   -- 8
    ('Yoshua Bengio',          'Canada',         '1964-03-05'),   -- 9
    ('Eric Matthes',           'United States',  '1970-01-01'),   -- 10
    ('Joshua Bloch',           'United States',  '1961-08-28');   -- 11
    
create table books (
	id int AUTO_INCREMENT primary key,
    isbn varchar(20) unique not null,
    title varchar(250) not null,
    category_id int,
    publication_year int,
    price decimal(10,2) not null,
    stock int default 0,
    is_active boolean default true,
    added_at timestamp default current_timestamp,
    
    constraint fk_books_category
		foreign key (category_id) references categories(id)
        on delete set null,
        
	constraint chk_year CHECK (publication_year between 1450 and 2100),
    constraint chk_price check (price >= 0),
    constraint chk_stock check (stock >= 0)
);

INSERT INTO books (isbn, title, category_id, publication_year, price, stock) 
VALUES
    -- Fiction (cat 1)
    ('978-0307474728', 'One Hundred Years of Solitude',            1, 1967, 18.99, 5),
    ('978-0142437247', 'The House of the Spirits',                 1, 1982, 16.50, 3),
    ('978-0439708180', 'Harry Potter and the Philosopher''s Stone', 1, 1997, 22.99, 8),

    -- Science (cat 2)
    ('978-0553380163', 'A Brief History of Time',                  2, 1988, 15.99, 4),
    ('978-0062316097', 'Sapiens: A Brief History of Humankind',    2, 2011, 24.99, 6),
    ('978-0062464310', 'Homo Deus',                                2, 2015, 26.50, 4),

    -- History (cat 3)
    ('978-0062315007', '21 Lessons for the 21st Century',          3, 2018, 20.99, 5),

    -- Children (cat 4)
    ('978-0142410318', 'Matilda',                                  4, 1988, 12.99, 10),
    ('978-0142410387', 'Charlie and the Chocolate Factory',        4, 1964, 14.50, 7),
    ('978-0141365534', 'The BFG',                                  4, 1982, 13.99, 6),

    -- Technology (cat 5)
    ('978-0132126953', 'Modern Operating Systems',                 5, 2007, 89.99, 3),
    ('978-0262035613', 'Deep Learning',                            5, 2016, 75.00, 2),
    ('978-0135957059', 'Computer Networks',                        5, 2010, 95.50, 2),
    ('978-1593279288', 'Python Crash Course',                      5, 2019, 39.99, 8),
    ('978-0134685991', 'Effective Java',                           5, 2017, 54.99, 4);

create table users (
	id int AUTO_INCREMENT primary key,
    email varchar(150) unique not null,
    name varchar(150) not null,
    phone varchar(20),
    membership_type enum('basic', 'premium', 'vip') default 'basic',
    is_active boolean default true,
    registered_at timestamp default current_timestamp
);

INSERT INTO users (email, name, phone, membership_type) VALUES
    ('alice.garcia@email.com',     'Alice Garcia',     '555-0001', 'premium'),   -- 1
    ('charles.lopez@email.com',    'Charles Lopez',    '555-0002', 'basic'),     -- 2
    ('mary.torres@email.com',      'Mary Torres',      '555-0003', 'vip'),       -- 3
    ('john.perez@email.com',       'John Perez',        NULL,      'basic'),     -- 4
    ('lucy.martinez@email.com',    'Lucy Martinez',    '555-0005', 'premium'),   -- 5
    ('sophie.rodriguez@email.com', 'Sophie Rodriguez', '555-0006', 'basic'),     -- 6
    ('david.fernandez@email.com',  'David Fernandez',   NULL,      'basic');     -- 7
    
create table loans (
	id int auto_increment primary key,
	user_id int not null,
	book_id int not null,
	loan_date date not null default (current_date),
	due_date date not null,
	return_date date,
	fine decimal(10,2) default 0.00,
	notes text,

constraint fk_loans_user
	foreign key (user_id) references users(id)
    on delete restrict,
    
constraint fk_loans_book
	foreign key (book_id) references books(id)
    on delete restrict,
    
constraint chk_fine check (fine >= 0),
constraint chk_return_date check (
	return_date is null or
    return_date >= loan_date
)
);

##check fase 2
select
(select count(*) from categories) as categories,
(select count(*) from authors) as authors,
(select count(*) from books) as books,
(select count(*) from users) as users;

create table book_authors (
    book_id int not null,
    author_id int not null,
    author_order int default 1,   -- 1 = autor principal, 2 = co-autor, etc.

    primary key (book_id, author_id),

    constraint fk_ba_book
        foreign key (book_id) references books(id)
        on delete cascade,

    constraint fk_ba_author
        foreign key (author_id) references authors(id)
        on delete cascade
);

insert into book_authors (book_id, author_id, author_order) 
values
    (1,  1, 1),   -- One Hundred Years → García Márquez
    (2,  2, 1),   -- The House of the Spirits → Allende
    (3,  4, 1),   -- Harry Potter → Rowling
    (4,  3, 1),   -- A Brief History → Hawking
    (5,  5, 1),   -- Sapiens → Harari
    (6,  5, 1),   -- Homo Deus → Harari
    (7,  5, 1),   -- 21 Lessons → Harari
    (8,  6, 1),   -- Matilda → Dahl
    (9,  6, 1),   -- Charlie → Dahl
    (10, 6, 1),   -- The BFG → Dahl
    (11, 7, 1),   -- Modern Operating Systems → Tanenbaum
    (12, 8, 1),   -- Deep Learning → Goodfellow (autor principal)
    (12, 9, 2),   -- Deep Learning → Bengio (co-autor)   ← ¡un libro, dos autores!
    (13, 7, 1),   -- Computer Networks → Tanenbaum
    (14, 10, 1),  -- Python Crash Course → Matthes
    (15, 11, 1);  -- Effective Java → Bloch
    
#verificacion de N:M
#libros co-escritos (más de un autor) -deberia salir solo Deep Learning
select b.title, count(*) as num_authors
from book_authors ba
join books b on ba.book_id = b.id
group by ba.book_id, b.title
having count(*) > 1;
    
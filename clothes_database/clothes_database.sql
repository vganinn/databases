CREATE TABLE pickpoint (
    PointId INT PRIMARY KEY CHECK(PointId/100000 BETWEEN 0.1 AND 0.99),
    City VARCHAR(60),
    Street VARCHAR(60),
    Building VARCHAR(20),
    Fitting_rooms INT DEFAULT 0 CHECK (Fitting_rooms >= 0),
    Opening_date DATE,
    Closing_date DATE DEFAULT NULL,
    Area NUMBER(5, 2) CHECK (Area >= 0) );

INSERT INTO pickpoint VALUES (18756, 'г. Москва', 'ул. Вавилова', '19', 4, '30-NOV-2012', NULL, 40.25);
INSERT INTO pickpoint VALUES (32469, 'г. Москва', 'ул. Арбат', '12', 5, '01-DEC-2014', '31-MAY-2020', 12.2);
INSERT INTO pickpoint VALUES (45908, 'г. Одинцово', 'ул. Первомайская', '34к2', 1, '23-JUL-2009', NULL, 12.15);
INSERT INTO pickpoint VALUES (10689, 'г. Казань', 'пр-т Ленинградский', '4', 2, '12-SEP-2015', NULL, 15);
INSERT INTO pickpoint VALUES (40214, 'г. Симферополь', 'ул. Московская', '22/3', 2, '22-NOV-2015', NULL, 35);


CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY CHECK(warehouse_id/100000 BETWEEN 0.1 AND 0.99),
    warehouse_name VARCHAR(70),
    City VARCHAR(50),
    Street VARCHAR(80),
    House_number VARCHAR(10),
    class_WH INT,
    coverage_area VARCHAR(10),
    CONSTRAINT unique_warehouse_name UNIQUE (warehouse_name),
    CONSTRAINT valid_coverage_area CHECK (coverage_area IN ('A', 'B', 'C', 'D'))
);
  
INSERT INTO warehouses VALUES (34565, 'Склад_М13', 'г. Москва', 'Ул. академика Павлова', '8', 1000, 'A');
INSERT INTO warehouses VALUES (25678, 'Склад_О23', 'г. Одинцово', 'Советская ул.', '5К2', 800, 'B');
INSERT INTO warehouses VALUES (23908, 'Склад_СИМФ21', 'г. Симферополь', 'Ул. Металлургов', '82', 500, 'A');
INSERT INTO warehouses VALUES (12087, 'Склад_М14', 'г. Москва', 'Автозаводская ул.', '18', 700, 'C');
INSERT INTO warehouses VALUES (87650, 'Склад_К19', 'г. Казань', 'Ул. Павлюхина', '91', 600, 'D');

CREATE TABLE Personnel_pick (
    Personnel_Id INT PRIMARY KEY,
    Name VARCHAR(80),
    Position VARCHAR(60),
    Id_Working_Place INT,
    Head_Id INT,
    FOREIGN KEY (Head_Id) REFERENCES Personnel_pick(Personnel_Id),
    FOREIGN KEY (Id_Working_Place) REFERENCES pickpoint(PointId));

-- Пункт выдачи №1
INSERT INTO Personnel_pick VALUES (4831, 'Алексеев Игорь Геннадьевич', 'Менеджер', 18756, NULL);
INSERT INTO Personnel_pick VALUES (4824, 'Петрова Татьяна Евгеньевна', 'Уборщица', 18756, 4831);
INSERT INTO Personnel_pick VALUES (2834, 'Пушкин Анатолий Павлович', 'Ассистент менеджера', 18756, 4831);

--Пункт выдачи №2
INSERT INTO Personnel_pick VALUES (4245, 'Соколова Виктория Дмитриевна', 'Менеджер', 45908, NULL);
INSERT INTO Personnel_pick VALUES (1256, 'Баранов Виталий Витальевич', 'Уборщик', 45908, 4245);

--Пункт выдачи №3
INSERT INTO Personnel_pick VALUES (4812, 'Ветрова Татьяна Игоревна', 'Менеджер', 10689, NULL);
INSERT INTO Personnel_pick VALUES (4384, 'Козлова Марина Юрьевна', 'Уборщица', 10689, 4812);

--Пункт выдачи №4
INSERT INTO Personnel_pick VALUES (3962, 'Петрова Татьяна Константиновна', 'Менеджер', 40214, NULL);

CREATE TABLE Personnel_warehouses (
    Personnel_Id INT PRIMARY KEY,
    Name VARCHAR(80),
    Position VARCHAR(60),
    Id_Working_Place INT,
    Head_Id INT,
    FOREIGN KEY (Head_Id) REFERENCES Personnel_warehouses(Personnel_Id),
    FOREIGN KEY (Id_Working_Place) REFERENCES warehouses(warehouse_id));

--Склад №1
INSERT INTO Personnel_warehouses VALUES (4134, 'Петров Анатолий Евгеньевич', 'Директор', 34565, NULL);
INSERT INTO Personnel_warehouses VALUES (4566, 'Алексеенко Сергей Павлович', 'Грузчик', 34565, 4134);
INSERT INTO Personnel_warehouses VALUES (2567, 'Пушков Анатолий Петрович', 'Кладовщик', 34565, 4134);

--Склад №2
INSERT INTO Personnel_warehouses VALUES (4357, 'Соколовская Ирина Евгеньевна', 'Директор', 25678, NULL);
INSERT INTO Personnel_warehouses VALUES (1235, 'Барановский Виктор Витальевич', 'Кладовщик-грузчик', 25678, 4357);

--Склад №3
INSERT INTO Personnel_warehouses VALUES (4834, 'Кирова Маргарита Игоревна', 'Директор', 23908, NULL);
INSERT INTO Personnel_warehouses VALUES (4575, 'Козловская Эльвира Игоревна', 'Водитель погрузчика', 23908, 4834);

--Склад №4
INSERT INTO Personnel_warehouses VALUES (1200, 'Власов Юрий Викторович', 'Заведующий складом', 12087, NULL);
INSERT INTO Personnel_warehouses VALUES (3963, 'Петрова Татьяна Витальевна', 'Рабочий склада', 12087, 1200);

--Склад №5
INSERT INTO Personnel_warehouses VALUES (1201, 'Бывалов Сергей Викторович', 'Заведующий складом', 87650, NULL);
INSERT INTO Personnel_warehouses VALUES (5467, 'Кириленко Маргарита Анатольевна', 'Уборщица', 87650, 1201);

CREATE TABLE Goods (
    ID_clothes INTEGER PRIMARY KEY, 
    Type VARCHAR(60) NOT NULL,    
    Purpose VARCHAR(60) NOT NULL,
    Gender VARCHAR(3) CHECK (Gender IN ('м', 'ж')),
    Size0 VARCHAR(10) CHECK (Size0 IN ('XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL', '4XL')),
    Season VARCHAR(60) NOT NULL,
    Country VARCHAR(60) NOT NULL,
    Material VARCHAR(60) NOT NULL);

INSERT INTO Goods VALUES (12347, 'куртка', 'повседневная', 'ж', 'XS', 'autumn, spring', 'Казахстан', 'шерсть 20%, акрил 80%');
INSERT INTO Goods VALUES (12346, 'куртка', 'повседневная, спорт', 'м', 'S', 'winter', 'Казахстан', 'экокожа 100%');
INSERT INTO Goods VALUES (12333, 'джинсы', 'повседневная', 'ж', 'M', 'all seasons', 'Казахстан', 'Хлопок 98%, Эластан 2%');
INSERT INTO Goods VALUES (12348, 'кофта на молнии', 'повседневная, спорт, дом', 'м', 'M', 'all seasons', 'Казахстан', 'Полиэстер - 80% , Хлопок - 20%');
INSERT INTO Goods VALUES (12349, 'кофта на молнии', 'повседневная, спорт, дом', 'ж', 'XL', 'spring, summer, autumn', 'Китай', 'хлопок');
INSERT INTO Goods VALUES (12342, 'рубашка', 'повседневная', 'м', 'XS', 'all seasons', 'Казахстан', 'хлопок');
INSERT INTO Goods VALUES (12340, 'носки', 'повседневная, спорт, дом', 'м', 'S', 'all seasons', 'Казахстан', 'хлопок');
INSERT INTO Goods VALUES (12341, 'топ', 'повседневная, спорт, дом', 'ж', '4XL', 'summer', 'Казахстан', 'хлопок');
INSERT INTO Goods VALUES (12444, 'рубашка', 'повседневная', 'м', '3XL', 'all seasons', 'Казахстан', 'хлопок');

CREATE TABLE Clients (
    Email VARCHAR(60),
    Phone_number VARCHAR(14),
    Date_of_birth DATE NOT NULL,
    Gender VARCHAR(3) CHECK (Gender IN ('м', 'ж')),
    Discount INTEGER CHECK (Discount BETWEEN 1 AND 25),
    Close_pickpoint_ID INTEGER,
    FOREIGN KEY (Close_pickpoint_ID) REFERENCES pickpoint(PointId),
    PRIMARY KEY (Email, Phone_number));

INSERT INTO Clients VALUES ('utka@mail.ru', '+79778480828', '20-OCT-1981', 'ж', 15, 18756);
INSERT INTO Clients VALUES ('superutka@mail.ru', '+79748680829', '03-OCT-1978', 'м', 3, 32469);
INSERT INTO Clients VALUES ('RichardK@mail.ru', '+79778333828', '13-NOV-1985', 'ж', 4, 45908);
INSERT INTO Clients VALUES ('kotleta@mail.ru', '+79778480777', '16-OCT-1982', 'м', 10, 10689);
INSERT INTO Clients VALUES ('psina@mail.ru', '+79778480666', '22-MAY-1975', 'ж', 9, 10689);
INSERT INTO Clients VALUES ('kotiki@mail.ru', '+7977844444', '24-NOV-1954', 'м', 20, 40214);

CREATE TABLE Keep (
    warehouse_id INTEGER,
    ID_clothes INTEGER, 
    Remainder INTEGER NOT NULL,
    PRIMARY KEY (warehouse_id, ID_clothes),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (ID_clothes) REFERENCES Goods(ID_clothes));

INSERT INTO Keep VALUES (34565, 12346, 15);
INSERT INTO Keep VALUES (25678, 12346, 43);
INSERT INTO Keep VALUES (23908, 12333, 10);
INSERT INTO Keep VALUES (12087, 12342, 55);
INSERT INTO Keep VALUES (87650, 12444, 73);

CREATE TABLE Shopping_cart (
    ID_clothes INTEGER,
    Email VARCHAR(60),
    Phone_number VARCHAR(14),
    Quantity INTEGER,
    PRIMARY KEY (ID_clothes, Email),
    FOREIGN KEY (Email, Phone_number) REFERENCES Clients(Email, Phone_number),
    FOREIGN KEY (ID_clothes) REFERENCES Goods(ID_clothes)
    );

INSERT INTO Shopping_cart VALUES (12346, 'utka@mail.ru','+79778480828', 1);
INSERT INTO Shopping_cart VALUES (12346, 'kotiki@mail.ru','+7977844444', 1);
INSERT INTO Shopping_cart VALUES (12333, 'utka@mail.ru','+79778480828', 1);
INSERT INTO Shopping_cart VALUES (12342, 'utka@mail.ru','+79778480828', 1);
INSERT INTO Shopping_cart VALUES (12444, 'RichardK@mail.ru','+79778333828', 1);

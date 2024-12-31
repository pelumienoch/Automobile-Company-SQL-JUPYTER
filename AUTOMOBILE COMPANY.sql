CREATE DATABASE automobile;
USE automobile;

-- Customers table
CREATE TABLE Customers (
    customer_id VARCHAR(255) PRIMARY KEY UNIQUE,  -- this constraint makes this attribute the primary key as well as unique from other entries
    name VARCHAR(255),
    email_address VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15)
);


-- Cars table
CREATE TABLE Cars (
    registration_no VARCHAR(15) PRIMARY KEY UNIQUE,
    make VARCHAR(100),
    model VARCHAR(100),
    manufacture_date DATE,
    customer_id VARCHAR (255),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Services table
CREATE TABLE Services (
    service_id VARCHAR(255) PRIMARY KEY,
    drop_off_date DATE NOT NULL,
    drop_off_time TIME NOT NULL,
    description TEXT,
    mileage INT,
    next_service_date DATE,
	registration_no VARCHAR(15),
    FOREIGN KEY (registration_no) REFERENCES Cars(registration_no) ON DELETE CASCADE
);

-- Automatically assigning a next service date
DELIMITER $$
CREATE TRIGGER trg_SetNextServiceDate
BEFORE INSERT ON services
FOR EACH ROW
BEGIN
    IF NEW.next_service_date IS NULL THEN
        SET NEW.next_service_date = DATE_ADD(NEW.drop_off_date, INTERVAL 12 MONTH);
    END IF;
END $$


-- Mechanics table
CREATE TABLE Mechanics (
    employee_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15) UNIQUE,
    grade VARCHAR(50)
);

-- Service_Mechanics table (to handle the many-to-many relationship)
CREATE TABLE Service_Mechanics (
    service_id VARCHAR(255),
    employee_id VARCHAR(20),
    time_spent TIME,
    PRIMARY KEY (service_id, employee_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (employee_id) REFERENCES Mechanics(employee_id),
	CONSTRAINT chk_time_spent_format CHECK (TIME_TO_SEC(time_spent) % 60 = 0) -- Ensures seconds are always zero
);

-- to automatically update the time spent
DELIMITER $$

CREATE TRIGGER trg_UpdateServiceTime
AFTER UPDATE ON service_mechanics
FOR EACH ROW
BEGIN
    UPDATE services
    SET TotalTimeSpent = (SELECT SUM(time_spent) FROM service_mechanics WHERE service_id = OLD.service_id)
    WHERE service_id = OLD.service_id;
END $$

DELIMITER ;




-- time to populate our tables with the customers data

INSERT INTO customers VALUES('D13-101', 'Bette Davis', 'bette.davis@ulster.ac.uk', '41728003');
INSERT INTO customers VALUES('D13-203', 'Cary Grant', 'bigcary@yahoo.com', '+44417654321');
INSERT INTO customers VALUES('D13-42 ', 'Humphrey Bogart', 'bogieh@gmail.com', '07782751839');
INSERT INTO customers VALUES('D13-R93', 'John Wayne', '', '02890112233');
INSERT INTO customers VALUES('D14-38 ', 'Katharine Hepburn', 'kath_hep29@hotmail.com', '');
INSERT INTO customers VALUES('D17-022', 'Marilyn Monroe', 'marilyn@hotmail.com', '+88487618356732');
INSERT INTO customers VALUES('D17-080', 'Orson Welles', 'welles.orson@ulster.ac.uk', '08998736126');
INSERT INTO customers VALUES('R180-05', 'Vivien Leigh', 'viv.leigh38@gmail.com', '02890289675');
INSERT INTO customers VALUES('D13-51 ', 'Ingrid Bergman', 'IngridB@hotmail.com', '66419887654');
INSERT INTO customers VALUES('D13-306', 'William Holden', 'billyho66@yahoo.com', '+38198322843');
INSERT INTO customers VALUES('L231-12', 'Rita Hayworth', 'ritah99@outlook.com', '077709873980');
INSERT INTO customers VALUES('D13-R45', 'James Stewart', 'jimmy_stew@qub.ac.uk', '08770987654');
INSERT INTO customers VALUES('D14-025', 'James Dean', 'deenj@outlook.com', '+447780276405');
INSERT INTO customers VALUES('D14-16', 'Rock Hudson', 'rockyh@hotmail.com', '');
INSERT INTO customers VALUES('D14-V17', 'Tony Curtis', 't.curtis@yahoo.com', '');
INSERT INTO customers VALUES('L231-47', 'Elvis Presley', 'elvisp@yahoo.com', '');
INSERT INTO customers VALUES('L231-05', 'Burt Lancaster', NULL, '+447781904569');
INSERT INTO customers VALUES('D17-945', 'Frank Sinatra', NULL, '08870286004');
INSERT INTO customers VALUES('D17-043', 'Deborah Kerr', NULL, '02890672593');
INSERT INTO customers VALUES('R180-61', 'Elizabeth Taylor', NULL, '+442891785397');
INSERT INTO customers VALUES('R180-32', 'Susan Hayward', 'susan.hayward@yahoo.com', '');
INSERT INTO customers VALUES('D17-R14', 'Lana Turner', 'lana.turner@yahoo.com', '');
INSERT INTO customers VALUES('L231-44', 'Omar Sharif', 'sharifo18@hotmail.com', '00447880708090');
INSERT INTO customers VALUES('D14-37 ', 'Natalie Wood', 'nattiewood@outlook.com', '');
INSERT INTO customers VALUES('D14-V77', 'Doris Day', 'd.day67@hotmail.com', '+4478779297611');
INSERT INTO customers VALUES('D13-R71', 'Sean Connery', 'connery.sean007@outlook.com', '');



-- time to populate our tables with the cars data

INSERT INTO cars VALUES('BJI 111', 'Vauxhall', 'Astra', '2016-02-07', 'D13-101');
INSERT INTO cars VALUES('AF56 WWJ',	'Volkswagen', 'Golf',	'2014-05-25', 'D13-203');
INSERT INTO cars VALUES('LV59 OTP',	'Volkswagen', 'Polo',	'2015-06-30',	'D13-42 ');
INSERT INTO cars VALUES('SEZ 5629',	'Skoda', 'Superb',	'2009-11-26','D13-R93');
INSERT INTO cars VALUES('MEZ 8086',	'Subaru', 'Impreza','2017-10-15','D14-38 ');
INSERT INTO cars VALUES('GRZ 6511',	'Subaru',	'Outback',	'2018-04-01',	'D17-022');
INSERT INTO cars VALUES('DCZ 1844',	'Nissan',	'Qashqai Visia','2008-03-13','D17-080');
INSERT INTO cars VALUES('VIM 8955',	'Skoda','Superb','2016-10-14','R180-05');
INSERT INTO cars VALUES('OEZ 1872', 'Alfa Romeo','Alfasud','2014-09-22', 'D13-101');
INSERT INTO cars VALUES('D268 YCF','Audi','A8 TFSI e','2020-02-07','D13-51 ');
INSERT INTO cars VALUES('CJ16 WED',	'Vauxhall',	'Corsa-e',	'2020-01-27',	'D13-306');
INSERT INTO cars VALUES('WVG 673',	'Volvo','V90',	'2019-12-13',	'D17-080');
INSERT INTO cars VALUES('W85 TTF',	'Nissan',	'Micra',	'2017-12-12',	'D17-022');

INSERT INTO cars VALUES('LLZ 9362','Volkswagen','Golf','2018-08-30','D13-306');

INSERT INTO cars VALUES('R99 YRK',	'BMW','6 Series Gran Coupe','2019-11-04','L231-12');
INSERT INTO cars VALUES('T779 OLI',	'Ford',	'Fiesta 1.25 Zetec','2016-03-16','D13-R45');
INSERT INTO cars VALUES('BEZ 8826','Toyota','Corolla','2015-05-26',	'D13-51 ');
INSERT INTO cars VALUES('G5 T77','Dacia','Duster','2017-09-19',	'D13-306');
-- INSERT INTO cars VALUES('SEZ 5629',	'Skoda','Superb','2009-11-26','D13-R93');
INSERT INTO cars VALUES('STR 9378',	'Skoda', '', NULL, 'D14-025');
INSERT INTO cars VALUES('F6 Y886','Skoda','Superb',	'2018-12-14', 'D14-16');
INSERT INTO cars VALUES('YR3 67', 'Vauxhall','Corsa-e', '2019-06-27','D14-V17');
INSERT INTO cars VALUES('DYR 87','Toyota',	'Corolla',	'2016-03-26',	'L231-47');
INSERT INTO cars VALUES('SWT 9930',	'Dacia',	'Duster',	'2018-02-15',	'L231-05');
INSERT INTO cars VALUES('D89 Y6', 'Alfa Romeo',	'Alfasud',	'2016-09-02',	'D17-945');
INSERT INTO cars VALUES('Y4 T87','Subaru',	'Impreza',	'2017-11-05',	'D17-043');
INSERT INTO cars VALUES('JEZ 7719',	'Dacia', '', NULL , 'R180-61');
INSERT INTO cars VALUES('MEW 783',	'Ford',	'Focus','2017-09-19',	'R180-32');
INSERT INTO cars VALUES('JEA 991',	'Volvo',	'V70',	'2018-10-13',	'D17-R14');
INSERT INTO cars VALUES('B56 Y34',	'Vauxhall',	'Astra','2017-07-22',	'L231-44');
INSERT INTO cars VALUES('FET 6821',	'Nissan',	'Qashqai Visia','2018-09-13','D14-37 ');
INSERT INTO cars VALUES('B82 T56','Skoda','Superb','2017-10-19','D14-V77');
INSERT INTO cars VALUES('CEZ 563',	'Volkswagen',	'Golf', NULL ,	'D13-R71');
-- INSERT INTO cars VALUES('AF56 WWJ',	'Volkswagen',	'Golf',	'2014-05-25', 'D13-203');
-- INSERT INTO cars VALUES('SEZ 5629',	'Skoda',	'Superb',	'2009-11-26', 'D13-R93');


-- time to populate our tables with the services data
INSERT INTO services VALUES('S2006-101', '2020-06-17','08:30:00',	'MOT check-up',	'45461','2021-06-21',	'BJI 111');
INSERT INTO services VALUES('S2006-102', '2020-06-17',	'14:30:00',	'MOT check-up',	'75712',	'2021-06-20',	'AF56 WWJ');
INSERT INTO services VALUES('S2006-103', '2020-06-17','08:00:00',	'Other - Wheel bearing - front passengers side',	'49904','2021-06-18','LV59 OTP');
INSERT INTO services VALUES('S2006-104', '2020-06-17','07:30:00','Other - Not going into third gear. All other gears are okay.','135312','2021-06-21','SEZ 5629');
INSERT INTO services VALUES('S2006-105', '2020-06-17','08:15:00','Annual service','31446','2021-06-19',	'MEZ 8086');
INSERT INTO services VALUES('S2006-106', '2020-06-18',	'16:30:00',	'Other - Rattle in the front suspension','21043','2021-06-21','GRZ 6511');
INSERT INTO services VALUES('S2006-107', '2020-06-18','08:30:00','MOT check-up','142958','2021-06-18','DCZ 1844');
INSERT INTO services VALUES('S2006-108', '2020-06-18','08:00:00',	'MOT check-up',	'25077','2021-06-19','VIM 8955');
INSERT INTO services VALUES('S2006-109', '2020-06-19','08:30:00','Other - Oil leak - looks major','85602','2021-06-21','OEZ 1872');
INSERT INTO services VALUES('S2006-110','2020-06-19','08:45:00','Other - Loses power going up hills. Can not go over 50 mph','9362','2021-06-21', 'D268 YCF');
INSERT INTO services VALUES('S2006-111', '2020-06-19','08:30:00','Other - Air conditioning not working','5903',	'2021-06-19','CJ16 WED');
INSERT INTO services VALUES('S2006-112', '2020-06-19','08:30:00','Other - Grinding noise from the brakes and whirring noise from the front.','34943','2021-06-23','W85 TTF');
INSERT INTO services VALUES('S2006-113', '2020-06-19','08:30:00','Annual service','15033','2021-06-21',	'LLZ 9362');
INSERT INTO services VALUES('S2006-114', '2020-06-20','16:45:00','Other - high pitched whistling noise coming from the front.','7034','2021-06-21',	'WVG 673');
INSERT INTO services VALUES('S2006-115', '2020-06-20','08:30:00','Other - Filled with diesel - should have been petrol! Will need collected.','4766', NULL,'R99 YRK');
INSERT INTO services VALUES('S2006-116', '2020-06-20','12:30:00','MOT check-up','21641','2021-06-22','T779 OLI');
INSERT INTO services VALUES('S2006-117', '2020-06-20','08:15:00','Other - Front tyres are wearing away on the inside. Wire is showing.','94006','2021-06-20','BEZ 8826');
INSERT INTO services VALUES('S2006-118', '2020-06-22','08:30:00', 'Annual service' ,'42743','2021-06-24','G5 T77');
INSERT INTO services VALUES('S2006-119', '2020-06-22','08:30:00','Other - Same problem as before - worked for a while, but now not going into first or third gear.','135394','2021-06-21','SEZ 5629');
INSERT INTO services VALUES('S2006-120', '2020-06-22','10:30:00','MOT check-up','63092','2021-06-22','STR 9378');
INSERT INTO services VALUES('S2006-121', '2020-06-23','08:30:00','Annual service','18932','2021-06-25','F6 Y886');
INSERT INTO services VALUES('S2006-122', '2020-06-23',	'09:00:00',	'Annual service',	'11037','2021-06-25','YR3 67');
INSERT INTO services VALUES('S2006-123', '2020-06-23','16:15:00','MOT check-up','48841','2021-06-23','DYR 87');
INSERT INTO services VALUES('S2006-124', '2020-06-23',	'08:30:00',	'Annual service','20026','2021-06-24','SWT 9930');
INSERT INTO services VALUES('S2006-125', '2020-06-24',	'12:15:00',	'MOT check-up',	'31604', NULL,'D89 Y6');
INSERT INTO services VALUES('S2006-126', '2020-06-24','08:15:00','Other - front suspension has collapsed.','36480',	NULL, 'Y4 T87');
INSERT INTO services VALUES('S2006-127', '2020-06-24','08:30:00','MOT check-up','84629','2021-06-24','JEZ 7719');
INSERT INTO services VALUES('S2006-128', '2020-06-24','08:00:00','Other - Power steering not working. Very hard to turn the steering wheel.','22030','2020-12-09',	'MEW 783');
INSERT INTO services VALUES('S2006-129', '2020-06-24','14:30:00','Annual service','11729','2020-06-25',	'JEA 991');
INSERT INTO services VALUES('S2006-130', '2020-06-24',	'08:00:00',	'Annual service','51815','2020-06-13','B56 Y34');
INSERT INTO services VALUES('S2006-131', '2020-06-25','07:45:00','Annual service',	'18037','2020-06-30','FET 6821');
INSERT INTO services VALUES('S2006-132', '2020-06-25','08:15:00','Other - none of the lights are working','37104',NULL, 'B82 T56');
INSERT INTO services VALUES('S2006-133', '2020-06-25',	'16:30:00',	'MOT check-up',	'71402','2021-06-25','CEZ 563');
INSERT INTO services VALUES('S2006-134', '2020-06-25','08:30:00',	'Other - Car not starting','76537',	'2021-06-20','AF56 WWJ');
INSERT INTO services VALUES('S2006-135', '2020-06-25','14:30:00','Other - Now there are grinding sounds from gearbox!!!','135576',	'2021-06-21','SEZ 5629');




-- time to populate our tables with the mechanics data

INSERT INTO mechanics VALUES('E9274','Tim Berners-Lee',	'+442890469927','Trainee');
INSERT INTO mechanics VALUES('E1037','Edgar F. Codd','07882751331','Mechanic');
INSERT INTO mechanics VALUES('E7291','Tony Hoare','+44717689275','Apprentice');
INSERT INTO mechanics VALUES('E4470','Ada Lovelace','07811304671','Mechanic');
INSERT INTO mechanics VALUES('E2045','Grace Hopper','+447880496206','Apprentice');
INSERT INTO mechanics VALUES('E0392','Edsger Dijkstra',	'07751839368','Senior Mechanic');
INSERT INTO mechanics VALUES('E2648','Alan Turing',	'02890568482','Apprentice');
-- INSERT INTO mechanics VALUES(NULL,NULL,	NULL,NULL);

-- drop table service_mechanics
-- time to populate our tables with the service mechanics data

INSERT INTO service_mechanics VALUES('S2006-101','E9274','03:15:00');
INSERT INTO service_mechanics VALUES('S2006-101', 'E1037','00:45:00');
INSERT INTO service_mechanics VALUES('S2006-102','E7291','04:00:00');
INSERT INTO service_mechanics VALUES('S2006-102','E4470','00:30:00');
INSERT INTO service_mechanics VALUES('S2006-103','E2045','03:30:00');
INSERT INTO service_mechanics VALUES('S2006-103','E1037','06:20:00');
INSERT INTO service_mechanics VALUES('S2006-103', 'E0392', '01:10:00');
INSERT INTO service_mechanics VALUES('S2006-104', 'E9274','02:25:00');
INSERT INTO service_mechanics VALUES('S2006-104', 'E4470','09:25:00');
INSERT INTO service_mechanics VALUES('S2006-104', 'E1037','05:15:00');
INSERT INTO service_mechanics VALUES('S2006-105', 'E2045','04:20:00');
INSERT INTO service_mechanics VALUES('S2006-105', 'E0392', '01:00:00');
INSERT INTO service_mechanics VALUES('S2006-106', 'E9274','05:20:00');
INSERT INTO service_mechanics VALUES('S2006-106', 'E1037','03:15:00');
INSERT INTO service_mechanics VALUES('S2006-107', 'E9274','01:15:00');
INSERT INTO service_mechanics VALUES('S2006-107', 'E1037', '04:35:00');
INSERT INTO service_mechanics VALUES('S2006-108', 'E2648','03:35:00');
INSERT INTO service_mechanics VALUES('S2006-108', 'E4470','03:35:00');
INSERT INTO service_mechanics VALUES('S2006-109', 'E7291','04:25:00');
INSERT INTO service_mechanics VALUES('S2006-109', 'E0392','06:20:00');
INSERT INTO service_mechanics VALUES('S2006-109', 'E1037','01:15:00');
INSERT INTO service_mechanics VALUES('S2006-110','E2648','02:15:00');
INSERT INTO service_mechanics VALUES('S2006-110', 'E0392','10:15:00');
INSERT INTO service_mechanics VALUES('S2006-110', 'E1037','10:15:00');
INSERT INTO service_mechanics VALUES('S2006-111','E2045','05:00:00');
INSERT INTO service_mechanics VALUES('S2006-112','E2045','01:45:00');
INSERT INTO service_mechanics VALUES('S2006-112','E4470','08:05:00');
INSERT INTO service_mechanics VALUES('S2006-112','E0392','06:35:00');
INSERT INTO service_mechanics VALUES('S2006-113','E7291','03:30:00');
INSERT INTO service_mechanics VALUES('S2006-113', 'E4470','03:55:00');
INSERT INTO service_mechanics VALUES('S2006-114','E7291','03:15:00');
INSERT INTO service_mechanics VALUES('S2006-114','E4470','03:20:00');
INSERT INTO service_mechanics VALUES('S2006-114','E1037','02:15:00');
INSERT INTO service_mechanics VALUES('S2006-115','E9274','05:35:00');
INSERT INTO service_mechanics VALUES('S2006-115','E1037','05:35:00');
INSERT INTO service_mechanics VALUES('S2006-116','E2045','03:45:00');
INSERT INTO service_mechanics VALUES('S2006-116','E1037','04:15:00');
INSERT INTO service_mechanics VALUES('S2006-117','E7291', '01:15:00');
INSERT INTO service_mechanics VALUES('S2006-117','E4470','02:35:00');
INSERT INTO service_mechanics VALUES('S2006-118','E9274','03:20:00');
INSERT INTO service_mechanics VALUES('S2006-118','E0392','00:50:00');
INSERT INTO service_mechanics VALUES('S2006-119', 'E9274','02:35:00');
INSERT INTO service_mechanics VALUES('S2006-119','E1037','04:40:00');
INSERT INTO service_mechanics VALUES('S2006-120','E2648','03:30:00');
INSERT INTO service_mechanics VALUES('S2006-120','E4470','02:50:00');
INSERT INTO service_mechanics VALUES('S2006-121','E2045', NULL);	
INSERT INTO service_mechanics VALUES('S2006-122','E7291', NULL);	
INSERT INTO service_mechanics VALUES('S2006-123','E2648', NULL);	
INSERT INTO service_mechanics VALUES('S2006-124','E9274', NULL);	
INSERT INTO service_mechanics VALUES('S2006-125','E2648', NULL);	
-- INSERT INTO service_mechanics VALUES('S2006-126','', NULL); 		
INSERT INTO service_mechanics VALUES('S2006-127','E7291', NULL);	
-- INSERT INTO service_mechanics VALUES('S2006-128', '', NULL); 		
INSERT INTO service_mechanics VALUES('S2006-129','E2045', NULL);	
INSERT INTO service_mechanics VALUES('S2006-130','E9274', NULL);	
INSERT INTO service_mechanics VALUES('S2006-131','E2648', NULL);	
-- INSERT INTO service_mechanics VALUES('S2006-132', '', NULL); 		
-- INSERT INTO service_mechanics VALUES('S2006-134','', NULL); 		
-- INSERT INTO service_mechanics VALUES('S2006-135', '', NULL); 


-- Business problem 1: Adding a new service booking
INSERT INTO services VALUES ('S2006-136', '2020-06-20', '10:00:00', 'Oil change and filter replacement', 10421, '2021-06-20', 'SEZ 5629');
INSERT INTO services VALUES ('S2006-137', '2020-06-26', '10:00:00', 'Oil change and filter replacement', 10421, '2021-06-30', 'BEZ 8826');

SELECT  S.service_id
FROM services S;

-- Business problem 2: Getting the name of any mechanic who have worked on previous services of a car involved in new booking

SELECT M.name, COUNT(SM.service_id) AS JobsOnDropOffDay
FROM mechanics M 
JOIN service_mechanics SM ON M.employee_id = SM.employee_id
JOIN services S ON SM.service_id = S.service_id
WHERE S.registration_no = 'SEZ 5629'
  AND S.drop_off_date = '2020-06-20'
  GROUP BY M.name
HAVING COUNT(SM.service_id) > 0;

-- Business problem 3: the total service time per mechanic within a period of time
SELECT M.name,  SEC_TO_TIME(SUM(TIME_TO_SEC(SM.time_spent))) AS TotalTimeSpent
FROM mechanics M 
JOIN service_mechanics SM ON M.employee_id = SM.employee_id
JOIN services S ON SM.service_id = S.service_id
WHERE S.drop_off_date BETWEEN '2020-06-18' AND '2020-06-19'
GROUP BY M.name;

-- Business problem 4: Listing the name and email address of customers who own a car where the date of next service falls between two given dates

SELECT C.name AS customername, C.email_address AS CustomerEmail, Cars.Make, Cars.registration_no, S.next_service_date
FROM customers C
JOIN cars ON C.customer_id = cars.customer_id
JOIN services S ON cars.registration_no = S.registration_no
WHERE S.next_service_Date BETWEEN '2021-06-18' AND '2021-06-23';


-- Business problem 5: Making a mechanic unavailable, then getting the services they may be involved with during those days of unavailability
-- First, I need to  alter the table by adding a column on the availabilty status
ALTER TABLE Mechanics
ADD COLUMN status VARCHAR(50) DEFAULT 'Available';
-- then, i want to change the status of a mechanic to unavailable, i will use Alan Turing with the ID no E2648
UPDATE mechanics
SET Status = 'Unavailable'
WHERE employee_id = 'E2648'; -- this should corresspond to Alan Turing
-- Now, the code to pull the data
SELECT S.service_id, S.drop_off_date, S.drop_off_time, S.description, S.registration_no
FROM services S
JOIN service_mechanics SM ON S.service_id = SM.service_id
JOIN mechanics M ON SM.employee_id = M.employee_id
WHERE M.Status = 'Unavailable'
  AND S.drop_off_date BETWEEN '2020-06-18' AND '2020-06-23';

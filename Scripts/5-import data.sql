
USE Aragon2020
;
GO

            -- Artem Garanin part

/***** Table No. 1 - Employee.tblClass ****/
INSERT INTO Employee.tblClass VALUES
    (1,N'Adult CPR',15,0,N'True',N'Red Cross'),
    (2,N'Child/Infant CPR',15,0,N'True',N'Red Cross'),
    (3,N'Adult CPR Recertification',10,1,N'True',N'Red Cross'),
    (4,N'First Aid',15,2,N'False',N'Red Cross'),
    (5,N'Defibrillator Use',25,1,N'True',N'Johnston Health Systems'),
    (6,N'Child/Infant CPR Recertification',10,1,N'True',N'Red Cross'),
    (7,N'Nutritional Supplements',25,0,N'False',N'Food Co-op'),
    (8,N'Yoga',50,0,N'False',N'Yoga Center')
;
go

/***** Table No. 2 - Employee.tblJobTitle ****/
INSERT INTO Employee.tblJobTitle VALUES
    (1,N'Owner'),
    (2,N'Pharmacist'),
    (3,N'Technician'),
    (4,N'Cashier'),
    (5,N'Manager')
    ;
    go

/***** Table No. 3 - Employee.tblEmployee ****/
INSERT INTO Employee.tblEmployee VALUES
    (1,N'Anne',N'M',N'Lessard',N'461-710-883','1968-12-09 00:00:00','2006-03-12 00:00:00',NULL,N'6803 90th Ave',N'Edmonton',N'AB',N'T6B 0P3',3,NULL,N'(780) 469-9664',N'(780) 469-1676',0,11,'2016-04-20 00:00:00'),
    (2,N'Phillip',N'T',N'Starkey',N'413-632-487','1972-04-05 00:00:00','2011-02-28 00:00:00',NULL,N'11122 39th Ave',N'Edmonton',N'AB',N'T6J 0M3',4,NULL,N'(780) 463-3578',N'(780) 577-1631',0,8.4,'2016-10-24 00:00:00'),
    (3,N'Catherine',N'C',N'Adams-Cook',N'504-019-756','1970-02-13 00:00:00','2011-02-24 00:00:00',NULL,N'2248 Tanner Wynd NW',N'Edmonton',N'AB',N'T6R 2S4',4,NULL,N'(780) 444-5432',N'(780) 444-5821',0,9,'2016-11-01 00:00:00'),
    (4,N'Juanita',N'M',N'Cortes',N'602-485-239','1980-09-24 00:00:00','2009-06-12 00:00:00',NULL,N'12107 40th St',N'Edmonton',N'AB',N'T6H 0J4',4,N'Speaks fluent Spanish',N'(780) 432-2035',N'(780) 577-8832',0,12,'2016-07-18 00:00:00'),
    (5,N'Joan',N'S',N'Gabel',N'366-346-168','1968-09-12 00:00:00','2010-05-01 00:00:00',NULL,N'9321 71st Ave NW',N'Edmonton',N'AB',N'T6E 1Z2',1,NULL,N'(780) 436-1128',N'(780) 479-1399',115000,0,NULL),
    (6,N'Karl',N'K',N'Fujikawa',N'409-554-546','1958-04-02 00:00:00','1994-06-12 00:00:00',NULL,N'501 10145th 119 St NW',N'Edmonton',N'AB',N'T5K 1Z2',2,NULL,N'(780) 444-1686',N'(780) 444-5422',50000,0,NULL),
    (7,N'Claudio',N'G',N'Montes',N'522-389-217','1972-05-02 00:00:00','2010-02-07 00:00:00','2016-12-01 00:00:00',N'6587 187th St',N'Edmonton',N'AB',N'T5T 2R7',3,N'Entered graduate program',N'(780) 487-5623',N'(780) 487-2644',0,9.8,NULL),
    (8,N'Krysta',N'L',N'Molloy',N'512-456-020','1972-06-30 00:00:00','2010-08-12 00:00:00',NULL,N'9015 56th St',N'Edmonton',N'AB',N'T6B 1J1',3,N'On family leave',N'(780) 465-8433',N'(780) 317-4405',0,8.15,'2016-07-02 00:00:00'),
    (9,N'Kim',N'W',N'Siemers',N'598-334-298','1971-11-29 00:00:00','2009-05-11 00:00:00',NULL,N'903 Saskatchewan Dr',N'Edmonton',N'AB',N'T6E 6J5',5,NULL,N'(780) 432-0987',N'(780) 432-7891',45500,0,NULL),
    (10,N'Jack',N'E',N'Knowles',N'632-583-120','1977-05-28 00:00:00','2010-07-14 00:00:00',NULL,N'8732 80th Ave SW',N'Edmonton',N'AB',N'T5K 1Z2',4,N'Reprimanded for tardiness (4/16)',N'(780) 462-3385',N'(780) 462-9038',0,7,'2016-02-20 00:00:00'),
    (11,N'Tem',N'N',N'Pom',N'605-239-401','1976-05-30 00:00:00','2012-06-01 00:00:00',NULL,N'802 4616th 106A St',N'Edmonton',N'AB',N'T6H 5J5',4,NULL,N'(780) 989-1465',N'(780) 989-1274',0,6.8,'2016-06-01 00:00:00'),
    (12,N'Desmond',N'L',N'Foxhall',N'412-489-423','1963-07-03 00:00:00','1996-03-04 00:00:00',NULL,N'412 1120th Tory Rd NW',N'Edmonton',N'AB',N'T5A 0A3',2,NULL,N'(780) 434-2518',N'(780) 434-5522',100000,0,NULL),
    (13,N'Ava',N'M',N'Foxhall',N'434-875-298','1965-09-23 00:00:00','2006-05-15 00:00:00',NULL,N'412 1120th Tory Rd NW',N'Edmonton',N'AB',N'T5A 0A3',3,NULL,N'(780) 434-2518',N'(780) 434-7832',0,11.5,'2016-05-15 00:00:00'),
    (14,N'Glenn',N'J',N'Hollander',N'582-631-450','1970-01-15 00:00:00','2008-04-12 00:00:00',NULL,N'171 Tudor Ln',N'Edmonton',N'AB',N'T6J 3T5',5,NULL,N'(780) 437-0538',N'(780) 317-4380',65000,0,NULL),
    (15,N'Tyler',N'A',N'Borley',N'701-432-589','1982-06-12 00:00:00','2007-11-15 00:00:00','2015-09-01 00:00:00',N'303 7905th 96 St',N'Edmonton',N'AB',N'T6C 4R3',4,NULL,N'(780) 437-7805',N'(780) 437-3398',0,7.8,NULL),
    (16,N'Michelle',N'C',N'Devereaux',N'504-587-339','1972-08-05 00:00:00','2010-11-20 00:00:00',NULL,N'4636 10th Ave',N'Edmonton',N'AB',N'T6L 4E3',3,NULL,N'(780) 450-2377',N'(780) 450-1224',0,12.5,'2016-11-15 00:00:00'),
    (17,N'Esteban',N'J',N'Lucas',N'567-223-559','1976-09-23 00:00:00','2011-10-14 00:00:00',NULL,N'8018 95th Ave NW',N'Edmonton',N'AB',N'T6C 1Y1',4,N'Speaks fluent Spanish',N'(780) 450-7734',N'(780) 450-6577',0,9,'2016-11-12 00:00:00'),
    (18,N'Eric',N'B',N'Campbell',N'512-587-668','1975-10-16 00:00:00','2011-08-01 00:00:00',NULL,N'12142 36th St',N'Edmonton',N'AB',N'T5W 2B6',3,NULL,N'(780) 474-1148',N'(780) 474-1678',0,10.5,'2016-08-01 00:00:00'),
    (19,N'Brittany',N'A',N'Greer',N'718-994-389','1982-09-14 00:00:00','2011-11-15 00:00:00',NULL,N'255 Southridge NW',N'Edmonton',N'AB',N'T6H 4M9',4,NULL,N'(780) 435-8874',N'(780) 435-8774',0,7,'2016-11-15 00:00:00'),
    (20,N'Janice',N'W',N'Millbrandt',N'398-704-239','1963-12-27 00:00:00','2004-05-12 00:00:00',NULL,N'4704 38B Ave',N'Edmonton',N'AB',N'T6L 5B9',2,N'Part-time',N'(780) 462-8557',N'(780) 462-7332',30000,0,'2016-05-15 00:00:00'),
    (21,N'Leigh',N'M',N'Watland-Hall',N'523-558-250','1973-08-24 00:00:00','2010-07-05 00:00:00',NULL,N'12908 134th St',N'Edmonton',N'AB',N'T5L 1V6',4,NULL,N'(780) 454-8114',N'(780) 454-4437',0,8.3,'2016-07-01 00:00:00'),
    (22,N'Frank',N'J',N'Pimienta',N'664-389-447','1981-03-17 00:00:00','2011-03-01 00:00:00',NULL,N'3531 105A St',N'Edmonton',N'AB',N'T6J 2M6',3,N'Reprimanded for missed shift (7/16)',N'(780) 434-1987',N'(780) 317-1978',0,11.8,'2016-03-01 00:00:00'),
    (23,N'Mai',N'W',N'Yan',N'598-374-129','1972-07-05 00:00:00','2010-09-02 00:00:00',NULL,N'7641 112th Ave',N'Edmonton',N'AB',N'T5B 0H4',2,NULL,N'(780) 479-0097',N'(780) 479-9805',42700,0,NULL),
    (24,N'Christine',N'A',N'Sullivan',N'659-228-459','1981-11-05 00:00:00','2011-02-15 00:00:00',NULL,N'13616 24th St',N'Edmonton',N'AB',N'T5A 3V2',4,NULL,N'(780) 476-1276',N'(780) 476-6687',0,8.6,'2016-02-15 00:00:00'),
    (25,N'Rebecca',N'M',N'Larousse',N'601-498-440','1979-06-24 00:00:00','2009-01-04 00:00:00','2016-08-15 00:00:00',N'110 3rd Ave W',N'Edmonton',N'AB',N'T5A 0A3',4,N'Left for college',N'(780) 893-5877',N'(780) 893-1255',0,8,NULL),
    (26,N'Cheri',N'L',N'Larousse',N'623-875-334','1982-09-02 00:00:00','2010-05-30 00:00:00',NULL,N'110 3rd Ave W',N'Edmonton',N'AB',N'T5A 0A3',4,NULL,N'(780) 893-5877',N'(780) 893-8832',0,9,'2016-05-30 00:00:00'),
    (27,N'Stephen',N'M',N'Strupp',N'664-329-554','1980-03-25 00:00:00','2009-11-02 00:00:00',NULL,N'900 9930th Bellamy Hill NW',N'Edmonton',N'AB',N'T5K 2B5',3,NULL,N'(780) 428-6337',N'(780) 428-5984',0,12.5,'2016-11-01 00:00:00'),
    (28,N'Dewana',N'L',N'Morgan',N'700-487-349','1985-10-23 00:00:00','2010-12-02 00:00:00',NULL,N'2532 Bell Ct SW',N'Edmonton',N'AB',N'T5A 0A3',4,NULL,N'(780) 438-2456',N'(780) 438-8943',0,9.5,'2016-12-01 00:00:00'),
    (29,N'Marie',N'C',N'Cresson',N'534-995-238','1973-12-24 00:00:00','2010-09-15 00:00:00',NULL,N'202 6205th 101 Ave NW',N'Edmonton',N'AB',N'T6A 0H3',5,NULL,N'(780) 439-8786',N'(780) 893-2238',63500,0,NULL),
    (30,N'Nicole
Nicole',N'D',N'Guidarelli',N'655-377-487','1982-04-29 00:00:00','2011-06-01 00:00:00',NULL,N'5117 14A Ave',N'Edmonton',N'AB',N'T6L 2A4',4,NULL,N'(780) 450-6337',N'(780) 450-4387',0,8.15,'2016-06-01 00:00:00')
;
go
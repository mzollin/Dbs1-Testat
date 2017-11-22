/*
 * INSERTS 'CocktailmixerDB'
 * 
 * Stocker Michael
 * Zollinger Marco
 */
 
-- Glasvolumen: Volumen_ml = Round(PI * (Durchmesser_cm/2)^2 * Hoehe_cm)
-- Festzutatenvolumen: Volumen_ml = Round(Gewicht_g / Dichte_g_pro_cm3)

-- TABLE GLASTYP
-- format: name, anzahl, volumen_ml, durchmesser_cm, hoehe_cm
INSERT INTO glas_typ VALUES ('Highball Glas', 3, 269, 7, 15);
INSERT INTO glas_typ VALUES ('Cocktail Glas', 11, 130, 9.2, 14.9);
INSERT INTO glas_typ VALUES ('Shot Glas', 9, 44, 5, 6);
INSERT INTO glas_typ VALUES ('Poco Glas', 3, 392, 8.9, 17.9);
INSERT INTO glas_typ VALUES ('Martini Glas', 5, 150, 11, 14.9);
INSERT INTO glas_typ VALUES ('Whiskey Glas', 2, 250, 7, 8);
INSERT INTO glas_typ VALUES ('Old Fashioned Glas', 5, 300, 8.4, 9.6);

-- TABLE COCKTAILREZEPT
-- format: name, glas_typ, enthaelt_alkohol
INSERT INTO cocktail_rezept VALUES ('Cuba Libre', 'Highball Glas', TRUE);
INSERT INTO cocktail_rezept VALUES ('Martini', 'Cocktail Glas', TRUE);
INSERT INTO cocktail_rezept VALUES ('Virgin Martini', 'Cocktail Glas', FALSE);
INSERT INTO cocktail_rezept VALUES ('Negroni', 'Cocktail Glas', TRUE);
INSERT INTO cocktail_rezept VALUES ('Null Pointer', 'Shot Glas', TRUE);
INSERT INTO cocktail_rezept VALUES ('Manhattan', 'Cocktail Glas', TRUE);
INSERT INTO cocktail_rezept VALUES ('Pina Colada', 'Poco Glas', TRUE);

-- TABLE ZUTATEN
-- format: name, vorrat_ml, alkohol_volproz
INSERT INTO zutaten VALUES ('Cola', 1500, 0),
                           ('Rum hell', 750, 42),
                           ('Limettensaft', 150, 0),
                           ('Eiswuerfel', 24, 0);
INSERT INTO zutaten VALUES ('Gin', 500, 39),
                           ('Wermuth trocken', 1000, 18),
                           ('Olive', 20, 0);
INSERT INTO zutaten VALUES ('Wasser', 1500, 0);
INSERT INTO zutaten VALUES ('Campari', 750, 25),
                           ('Wermuth suess', 1000, 17),
                           ('Orangenschnitz', 8, 0);
INSERT INTO zutaten VALUES ('Jaegermeister', 700, 35),
                           ('Rum dunkel', 750, 40);
INSERT INTO zutaten VALUES ('Whisky', 750, 41),
                           ('Angosturabitter', 200, 45),
                           ('Cocktailkirsche', 25, 0);
INSERT INTO zutaten VALUES ('Kokosnussmilch', 150, 0),
                           ('Ananassaft', 500, 0),
                           ('Ananasschnitz', 16, 0);

-- TABLE ZUTATENZUTEILUNG
-- format: cocktail_rezept, zutaten, volumen_ml
INSERT INTO zutaten_zuteilung VALUES ('Cuba Libre', 'Cola', 120),
                                     ('Cuba Libre', 'Rum hell', 50),
                                     ('Cuba Libre', 'Limettensaft', 10),
                                     ('Cuba Libre', 'Eiswuerfel', 4);
INSERT INTO zutaten_zuteilung VALUES ('Martini', 'Gin', 60),
                                     ('Martini', 'Wermuth trocken', 10),
                                     ('Martini', 'Olive', 1);
INSERT INTO zutaten_zuteilung VALUES ('Virgin Martini', 'Wasser', 70),
                                     ('Virgin Martini', 'Olive', 1);
INSERT INTO zutaten_zuteilung VALUES ('Negroni', 'Gin', 30),
                                     ('Negroni', 'Wermuth suess', 30),
                                     ('Negroni', 'Campari', 30),
                                     ('Negroni', 'Orangenschnitz', 1);
INSERT INTO zutaten_zuteilung VALUES ('Null Pointer', 'Jaegermeister', 20),
                                     ('Null Pointer', 'Rum dunkel', 20);
INSERT INTO zutaten_zuteilung VALUES ('Manhattan', 'Whisky', 50),
                                     ('Manhattan', 'Wermuth suess', 20),
                                     ('Manhattan', 'Angosturabitter', 5),
                                     ('Manhattan', 'Cocktailkirsche', 1);
INSERT INTO zutaten_zuteilung VALUES ('Pina Colada', 'Rum hell', 30),
                                     ('Pina Colada', 'Kokosnussmilch', 30),
                                     ('Pina Colada', 'Ananassaft', 90),
                                     ('Pina Colada', 'Ananasschnitz', 1);

-- TABLE FESTZUTATEN
-- format: name, dichte_g_pro_cm3, gewicht_g, durchmesser_cm, hoehe_cm
INSERT INTO festzutaten VALUES ('Eiswuerfel', 1, 1, 1.4, 1);
INSERT INTO festzutaten VALUES ('Olive', 1, 1, 0.8, 1.2);
INSERT INTO festzutaten VALUES ('Orangenschnitz', 1, 1, 2.5, 4);
INSERT INTO festzutaten VALUES ('Cocktailkirsche', 1, 1, 1, 1);
INSERT INTO festzutaten VALUES ('Ananasschnitz', 1, 1, 3, 5);

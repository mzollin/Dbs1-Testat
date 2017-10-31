/*
 * Testdaten einfügen
 * 
 * Stocker Michael
 * Zollinger Marco
 *
 */
 
-- Glasvolumen: Volumen_ml = Round(PI * (Durchmesser_cm/2)^2 * Hoehe_cm)
-- Festzutatenvolumen: Volumen_ml = Round(Gewicht_g / Dichte_g_pro_cm3)

-- TABLE COCKTAILREZEPT
INSERT INTO cocktail_rezept VALUES ('Cuba Libre', 'Highball', TRUE);

-- TABLE GLASTYP
INSERT INTO glas_typ VALUES ('Highball', 3, 269, 7, 15);

-- TABLE ZUTATEN
INSERT INTO zutaten VALUES ('Cola', 1500, 0),
                           ('Rum hell', 750, 42),
                           ('Limettensaft', 150, 0),
                           ('Eiswuerfel', 24, 0);

-- TABLE ZUTATENZUTEILUNG
INSERT INTO zutaten_zuteilung VALUES ('Cuba Libre', 'Cola', 120),
                                     ('Cuba Libre', 'Rum hell', 50),
                                     ('Cuba Libre', 'Limettensaft', 10),
                                     ('Cuba Libre', 'Eiswuerfel', 4);

-- TABLE FESTZUTATEN
INSERT INTO festzutaten VALUES ('Eiswuerfel', 0.92, 1, 1.4, 1);
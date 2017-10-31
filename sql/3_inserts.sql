/*
 * Testdaten einfügen
 * 
 * Stocker Michael
 * Zollinger Marco
 *
 */
 
-- Glasvolumen: Volumen_ml = PI * (Durchmesser_cm/2)^2 * Hoehe_cm

-- TABLE COCKTAILREZEPT
INSERT INTO cocktail_rezept VALUES ('Cuba Libre', 'Highball', TRUE);

-- TABLE GLASTYP
INSERT INTO glas_typ VALUES ('Highball', 3, 269, 7, 15);

-- TABLE ZUTATEN
INSERT INTO zutaten VALUES ('Cola', 1500, 0);
INSERT INTO zutaten VALUES ('Rum hell', 750, 42);
INSERT INTO zutaten VALUES ('Limettensaft', 150, 0);

-- TABLE ZUTATENZUTEILUNG
INSERT INTO zutaten_zuteilung VALUES ('Cuba Libre', 'Cola', 120);
INSERT INTO zutaten_zuteilung VALUES ('Cuba Libre', 'Rum hell', 50);
INSERT INTO zutaten_zuteilung VALUES ('Cuba Libre', 'Limettensaft', 10);
INSERT INTO zutaten_zuteilung VALUES ('Cuba Libre', 'Eiswuerfel', NULL);    -- FIXME

-- TABLE FESTZUTATEN
INSERT INTO festzutaten VALUES ('Eiswuerfel', 1, 14, 10);
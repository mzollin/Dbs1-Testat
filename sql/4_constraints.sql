/*
 * CONSTRAINTS 'CocktailmixerDB'
 *
 * Stocker Michael
 * Zollinger Marco
 */

ALTER TABLE cocktail_rezept
ADD CONSTRAINT fk_glastyp_von_glastyp_name
    FOREIGN KEY (glas_typ) REFERENCES glas_typ (name)
;

ALTER TABLE zutaten_zuteilung
ADD CONSTRAINT fk_cocktailrezept_von_cocktailrezept_name
    FOREIGN KEY (cocktail_rezept) REFERENCES cocktail_rezept (name)
;

ALTER TABLE zutaten_zuteilung
ADD CONSTRAINT fk_zutaten_von_zutaten_name
    FOREIGN KEY (zutaten) REFERENCES zutaten (name)
;

ALTER TABLE festzutaten
ADD CONSTRAINT fk_name_von_zutaten_name
    FOREIGN KEY (name) REFERENCES zutaten (name)
;
/*
 * QUERIES 'CocktailmixerDB'
 *
 * Stocker Michael
 * Zollinger Marco
 */

-- SELECT zutaten and present them nicely
SELECT cocktail_rezept, zutaten as zutaten_name, volumen_ml as menge, alkohol_volproz as alkoholgehalt, EXISTS(SELECT * FROM festzutaten WHERE name = zutaten_zuteilung.zutaten) as fest FROM zutaten_zuteilung FULL OUTER JOIN zutaten ON zutaten_zuteilung.zutaten = zutaten.name;
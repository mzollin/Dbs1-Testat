/*
 * QUERIES 'CocktailmixerDB'
 *
 * Stocker Michael
 * Zollinger Marco
 */

-- SELECT zutaten and present them nicely
-- TODO: improve this query and description
SELECT cocktail_rezept as CocktailRezept,
       zutaten as ZutatenName,
       volumen_ml as Menge,
       alkohol_volproz as Alkoholgehalt,
       EXISTS(SELECT * FROM festzutaten WHERE "name" = zutaten_zuteilung.zutaten) as fest
  FROM zutaten_zuteilung FULL OUTER JOIN zutaten
  ON zutaten_zuteilung.zutaten = zutaten."name";

-- Get a list of glass types needed for the known cocktail recipes
SELECT DISTINCT glas_typ as GlasTyp
  FROM cocktail_rezept;

-- Count how many recipes exist for each glass type, order descending by occurence
SELECT COUNT(name),
       glas_typ as GlasTyp
  FROM cocktail_rezept
  GROUP BY glas_typ
  ORDER BY COUNT(name) DESC;
  
SELECT cocktail_rezept.name, glas_typ.name, glas_typ.volumen_ml
  FROM cocktail_rezept, glas_typ;
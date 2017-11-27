/*
 * QUERIES 'CocktailmixerDB'
 *
 * Stocker Michael
 * Zollinger Marco
 */

-- SELECT zutaten and present them nicely
-- TODO: improve this query and description
SELECT cocktail_rezept AS CocktailRezept,
       zutaten AS ZutatenName,
       volumen_ml AS Menge,
       alkohol_volproz AS Alkoholgehalt,
       EXISTS(SELECT * FROM festzutaten WHERE "name" = zutaten_zuteilung.zutaten) AS fest
  FROM zutaten_zuteilung FULL OUTER JOIN zutaten
  ON zutaten_zuteilung.zutaten = zutaten."name";

-- 1.1: Get a list of glass types needed for the known cocktail recipes
SELECT DISTINCT glas_typ AS GlasTyp
  FROM cocktail_rezept;
  
-- 1.2: 
SELECT cocktail_rezept.name AS CocktailRezept,
       glas_typ.name AS GlasTyp,
       glas_typ.volumen_ml AS GlasVolumen,
       SUM(zutaten_zuteilung.volumen_ml) AS CocktailVolumen
  FROM cocktail_rezept
  INNER JOIN glas_typ ON cocktail_rezept.glas_typ = glas_typ.name
  INNER JOIN zutaten_zuteilung ON cocktail_rezept.name = zutaten_zuteilung.cocktail_rezept
  GROUP BY zutaten_zuteilung.cocktail_rezept;
  
-- FIXME: test query
SELECT SUM(volumen_ml) AS CocktailVolumen
  FROM zutaten_zuteilung
  GROUP BY zutaten_zuteilung.cocktail_rezept;

-- 1.3: 

-- 1.4: Count how many recipes exist for each glass type, order descending by occurence
SELECT COUNT(name),
       glas_typ AS GlasTyp
  FROM cocktail_rezept
  GROUP BY glas_typ
  ORDER BY COUNT(name) DESC;
  
-- 1.5: 

  
-- 2.1: 

-- 2.2: 


-- 3.1: 

-- 3.2: 
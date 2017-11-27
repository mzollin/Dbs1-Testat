/*
 * QUERIES 'CocktailmixerDB'
 *
 * Stocker Michael
 * Zollinger Marco
 */

-- 1.1: Get a list of glass types needed for the known cocktail recipes
SELECT DISTINCT glas_typ AS GlasTyp
  FROM cocktail_rezept;
  
-- 1.2: Show all cocktail recipes, the corresponding glasses, their volumes, and how much the glasses are filled
SELECT cocktail_rezept."name" AS CocktailRezept,
       glas_typ."name" AS GlasTyp,
       glas_typ.volumen_ml AS GlasVolumen,
       SUM(zutaten_zuteilung.volumen_ml) AS CocktailVolumen,
       (SUM(zutaten_zuteilung.volumen_ml)::decimal / glas_typ.volumen_ml * 100)::int AS ProzentGefuellt
  FROM cocktail_rezept
  INNER JOIN glas_typ ON cocktail_rezept.glas_typ = glas_typ."name"
  INNER JOIN zutaten_zuteilung ON cocktail_rezept."name" = zutaten_zuteilung.cocktail_rezept
  GROUP BY cocktail_rezept."name", glas_typ."name", glas_typ.volumen_ml;
  
-- 1.3: Show all cocktail recipes that contain light or dark rum, and if they contain alcohol
SELECT "name" AS CocktailRezept, enthaelt_alkohol AS Alkoholgehalt
  FROM cocktail_rezept
  WHERE "name" IN (SELECT cocktail_rezept FROM zutaten_zuteilung WHERE zutaten IN ('Rum hell', 'Rum dunkel'));

-- 1.4: Count how many recipes exist for each glass type, order descending by occurence
SELECT COUNT("name"),
       glas_typ AS GlasTyp
  FROM cocktail_rezept
  GROUP BY glas_typ
  ORDER BY COUNT("name") DESC;

-- 1.5: Show all ingredients that are needed for Cuba Libres or Pina Coladas
SELECT DISTINCT zutaten_zuteilung.zutaten
  FROM zutaten_zuteilung
  WHERE zutaten_zuteilung.cocktail_rezept IN ('Pina Colada', 'Cuba Libre');
  
/*
 * 2.1: Print out all recipes in the database
 *      (make a list of ingredients with the amount in ml of this ingredient,
 *      alcohol percentage & a flag telling if it's a solid, for each recipe)
 *
 *  1. select all required fields using a join over zutaten_zuteilung & zutaten
 *  1b) use a subquery to detect if an ingredient is a solid
 *  1c) add empty rows with UNION to be used as dividers between recipes
 *  2. select all fields and order them by recipe name, then by ingredient (null values first)
 *  2b) offset result set by 1 getting rid of first divider row
 *  3. Select everything again, use case to get rid of recipe name in divider column
 */
SELECT CASE
         WHEN "Zutat" IS NULL THEN NULL::text
         ELSE "Cocktail"
       END,
       "Zutat",
       "Menge(ml)",
       "Alk(%)",
       "Fest"
FROM (
  SELECT * FROM (
    SELECT cocktail_rezept AS "Cocktail",
           zutaten AS "Zutat",
           volumen_ml AS "Menge(ml)",
           alkohol_volproz AS "Alk(%)",
           CASE
             WHEN EXISTS(SELECT * FROM festzutaten WHERE "name" = zutaten_zuteilung.zutaten) THEN 'Ja'
             ELSE 'Nein'
           END AS "Fest"
      FROM zutaten_zuteilung FULL OUTER JOIN zutaten
      ON zutaten_zuteilung.zutaten = zutaten."name"
    
      UNION ALL
      SELECT DISTINCT cocktail_rezept,
                      NULL::text,
                      NULL::int,
                      NULL::int,
                      NULL::text
        FROM zutaten_zuteilung
  ) AS set_with_break_rows
  ORDER BY "Cocktail", "Zutat" NULLS FIRST OFFSET 1
) AS ordered_set;

-- above query using WITH statements
WITH set_with_break_rows AS (
  SELECT cocktail_rezept AS "Cocktail",
         zutaten AS "Zutat",
         volumen_ml AS "Menge(ml)",
         alkohol_volproz AS "Alk(%)",
         CASE
           WHEN EXISTS(SELECT * FROM festzutaten WHERE "name" = zutaten_zuteilung.zutaten) THEN 'Ja'
           ELSE 'Nein'
         END AS "Fest"
    FROM zutaten_zuteilung FULL OUTER JOIN zutaten
    ON zutaten_zuteilung.zutaten = zutaten."name"

    UNION ALL
    SELECT DISTINCT cocktail_rezept,
                    NULL::text,
                    NULL::int,
                    NULL::int,
                    NULL::text
      FROM zutaten_zuteilung
), ordered_set AS (
  SELECT * FROM set_with_break_rows
  ORDER BY "Cocktail", "Zutat" NULLS FIRST OFFSET 1
)

SELECT CASE
         WHEN "Zutat" IS NULL THEN NULL::text
         ELSE "Cocktail"
       END,
       "Zutat",
       "Menge(ml)",
       "Alk(%)",
       "Fest"
FROM ordered_set;

/*
 * 2.2: clean up output from query 2.1 by reducing mention of recipe name to once per recipe using CTE
 *
 *  > using row_number() to only print second mention of recipe name for each partition
 */
WITH set_with_break_rows AS (
  SELECT cocktail_rezept AS "Cocktail",
         zutaten AS "Zutat",
         volumen_ml AS "Menge(ml)",
         alkohol_volproz AS "Alk(%)",
         CASE
           WHEN EXISTS(SELECT * FROM festzutaten WHERE "name" = zutaten_zuteilung.zutaten) THEN 'Ja'
           ELSE 'Nein'
         END AS "Fest"
    FROM zutaten_zuteilung FULL OUTER JOIN zutaten
    ON zutaten_zuteilung.zutaten = zutaten."name"

    UNION ALL
    SELECT DISTINCT cocktail_rezept,
                    NULL::text,
                    NULL::int,
                    NULL::int,
                    NULL::text
      FROM zutaten_zuteilung
), ordered_set AS (
  SELECT * FROM set_with_break_rows
  ORDER BY "Cocktail", "Zutat" NULLS FIRST
)

SELECT CASE
         WHEN ROW_NUMBER() OVER(PARTITION BY "Cocktail") = 2 THEN "Cocktail"
         ELSE NULL::text
       END,
       "Zutat",
       "Menge(ml)",
       "Alk(%)",
       "Fest"
FROM ordered_set OFFSET 1;

-- 3.1: Zutatenübersicht für alle Rezepte mit zugehörigen Gläsern
CREATE OR REPLACE VIEW komplette_rezepte AS
  SELECT cocktail_rezept."name" AS "Cocktail",
         glas_typ."name" AS "Glas",
         string_agg(zutaten."name", ', ') AS "Zutaten"
    FROM zutaten_zuteilung
    JOIN zutaten ON zutaten_zuteilung.zutaten = zutaten."name"
    JOIN cocktail_rezept ON zutaten_zuteilung.cocktail_rezept = cocktail_rezept."name"
    JOIN glas_typ ON cocktail_rezept.glas_typ = glas_typ."name"
  GROUP BY cocktail_rezept."name", glas_typ."name";

-- view query
SELECT * FROM komplette_rezepte;

-- 3.2: Zutatenübersicht für alle Zutaten die Festzutaten sind
CREATE OR REPLACE VIEW festzutaten_bestand AS
  SELECT zutaten."name" AS "Zutat",
         zutaten.vorrat_ml AS "Vorrat"
    FROM zutaten
    WHERE EXISTS(SELECT * FROM zutaten JOIN festzutaten ON zutaten."name" = festzutaten."name");

-- view before update
SELECT * FROM festzutaten_bestand ORDER BY "Zutat";

-- set vorrat for Eiswuerfel to 30
UPDATE festzutaten_bestand SET "Vorrat" = 30 WHERE "Zutat" = 'Eiswuerfel';

-- view after update
SELECT * FROM festzutaten_bestand ORDER BY "Zutat";

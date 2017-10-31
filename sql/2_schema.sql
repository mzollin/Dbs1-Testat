/*
 * DATABASE SCHEMA 'CocktailmixerDB'
 *
 * Stocker Michael
 * Zollinger Marco
 */

CREATE TABLE cocktail_rezept (
    name                TEXT    PRIMARY KEY,
    glas_typ            TEXT    NOT NULL,
    enthaelt_alkohol    BOOLEAN DEFAULT TRUE
);

CREATE TABLE glas_typ (
    name                TEXT    PRIMARY KEY,
    anzahl              INTEGER DEFAULT 0,
    volumen_ml          INTEGER NOT NULL,
    durchmesser_cm      DECIMAL NOT NULL,
    hoehe_cm            DECIMAL NOT NULL
);

CREATE TABLE zutaten (
    name                TEXT    PRIMARY KEY,
    vorrat_ml           INTEGER DEFAULT 0,
    alkohol_volproz     INTEGER NOT NULL
);

CREATE TABLE zutaten_zuteilung (
    cocktail_rezept     TEXT,
    zutaten             TEXT,
    volumen_ml          INTEGER NOT NULL,
    PRIMARY KEY (cocktail_rezept, zutaten)
);

CREATE TABLE festzutaten (
    name                TEXT    PRIMARY KEY,
    dichte_g_pro_cm3    DECIMAL NOT NULL,
    gewicht_g           INTEGER NOT NULL,
    durchmesser_cm      DECIMAL NOT NULL,
    hoehe_cm            DECIMAL NOT NULL
);
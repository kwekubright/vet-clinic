CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL NOT NULL,
  PRIMARY KEY(id)
);

ALTER TABLE
  animals
ADD
  species VARCHAR(100);

CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100) NOT NULL,
  age INT NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
);

ALTER TABLE
  animals DROP COLUMN species;

ALTER TABLE
  animals
ADD
  COLUMN species_id INT REFERENCES species;

ALTER TABLE
  animals
ADD
  COLUMN owner_id INT REFERENCES owners;

CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  vet_id INT REFERENCES vets,
  species_id INT REFERENCES species,
  PRIMARY KEY(vet_id, species_id)
);

CREATE TABLE visits (
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals,
  vet_id INT REFERENCES vets,
  date_of_visit DATE NOT NULL,
  PRIMARY KEY(id)
);
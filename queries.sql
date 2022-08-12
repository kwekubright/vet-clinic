/*Queries that provide answers to the questions from all projects.*/
SELECT
  *
from
  animals
WHERE
  name LIKE '%mon';

SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-12-31';

SELECT
  name
FROM
  animals
WHERE
  neutered = true
  AND escape_attempts < 3;

SELECT
  date_of_birth
FROM
  animals
WHERE
  name = 'Agumon'
  OR name = 'Pikachu';

SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

SELECT
  name
FROM
  animals
WHERE
  neutered = true;

SELECT
  name
FROM
  animals
WHERE
  name != 'Gabumon';

SELECT
  name
FROM
  animals
WHERE
  weight_kg BETWEEN 10.4
  AND 17.3;

SELECT
  COUNT(*)
FROM
  animals;

SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

SELECT
  AVG(weight_kg)
FROM
  animals;

SELECT
  name
FROM
  animals
WHERE
  escape_attempts = (
    SELECT
      MAX(escape_attempts)
    FROM
      animals
  ) neutered = true
  OR neutered = false;

SELECT
  species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM
  animals
GROUP BY
  species;

SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-12-31'
GROUP BY
  species;

-- What animals belong to Melody Pond? 
SELECT
  animals.name
FROM
  animals
  JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
  animals.name
FROM
  animals
  JOIN species ON species.id = animals.species_id
WHERE
  species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
  owners.full_name,
  animals.name
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT
  species.name,
  COUNT(*)
FROM
  species
  JOIN animals ON species.id = animals.species_id
GROUP BY
  species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
  animals.name
FROM
  animals
  JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
  animals.name
FROM
  animals
  JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Dean Winchester'
  AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT
  owners.full_name,
  COUNT(*)
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
GROUP BY
  owners.full_name
ORDER BY
  COUNT(*) DESC;

-- Who was the last animal seen by William Tatcher ?
SELECT
  owners.full_name
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
WHERE
  animals.name = 'William Tatcher';

-- How many different animals did Stephanie Mendez see ?
SELECT
  COUNT(DISTINCT animals.name)
FROM
  animals
  JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Stephanie Mendez';

-- List all vets and their specializations, including vets with no specializations. Join specializations with vets.
SELECT
  vets.name,
  specializations.species_id
FROM
  vets
  JOIN specializations ON vets.id = specializations.vet_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  animals.name
FROM
  animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Stephanie Mendez'
  AND visits.date_of_visit BETWEEN '2020-04-01'
  AND '2020-08-30';

-- What animal has the most visits to vets ?
SELECT
  animals.name
FROM
  animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN owners ON owners.id = animals.owner_id
GROUP BY
  animals.name
ORDER BY
  COUNT(*) DESC;

-- What animal visited Maisy Smith first ?
SELECT
  animals.name
FROM
  animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Maisy Smith'
ORDER BY
  visits.date_of_visit ASC;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  animals.name,
  vets.name,
  visits.date_of_visit
FROM
  animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN owners ON owners.id = animals.owner_id
  JOIN vets ON vets.id = visits.vet_id
GROUP BY
  animals.name,
  vets.name,
  visits.date_of_visit
ORDER BY
  visits.date_of_visit DESC;

-- How many visits were with a vet that did not specialize in that animal 's species? Join specializations with table
SELECT
  COUNT(*)
FROM
  visits
  JOIN vets ON vets.id = visits.vet_id
  JOIN specializations ON specializations.vet_id = vets.id
  JOIN animals ON animals.id = visits.animal_id
WHERE
  specializations.species_id = animals.species_id;

-- What specialty should Maisy Smith consider getting ? Look for the species she gets the most.
SELECT
  species.name
FROM
  species
  JOIN animals ON species.id = animals.species_id
  JOIN owners ON owners.id = animals.owner_id
  JOIN visits ON visits.animal_id = animals.id
WHERE
  owners.full_name = 'Maisy Smith'
GROUP BY
  species.name
ORDER BY
  COUNT(*) DESC;
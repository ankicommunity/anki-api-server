#!/usr/bin/env bash
# file: poetry-export.sh
# description: Lock dependencies and export them as backward-compatible requirements.txt files.

echo '[INFO] Updating poetry.lock file.'
poetry lock

echo '[INFO] Generating requirements.txt.'
echo "# file: requirements.txt" > src/requirements.txt
echo "# description: Dependencies. THE FILE WAS GENERATED BY POETRY, DO NOT EDIT!" >> src/requirements.txt
printf "# date: $(date '+%Y-%m-%d')\n\n" >> src/requirements.txt

echo '[INFO] Generating requirements-dev.txt.'
echo "# file: requirements-dev.txt " > src/requirements-dev.txt
echo "# description: Dev dependencies. THE FILE WAS GENERATED BY POETRY, DO NOT EDIT!" >> src/requirements-dev.txt
printf "# date: $(date '+%Y-%m-%d')\n\n" >> src/requirements-dev.txt

echo '[INFO] Generate requirement files for backward compatibility.'
poetry export --without-hashes -f requirements.txt >> src/requirements.txt
poetry export --dev --without-hashes -f requirements.txt >> src/requirements-dev.txt

# Include editable install for src
echo "-e src/." >> src/requirements-dev.txt

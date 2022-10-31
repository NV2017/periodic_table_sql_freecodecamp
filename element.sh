#!/bin/bash

# Esabtlish link to SQL
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#echo "Please provide an element as an argument."

if [[ $1 ]]
then
  # Check if number was entered
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # echo Number Found: $1
    temp_atomic_numbers=$($PSQL "SELECT atomic_number FROM elements")
    # echo $temp_atomic_numbers
    # if number matches some atomic_number in database
    # else number does not match any atomic_number in database
    if [[ ${temp_atomic_numbers[*]} =~ (^|[[:space:]])$1($|[[:space:]]) ]]
    then
      # echo I found that element in the database.
      temp_name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
      temp_name=${temp_name//[[:space:]]}
      temp_symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
      temp_symbol=${temp_symbol//[[:space:]]}

      # temp_type=$($PSQL "SELECT type FROM properties WHERE atomic_number=$1")
      temp_type=$($PSQL "WITH temp_table AS (SELECT type_id FROM properties WHERE atomic_number=$1) SELECT type FROM temp_table INNER JOIN types USING (type_id)")
      temp_type=${temp_type//[[:space:]]}

      temp_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
      temp_mass=${temp_mass//[[:space:]]}
      temp_mp=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
      temp_mp=${temp_mp//[[:space:]]}
      temp_bp=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
      temp_bp=${temp_bp//[[:space:]]}
      echo "The element with atomic number $1 is $temp_name ($temp_symbol). It's a $temp_type, with a mass of $temp_mass amu. $temp_name has a melting point of $temp_mp celsius and a boiling point of $temp_bp celsius."
    else
      echo "I could not find that element in the database."
    fi # End of 'if [[ ${temp_atomic_numbers[*]} =~ (^|[[:space:]])$1($|[[:space:]]) ]]'
  else
    temp_length=$(expr length "$1")
    if [[ $temp_length<4 ]]
    then
      temp_symbol=$1
      temp_name=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
      temp_name=${temp_name//[[:space:]]} 
      temp_an=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
      temp_an=${temp_an//[[:space:]]}

      if [[ -z $temp_an ]]
      then
        echo "I could not find that element in the database."
      else
        # temp_type=$($PSQL "SELECT type FROM properties WHERE atomic_number=$temp_an")
        temp_type=$($PSQL "WITH temp_table AS (SELECT type_id FROM properties WHERE atomic_number=$temp_an) SELECT type FROM temp_table INNER JOIN types USING (type_id)")
        temp_type=${temp_type//[[:space:]]}

        temp_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$temp_an")
        temp_mass=${temp_mass//[[:space:]]}
        temp_mp=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$temp_an")
        temp_mp=${temp_mp//[[:space:]]}
        temp_bp=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$temp_an")
        temp_bp=${temp_bp//[[:space:]]}
        echo "The element with atomic number $temp_an is $temp_name ($temp_symbol). It's a $temp_type, with a mass of $temp_mass amu. $temp_name has a melting point of $temp_mp celsius and a boiling point of $temp_bp celsius."
      fi # End of 'if [[ -z $temp_an ]]'
    else
      temp_name=$1
      temp_an=$($PSQL "SELECT atomic_number FROM elements WHERE name='$temp_name'")
      temp_an=${temp_an//[[:space:]]}
      
      if [[ -z $temp_an ]]
      then
        echo "I could not find that element in the database."
      else
        temp_symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$temp_an")
        temp_symbol=${temp_symbol//[[:space:]]}

        # temp_type=$($PSQL "SELECT type FROM properties WHERE atomic_number=$temp_an")
        temp_type=$($PSQL "WITH temp_table AS (SELECT type_id FROM properties WHERE atomic_number=$temp_an) SELECT type FROM temp_table INNER JOIN types USING (type_id)")
        temp_type=${temp_type//[[:space:]]}

        temp_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$temp_an")
        temp_mass=${temp_mass//[[:space:]]}
        temp_mp=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$temp_an")
        temp_mp=${temp_mp//[[:space:]]}
        temp_bp=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$temp_an")
        temp_bp=${temp_bp//[[:space:]]}
        echo "The element with atomic number $temp_an is $temp_name ($temp_symbol). It's a $temp_type, with a mass of $temp_mass amu. $temp_name has a melting point of $temp_mp celsius and a boiling point of $temp_bp celsius."
      fi # End of 'if [[ -z $temp_an ]]'      
    fi # End of 'if [[ temp_length<4 ]]'
  fi # End of 'if [[ $1 =~ ^[0-9]+$ ]]'
else
  echo "Please provide an element as an argument."
fi # End of 'if [[ $1 ]]'

#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INFOS_ABOUT_ELEMENT() {
   if [[ -z $1 ]] 
   then
    echo "Please provide an element as an argument."
    else
      if [[ $(echo "$1" | sed -n '/^[0-9]\+$/p') ]]
      then
        ELEMENT_INFO=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING (type_id) WHERE elements.atomic_number=$1")
      else
        ELEMENT_INFO=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING (type_id) WHERE elements.symbol='$1' OR elements.name='$1'")
      fi
      
      if [[ -z $ELEMENT_INFO ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$ELEMENT_INFO" | while read _ BAR AN BAR S BAR N BAR AM BAR MPC BAR BPC BAR T
        do
          echo "The element with atomic number $AN is $N ($S). It's a $T, with a mass of $AM amu. $N has a melting point of $MPC celsius and a boiling point of $BPC celsius."
        done
      fi
   fi
}

INFOS_ABOUT_ELEMENT $1
#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=random_num_game --tuples-only -c"
# PSQL="psql -X -t --username=freecodecamp --dbname=random_num_game -c"

PICK_NUMBER() {
  echo "Enter your username:"
  read USERNAME
  FOUND_USERNAME=$($PSQL "SELECT username, games_played, best_score FROM UserGameStats WHERE username = '$USERNAME'")


  if [[ -z $FOUND_USERNAME ]]
  then
      echo "Welcome, $USERNAME! It looks like this is your first time here."
      CREATE_USER=$($PSQL "INSERT INTO UserGameStats (username, games_played, best_score) VALUES ('$USERNAME', 0, 0)");
  else
    echo "$FOUND_USERNAME" | while read USER BAR GAMES_PLAYED BAR BEST_SCORE
    do
      USER=$(echo "$USER" | sed 's/^ *//;s/ *$//;s/'\''//g')
      GAMES_PLAYED=$(echo "$GAMES_PLAYED" | sed 's/^ *//;s/ *$//;s/'\''//g')
      BEST_SCORE=$(echo "$BEST_SCORE" | sed 's/^ *//;s/ *$//;s/'\''//g')
      echo "Welcome back, $USER! You have played $GAMES_PLAYED games, and your best game took $BEST_SCORE guesses."
      done
  fi
  NUMBER_OF_GUESSES=1
  SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
  echo "secret number $SECRET_NUMBER"
  echo "Guess the secret number between 1 and 1000:"
  GUESS_NUMBER
}

GUESS_NUMBER() {
  STATEMENT=false
  while [[ $STATEMENT == false ]]
  do
    read NUMBER_GUESS 
    if ! [[ $NUMBER_GUESS =~ ^[0-9]+$ ]]
    then
      echo "That is not an integer, guess again:"
    elif [[ $NUMBER_GUESS -eq $SECRET_NUMBER ]]
    then
      STATEMENT=true
      break
    elif [[ $NUMBER_GUESS -gt $SECRET_NUMBER ]]
    then
      ((NUMBER_OF_GUESSES++))
      echo "It's lower than that, guess again:"
    elif [[ $NUMBER_GUESS -lt $SECRET_NUMBER ]]
    then
      ((NUMBER_OF_GUESSES++))
      echo "It's higher than that, guess again:" 
    fi
  done
  NUMBER_OF_GAMES=$($PSQL "SELECT games_played FROM UserGameStats WHERE username = '$USERNAME'") 
  NUMBER_OF_GAMES=$(echo "$NUMBER_OF_GAMES" | sed 's/^ *//;s/ *$//;s/'\''//g');
  UPDATE_GAMES_PLAYED=$($PSQL "UPDATE UserGameStats SET games_played = $(($NUMBER_OF_GAMES + 1)) WHERE username = '$USERNAME'")
  BEST_SCORE=$($PSQL "SELECT best_score FROM UserGameStats WHERE username = '$USERNAME'")
  BEST_SCORE=$(echo "$BEST_SCORE" | sed 's/^ *//;s/ *$//;s/'\''//g')
  if [[ $BEST_SCORE == 0 || $BEST_SCORE < $NUMBER_OF_GUESSES ]]
  then
    UPDATE_SCORE=$($PSQL "UPDATE UserGameStats SET best_score = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
  fi
  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
}

PICK_NUMBER
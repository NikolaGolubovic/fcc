#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"


MAIN_MENU() {
  if [[ -z $1 ]]
  then
    echo -e "\nWellcome to Universal Saloon, please choose what service do you want to use?"
  else
    echo -e "\n'$1'"
  fi
  SERVICE_MENU
}

SERVICE_MENU() {
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services");
  echo -e "\nAvailable Services:"
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID _ NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  echo -e "\nPlease choose what service do you want to use?"
  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]*$ ]]
  then
    MAIN_MENU "Invalid input. Choose service again."
    else
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
      if [[ -z $SERVICE_NAME ]]
      then
        MAIN MENU "Please use available services"
      else
        echo -e "\nWhat is your phone number?"
        read CUSTOMER_PHONE
        PHONE_FOUND=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
        if [[ -z $PHONE_FOUND ]]
        then
          echo -e "\nAs a new user, please tell us your name?"
          read CUSTOMER_NAME
          CREATE_NAME=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
        fi
        echo -e "\nIn what time do you want to reserve service?"
        read SERVICE_TIME
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'");
        CREATE_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME') ")
        USER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
        SERVICE_NAME=$(echo "$SERVICE_NAME" | sed 's/^ *//;s/ *$//;s/'\''//g')
        SERVICE_TIME=$(echo "$SERVICE_TIME" | sed 's/^ *//;s/ *$//;s/'\''//g')
        USER_NAME=$(echo "$USER_NAME" | sed 's/^ *//;s/ *$//;s/'\''//g')
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $USER_NAME."
      fi
  fi
}

EXIT() {
    echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU
#!/bin/bash
## Script to import data from crawler database
## Database:Mysql

NOW=`date +%d-%m-%Y_%Hh%Mm%Ss`
SRC_DATABASE_NAME=CPGF_2016_IMPORT
TARGET_DATABASE_NAME=CPGF_2016_DEV
OUTPUT_FILE="dump_add_$NOW.sql"

##GET PREVIOUS STATE
MAX_PERSON_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM people'`
MAX_FAVORED_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM favored'`
MAX_SUBORDINATED_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM subordinated_organs'`
MAX_SUPERIOR_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM superior_organs'`
MAX_TRANSACTION_TYPE_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT max(id) FROM transaction_types'`
MAX_MANAGEMENT_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM management_units'`
MAX_SOURCE_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM sources'`
MAX_TRANSACTION_ID=`mysql -u root $TARGET_DATABASE_NAME -Bse 'SELECT MAX(id) FROM transactions'`

##EXPORTS DATA
#export extrato
mysqldump -u root --no-create-info $SRC_DATABASE_NAME sources --where "id > $MAX_SOURCE_ID" > $OUTPUT_FILE
#export portadores
mysqldump -u root --no-create-info $SRC_DATABASE_NAME people --where "id > $MAX_PERSON_ID" >> $OUTPUT_FILE
#export favorecidos
mysqldump -u root --no-create-info $SRC_DATABASE_NAME favored --where "id > $MAX_FAVORED_ID" >> $OUTPUT_FILE
#export tipo transacao
mysqldump -u root --no-create-info $SRC_DATABASE_NAME transaction_types --where "id > $MAX_TRANSACTION_TYPE_ID" >> $OUTPUT_FILE
#export tipo orgao superior
mysqldump -u root --no-create-info $SRC_DATABASE_NAME superior_organs --where "id > $MAX_SUPERIOR_ID" >> $OUTPUT_FILE
#export tipo orgao subordinado
mysqldump -u root --no-create-info $SRC_DATABASE_NAME subordinated_organs --where "id > $MAX_SUBORDINATED_ID" >> $OUTPUT_FILE
#export transações
mysqldump -u root --no-create-info $SRC_DATABASE_NAME transactions --where "id > $MAX_TRANSACTION_ID" >> $OUTPUT_FILE

echo "Update data is ready at $OUTPUT_FILE"

echo "Importing data to $TARGET_DATABASE_NAME"
pv $OUTPUT_FILE | mysql -u root $TARGET_DATABASE_NAME

#fix transactions with null dates (protected data)
mysql -u root -e 'UPDATE transactions SET date = (select reference from sources where sources.id = transactions.source_id) , hidden_date = true
WHERE transactions.date is null' $TARGET_DATABASE_NAME

mysql -u root -e 'UPDATE people set name = "INFORMAÇÃO SIGILOSA*" where name is null' $TARGET_DATABASE_NAME

mysql -u root -e 'UPDATE favored set name = "NÃO INFORMADO" where name is null' $TARGET_DATABASE_NAME

mysql -u root -e 'UPDATE transaction_types set description = "INFORMAÇÃO SIGILOSA*" where description is null' $TARGET_DATABASE_NAME

echo "Updating calculated totals."
#calculate total spendings by person
mysql -u root -e 'UPDATE people set total_transactions = (SELECT SUM(value) from transactions where transactions.person_id = people.id)' $TARGET_DATABASE_NAME
#calculate total spendings by favored
mysql -u root -e 'UPDATE favored set total_transactions = (SELECT SUM(value) from transactions where transactions.favored_id = favored.id)' $TARGET_DATABASE_NAME

#REMOVE CACHED PAGES 
#FROM (index.html, mainly) ./app-root/runtime/repo/public/
#AND (ALL) ./app-root/runtime/repo/tmp/cache

#UPDATING USING DUMP FROM IMPORT (FULL UPDATE):
#sed -i 's/20170329_CPGF_2016_IMPORT/web/g' 20170329_CPGF_2016_IMPORT.sql
#(with rhc port-forward)
#pv 20170329_CPGF_2016_IMPORT.sql | mysql --port=54641 --host=127.0.0.1 -u user -ppassword
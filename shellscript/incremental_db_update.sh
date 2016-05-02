#!/bin/bash
## Script to import data from crawler database
## Database:Mysql

NOW=`date +%d-%m-%Y_%Hh%Mm%Ss`
SRC_DATABASE_NAME=CPGF_2016
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
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_EXTRATO --where "id > $MAX_SOURCE_ID" > $OUTPUT_FILE
#export portadores
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_PESSOA --where "id > $MAX_PERSON_ID" >> $OUTPUT_FILE
#export favorecidos
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_FAVORECIDO --where "id > $MAX_FAVORED_ID" >> $OUTPUT_FILE
#export tipo transacao
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_TIPO_TRANSACAO --where "id > $MAX_TRANSACTION_TYPE_ID" >> $OUTPUT_FILE
#export tipo orgao superior
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_ORGAO_SUPERIOR --where "id > $MAX_SUPERIOR_ID" >> $OUTPUT_FILE
#export tipo orgao subordinado
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_ORGAO_SUBORDINADO --where "id > $MAX_SUBORDINATED_ID" >> $OUTPUT_FILE
#export transações
mysqldump -u root --no-create-info $SRC_DATABASE_NAME CPGF_TRANSACAO --where "id > $MAX_TRANSACTION_ID" >> $OUTPUT_FILE

#Fix table names
sed -i 's/CPGF_FAVORECIDO/favored/g' $OUTPUT_FILE
sed -i 's/CPGF_EXTRATO/sources/g' $OUTPUT_FILE
sed -i 's/CPGF_ORGAO_SUBORDINADO/subordinated_organs/g' $OUTPUT_FILE
sed -i 's/CPGF_ORGAO_SUPERIOR/superior_organs/g' $OUTPUT_FILE
sed -i 's/CPGF_PESSOA/people/g' $OUTPUT_FILE
sed -i 's/CPGF_TIPO_TRANSACAO/transaction_types/g' $OUTPUT_FILE
sed -i 's/CPGF_TRANSACAO/transactions/g' $OUTPUT_FILE
sed -i 's/CPGF_UNIDADE_GESTORA/management_units/g' $OUTPUT_FILE

#fix table differences
sed -i 's/INSERT INTO `transactions` /INSERT INTO `transactions` (`id`, `value`, `date`, `superior_organ_id`, `subordinated_organ_id`, `management_unit_id`, `source_id`, `person_id`, `favored_id`, `transaction_type_id`, `created_at`, `updated_at`) /g' $OUTPUT_FILE
sed -i 's/INSERT INTO `favored` /INSERT INTO `favored` (`id`, `name`, `masked_document`, `created_at`, `updated_at`) /g' $OUTPUT_FILE
sed -i 's/INSERT INTO `people` /INSERT INTO `people` (`id`, `name`, `masked_document`, `created_at`, `updated_at`) /g' $OUTPUT_FILE

#insert aditional params for created_at and updated_at
sed -i 's/),/,NOW(),NOW()),/g' $OUTPUT_FILE
sed -i 's/);/,NOW(),NOW());/g' $OUTPUT_FILE

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

#REMOVE CACHED PAGES FROM ./app-root/runtime/repo/public/
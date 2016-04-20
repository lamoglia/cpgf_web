#!/bin/bash
mysqldump -u root --no-create-info CPGF_2016 > data.sql

TARGET_DATABASE_NAME='CPGF_2016_DEV'

#Fix table names
sed -i 's/CPGF_FAVORECIDO/favored/g' data.sql
sed -i 's/CPGF_EXTRATO/sources/g' data.sql
sed -i 's/CPGF_ORGAO_SUBORDINADO/subordinated_organs/g' data.sql
sed -i 's/CPGF_ORGAO_SUPERIOR/superior_organs/g' data.sql
sed -i 's/CPGF_PESSOA/people/g' data.sql
sed -i 's/CPGF_TIPO_TRANSACAO/transaction_types/g' data.sql
sed -i 's/CPGF_TRANSACAO/transactions/g' data.sql
sed -i 's/CPGF_UNIDADE_GESTORA/management_units/g' data.sql

#fix table differences
sed -i 's/INSERT INTO `transactions` /INSERT INTO `transactions` (`id`, `value`, `date`, `superior_organ_id`, `subordinated_organ_id`, `management_unit_id`, `source_id`, `person_id`, `favored_id`, `transaction_type_id`, `created_at`, `updated_at`) /g' data.sql
sed -i 's/INSERT INTO `favored` /INSERT INTO `favored` (`id`, `name`, `masked_document`, `created_at`, `updated_at`) /g' data.sql
sed -i 's/INSERT INTO `people` /INSERT INTO `people` (`id`, `name`, `masked_document`, `created_at`, `updated_at`) /g' data.sql

#Remove locks to track import progress
sed -i 's/^UNLOCK TABLE/-- UNLOCK TABLE/g' data.sql
sed -i 's/^LOCK TABLE/-- LOCK TABLE/g' data.sql 

#insert aditional params for created_at and updated_at
sed -i 's/),/,NOW(),NOW()),/g' data.sql
sed -i 's/);/,NOW(),NOW());/g' data.sql

#import
pv data.sql | mysql -u root $TARGET_DATABASE_NAME

#fix transactions with null dates (protected data)
mysql -u root -e 'UPDATE transactions SET date = (select reference from sources where sources.id = transactions.source_id) , hidden_date = true
WHERE transactions.date is null' $TARGET_DATABASE_NAME

mysql -u root -e 'UPDATE people set name = "INFORMAÇÃO SIGILOSA*" where name is null' $TARGET_DATABASE_NAME

mysql -u root -e 'UPDATE favored set name = "NÃO INFORMADO" where name is null' $TARGET_DATABASE_NAME

mysql -u root -e 'UPDATE transaction_types set description = "INFORMAÇÃO SIGILOSA*" where description is null' $TARGET_DATABASE_NAME

#calculate total spendings by person
mysql -u root -e 'UPDATE people set total_transactions = (SELECT SUM(value) from transactions where transactions.person_id = people.id)' $TARGET_DATABASE_NAME

#calculate total spendings by favored
mysql -u root -e 'UPDATE favored set total_transactions = (SELECT SUM(value) from transactions where transactions.favored_id = favored.id)' $TARGET_DATABASE_NAME
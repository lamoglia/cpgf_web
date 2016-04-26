# CPGF web

O objetivo é criar uma apresentação inteligível, permtindo diversas consultas, sobre os dados fornecidos pelo governo federal sobre CPGF (Cartão de Pagamento do Governo Federal)

### Fontes dos dados:
[http://www.portaltransparencia.gov.br/downloads/mensal.asp?c=CPGF](http://www.portaltransparencia.gov.br/downloads/mensal.asp?c=CPGF)


### Dependências

#### Groupdate

É necessário configurar o banco de dados caso seja MySQL, habilitando suporte a timezones:

[Time zone support](http://dev.mysql.com/doc/refman/5.6/en/time-zone-support.html) deve estar instalado no servidor.

```sh
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
```

or copy and paste [these statements](https://gist.githubusercontent.com/ankane/1d6b0022173186accbf0/raw/time_zone_support.sql) into a SQL console.
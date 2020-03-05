KEY_NAME:=key
CERT_NAME:=cert

HOST:=0.0.0.0
PORT:=8080

sslkey:
	openssl req -x509 -newkey rsa:4096 -nodes -out ${CERT_NAME}.pem -keyout ${KEY_NAME}.pem -days 365

clean_sslkey:
	rm ${CERT_NAME}.pem ${KEY_NAME}.pem

install:
	pipenv install

run: Pipfile.lock
	pipenv run flask run --host=${HOST} --port=${PORT}

run_ssl: Pipfile.lock ${CERT_NAME}.pem ${KEY_NAME}.pem
	pipenv run flask run --host=${HOST} --port=${PORT} --cert=${CERT_NAME}.pem --key=${KEY_NAME}.pem

clean: Pipfile.lock
	pipenv --rm

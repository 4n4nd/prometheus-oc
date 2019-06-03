ENV_FILE := .env
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
export PIPENV_DOTENV_LOCATION=${ENV_FILE}

apply_prometheus:
	oc process \
		-p NAMESPACE=${PROJECT} \
		-p LIMIT_MEMORY_PROMETHEUS=${LIMIT_MEMORY_PROMETHEUS} \
		-p PROM_FEDERATE_TARGET=${PROM_FEDERATE_TARGET} \
		-p PROM_FEDERATE_BEARER=${PROM_FEDERATE_BEARER} \
		-f ./prometheus.yaml -n ${PROJECT} | oc apply -f -

delete_prometheus:
	oc process \
		-p NAMESPACE=${PROJECT} \
		-p LIMIT_MEMORY_PROMETHEUS=${LIMIT_MEMORY_PROMETHEUS} \
		-p PROM_FEDERATE_TARGET=${PROM_FEDERATE_TARGET} \
		-p PROM_FEDERATE_BEARER=${PROM_FEDERATE_BEARER} \
		-f ./prometheus.yaml -n ${PROJECT} | oc delete -f -

#!/bin/bash

readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function execute () {
    local exec_command=$1
    eval "${exec_command}"
    echo "${exec_command}" | awk '{$1=$1;print}'
}
# readonly definition of a function throws an error if another function
# with the same name is defined a second time
readonly -f execute
[ "$?" -eq "0" ] || return $?

main() {
     # getopts
    local command=$@

    if [[ ${command} == "init" ]];then
        execute "docker run --name postgres_training -p 5432:5432 -d -e POSTGRES_PASSWORD=training -e POSTGRES_USER=cinema  postgres:13.2"
        sleep 2
        execute "mvn -f ${SCRIPT_DIR}/../../flyway/pom.xml flyway:migrate"
        exit 0
    fi

     if [[ ${command} == "start" ]];then
        execute "docker start postgres_training"
        exit 0
    fi

    if [[ ${command} == "stop" ]];then
        execute "docker stop postgres_training"
        exit 0
    fi

    if [[ ${command} == "tear-down" ]];then
        execute "docker rm -f postgres_training"
        exit 0
    fi

    echo "available options are init, start, stop, tear-down."
    exit 1
}
readonly -f main
[ "$?" -eq "0" ] || return $?

main $@

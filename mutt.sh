#!/bin/bash

set -eo pipefail

err() {
    echo "$*" >&2
    exit 1
}

parse_arguments() {
    POSITIONAL=()
    while [[ $# -gt 0 ]]; do
        KEY="$1"
        case $KEY in
        -a|--attachment)
            ATTACHMENT="$2"
            shift
            shift
            ;;
        -b|--body)
            BODY="$2"
            shift 
            shift
            ;;
        -r|--recipients)
            RECIPIENTS="$2"
            shift
            shift
            ;;
        -s|--subject)
            SUBJECT="$2"
            shift
            shift
            ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
        esac       
    done

    if [[ -z "${SUBJECT}" ]]; then 
        err "email subject is required"
    fi

    if [[ -z "${RECIPIENTS}" ]]; then 
        err "email recipients are required"
    fi

    if [[ "${ATTACHMENT}" != "" ]]; then 
        ATTACHMENT="-a "${ATTACHMENT}""
    fi

}

parse_arguments "$@"

type mutt >/dev/null 2>&1 
if [[ "$?" != "0"  ]]; then  
    sudo apt update && sudo apt install -y mutt
fi

echo "${BODY}" | mutt -s "${SUBJECT}" ${ATTACHMENT} -- "${RECIPIENTS}"








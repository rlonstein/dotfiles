kubeconfig() {
    KUBECONF_PATH="$HOME/.kube"
    KUBECONFIG="$KUBECONF_PATH/config"
    if [ -z "${KUBECONFIG}" ]; then
        echo "** ERROR: No kube config found"
        return 1
    else
        export KUBECONFIG
        export KUBECONF_PATH
    fi
}

kc_conf_get_name() {
    # output filename and name@server
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <kubename>"
        return 1
    fi
    y2j "$KUBECONF_PATH/conf.d/$1" | jq -r '.clusters[]|[.name,.cluster.server|sub("^[a-z0-9.-_]*://";"")]|join("@")'
}

kc_conf_list() {
    if [ -z "$KUBECONF_PATH" ]; then
        echo "No kube conf path set!"
        return 1
    fi
    
    for c in $(find "$KUBECONF_PATH/conf.d" -type f); do
        name=`basename $c`
        id=$(kc_conf_get_name $name)
        echo "$name,$id"
    done
}

kc_conf_change() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <kubecfgname>"
        return 1
    fi

    if [ ! -e "$KUBECONF_PATH/conf.d/$1" ]; then
        echo "Config not found!"
        return 1
    fi
    
    if [ -e "$KUBECONF_PATH/config" ]; then
        mv "$KUBECONF_PATH/config" "$KUBECONF_PATH/config.bak"
    fi

    cp "$KUBECONF_PATH/conf.d/$1" "$KUBECONF_PATH/config"
}

kuse() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <namespace>"
        return 1
    else
        export KUBE_NAMESPACE=$1
    fi
}

kc() {
    if [ -z "${KUBE_NAMESPACE}" ]; then
        kubectl "$@"
    else
        kubectl --namespace $KUBE_NAMESPACE "$@"
    fi
}

kswitch() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <kube-context>"
        return 1
    fi
    kubectl config use-context $1
}

kwatch() {
    kccmd="kubectl get po,ds,deploy,hpa,ing,petsets,rs,svc,pvc -o wide --no-headers=true"
    if [ -z $1 ]; then
        watch -ct "${kccmd} --all-namespaces | grep -v ^kube-system"
    else
        watch -ct "${kccmd} --namespace $1"
    fi
}

kpods() {
    NS="${1-$KUBE_NAMESPACE}"
    CMD="kubectl get pods -o json"
    if [ -n "$NS" ]; then
        CMD="$CMD -n $NS"
    fi
    eval "$CMD" | jq -r '.["items"] | .[] | .["metadata"]["name"] + " " + .["status"]["phase"]'
}

kfindsvc() {
    case "$#" in
        0) kpods
           ;;
        1) if [ -z "${KUBE_NAMESPACE}" ]; then
              echo "Must set KUBE_NAMESPACE if only supplying <substring>"
           else
               kpods $KUBE_NAMESPACE | grep $1
           fi
           ;;
        2) kpods "${1:-$KUBE_NAMESPACE}" | grep $2
           ;;
        *) echo "Must supply either <namespace> or <namespace> <substring>"
           ;;
    esac
}


k50 () {
    KOPS_STATE_STORE=s3://oscar-ai-kops kops export kubecfg --name $1
}

kcred () {
  aws s3 cp s3://oscar-ai-kubernetes/${1:-control}.aws-us-west-2.datapipe.io/kubeconfig ~/.kube/config
}

kubeconfig

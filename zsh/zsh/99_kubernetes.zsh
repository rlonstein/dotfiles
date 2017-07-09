kubeconfig() {
    KUBECONFIG=`find ~/.kube/config ~/.kube/conf.d -type f 2>/dev/null | paste -s -d : -`
    if [ -z "${KUBECONFIG}" ]; then
        echo "** ERROR: No kube config found"
        return 1
    else
        export KUBECONFIG
    fi
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

#kubeconfig

#!/bin/bash

absdir="$(realpath "$(dirname "$0")")"

# cygrunsrv option
name="frpc_aliyun"
exe="$absdir/../../../windows/frpc.exe"
arg="-c \"$(cygpath -m "$absdir/../frpc_aliyun_office_tocken.ini")\""
disp="Frp Client Service (aliyun-ecs)"
desc="A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet"
dep="--dep tcpip"

# check
if cygrunsrv --query $name >/dev/null 2>&1 ; then
    echo "$name service is already installed."
    exit 0
fi

# cygrunsrv
#   --install   Installes a new service named <svc_name>
#   --start     Starts a service named <svc_name>
#   --path      Application path which is run as a service
#   --args      command line options
#   --disp      display name of the service. Defaults to service name.
#   --desc      service description.
#   --type      Optional start type of service [auto|manual]
#   --dep       name of service that must be started before this new service
#   --env       environment strings which are added to the environment, /bin is always added to $PATH
cygrunsrv --install "$name" --path "$exe" --args "$arg" --disp "$disp" --desc "$desc" --type auto $dep --env "HOME=$HOME"
cygrunsrv --start "$name"


#!/bin/sh
if [ ! -d $GF_PROVISIONING_PATH/dashboards  ];then
    mkdir -p $GF_PROVISIONING_PATH/dashboards
else
    rm -rf  $GF_PROVISIONING_PATH/dashboards/*
fi

# MYSQL dashboard
cp /tmp/mysql-overview.json $GF_PROVISIONING_PATH/dashboards
sed -i 's/Test-Cluster-GreatDB/'$GREATDB_CLUSTER_NAME'-GreatDB/g'  $GF_PROVISIONING_PATH/dashboards/mysql-overview.json


# Rules
if [ ! -d $PROM_CONFIG_PATH/rules  ];then
    mkdir -p $PROM_CONFIG_PATH/rules
else
    rm -rf  $PROM_CONFIG_PATH/rules/*
fi
echo $META_TYPE
echo $META_INSTANCE
echo $META_VALUE
cp /tmp/rules.yaml $PROM_CONFIG_PATH/rules
for file in $PROM_CONFIG_PATH/rules/*
do
    sed -i 's/ENV_LABELS_ENV/'$GREATDB_CLUSTER_NAME'/g' $file
done

# Alerts
if [ ! -d $PROM_CONFIG_PATH/alerts  ];then
    mkdir -p $PROM_CONFIG_PATH/alerts
else
    rm -rf  $PROM_CONFIG_PATH/alerts/*
fi
echo $META_TYPE
echo $META_INSTANCE
echo $META_VALUE
cp /tmp/galera.yaml $PROM_CONFIG_PATH/alerts
cp /tmp/general.yaml $PROM_CONFIG_PATH/alerts
for file in $PROM_CONFIG_PATH/alerts/*
do
    sed -i 's/ENV_LABELS_ENV/'$GREATDB_CLUSTER_NAME'/g' $file
done


# Copy Persistent rules to override raw files
if [ ! -z $PROM_PERSISTENT_DIR ];
then
    if [ -d $PROM_PERSISTENT_DIR/latest-rules/${GREATDB_VERSION##*/} ];then
        cp -f $PROM_PERSISTENT_DIR/latest-rules/${GREATDB_VERSION##*/}/rules.yml $PROM_CONFIG_PATH/rules
    fi
fi


# Datasources
if [ ! -z $GF_DATASOURCE_PATH ];
then
    if [ ! -z $GF_K8S_PROMETHEUS_URL ];
    then
        sed -i 's,http://prometheus-k8s.monitoring.svc:9090,'$GF_K8S_PROMETHEUS_URL',g' /tmp/k8s-datasource.yaml
    fi

    if [ ! -z $GF_GREATDB_PROMETHEUS_URL ];
    then
        sed -i 's,http://127.0.0.1:9090,'$GF_GREATDB_PROMETHEUS_URL',g' /tmp/greatdb-cluster-datasource.yaml
    fi

    cp /tmp/k8s-datasource.yaml $GF_DATASOURCE_PATH/
    cp /tmp/greatdb-cluster-datasource.yaml $GF_DATASOURCE_PATH/

    # pods
    if [ ! -z $GREATDB_CLUSTER_NAMESPACE ];
    then
         sed -i 's/$namespace/'$GREATDB_CLUSTER_NAMESPACE'/g' /tmp/pods.json
    else
         sed -i 's/$namespace/default/g' /tmp/pods.json
    fi
    sed -i 's/Test-Cluster-Pods-Info/'$GREATDB_CLUSTER_NAME'-Pods-Info/g' /tmp/pods.json
    cp /tmp/pods.json $GF_PROVISIONING_PATH/dashboards

    # nodes
     cp /tmp/nodes.json $GF_PROVISIONING_PATH/dashboards
fi

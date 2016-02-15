#!/usr/bin/env bash

set -e

export JOB_NAME=$1
export OUTPUT_LABEL=${2:-$JOB_NAME}

# Setup job home folder
export HOME=/var/vcap
export JOB_DIR=$HOME/jobs/$JOB_NAME

# Setup log, run, store and tmp folders
export LOG_DIR=$HOME/sys/log/$JOB_NAME
export RUN_DIR=$HOME/sys/run/$JOB_NAME
export STORE_DIR=$HOME/store/$JOB_NAME
export TMP_DIR=$HOME/sys/tmp/$JOB_NAME
export TMPDIR=$TMP_DIR
for dir in $LOG_DIR $RUN_DIR $STORE_DIR $TMP_DIR
do
  mkdir -p ${dir}
  chown vcap:vcap ${dir}
  chmod 775 ${dir}
done

# Add all packages /bin & /sbin into $PATH
for package_bin_dir in $(ls -d $HOME/packages/*/*bin)
do
  export PATH=${package_bin_dir}:$PATH
done

# Load job properties
if [ -f $JOB_DIR/bin/job_properties.sh ]; then
  source $JOB_DIR/bin/job_properties.sh
fi

# Load some control helpers
source $HOME/packages/docker/ctl_utils.sh

# Redirect output
redirect_output ${OUTPUT_LABEL}

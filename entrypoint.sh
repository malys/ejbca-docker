#!/bin/bash

cat > /home/ejbca/entrypoint.ejbca.sh <<EOF
HOME=/home/ejbca
export HOME
cd ~ejbca || exit 1

if [ -d ejbca-custom ]; then
  FILE=./environment
  if [[ -f "$FILE" ]]; then
    . ./environment
  fi

  export JAVA_OPTS
  echo "Run EJBCA"
  wildfly/bin/standalone.sh -b 0.0.0.0
else
  echo "Install EJBCA"
  /root/ejbca-setup
fi
EOF

#cp /root/ejbca-setup /home/ejbca/ejbca-setup
chown -R ejbca:ejbca /home/ejbca
chmod 700 /home/ejbca/entrypoint.ejbca.sh /home/ejbca/ejbca-setup

/usr/bin/setpriv --init-groups --reuid=ejbca --regid=ejbca /home/ejbca/entrypoint.ejbca.sh

#echo "Either ejbca-setup has finsihed, or your EJBCA installation has a problem"

# shutdown: wildfly/bin/jboss-cli.sh --connect ":shutdown"


#!/bin/bash

cat > /home/ejbca/entrypoint.ejbca.sh <<EOF
cd ~ejbca || exit 1

if [ -d ejbca-custom ]; then
  . ./environment
  export JAVA_OPTS
  echo "Run EJBCA"
  wildfly/bin/standalone.sh -b 0.0.0.0
else
  echo "Install EJBCA"
  ./ejbca-setup
fi
EOF

chown -R ejbca:ejbca /home/ejbca
chmod 700 /home/ejbca/entrypoint.ejbca.sh

su --command=/home/ejbca/entrypoint.ejbca.sh ejbca

#echo "Either ejbca-setup has finsihed, or your EJBCA installation has a problem"

# shutdown: wildfly/bin/jboss-cli.sh --connect ":shutdown"


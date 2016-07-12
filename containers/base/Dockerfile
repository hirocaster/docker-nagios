FROM ubuntu:16.04

ENV ENTRYKIT_VERSION 0.4.0

WORKDIR /

RUN apt-get update

# entrykit
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes \
  wget

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz --no-check-certificate\
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y nagios3 nsca && \
    apt-get clean

# Configure Nagios
ENV NAGIOSADMIN_USER nagiosadmin
ENV NAGIOSADMIN_PASS nagios

RUN htpasswd -bc /etc/nagios3/htpasswd.users ${NAGIOSADMIN_USER} ${NAGIOSADMIN_PASS}

# nsca
EXPOSE 5667

# Configure Apache2
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
env APACHE_PID_FILE     /var/run/apache2.pid
env APACHE_RUN_DIR      /var/run/apache2
env APACHE_LOCK_DIR     /var/lock/apache2
env APACHE_LOG_DIR      /var/log/apache2

EXPOSE 80

COPY run_apache.sh /tmp/run_apache.sh
COPY run_nagios.sh /tmp/run_nagios.sh
COPY run_nsca.sh /tmp/run_nsca.sh

ENTRYPOINT [ \
  "prehook", \
    "/usr/sbin/nagios3 --version", \
    "--", \
  "switch", \
    "shell=/bin/bash", \
    "--", \
  "codep", \
    "/tmp/run_apache.sh", \
    "/tmp/run_nagios.sh", \
    "/tmp/run_nsca.sh" \
]

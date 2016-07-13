FROM hirocaster/nagios-base

# Configure Nagios
ENV CHECK_EXTERNAL_COMMANDS 1

COPY ./nagios.cfg.tmpl /etc/nagios3/nagios.cfg.tmpl

ENV DEBUG 1
COPY ./nsca.cfg.tmpl /etc/nsca.cfg.tmpl


COPY generic-passiv_service.cfg /etc/nagios3/conf.d/generic-passiv_service.cfg
COPY service-is-stale_command.cfg /etc/nagios3/conf.d/service-is-stale_command.cfg
COPY services.cfg /etc/nagios3/conf.d/services.cfg

COPY run_nsca.sh /tmp/run_nsca.sh

ENTRYPOINT [ \
  "prehook", \
    "/usr/sbin/nagios3 --version", \
    "--", \
  "switch", \
    "shell=/bin/bash", \
    "--", \
  "render", \
    "/etc/nagios3/nagios.cfg", \
    "/etc/nsca.cfg", \
    "--", \
  "codep", \
    "/tmp/run_apache.sh", \
    "/tmp/run_nagios.sh", \
    "/tmp/run_nsca.sh" \
]

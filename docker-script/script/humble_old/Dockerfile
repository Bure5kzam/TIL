
FROM ubuntu:22.04

RUN apt-get update && apt-get -y install sudo

WORKDIR /script

COPY --chown=root:root /init/system_init.sh ./
COPY --chown=root:root /init/system_init_more.sh /script
COPY --chown=root:root /init/system_init_ros.sh /script

RUN ./system_init.sh

RUN ./system_init_more.sh
RUN ./system_init_ros.sh

CMD /bin/bash

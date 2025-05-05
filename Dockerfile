ARG PUID=1000
ARG PGID=1000

FROM archlinux:base
ARG PUID
ARG PGID

ENV UID=${PUID}
ENV GID=${PGID}

RUN pacman-key --init && \
	pacman-key --populate archlinux && \
	pacman --noconfirm -Syyu && \
	pacman --noconfirm -S hugo nodejs npm go dart-sass && \
	pacman --noconfirm -Scc && \
	groupadd -g ${GID} hugo && \
	useradd --create-home --gid ${GID} --uid ${UID} hugo && \
	npm install -g yarn pnpm

WORKDIR /home/hugo
USER hugo

VOLUME /home/hugo

EXPOSE 1313

CMD ["/usr/bin/hugo"]

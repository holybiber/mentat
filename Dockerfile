FROM debian

# Configure environment variables and time zone
# to avoid questions during docker build
ENV TZ="Europe/Berlin"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update -y && \
    apt-get install -y -o Acquire::Retries=10 \
                    --no-install-recommends \
    python3 \
	python3-pip \
	python3-venv \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# TODO: Make /screenshot functionality work
# After installing firefox-esr or chromium it still doesn't work
# ("No suitable browser found")
# Installing chromium lets the docker image size increase to 1.45 GB
#    chromium \
# Installing firefox-esr lets the docker image size increase to 1.25 GB
#    firefox-esr \

RUN python3 -m venv /home/.venv
RUN /home/.venv/bin/python -m pip install mentat

# TODO: Get rid of the venv as we're anyway on a docker container
# Use pip --break-system-packages to avoid the
# externally-managed-environment error
#RUN pip install --break-system-packages mentat
#CMD ["python",  "-m",  "mentat"]

#VOLUME ["/root/.mentat"]
CMD ["/home/.venv/bin/python",  "-m",  "mentat"]

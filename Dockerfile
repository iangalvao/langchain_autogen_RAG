FROM python:3.10-slim-buster

# Install build tools and dependencies
RUN apt-get update && apt-get install -y build-essential wget tar

# Download and compile SQLite 3.35.5 from source
RUN wget https://www.sqlite.org/2023/sqlite-autoconf-3440000.tar.gz
RUN tar -xzvf sqlite-autoconf-3440000.tar.gz
WORKDIR /sqlite-autoconf-3440000
RUN ./configure
RUN make
RUN make install

#Clean up
WORKDIR /
RUN rm -r sqlite-autoconf-3440000
RUN rm sqlite-autoconf-3440000.tar.gz

RUN useradd -m jupyteruser
USER jupyteruser


# Set the user's home directory
ENV HOME /home/jupyteruser
ENV PATH="${HOME}/.local/bin:${PATH}"

COPY requirements.txt .

RUN pip3 install -r requirements.txt --no-cache-dir --disable-pip-version-check --no-deps
ENV LD_LIBRARY_PATH=/usr/local/lib


WORKDIR /my_app

CMD ["jupyter", "notebook"]
FROM postgis/postgis:14-3.2

# Configuration Parameters
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV MOBILITYDB_VERSION 1.0
ENV POSTGRES_DB=mobilitydb
ENV POSTGRES_USER=docker 
ENV POSTGRES_PASSWORD=docker

# Fix the Release file expired problem
RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until


# Install Prerequisites 
RUN apt-get update \
 && apt-get install -y \
    build-essential \
    cmake \
    git \
    libproj-dev \    
    g++ \
    wget \
    autoconf \
    autotools-dev \
    libpq-dev \
    libproj-dev \
    libgeos-dev \
    libjson-c-dev \
    protobuf-c-compiler \
    xsltproc \
    libgsl-dev \
    libgslcblas0 \  
    postgresql-server-dev-${PG_MAJOR} \
  && rm -rf /var/lib/apt/lists/*     

# Install MobilityDB     
RUN git clone https://github.com/MobilityDB/MobilityDB.git -b develop /usr/local/src/MobilityDB --depth 1
RUN mkdir /usr/local/src/MobilityDB/build
RUN cd /usr/local/src/MobilityDB/build && \
    cmake .. && \
    make -j$(nproc) && \
    make install

RUN rm /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/mobilitydb.sh
RUN chmod +x /docker-entrypoint-initdb.d/mobilitydb.sh
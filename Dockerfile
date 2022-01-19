#===============================================================================
# FROMFREEZE docker.io/library/debian:9
#FROM docker.io/library/debian@sha256:d844caef45253dab4cb7543b5781f529c1c3f140fcf9cd6172e1d6cb616a51c3
FROM centos7:coreset

ARG PG_HOME=/var/lib/postgresql
ARG PG_LIB=/usr/local/lib/postgresql
ARG PG_USER=postgres
#-------------------------------------------------------------------------------


RUN yum -y update
RUN yum install -y perl readline readline-devel zlib zlib-devel bison bison-devel flex flex-devel lz4 lz4-devel gcc gcc-c++
RUN yum install -y gdb sudo vim file make cmake iproute rsync  perf strace wget python-pip

#RUN pip install --upgrade pip
RUN pip install psycopg2==2.7.3.1
#RUN pip install --upgrade pip  -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com
#RUN pip install psycopg2 -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com

#RUN mkdir /cores && chmod 777 /cores
#RUN echo '/cores/core.%e.%p' | sudo tee /proc/sys/kernel/core_pattern

RUN useradd ${PG_USER} -d ${PG_HOME} && \
    mkdir -p ${PG_LIB} ${PG_HOME} && \
    chown -R ${PG_USER}:${PG_USER} ${PG_LIB} ${PG_HOME}
#-------------------------------------------------------------------------------
WORKDIR ${PG_HOME}

COPY --chown=postgres:postgres lib/ ./lib/
#-------------------------------------------------------------------------------
USER ${PG_USER}

WORKDIR ${PG_HOME}/lib/postgres-xl
#-DEXEC_NESTLOOPDEBUG -DEXEC_NESTLOOPVLEDEBUG
RUN ./configure --with-blocksize=32 --enable-debug --enable-cassert CFLAGS='-O0 -ggdb -DDEBUG' --prefix ${PG_LIB} && \
    make && \
    cd contrib/pgxc_monitor && \
    make && cd ../pg_plan_tree_dot && make
#-------------------------------------------------------------------------------
USER root

RUN make install && \
    cd contrib/pgxc_monitor && \
    make install && cd ../pg_plan_tree_dot && make install



#-------------------------------------------------------------------------------
USER ${PG_USER}

WORKDIR ${PG_HOME}

ENV PATH=${PG_LIB}/bin:$PATH \
    PGDATA=${PG_HOME}/data \
    PG_USER_HEALTHCHECK=_healthcheck

COPY bin/* ${PG_LIB}/bin/
COPY ci/ ./ci/




VOLUME ${PG_HOME}
#===============================================================================

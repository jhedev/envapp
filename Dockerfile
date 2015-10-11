FROM fpco/stack-build:lts-3.4


RUN mkdir -p /opt/app
ADD . /opt/app

WORKDIR /opt/app

RUN stack setup
RUN stack build

EXPOSE 3000
ENV PORT=3000
CMD stack exec EnvApp

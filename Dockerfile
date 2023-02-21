FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
# Update default packages
RUN apt-get update
RUN apt-get -y install software-properties-common dirmngr
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '51716619E084DAB9'
RUN add-apt-repository "deb [trusted=yes] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
RUN apt-get update


# Get Ubuntu packages
RUN apt-get install -y \
    build-essential \
    curl r-base g++ openssl libssl-dev

# Get Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
USER root
ENV PATH="/root/.cargo/bin:${PATH}"
RUN R --version

RUN rustup install 1.64.0
RUN rustup default 1.64.0

WORKDIR /app
RUN R -e 'install.packages("remotes", repos = "http://cran.us.r-project.org")'
RUN R -e 'install.packages("RestRserve", repos = "https://cloud.r-project.org")'
RUN R -e 'remotes::install_github("Tmando/RWrapperMiscellaneousPkg",force = TRUE, upgrade = TRUE,build = TRUE)'


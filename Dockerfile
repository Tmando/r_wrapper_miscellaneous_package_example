FROM alpine:latest
RUN apk add --no-cache R
RUN apk add --no-cache R-dev
RUN apk add curl
RUN apk add bash
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
WORKDIR /app
RUN R_REMOTES_NO_ERRORS_FROM_WARNINGS=true
RUN R -e 'install.packages("remotes", repos = "http://cran.us.r-project.org")'
RUN R -e 'remotes::install_github("Tmando/RWrapperMiscellaneousPkg", build = TRUE)'


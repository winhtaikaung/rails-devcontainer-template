ARG RUBY_VERSION=2.7.5

FROM ruby:${RUBY_VERSION}

RUN apt-get update -qq && apt-get install -y git curl sudo postgresql-client ca-certificates build-essential && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

ENV USERNAME=rubydev \
    USER_UID=2001 \
    USER_GID=2001

# Creating User 
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd -ms /bin/bash -K MAIL_DIR=/dev/null --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

RUN gem install rails webdrivers

#  Install Node Version Manager You can comment the lines Node if you project doesnt need 

USER ${USER_UID}:${USER_GID}

ENV NVM_VERSION=0.39.1
ARG NODE_VERSION="lts/*" 

ENV NVM_DIR /home/${USERNAME}/.nvm
RUN mkdir $NVM_DIR

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v{$NVM_VERSION}/install.sh | bash

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN echo "source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default" | bash
    
CMD npm install --global yarn

WORKDIR /home/${USERNAME}/app

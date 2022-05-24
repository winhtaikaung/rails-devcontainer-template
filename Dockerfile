ARG RUBY_VERSION=2.7.5

FROM ruby:${RUBY_VERSION}

RUN apt-get update -qq && apt-get install -y git curl sudo postgresql-client ca-certificates build-essential zsh && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update && apt-get install -y nodejs


ENV USERNAME=rubydev \
    USER_UID=2001 \
    USER_GID=2001

# Creating User 
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd -ms /bin/bash -K MAIL_DIR=/dev/null --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

RUN gem install rails webdrivers solargraph rubocop

#  Install Node Version Manager You can comment the lines Node if you project doesnt need 

USER ${USER_UID}:${USER_GID}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


WORKDIR /home/${USERNAME}/app

ENTRYPOINT ["zsh"]

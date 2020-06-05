FROM ubuntu

RUN apt-get update && apt-get install --assume-yes curl ruby build-essential git

RUN useradd -p 1234 -m homebrew

USER homebrew

ENTRYPOINT ["/bin/bash"]

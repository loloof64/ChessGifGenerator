# Building for Linux
# Image with Flutter and AppImage Builder set.
# Don't forget to mount current project's folder when running.

# Setup Ubuntu
FROM appimagecrafters/appimage-builder:latest
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install --yes bash curl wget file git unzip xz-utils zip libglu1-mesa build-essential cmake ninja-build clang libgtk-3-dev

# Setup user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Setup Flutter
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.3.5-stable.tar.xz
RUN tar xf flutter_linux_3.3.5-stable.tar.xz
RUN rm -rf flutter_linux_3.3.5-stable.tar.xz
ENV PATH=$PATH:/home/developer/flutter/bin
RUN flutter upgrade
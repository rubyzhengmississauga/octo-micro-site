#Use ruby-2.1.5 official image
FROM ruby:2.1.5

MAINTAINER Tushar Dwivedi  <tushar@octo.ai>

#Install dependencies:
# - build-essentials: to ensure certain gems can be compiled
#RUN apt-get update && apt-get install -qq -y build-essential
RUN apt-get update

#Set ENV variable to store app inside the image
ENV INSTALL_PATH  /apps 
RUN mkdir -p $INSTALL_PATH

#Ensure gems are cached and only get updated when they change.
WORKDIR /tmp
COPY  Gemfile /tmp/Gemfile
RUN bundle install

#Copy application code from workstation to the working directory
COPY  . $INSTALL_PATH

#Symlink central config to app config
#COPY  central-config  . 
#RUN ln -s config-master/ config/config
WORKDIR $INSTALL_PATH
CMD ["rackup"]

EXPOSE 9292
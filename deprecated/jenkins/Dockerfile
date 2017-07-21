FROM jenkins:latest

COPY jenkins/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY jenkins/seed.groovy /usr/share/jenkins/ref/init.groovy.d/seed.groovy

COPY jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

COPY jenkins/pipeline/ /usr/share/jenkins/ref/init.groovy.d/
COPY jenkins/provisioner/ /usr/share/jenkins/ref/init.groovy.d/

#Add/Boot to Jenkins User
#USER root
#RUN groupadd -g 125 docker && usermod -a -G docker jenkins
#USER jenkins

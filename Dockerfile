FROM ubuntu
MAINTAINER Preston Hunt <me@prestonhunt.com>

RUN apt-get update && apt-get install -y \
    dovecot-core \
    dovecot-imapd \
    inotify-tools

RUN echo "mail_location = maildir:~/Maildir" >> /etc/dovecot/conf.d/10-mail.conf && \
	echo "ssl = no" > /etc/dovecot/conf.d/10-ssl.conf && \
	echo "log_path = /dev/stderr" >> /etc/dovecot/conf.d/10-logging.conf && \
	echo "auth_verbose = yes" >> /etc/dovecot/conf.d/10-logging.conf && \
	echo "disable_plaintext_auth = no" >> /etc/dovecot/conf.d/10-auth.conf && \
	echo "auth_mechanisms = plain login" >> /etc/dovecot/conf.d/10-auth.conf

RUN useradd -m mailarchive -p mailarchive -s /bin/false && \
	echo "mailarchive:mailarchive"|chpasswd && \
	mkdir /home/mailarchive/Maildir && \
	chown mailarchive:mailarchive /home/mailarchive/Maildir

EXPOSE 143

CMD ["dovecot", "-F"]

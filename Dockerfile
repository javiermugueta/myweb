FROM javiermugueta/apacheimg:latest
#
#RUN useradd opc
#
WORKDIR /etc/httpd/conf/myconf
ADD myweb.conf .
RUN echo "LoadModule weblogic_module /wlsplugin/lib/mod_wl_24.so" >> /etc/httpd/conf/httpd.conf
RUN echo "Include  /etc/httpd/conf/myconf/myweb.conf" >> /etc/httpd/conf/httpd.conf
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

#RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> /etc/httpd/conf/httpd.conf
#RUN echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /etc/httpd/conf/httpd.conf
#RUN echo "LoadModule ssl_module modules/mod_ssl.so"  >> /etc/httpd/conf/httpd.conf
#
WORKDIR /var/estaticos/myweb 
ADD index.html .
## start A
# https://docs.oracle.com/en/middleware/fusion-middleware/web-tier/12.2.1.4/develop-plugin/apache.html#GUID-C5484884-5311-4353-AA32-5ED25F3BBD64
### start B
### Apache Fails to Start with "libonssys.so: cannot open shared object file: No such file or directory" After Weblogic Plugin is Configured (Doc ID 2522962.1)
RUN echo "/wlsplugin/lib" > /etc/ld.so.conf.d/wlsplugin.conf
RUN ldconfig
### end B
## end A
WORKDIR /myweb 
COPY init.sh .
RUN chmod +x /myweb/init.sh
ENTRYPOINT ["/myweb/init.sh"]
EXPOSE 80
CMD ["run"]
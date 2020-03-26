# panawebimg
Apache + wls proxy plugin
Creaos esta imagen porque en git no podemos meter los binarios de wlsproxyplugin
Así que lo hacemos en dos pasos
1) Creamos esta imagen
2) Creamos la imagen panaweb a partir de esta
##
```
docker build -t javiermugueta/apacheimg -f Dockerfileimgbase .
docker push javiermugueta/apacheimg

docker build -t javiermugueta/myweb .
docker push javiermugueta/myweb
```
# myweb

## helper
git add * && git commit -m . && git push
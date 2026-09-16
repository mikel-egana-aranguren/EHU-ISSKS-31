# Laborategia: Zifraketa aplikazioak

## Beharrezkoak

- GNU/Linux makina: eramangarria, makina birtuala, edo laborategiko PCa (Sartu LDAP kredentzialarekin).
- Kode-editorea. Visual Studio Code-n, ctrl+mayus+v sakatuta fitxategi hau modu atsegin batean ikusten da (Batez ere irudientzat).
- Beharrezko tresnak: OpenSSL (`sudo apt install openssl`), Apache (`sudo apt-get install apache2`).
- Irakasgaiaren GitHub biltegia: laborategian garatutako programak igo ditzakezu.

## Apache instalazioa

Webgune segurua sortzeko, lehenik web zerbitzari bat instalatu behar dugu gure Google Cloud zerbitzarian, kasu honetan Apache. Horretarako, ireki SSH konexio bat zerbitzarira eta exekutatu:

```bash
sudo apt-get install apache2
```

Makinaren IP helbidea nabigatzailearekin bisitatzen baduzu, adibidez `http://35.216.188.54`, Apacheren lehenetsitako orria agertu beharko litzateke. Nabigatzaileak konexioa segurua ez dela erakutsiko du, adibidez, “Not secure” mezuaren bidez.

![Apache](apache.png)

## Gune segurua sortzea

Sortu berri dugun webgunearekiko konexioak seguruak izatea nahi badugu, HTTP protokoloaren ordez HTTPS erabiliz, zerbitzariaren autosinatutako ziurtagiria erabili behar dugu eta 80 portuko trafikoa 443 portura birbideratu.

Horretarako, Apacheren lehenetsitako konfigurazioa erabili beharrean, sortu `index.html` izeneko orri bakarra duen `VirtualHost` bat, honako eduki honekin:

```html
<h1>SSL konexioa</h1>
```

Sortu autosinatutako ziurtagiri bat OpenSSL erabiliz eta sortu Apacheren konfigurazio berri bat 80 atakatik 443 atakarako birbideratzearekin.

Webgunea HTTPS bidez bisitatzean, ziurtagiria izan arren, errore-mezu bat agertuko da oraindik. Esportatu ziurtagiria eta gehitu zure nabigatzailera abisu hori ez agertzeko.




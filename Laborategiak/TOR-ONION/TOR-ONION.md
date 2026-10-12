# Laborategia: TOR, ONION

## Beharrezkoa

- Kode-editorea. Visual Studio Code-n, `ctrl+mayus+v` sakatuta fitxategi hau modu erosoan bistaratzen da (batez ere irudietarako).
- GNU/Linux makina: eramangarria, makina birtuala, edo laborategiko PCa (LDAP kredentzialarekin sartu).
- Urruneko Google Cloud zerbitzaria konfiguratuta, Apache funtzionatzen eta firewall-ak konexioak onartzen.

## Deep Web

Ohiko eta ezaguna den sarea (Clearnet) helbide ezagunek osatzen dute (Adib: www.ehu.eus), indexatuta dauden HTML edukiekin, interesatzen zaigun edukia aurkitzeko bilaketak egiteko aukera ematen dutenak.

Deep Web-a (internet sakona) internet bidez zuzenean eskuragarri ez dagoen eduki guztiak osatzen du. Kalkulatzen da existitzen den eduki guztitik:

- %10 Clearnet-en dagoela (ezagutzen dugun internet).
- %90 Deep Web-en dagoela.

Deep Web-eko edukia:

- Informazio konfidentziala edo babestua (normalean bilatzaileek ez dute indexatzen eta ezin da zuzenean atzitu): erregistro sanitarioak, erregistro akademikoak, banku-datuak, etab.
- Informazio "solte"a: adibidez, beste inongo tokitatik estekatuta ez dagoen HTML fitxategi bat.
- HTML ez den formatuko informazioa, nabigatzaile batek irakurri ezin duena.
- Argitaratu ezin daitekeen edukia (Zentsura): ondorioak ekar ditzaketelako libreki argitaratu ezin diren edukiak.
- Eduki ilegala eta/edo desatsegina (Darknet): arma, droga eta pertsonen trafikoa; pederastia materiala; malwarea; hackerren, matoien, etab. alokairua.

Deep Web-era sartzeko, pribatutasuna eta anonimotasuna eskaintzen dituen eta proxy gisa jarduten duen software berezia behar da.

Hainbat alternatiba daude Deep Web-eko eduki desberdinetara sartzeko: TOR, I2P, Freenet, Zeronet, etab.

## TOR

TOR-ek (The Onion Router) nabigatzeko modu segurua eskaintzen du, [sarea](https://community.torproject.org/) osatzen duten nodoen jatorrizko eta helmugako IPa ezkutatzen baitu. Onion guneak giza irakurketarako ez diren helbide alfanumeriko oso luzeak dira, HTTP(S) bidez atzigarriak, paketeak hainbat ONION nodotan zehar bidaiatu ondoren, paketeen jatorria eta helmuga ezkutatuz.

Konexio bat egin behar den bakoitzean, sareko nodoetan oinarritutako ausazko bide bat kalkulatzen da:

![TOR](tor.png)

Informazioa geruzatan zifratzen da (tipula bat bezala) nodo desberdinen gako publikoekin, nodo bakoitzak hurrengoa zein den bakarrik ikus dezan:

![capas](capas.png)

TOR sarea erabiliz beste modu batean atzigarriak ez diren URLetara sar gaitezke:

- `.onion` domeinua.
- URL alfanumerikoak: `http://3g2upl4pq6kufc4m.onion/`.

Edukiak aurkitzeko, bilatzaile espezifikoak edo URLak biltzen dituzten guneak erabili behar dira:

- Torch bilatzailea (`http://xmh57jrzrnw6insl.onion/`).
- The Hidden Wiki (`http://kpvz7ki2v5agwt35.onion`).

## TOR nabigatzailea

Onion guneetara sartzeko TOR nabigatzaile bat erabili behar da. Deskargatu [TOR nabigatzaile ofiziala](https://www.torproject.org/download/) eta erabili [gune desberdinetara](https://community.torproject.org/es/onion-services/) konektatzeko, adibidez [New York Times](https://www.nytimesn7cgmftshazwhfgzm37qxb44r64ytbb2dj3x62d2lljsciiyd.onion/) egunkarira.

> Zergatik uste duzu ONION zerbitzuak eskaintzen dituzten guneen artean egunkariak ugariak direla?

## ONION zerbitzua Google Cloud-en

### TOR instalatu

Zerbitzarian TOR instalatzeko jarraitu [argibide arruntak](https://community.torproject.org/onion-services/setup/install/) (Kontuan izan TOR instalatzeko [APT biltegi espezifiko batzuk](https://support.torproject.org/apt/tor-deb-repo/) konfiguratu behar direla).

Behin TOR instalatuta, bere funtzionamendua egiaztatzeko, exekutatu zerbitzarian:

```bash
curl -x socks5h://localhost:9050 -s https://check.torproject.org/api/ip
```

Honako hau itzuli beharko luke:

```json
{"IsTor":true,"IP":"xxx.xxx.xxx.xxx"}
```

### ONION zerbitzua konfiguratu

Jarraitu [argibide arruntak](https://community.torproject.org/onion-services/setup/) ONION zerbitzua konfiguratzeko. Kontuan izan:

- Apache funtzionatzen egon behar du eta firewall-ak konexioak onartu behar ditu. Komeni da web orri berri bat sortzea ONION bidezko konexioa egiaztatzeko.
- TOR-en konfigurazio fitxategia editatu behar da Hidden Service berri bat gehitzeko.
- ONION konexioa egiaztatzeko, Hidden Service-n sortutako ONION helbidea eta TOR nabigatzailea erabili beharko dituzu.

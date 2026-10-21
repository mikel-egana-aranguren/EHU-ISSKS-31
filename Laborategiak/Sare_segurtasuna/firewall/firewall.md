# Laborategia: Firewall

## Aurreko baldintzak

- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu; beharrezkoa bada, `lsi` erabiltzailea soilik, `su - lsi` komandoaren bidez).
- Kode-editorea. Visual Studio Code-n, ctrl+maius+v sakatuz fitxategi hau testu erraz batean bistaratzen da (batez ere irudietarako).
- Ikasgaiaren GitHub biltegia: laborategian garatutako programak igo ahal dituzu.
- Google Cloud kontua.

## Firewall Google Cloud-en

Laborategi honetan zuen web sistema Google Cloud-eko urruneko zerbitzarian zabalduko duzue, Google Cloud-ek lehenespenez ematen duen firewall-aren bidez sarbidea nola konfiguratu ikasteko. Web proiektua urruneko zerbitzarian zabaltzeko, Docker eta Docker Compose instalatu behar dira. Klonatu web proiektua Google Cloud-eko zerbitzarian (SSH konexioa ezarri ondoren):

```bash
git clone https://github.com/mikel-egana-aranguren/docker-lamp.git
```

Eraiki web irudia:

```bash
docker build -t="web" .
```

Zabaldu aplikazioa Docker Compose bidez:

```bash
docker-compose up
```

Gure proiektura sartu, phpMyAdmin bidez datuak kargatu eta webgunea ikusi ahal izateko, portu batzuk ireki behar ditugu.

> Zein portutan entzuten du gure proiektuak? (Pista: `netstat`).

Behin gure proiektua zein portutan ari den entzuten egiaztatu dugunean, portu horiek ireki behar ditugu kanpotik sartu ahal izateko.

> Nola ireki daitezke portu horiek Google Cloud-en? (Pistak: VPC sarea, `http-server` etiketa, `0.0.0.0/0`).

Firewall batean sarrerako trafikoa eragoztea ere posible da, ez soilik baimentzea.

> Nola itxiko zenituzke 80 eta 443 portuak sarrerako trafikorako?

Sarrerako trafikoaz gain, firewall batean irteerako trafikoa ere blokeatu daiteke.

> Nola eragotziko zenuke zure Google Cloud zerbitzaritik [https://en.wikipedia.org](https://en.wikipedia.org/) orrialderako irteerako trafikoa? (Pistak: `wget`, `ping`).

Azkenik, helbide jakin batetik datorren trafikoa ere blokeatu daiteke.

> Nola eragotziko zenuke zure uneko IPtik 8890 portura datorren sarrerako trafikoa? (Pista: «What is my IP?»).

## IPTables

**IPTables** Linux-en kernelari dagokion modulua da, eta firewall gisa jardutea ahalbidetzen du, makinatik sartu eta irteten diren datu-paketeak iragazteaz arduratzen baita. IPTables-ek egin nahi dugunaren arabera definitu beharreko arauen bidez funtzionatzen du. Lehenespenez, definitutako arauak ez dira iraunkorrak; hau da, sistema berrabiaraztean ezabatu egiten dira.

Arau berak behin eta berriz sartu behar ez izateko, fitxategi batean gorde daitezke honako komando honen bidez:

```bash
sudo iptables-save > /home/user/fitxategia
```

Makina berrabiarazi ondoren, honela berreskura daitezke:

```bash
sudo iptables-restore < /home/user/fitxategia
```

Arauen leheneratzea sistema berrabiarazten den bakoitzean automatikoki egitea nahi bagenu, makina abiaraztean exekutatuko litzatekeen script bat sor genezake, edo sarearen konfigurazioa aldatu, konexioak konfiguratzean IPTables-en arauak automatikoki leheneratu daitezen.

Defini itzazu ondorengoa lortzeko beharrezko arauak:

> Zure Google Cloud zerbitzariak SSH konexioak ikaskide baten Google Cloud zerbitzaritik eta zure makina lokaletik soilik onar ditzala.

> Instalatu FTP zerbitzu bat zure Google Cloud zerbitzarian, eta konfiguratu `ehu.eus` sareko makinetatik datozen FTP konexioak soilik onar ditzan.

> Zure Google Cloud zerbitzariak HTTP konexioak ez onartzea (HTTPS soilik).

> Zure makina lokaletik Twitter, Facebook edo YouTube-rako irteerako konexiorik ezin egitea.

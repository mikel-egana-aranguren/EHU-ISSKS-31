# Laborategia: Load balancer

## Aurreko baldintzak

- Google Cloud proiektua kreditu aktiboekin (ikus [Google Cloudeko urruneko zerbitzaria](../../Google_Cloud/Google_Cloud.md) laborategia).
- SSH gako publiko eta pribatuaren bikotea.

## Sarrera

Laborategi honek Compute Engine-ko hainbat instantziatan errepikatutako web zerbitzu bat zabaltzen du, baita haien artean eskaerak banatzen dituen HTTP karga-banatzaile bat ere:

- **Backend maila**: kudeatutako instantzia-talde bat (`Managed Instance Group`) bi Apache web zerbitzarirekin, bakoitzak bere host-izena erakusten duelarik.
- **Balantzeo maila**: IP publiko bakarra duen kanpoko HTTP(S) karga-banatzaile bat, instantzien osasuna egiaztatzen duena eta ongi erantzuten duten instantzietara soilik trafikoa bidaltzen duena.

Helburua erabilgarritasuna eta trafikoaren banaketa lantzea da, eta zerbitzuak instantzia bat huts egin arren funtzionatzen jarraitzen duela egiaztatzea.

## VPC sarea eta firewall araua sortu

Nabigazio-menuan joan `VPC network` > `VPC networks` > `Create VPC network`-era:

- Izena: `lb-vpc`.
- Azpisareen sorrera modua: `Custom`.
- Azpisare bat gehitu:
  - Izena: `lb-subnet`.
  - Eskualdea: Europa barruko eskualde bat.
  - IPv4 helbide-barrutia: `10.0.5.0/24`.

Sakatu `Done` `lb-subnet` atalean eta `Create` nagusian.

Joan `VPC network` > `Firewall` > `Create firewall rule`-era.

Erabiltzaileen eta karga-banatzailearen trafikorako araua:

- Izena: `lb-allow-web`.
- Sarea: `lb-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `lb-backend`.
- Jatorri-iragazkia: `IPv4 ranges`, `130.211.0.0/22` eta `35.191.0.0/16` barrutiak ([Google-ren karga-banatzailea eta osasun-egiaztapenak](https://docs.cloud.google.com/load-balancing/docs/firewall-rules#health-checks)).
- Protokoloak eta atakak: `TCP`, `80` ataka.

Administraziorako araua:

- Izena: `lb-allow-ssh`.
- Sarea: `lb-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `lb-backend`.
- Jatorri-iragazkia: `IPv4 ranges`, `0.0.0.0/0` barrutia.
- Protokoloak eta atakak: `TCP`, `22` ataka.

## Instantzia-txantiloia sortu

Joan `Compute Engine` > `Instance templates` > `Create instance template`-era.

- Izena: `lb-template`.
- Eskualdea: `europe-central2`.
- Seriea: `E2`, makina mota: `e2-micro`.
- `Boot disk`: sistema eragile gisa `Ubuntu 26.04 LTS Minimal`.
- `Firewall`: `Allow HTTP traffic`, `Allow HTTPS traffic`, `Allow load balancer health checks`.
- `Advanced options` > `Networking` atalean:
  - Sare-etiketa: gehitu `lb-backend`.
  - `Network interfaces` atalean, hautatu `lb-vpc` sarea eta `lb-subnet` azpisarea.
- `Advanced options` > `Security` > `Manage access` atalean: gehitu SSH gako publikoa (`Add manually generated SSH keys`).
- `Advanced options` > `Management` > `Automation` atalean: itsatsi hurrengo abiatze-script-a, Apache instalatzen duena eta instantziaren izena duen orrialde bat argitaratzen duena:

```bash
sudo apt-get update
sudo apt-get install -y apache2
echo "<h1>Servidor: $(hostname)</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart apache2
```

Sakatu `Create`.

## Kudeatutako instantzia-taldea sortu

`instance templates` zerrendan, sakatu `Actions` `lb-template`-n eta `Create instance group` (`New managed instance group (stateless)`):

- Izena: `lb-mig`.
- Instantzia-txantiloia: `lb-template`.
- Kokapena: `Europe central` (`lb-template`-ren berdina).
- Instantzia kopurua: `2` (autoeskalatzea desaktibatuta).
- `Port mapping`: izena `http`, ataka `80`.
- `Autohealing` > `Create a health check`:
  - Izena: `lb-health-check`.
  - Protokoloa: `HTTP`, ataka `80`, bidea `/`.

Sakatu `Create`. Itxaron bi instantziak exekutatzen hasi arte.

## Karga-banatzailea sortu

Joan `Network services` > `Load balancing` > `Create load balancer`-era:

- Mota: `Application Load Balancer (HTTP/HTTPS)`.
- Publikoa (`Public facing`)
- Globala.
- Izena: `lb-http`.

Konfigurazioa:

- `Frontend configuration`:
  - Izena: `lb-frontend`.
  - Protokoloa: `HTTP`, ataka `80`.
  - IP address: `Create IP address`, izena `lb-ip` (kanpoko IP estatikoa).
- `Backend configuration` > `Create a backend service`:
  - Izena: `lb-backend-service`.
  - Backend mota: `Instance group`.
  - Instantzia-taldea: `lb-mig`, ataka `80`.
  - Osasun-egiaztapena: `lb-health-check`.
- `Host and path rules`: utzi lehenetsitako arauak.

Sakatu `Create`. Karga-banatzailea abian jartzeak zenbait minutu behar izan ditzake.

## Karga-banatzailea probatu

Bisitatu `http://IP_LOAD_BALANCER` (`lb-ip` IPa) eta birkargatu orrialdea hainbat aldiz (edo exekutatu `for i in $(seq 1 20); do curl -s http://IP_LOAD_BALANCER; done`). Taldeko instantzia desberdinen izena agertu beharko litzateke.

## Akatsekiko tolerantzia probatu

1. SSH bidez konektatu instantzietako batera eta gelditu Apache: `sudo systemctl stop apache2`.
2. Segundo batzuen buruan osasun-egiaztapenak instantzia osasuntsu gabe gisa markatuko du (`Load balancing` > `lb-http` > `Backends`).
3. Berriro bisitatu `http://IP_LOAD_BALANCER`: erantzun guztiak geratzen den instantziatik datoz.
4. Berrabiarazi Apache (`sudo systemctl start apache2`) eta egiaztatu instantziak trafikoa jasotzen berriro hasten dela.

## Garbiketa

Kosturik ez izateko, ezabatu karga-banatzailea (`lb-http`), instantzia-taldea (`lb-mig`), txantiloia (`lb-template`), IP estatikoa (`lb-ip`), firewall arauak eta `lb-vpc` sarea.

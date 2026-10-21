# Laborategia: Alderantzizko proxy-a

## Aurreko baldintzak

- Google Cloud proiektua kreditu aktiboekin (ikus [Google Cloudeko urruneko zerbitzaria](../../Google_Cloud/Google_Cloud.md) laborategia).
- SSH gako publiko eta pribatuaren bikotea.

## Sarrera

Laborategi honek Squid bidez babestutako web zerbitzari bat zabaltzen du, alderantzizko proxy baten bidez, bi sare-maila bereizirekin:

- **Proxy maila**: Squid duen Compute Engine instantzia bat, internetetik SSH eta HTTP bidez eskuragarria. Sarbide-puntu bakarra da.
- **Backend maila**: Apache duen Compute Engine instantzia bat, kanpoko IP gabea, proxytik soilik eskuragarria.

Helburua alderantzizko proxy batek benetako zerbitzaria nola ezkutatzen eta babesten duen lantzea da, baita bere erantzunak cache-an nola gorde ditzakeen ere.

## VPC sarea eta azpisareak sortu

Nabigazio-menuan joan `VPC network` > `VPC networks` > `Create VPC network`-era:

- Izena: `proxy-vpc`.
- Azpisareen sorrera modua: `Custom`.
- Azpisare bat gehitu:
  - Izena: `proxy-subnet`.
  - Eskualdea: Europa barruko eskualde bat.
  - IPv4 helbide-barrutia: `10.0.1.0/24`.
- Bigarren azpisare bat gehitu:
  - Izena: `backend-subnet`.
  - Eskualdea: `proxy-subnet`-en berdina.
  - IPv4 helbide-barrutia: `10.0.2.0/24`.

Sakatu `Create`.

## Firewall arauak sortu

Joan `VPC network` > `Firewall` > `Create firewall rule`-era.

Proxy mailarentzako araua:

- Izena: `proxy-allow-web`.
- Sarea: `proxy-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `proxy-server`.
- Jatorri-iragazkia: `IPv4 ranges`, `0.0.0.0/0` barrutia.
- Protokoloak eta atakak: `TCP`, `22, 80` atakak.

Backend mailarentzako araua:

- Izena: `proxy-allow-backend`.
- Sarea: `proxy-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `backend-server`.
- Jatorri-iragazkia: `IPv4 ranges`, `10.0.1.0/24` barrutia (`proxy-subnet` azpisarea).
- Protokoloak eta atakak: `tcp`, `80` ataka.

Backend-a proxyaren bidez administratzeko araua (SSH):

- Izena: `proxy-allow-backend-ssh`.
- Sarea: `proxy-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `backend-server`.
- Jatorri-iragazkia: `IPv4 ranges`, `10.0.1.0/24` barrutia (`proxy-subnet` azpisarea).
- Protokoloak eta atakak: `tcp`, `22` ataka.

## Backendarentzako Cloud NAT sortu

Backendak ez du kanpoko IPrik, baina internetera atera behar du Apache instalatzeko. Joan `Network services` > `Cloud NAT` > `Get started`-era:

- Atebidearen izena: `backend-nat`.
- Sarea: `proxy-vpc`.
- Eskualdea: `backend-subnet`-en berdina.
- Cloud Router: `Create new router`, izena `backend-router`.

Sakatu `Create`.

## Backend zerbitzariaren instantzia sortu

Joan `Compute Engine` > `VM instances` > `Create instance`-era.

- Izena: `backend-web`.
- Eskualdea/zonea: `backend-subnet`-en berdina.
- Seriea: `E2`, makina mota: `e2-micro`.
- `OS and storage`: sistema eragile gisa `Ubuntu 26.04 LTS Minimal`.
- `Networking`:
  - Sare-etiketa: `backend-server`.
  - `Network interfaces` atalean, hautatu `proxy-vpc` sarea eta `backend-subnet` azpisarea.
  - IP barne nagusia: erreserbatu IP barne estatiko bat (`Reserve static internal IP address`) `10.0.2.10` helbidearekin.
  - Kanpoko IP: `None`.
- `Security` > `Manage access`: gehitu SSH gako publikoa (`Add manually generated SSH keys`).
- `Advanced options` > `Management` > `Automation`: itsatsi hurrengo abiatze-script-a:

```bash
sudo apt-get update
sudo apt-get install -y apache2
echo "<h1>Servidor backend: $(hostname)</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart apache2
```

Instantzia sortu. Itxaron abiatu arte.

## Alderantzizko proxy-aren instantzia sortu

Joan `Compute Engine` > `VM instances` > `Create instance`-era.

- Izena: `proxy-web`.
- Eskualdea/zonea: `proxy-subnet`-en berdina.
- Seriea: `E2`, makina mota: `e2-micro`.
- `OS and storage`: sistema eragile gisa `Ubuntu 26.04 LTS Minimal`.
- `Networking`:
  - Gaitu HTTP trafikoa (`Allow HTTP traffic`).
  - Sare-etiketa: `proxy-server`.
  - `Network interfaces` atalean, hautatu `proxy-vpc` sarea eta `proxy-subnet` azpisarea.
  - Erreserbatu kanpoko IP estatiko bat (`External IPv4 address` > `Reserve static external IP address`).
- `Security` > `Manage access`: gehitu SSH gako publikoa (`Add manually generated SSH keys`).
- `Advanced options` > `Management` > `Automation`: itsatsi hurrengo abiatze-script-a, Squid instalatzen duena eta `10.0.2.10` backendaren alderantzizko proxy gisa konfiguratzen duena:

```bash
sudo apt-get update
sudo apt-get install -y squid
sudo tee /etc/squid/squid.conf > /dev/null <<'CONF'
http_port 80 accel defaultsite=10.0.2.10 no-vhost
cache_peer 10.0.2.10 parent 80 0 no-query originserver name=backend
acl all_sites src all
http_access allow all_sites
cache_peer_access backend allow all_sites
cache_mem 64 MB
CONF
sudo systemctl restart squid
```

Instantzia sortu. Bisitatu `http://KANPO_IP_PROXYA` eta backend zerbitzariaren orrialdea agertu beharko litzateke, honek kanpoko IPrik ez duen arren.

## Alderantzizko proxy-a probatu

1. Makina lokaletik, egiaztatu Squid-ek gehitutako goiburuak eta cachea (errepikatu komandoa bi aldiz):

```bash
curl -I http://KANPO_IP_PROXYA
```

   `Via` eta `X-Cache` goiburuak agertu beharko lirateke. Lehen eskaeran `X-Cache: MISS`, eta ondorengoetan `X-Cache: HIT`, horrek adierazten du proxyak backendari kontsultatu gabe erantzuten diola.

2. Egiaztatu backend-a ezin dela zuzenean atzitu: ez du kanpoko IPrik, eta `curl http://10.0.2.10` `proxy-web`-etik soilik funtzionatzen du.
3. SSH bidez konektatu `proxy-web`-era eta kontsultatu Squid-en erregistroa: `sudo tail /var/log/squid/access.log`. Eskaerak `TCP_MISS` eta `TCP_HIT`/`TCP_MEM_HIT` etiketekin ikusiko dira.
4. `proxy-web`-etik, SSH bidez konektatu `backend-web`-era (`ssh ERABILTZAILEA@10.0.2.10`, agentearen birbidalketarekin `ssh -A`) eta kontsultatu `sudo tail /var/log/apache2/access.log`: proxyaren IPa (`10.0.1.x`) bakarrik agertzen da bezero gisa, eta cachean dauden eskaerak ez dira iristen.

## Garbiketa

Kosturik ez izateko, ezabatu bi instantziak, proxyaren IP estatikoa, `backend-nat` atebidea eta `backend-router` routerra, firewall arauak eta `proxy-vpc` sarea.

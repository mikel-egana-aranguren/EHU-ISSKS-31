# Laborategia: Azpisareak Google Cloud-en

## Aurreko baldintzak

- Google Cloud proiektua kreditu aktiboekin.
- SSH gako publikoa eta pribatua sortuta.

## Sarrera

Laborategi honek telefono-agenda web aplikazio txiki bat abiarazten du, bi sare-maila bereizita:

- **Web maila**: Compute Engine instantzia batekin Python Web aplikazio bat, internetetik SSH eta HTTP bidez eskuragarria.
- **Datu-base maila**: Cloud SQL instantzia (MySQL), soilik web mailatik sar daitekeena.

Helburua sare-segmentazioa lantzea da, VPC azpisareak eta firewall arauak erabiliz.

## VPC sarea eta azpisareak sortu

Nabigazio-menuan joan `VPC network` > `VPC networks` > `Create VPC network`:

- Izena: `phonebook-vpc`.
- Azpisareen sorrera modua: `Custom`.
- Azpisare bat gehitu:
  - Izena: `web-subnet`.
  - Eskualdea: Europa barruko eskualde bat.
  - IPv4 helbide-barrutia: `10.0.1.0/24`.
- Bigarren azpisarea gehitu:
  - Izena: `db-subnet`.
  - Eskualdea: `web-subnet`-en berdina.
  - IPv4 helbide-barrutia: `10.0.2.0/24`.

Sakatu `Create`.

## Firewall arauak sortu

Joan `VPC network` > `Firewall` > `Create firewall rule`.

Web mailarentzako araua:

- Izena: `phonebook-allow-web`.
- Sarea: `phonebook-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `http-server`.
- Jatorri-iragazkia: `IPv4 ranges`, `0.0.0.0/0` barrutia.
- Protokoloak eta atakak: `TCP`, `22, 80` atakak.

Datu-base mailarentzako araua:

- Izena: `phonebook-allow-db`.
- Sarea: `phonebook-vpc`.
- Trafiko norabidea: `Ingress`.
- Helburuak: `Specified target tags`, etiketa `db-server`.
- Jatorri-iragazkia: `IPv4 ranges`, `10.0.1.0/24` barrutia (`web-subnet` azpisarea).
- Protokoloak eta atakak: `tcp`, `3306` ataka.

## Web zerbitzari instantzia sortu

Joan `Compute Engine` > `VM instances` > `Create instance`.

- Izena: `phonebook-web`.
- Eskualdea/zonea: `web-subnet`-en berdina.
- Seriea: `E2`, makina mota: `e2-micro`.
- `OS and storage`: sistema eragile gisa `Ubuntu 26.04 LTS Minimal`.
- `Networking`:
  - Gaitu HTTP trafikoa (`Allow HTTP traffic`).
  - `Network interfaces` atalean, hautatu `phonebook-vpc` sarea eta `web-subnet` azpisarea.
  - Eman kanpoko IP estatiko bat (`External IPv4 address` > `Reserve static external IP address`).
- `Security` > `Manage access`: gehitu SSH gako publikoa (`Add manually generated SSH keys`).
- `Advanced options` > `Management` > `Automation`: itsatsi hurrengo abiatze-script-a aplikazioa automatikoki instalatu eta konfiguratzeko:

```bash
sudo apt-get update
sudo apt-get install -y apache2 python3-pymysql
sudo a2enmod cgid
systemctl restart apache2
cd /usr/lib/cgi-bin/
wget https://raw.githubusercontent.com/mikel-egana-aranguren/EHU-SGSSI-01/refs/heads/develop/Laboratorios/Seguridad_red/vpc-google-cloud/index.py
sudo chmod +x index.py
sudo chown www-data:www-data index.py
```

Instantzia sortu. Bisitatu `http://KANPO_IP_WEB_ZERBITZARIA/cgi-bin/index.py` eta errore hau agertu beharko litzateke, DBra ezin delako konektatu: `Database error: (2003, "Can't connect to MySQL server on 'DB_PRIVATE_IP' ([Errno -3] Temporary failure in name resolution)")`


## Datu-basea sortu (Cloud SQL)

Joan `Cloud SQL` > `Instances` > `Create free instance` (30 eguneko Cloud SQL doakoa) > `MySQL`:

- Database Engine: `MySQL`.
- Instance ID: `phonebook-db`.
- `root` erabiltzailearen pasahitza.
- Datu-base bertsioa: `MySQL 8.0`.
- Eskualdea: `db-subnet`-en berdina.

Instantzia editatu:
- `Connections`:
  - Desaktibatu `Public IP`.
  - Gaitu `Private IP` eta hautatu `phonebook-vpc` sarea. Eskatzen badu, jarraitu laguntzaileari IP barruti bat erreserbatzeko eta pribatuko zerbitzuetarako sarbidea gaitzeko (`Service Networking API`).

Gorde.

- `Databases` fitxa > `Create database`: `mydb` izena.
- `Users` fitxa > `Add user account`: `admin` erabiltzailea pasahitz batekin.

## Web zerbitzaria datu-basera konektatu

Konexioa egin `phonebook-web`-era SSH bidez eta editatu aplikazioaren konfigurazio-fitxategia datu-basearen konexio-datuak sartzeko (Cloud SQL instantziaren IP pribatua, datu-basearen izena, aurreko urratsean sortutako erabiltzailea eta pasahitza):

```
HOSTNAME = "DB_PRIVATE_IP"
USERNAME = "admin"
PASSWORD = "DB_PASSWORD"
DATABASE = "mydb"
```

## Aplikazioa probatu

Bisitatu `http://KANPO_IP_WEB_ZERBITZARIA/cgi-bin/index.py`. Agenda datuak agertu beharko lirateke.




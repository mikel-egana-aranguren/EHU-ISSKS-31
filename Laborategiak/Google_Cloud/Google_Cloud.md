# Laborategia: Google Cloudeko urruneko zerbitzaria

## Beharrezkoa

- Kode-editorea. Visual Studio Code-n, `ctrl+mayus+v` sakatuta fitxategi hau modu erosoan bistaratzen da (batez ere irudietarako).
- Bi posta-kontu:
  - Unibertsitateko posta (@ehu.eus, @ikasle.ehu.eus), Google Cloud kredituak lortzeko.
  - Gmail kontu berri bat (adibidez, nire_izena_issks_26_27@gmail.com), ikasturtean zehar Google Cloud zerbitzua erabiltzeko.
- SSH gako publiko/pribatu bikotea (GitHuberako bera erabil daiteke edo berri bat sortu).

## Sarrera

[Google Cloud](https://cloud.google.com/) Googlek eskaintzen duen hodeiko konputazio plataforma da. [Hezkuntzarako](https://cloud.google.com/billing/docs/how-to/edu-grants) kreditu doakoak eskaintzen ditu; kreditu horiek erabiliko ditugu zerbitzari bat sortu eta harekin lan egiteko, SSH bidez konektatuz.

<img src="Local-remoto.png" width="600" />

<img src="SSH-TOFU.png" width="600" />

## Kreditua lortu eta proiektu bat sortu

Ikasturterako sortutako kontuaren Gmail-era sartu (**GARRANTZITSUA**: ez da egon behar beste Gmail kontu batekin irekita dagoen beste fitxarik). Beste fitxa berri batean, sartu [Google Cloud Console](https://console.cloud.google.com) atarian:

<img src="GoogleCloudConsole_no_project.png" alt="Google Cloud Console no project" width="600">

(**GARRANTZITSUA**: ez sakatu 300$-eko kredituen gainean).

Sakatu `Select a project` eta gero `New project`:

<img src="GoogleCloudConsole_select_project_new_project.png" alt="Google Cloud Console select project new project" width="600">

Sortu proiektu bat, adibidez "ISSKS-26-27", eta hautatu; sakatu `Select a project` eta gero `ISSKS-26-27`:

<img src="GoogleCloudConsole_select_project_sgssi_26_27.png" alt="Google Cloud Console select project SGSSI-26-27" width="600">

Ireki beste fitxa bat eta itsatsi eGelan dagoen URLa, `Google Cloud kredituak` atalean (`Oinarrizko laborategiak` atalaren azpian); honelako orri bat agertu beharko litzateke:

<img src="GoogleCloudConsole_credits.png" alt="Google Cloud Console credits" width="600">

Bertan izena-abizenak eta EHUko posta-helbidea sartu (ez Gmail, ez beste edozein). **GARRANTZITSUA**: `Submit` sakatu ondoren, ez berriro sakatu; denbora pixka bat behar izan dezake. EHUko postan hurrengo urratsekin baieztapena jasoko duzu. Kredituak lortutakoan, `Google Cloud`; menu burger (hiru lerro); `Billing`; `Credits` atalean honelako zerbait agertu beharko litzateke (ziurrenik 100 beharrean 50ekin):

<img src="GoogleCloudConsole_credits_100.png" alt="Google Cloud Console credits 100" width="600">

**GARRANTZITSUA**: baliteke sortutako proiektua eskuratu berri den kreditu-kontuarekin lotu behar izatea.

## Zerbitzaria sortu

Behin orri nagusian zaudela, sakatu `Compute Engine` eta gero `Instancias de VM` (beharrezkoa bada, gaitu Compute Engine API).

<img src="GoogleCloudConsole_compute_engine_API.png" alt="Google Cloud Console Compute Engine API" width="600">

Sakatu `Create instance` eta honen antzeko pantaila bat agertuko da:

<img src="ComputeEngine_MachineConfiguration.png" alt="Compute Engine Machine Configuration" width="600">

Aukera garrantzitsuak:

- Izena: edozein, baina erraz identifikatzeko modukoa; adibidez, “issks-labo”.
- Aukeratu Europa barruko eskualde bat.
- Erabilera orokorrekoa.
- Seriea: E2.
- Makina mota: e2-small.

Joan `OS and storage` atalera:

<img src="ComputeEngine_OS.png" alt="Compute Engine OS and Storage" width="600">

Aukeratu `Ubuntu 26.04 LTS Minimal` eta `Standard persistent disk`.

Joan `Data protection` atalera eta aukeratu `No backup`:

<img src="ComputeEngine_data_protection.png" alt="Compute Engine Data Protection" width="600">

Joan `Networking` atalera eta aktibatu HTTP, HTTPS eta karga-orekatzaileko trafikoa:

<img src="ComputeEngine_http-server.png" alt="Compute Engine http-server" width="600">

`Networking` barruan, sakatu `Default` `Network interfaces` atalean:

<img src="ComputeEngine_network_interfaces_default.png" alt="Compute Engine Network Interfaces Default" width="600">

Sakatu `External IPv4 address - Ephemeral` eta gero `Reserve static external IP address`, IP estatiko bat erreserbatzeko:

<img src="ComputeEngine_network_ephemeral.png" alt="Compute Engine Network Ephemeral" width="600">

`Security` atalean, sakatu `Manage access`:

<img src="ComputeEngine_manage_access.png" alt="Compute Engine manage access" width="600">

Sakatu `Add manually generated SSH keys - add item` eta itsatsi SSH gako publikoa (ordenagailu lokaletik kopiatu `cat` erabiliz):

<img src="ComputeEngine_add_keys.png" alt="Compute Engine add keys" width="600">

**GARRANTZITSUA**: Google Cloudek instantzian erabiltzaile berri bat sortzen du, gako publikoko erabiltzaile-izen berarekin, `ssh./authorized_keys` fitxategiarekin.

Sortu instantzia aipatutako aukera guztiekin. Une batzuk igaro ondoren, honela agertu beharko litzateke:

<img src="ComputeEngine_instancia.png" alt="Compute Engine Instancia" width="600">

## SSH sarbidea

Sarbidea ziurtatzeko, egin SSH konexioa ordenagailu lokaletik kanpoko IPra, terminal lokalean (Google Cloud web interfazeko SSH botoia erabili gabe):

```bash
$ ssh KANPO_IP_GOOGLE_CLOUD
```
**GARRANTZITSUA**: SSHk erabiltzailerik gabe funtzionatzen du, baldin eta gehitutako erabiltzailea uneko terminaleko bera bada.

`.ssh/authorized_keys` fitxategia begiratzean, zuen gako publikoa agertuko da, Googlek gehituta.

Irakasleari sarbidea emateko, sortu `bgpegarm` erabiltzailea, `sudoer` taldean eta eGelan dagoen pasahitzarekin. Gehitu eGelan eskuragarri dagoen irakaslearen gako publikoa erabiltzaile horren `home` direktorioan, `.ssh/authorized_keys` fitxategian. Bidali kanpoko IPa (IPa bakarrik, testu lau gisa) eGelako entregan, irakasleak konekta daitekeela egiaztatzeko.

**GARRANTZITSUA**: azterketan ezin da ordenagailu eramangarri pribatua erabili, eta laborategiko edozein ordenagailu erabiliko da; beraz, azterketan ikaslea gai izan behar da SSH gako berriak sortzeko edo gordetako SSH gakoak berrerabiltzeko.

**GARRANTZITSUA**: instantzia erabilera bakoitzaren ondoren itzali. Ikasle bakoitzaren ardura da azterketarako nahikoa Google Cloud kreditu izatea.

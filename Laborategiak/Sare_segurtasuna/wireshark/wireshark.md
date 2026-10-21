# Laborategia: Sarea segurtasuna

## Aurreko baldintzak

- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialekin sartu).
- Kode-editorea. Visual Studio Code-n, ctrl+maius+v sakatuz fitxategi hau testu erraz batean bistaratzen da (batez ere irudietarako).
- Ikasgaiaren GitHub biltegia: laborategian garatutako programak igo ahal dituzu.
- Google Cloud kontua.

## Sareko trafikoa WireShark erabiliz kapturatzea

[WireShark](https://www.wireshark.org) host jakin baten sarrerako eta irteerako trafikoa ikusteko Sniffer-a da. Instalatzeko, Wireshark webgunean "Download Now", "Stable release 4.6.9" eta ondoren "Ubuntu" aukeratu, eta jarraitu instrukzioak:

```bash
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update
sudo apt install wireshark
```

Segurtasun galderari "Bai" erantzun behar zaio. Bestela:

```bash
sudo dpkg-reconfigure wireshark-common
sudo usermod -aG wireshark $USER
```

Eta berriro hasi saioa erabiltzaile horrekin.

Sare-interfazea lokalizatu:

```bash
ip -br a
```

`lo` loopback interfazea da, hau da, localhost bere buruarekin konektatzea. Normalean interfaze aktiboak `UP` gisa agertzen dira. WireShark-en interfazea aukeratu eta "capture" sakatu.

Nabigatzailean webgune bat ireki, adibidez `https://phrack.org/issues/72/linenoise_md#article`. Kaptura gelditu eta HTTP bidez filtratu lehen GET eskaera bilatzeko.

> Zer protokolo erabiltzen dira? Mezuaren zein bit-ek bat egiten dute bakoitzarekin?
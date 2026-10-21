# Laborategia: NMAP

## Aurreko baldintzak

- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu; beharrezkoa bada, `lsi` erabiltzailea soilik, `su - lsi` komandoaren bidez).
- Kode-editorea. Visual Studio Code-n, ctrl+maius+v sakatuz fitxategi hau testu erraz batean bistaratzen da (batez ere irudietarako).
- Ikasgaiaren GitHub biltegia: laborategian garatutako programak igo ahal dituzu.
- Google Cloud kontua.

## NMap

[Nmap](https://nmap.org/) sareko portuak eta makinak arakatzeko balio duen kode irekiko programa bat da (ziurrenik filmetan gehien agertzen den hacking tresna da: [https://nmap.org/movies/](https://nmap.org/movies/)). Nmap-ekin erraz aurki daitezke sarean ikusgai dauden makinen hainbat ezaugarri: zein makina dauden piztuta, makina jakin batek zein portu dituen irekita, zein zerbitzu exekutatzen ari den eta zein bertsio darabilten, zein sistema eragile eta zein bertsio erabiltzen duen, etab.

Instalatu NMap:

```bash
sudo apt install nmap
```

Deskribatu ondorengoa aurkitzeko beharrezko komandoak:

> Zein portu daude irekita `scanme.nmap.org`-en eta zure Google Cloud zerbitzarian, zein zerbitzu eta zerbitzu horien zein bertsio?

> Zein makina daude aktibo sarean, zure makinatik zure urruneko zerbitzarira? (Pista: `traceroute`).

> Zein portu ditu irekita sareko makina aktiboetako batek?

> Zerbitzuen zein bertsio erabiltzen ari da sareko makina aktiboetako bat?

> Zein sistema eragile du sareko makina aktiboetako batek?

> Zein sistema eragile du zure Google Cloud zerbitzariak (NMap-en arabera)?

> Zein sistema eragile du `scanme.nmap.org`-ek?

> Behin sistema eragilea zehaztuta, zein ahultasun ditu? (Pista: [https://cve.mitre.org](https://cve.mitre.org/)).

> Nola erabil daiteke NMap makina batek firewall bat duen detektatzeko?

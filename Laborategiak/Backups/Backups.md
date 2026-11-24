# Laborategia: Segurtasun kopiak

### Aurretiko baldintzak

- GNU/Linux makina: ordenagailu eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu; `lsi` erabiltzailea soilik erabili beharrezkoa bada, `su - lsi` komandoaren bidez).
- Kode-editorea. Visual Studio Code-n, `Ctrl+Shift+V` sakatuz fitxategi hau modu atseginean bistaratzen da (batez ere irudientzat).
- Irakasgaiaren GitHub biltegia: laborategian garatutako programak igo ditzakezu.

## UNIX segurtasun-kopiak

* Sortu  `Segur` izeneko karpeta, eta bere barnean `a`, `b`, `c`, `d` eta `e` izeneko 5 artxibo. Fitxategi bakoitzak nahi duzuen edukia izan dezake (adib. `$ echo "A" > A`).

`rsync` tresna erabiliko dugu segurtasun-kopiak egiteko. Rsync oso ohikoa den UNIX tresna da eta Linux banaketa gehienetan dago. Horretarako, gure `Segur` karpetaren segurtasun-kopia osoa eginez hasiko gara, eta hortik aurrera segurtasun-kopia inkrementalak egingo ditugu.

* Sortu `Backups` izeneko karpeta `/var/tmp` karpetan.

Exekutatu honako komandoa (`user` dagokion erabiltzaileagatik ordeztu): `$ rsync -av /home/user/Segur /var/tmp/Backups`

> Zer egiten du zehazki komando horrek? Zer esan nahi dute erabili dituzun `a` eta `v` aukerek? (`$ info rsync`)

* Exekutatu berriro komandoa, baina oraingoan slash batekin (“/”) lehen argumentuaren amaieran: `$ rsync -av /home/usuario/Segur/ /var/tmp/Backups`

> Zein diferentzia dago slash gabeko komandoarekin alderatuta?

* Aldatu `Segur` karpetako `a` eta `b` artxiboen edukia, eta sortu `f` izeneko artxibo berri bat.
* Sortu `Backups` karpetaren barruan, uneko data aaaa-mm-dd formatuan duen karpeta bat.
* Sortu `Backups` karpetaren barruan `SegurLinkDest` izeneko karpeta bat.
* Kokatu terminalaren bidez `Segur` karpetan.
* Exekutatu honako komandoa, “gaurkodata” adierazitako formatuan dagokion dataz ordeztuz: `$ rsync -av --link-dest=/var/tmp/Backups/SegurLinkDest . /var/tmp/Backups/gaurkodata`

> Zer egiten du zehazki komando horrek? Zer agertzen da uneko dataren direktorioan? Zer esan nahi dute komandoan erabiltzen diren “/var/tmp/Backups/SegurLinkDest”, “.” eta “/var/tmp/Backups/gaurkodata” parametroek?

* `Segur` direktorioan ezabatu `c` artxiboa, gehitu aldaketak `a` eta `e` fitxategiei, eta sortu `g` izeneko artxibo bat (`$ echo "G" > G`).
* Denboraren igarotzea simulatuko dugu. Sortu `Backups` karpetaren barruan, biharko data aaaa-mm-dd formatuan duen karpeta bat.
* Kokatu terminalaren bidez `Segur` direktorioan eta exekutatu honako komandoa, “biharkodata” adierazitako formatuan dagokion dataz ordeztuz: `$ rsync -av --link-dest=/var/tmp/Backups/gaurkodata . /var/tmp/Backups/biharkodata`.

> Zer dago biharko dataren direktorioan? Zer gertatu da eta zergatik?

* Aldatu `g` artxiboaren edukia.

> Zein komando beharko litzateke `Backups/etzidata` karpetan, aurreko segurtasun-kopiatik (biharko data duenetik) aldatutako fitxategiarekin bakarrik, segurtasun-kopia bat egiteko?

* Ezabatu `Segur` karpetaren eduki osoa.

> Zein komando dira beharrezkoak eduki osoa berreskuratzeko azken aurreko segurtasun-kopiatik abiatuta (biharko data duenetik)?

* Exekutatu honako komandoa `Backups` karpetako hainbat karpetatan: `$ ls -ali /var/tmp/Backups/biharkodata`

> Bi zenbaki garrantzitsu kontuan hartu behar dira: (1) Baimenen aurretik, digitu asko dituen zenbakia, adibidez 1150561; (2) Baimenen ondoren, zenbaki txiki bat, beti 1 edo handiagoa (1, 2, edo 3 kasu honetan). Zer esan nahi dute? Zer erabilgarritasun izan dezakete segurtasun-kopiak egiterakoan?

## Zereginen automatizazioa

* Sortu Cron script bat, egunero eguerdiko 12etan `Segur` karpetaren segurtasun-kopia inkremental bat egiten duena. Kopia bakoitza karpeta ezberdin batean egin beharko da, eta karpetaren izena dagokion kopia egin zen eguneko data izango da.

Cron-ekin lan egitean, Cron-ek exekutatu behar duen komandoa oso luzea bada edo zeregina aldi berean hainbat komandoz osatuta badago, oso ohikoa da Shell Script bat sortzea, eta hori da Cron-ek exekutatzen duena.

## Urruneko segurtasun-kopiak

Babestu nahi dugun informazioa dagoen makina berean segurtasun-kopiak egitea ez da ideia ona. Onena urruneko makina batean kopiak egitea da: erabili Google Cloud-eko urruneko makina bertan segurtasun-kopiak egiteko, SSH protokoloaren bidez. Birsortu rsync-ari buruzko lehen ataleko ariketak, baina egin segurtasun-kopiak Google Cloud-eko urruneko zerbitzarian SSH bidez.

> Zertan aldatzen da rsync komandoa SSH gainean? 

> Nolakoa da cp komandoaren bertsioa SSH gainean?

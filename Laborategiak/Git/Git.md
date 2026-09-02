# Laborategia: Git

## Beharrezkoa

- Kode-editorea. Visual Studio Code-n, `ctrl+mayus+v` sakatuta fitxategi hau modu erosoan bistaratzen da (batez ere irudietarako).
- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu).
- Beharrezko tresnak: `git`.

## Git

Git Linus Torvalds-ek (Linux-en sortzaileak) garatutako bertsio-kontrol sistema banatua da, oso hedatua, eta ikasgaiko hainbat ataletan erabiliko duguna. Haren oinarrizko elementuak:

- Biltegia (Repoa): edukiaren biltegia (normalean kode-fitxategiak). Karpeta bat da, `.git` izeneko karpeta ezkutua duena.
- Fork: biltegi oso baten kopia independentea.
- Urrunekoa (Remote): biltegia lokala (gure ordenagailu fisikoan) edo urrunekoa izan daiteke (adibidez, GitHub-en). Bi instantziak `pull`/`push` bidez sinkroniza daitezke.
- Commit: biltegi bat karpeta baten historiaren "grabazioa" da (gehitutako, ezabatutako edo aldatutako elementuak). Commit bat historia horretako une jakin bat da.
- Adarra: historia espezifiko bat. Biltegi batek hainbat adar izan ditzake, bakoitzak historia desberdin bat adieraziz ("unibertso paralelo" bat). Adarrak elkarren artean sinkronizatzen dira `merge` erabilita.

## GitHub-era sarbidea

Irakasgai honetan Git-ekin lan egiteko, unibertsitateko emailarekin [GitHub](https://github.com/) kontu doakoa sortu behar duzue.

GitHub-eko biltegietara sartzeko bi modu daude: HTTP(S) edo SSH bidez. SSH askoz seguruagoa da, ez delako erabiltzaile/pasahitzik erabili behar, eta gainera GitHubek lehenesten du `push` egin ahal izateko. SSH sarbidea konfiguratzeko, jarraitu [argibideak](https://docs.github.com/en/authentication/connecting-to-github-with-ssh). SSH gako bera beste laborategi batzuetan ere erabiliko duzue, adibidez Google Cloud-eko urruneko zerbitzarira konektatzeko; beraz, gorde ondo.

## Biltegia

Sortu GitHub-en **publikoa** den biltegi bat, "sgssi-26-27-izena-ikaslea" eredua jarraituta (izena normalizatuta egon behar da; adibidez, "Mikel Egaña Aranguren" -> "mikel-egana-aranguren", hau da, "sgssi-26-27-mikel-egana-aranguren"). Biltegi hau laborategiko ariketa batzuetarako eta azterketarako erabiliko da.

Sortu berri duzuen biltegia klonatu `git clone git@github.com:...` erabiliz (SSH bidez). Aldatu terminala klonatu berri den biltegiaren karpetara.

Aldaketak egin. Gehitu Staging area-ra:

```bash
$ git add ...
```

Sortu commit bat (aldaketak biltegi lokalean gehitu):

```bash
$ git commit ...
```

Igo aldaketak urrunekora:

```bash
$ git push
```

Aldatu lehendik dagoen adar batera:

```bash
$ git checkout adarra
```

Aldatu adar berri batera (adarra sortu):

```bash
$ git checkout -b adar_berria
```

Adarrak batu (target adarrean, hau da, aldaketak jasoko dituen adarrean):

```bash
$ git merge adarra
```

## Klaseko apunteak eskuratu eta aldatu

Lehen aldiz repoa SSH bidez klonatzeko:

```bash
$ git clone git@github.com:mikel-egana-aranguren/EHU-ISSKS-31.git
```
(Edukia karpeta bakoitzaren barruan dago, PDF edo HTML formatuan).

Edukia eguneratzeko (maiz aldatzen da):

```bash
$ cd EHU-ISSKS-31
$ git pull
```

Apunteek akatsak izan ditzaketenez, ikasleek zuzen ditzakete eta, zuzenketa egokia bada, partzial horren notan 0,5 puntu lor ditzakete.

Akats bat zuzentzeko:
- GitHub-eko webgunean, [apunteen biltegitik](https://github.com/mikel-egana-aranguren/EHU-ISSKS-31) abiatuta fork bat lortu.
- Fork-a klonatu (ez jatorrizkoa).
- Zuzenketa **develop** adarrean egin eta fork-era igo.
- [Pull request](https://github.com/mikel-egana-aranguren/EHU-ISSKS-31/pulls?q=is%3Apr+is%3Aclosed) bat sortu.

## Informazio gehiago

"La he liado parda" esamoldeak egoera nahiko arrunta deskribatzen du:
- [La he liado parda](https://www.youtube.com/watch?v=QNTZbJSQVis).
- [La he liado parda - Git bertsioa](https://vimeo.com/82408340).

Software carpentry - [Version Control with Git](https://swcarpentry.github.io/git-novice/).

[Git](https://git-scm.com/).

[GitFlow](https://nvie.com/posts/a-successful-git-branching-model/).

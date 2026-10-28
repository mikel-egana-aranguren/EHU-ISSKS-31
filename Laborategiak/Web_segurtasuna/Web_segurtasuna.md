# Laborategia: Pen-testing-a

## Aurretiazko eskakizunak

- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu; `lsi` erabiltzailea beharrezkoa bada bakarrik erabili, `su - lsi` komandoaren bidez).
- Kode-editorea. Visual Studio Code-n, `Ctrl + Shift + V` sakatuta fitxategi hau modu atseginean bistaratuko da (bereziki irudietarako).
- Irakasgaiaren GitHub biltegia: laborategian garatutako programak bertara igo ditzakezu.

## Pen-testing-a ZAP eta Mutillidae erabiliz

Pen-testing-a web sistemetan ahultasunak bilatzeko prozesua da. Horretarako, web aplikazio zaurgarri bat (Mutillidae) eta ahultasunen eskaner bat (ZAP) erabiliko ditugu.

## Mutillidae martxan jartzea

Klonatu Mutillidae biltegia:

```bash
git clone https://github.com/webpwnized/mutillidae-dockerhub
```

Abiarazi proiektua `mutillidae-dockerhub` karpetaren barruan:

```bash
docker compose up
```

Joan helbide honetara: http://localhost:80

"Database not set" bezalako errore bat agertzen bada, sakatu **"Set up database"** botoia.

## ZAP instalatzea

Joan helbide honetara: https://www.zaproxy.org/download/

Deskargatu **Linux package** fitxategia eta deskonprimatu. Dagokion karpetan, exekutatu ZAP:

```bash
./zap.sh
```

Aukeratu:

1. **Eskaneatze automatikoa**.
2. Helburua: `http://localhost:80`
3. **Erasotu**.

Eskaneatze automatikoa amaitutakoan:

> Zer ahultasun aurkitu dituzu? Zein CVE edo CWErekin lotu daitezke?

> Saiatu eskaneoa irakasleak emandako Google Cloud IP helbidean egiten. Ahultasun berberak aurkitu dituzu?

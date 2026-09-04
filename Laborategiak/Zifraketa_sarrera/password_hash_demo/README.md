# Demoa: pasahitzak testu lauan, hash eta gatza

Proiektu honek web-aplikazioaren hiru bertsio berdin erakusten ditu, pasahitzak nola gordetzen diren alderatzeko.

## Sartutako zerbitzuak

- `plain`: pasahitza testu lauan gordetzen du.
- `hashed`: pasahitzaren SHA-256 laburpena gordetzen du.
- `salted`: ausazko gatza eta PBKDF2-HMAC-SHA256 algoritmoarekin laburtutako pasahitza gordetzen du.

## Abioa

```bash
cd password_hash_demo
docker compose up --build
```

Ondoren ireki:

- http://localhost:5001/  -> bertsio ez-segura
- http://localhost:5002/  -> hasharekin bertsioa
- http://localhost:5003/  -> gatza duen bertsioa

## Nola erabili

1. Erregistratu erabiltzaile bat pasahitz berdinarekin bertsio bakoitzean.
2. Begiratu datu-basea edo nabigatzaileko erabiltzaileen ikuspegia.
3. Egiaztatu:
   - `plain` bertsioan, pasahitza jatorrizko moduan ikusten da.
   - `hashed` bertsioan, pasahitz bera duen erabiltzaile guztientzat hash berdina dago.
   - `salted` bertsioan, erabiltzaile bakoitzak gatza desberdina du eta hash-a aldatzen da pasahitz bera ere badago.

## Funtsezko kontzeptuak

- Gatzarik gabe: pasahitz bera duten bi erabiltzailek hash berdina partekatzen dute.
- Gatzarekin: pasahitz bera erabiltzean hash desberdinak sortzen dira erabiltzaile bakoitzak balio ausazko bat erabiltzen duelako.
- Testu lauan gordetzea ahula da eta beti saihestu behar da.

## Garbiketa

```bash
docker compose down -v
```

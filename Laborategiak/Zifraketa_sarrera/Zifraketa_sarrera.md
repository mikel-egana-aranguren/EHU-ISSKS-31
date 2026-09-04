# Laborategia: Enkriptazioaren sarrera, esteganografia eta laburpen algoritmoak

## Aurrez aurreko baldintzak

- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialekin sartu).
- Kode-editorea. Visual Studio Code-n, `ctrl+shift+v` sakatuta fitxategi hau modu erosoan ikusten da (batez ere irudietarako).
- Beharrezko tresnak: `openssl`, `sha512sum`, `git`, `steghide`, `docker`, `docker compose`.

## Esteganografia praktikoa

Bloke honetan mezu bat ezkutatuko dugu edukiontzi-irudi baten barruan.

`steghide` instalatuta ez badago:

```bash
sudo apt update
sudo apt install steghide -y
```

Mezua prestatu:

```bash
echo "SGSSI-26-27 Software is like sex: it's better when it's free" > msg_linus
```

Mezua pasahitzarekin txertatu `linus.jpg` irudian:

```bash
steghide embed -cf linus.jpg -ef msg_linus -sf linus_steg.jpg
```

Ezkutuko mezua erauztea (lehenik jatorrizko mezua `msg_linus_old` izenera berrizendatu):

```bash
steghide extract -sf linus_steg.jpg
less msg_linus
```

Edukiontziaren tamaina:

```bash
ls -lh linus.jpg linus_steg.jpg
```

## Osotasuna hash funtzioekin

Laburpenen kalkulua:

```bash
echo "Osotasuna" > osotasuna.txt
md5sum osotasuna.txt
sha256sum osotasuna.txt
```

Aldatu karaktere bakar bat eta berriro kalkulatu laburpenak. Nola aldatu dira?

## Osotasuna eta esteganografia

Alderatu esteganografian erabilitako mezuen hash-ak:

```bash
sha256sum msg_linus
sha256sum msg_linus_old
```

Bat datoz?

Alderatu edukiontzi-fitxategien hash-ak:

```bash
sha256sum linus.jpg
sha256sum linus_steg.jpg
```

Bat datoz?

Buenaventura Durrutiren mezu garrantzitsu bat dago zuentzat `durruti` karpetako irudietako batean. Mezua `steghide` programaren bidez sartu da, "durruti" pasahitzarekin. Irudia, mezuarekin bat datorren Hash (SHA256): `7d573924d70a604cb56122aed9bded3f40d3083d8adc353a97c0b816c0e573bb`. Zein fitxategi da? Zer dio esaldiak? Nola automatizatuko zenuke bilaketa fitxategi asko izango bazenitu karpetetan eta azpikarpetetan?

## Pasahitzak eta gatza

Exekutatu:

```bash
echo -n "PasahitzSegurua" | sha256sum
echo -n "PasahitzSegurua" | sha256sum
```

Ikusi emaitza berdina dela.

OpenSSL-rekin gatzaren erabilera:

```bash
openssl passwd -6 -salt SAL001 PasahitzSegurua
openssl passwd -6 -salt SAL002 PasahitzSegurua
```

Hash-ak aldatzen dira?

Karpetan `password_hash_demo` aplikazio web txiki bat dago hiru bertsio berberarekin:

- `plain`: pasahitza testu arruntean gordetzen du.
- `hashed`: pasahitzaren SHA-256 hash bat gordetzen du.
- `salted`: ausazko gatza eta PBKDF2-HMAC-SHA256 hash bat gordetzen du.

Hura exekutatzeko:

```bash
cd password_hash_demo
docker compose up --build
```

Ondoren ireki:

- http://localhost:5001/ -> bertsio ez-segura (testu laua)
- http://localhost:5002/ -> hasharekin bertsioa
- http://localhost:5003/ -> gatza duen bertsioa

Erregistratu erabiltzaile eta pasahitz berdina hiru bertsioetan eta alderatu datu-basea edo zerbitzuko informazioa. Begiratu:

- Testu lauan pasahitza jatorrizkoa ikus daiteke;
- Hasharekin, pasahitz bera erabiltzaile guztientzat hash balio berdina sortzen da;
- Gatzarekin, erabiltzaile bakoitzak gatza desberdina du, beraz pasahitz berdinak ez dute gordetako balio bera sortzen.

Deskargatu proiektua zure Google Cloud zerbitzarian eta egiaztatu funtzionatzen duela, eta gatza zenbaki definitu batez alda daitekeela.

## Hash-ak eta Git

Klonatu, oraindik egin ez baduzu, irakasgaiaren biltegia (SSH erabiliz):

```bash
git clone git@github.com:mikel-egana-aranguren/EHU-SGSSI-01.git
cd cd EHU-SGSSI-01/
git log
```

Zerk identifikatzen du commit-aren hash-a? Zergatik detektatzen ditu Git-ek eduki-aldaketak modu eraginkorrean?

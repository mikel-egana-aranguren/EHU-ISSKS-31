# Laborategia: Zifraketaren sarrera, esteganografia eta laburpen algoritmoak

## Beharrezkoa

- GNU/Linux makina: eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu).
- Kode-editorea. Visual Studio Code-n, `ctrl+mayus+v` sakatuta fitxategi hau modu erosoan ikusten da (batez ere irudietarako).
- Beharrezko tresnak: `openssl`, `sha512sum`, `git`, `steghide`.

## Esteganografia praktikoa

Bloke honetan mezu bat ezkutatuko dugu irudi edukitzaile baten barruan.

`steghide` instalatuta ez badago:

```bash
sudo apt update
sudo apt install steghide -y
```

Mezua prestatu:

```bash
echo "ISSKS-26-27 Software is like sex: it's better when it's free" > msg_linus
```

Mezua pasahitzarekin txertatu `linus.jpg` irudian:

```bash
steghide embed -cf linus.jpg -ef msg_linus -sf linus_steg.jpg
```

Ezkutuko mezua erauztea (lehenik jatorrizko mezu fitxategia `msg_linus_old` izenera berrizendatu):

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

Buenaventura Durrutiren mezu garrantzitsu bat dago zuentzat `durruti` karpetako irudietako batean. Mezua steghide programaren bidez sartu da, "durruti" pasahitzarekin. Mezua duen irudia honako Hash (SHA256) honekin bat dator: `7d573924d70a604cb56122aed9bded3f40d3083d8adc353a97c0b816c0e573bb`. Zein fitxategi da? Zer dio esaldiak? Nola automatizatuko zenuke bilaketa fitxategi asko izango bazenitu karpetetan eta azpikarpetetan?

## Pasahitzak eta gatza

Exekutatu:

```bash
echo -n "pasahitza" | sha256sum
echo -n "pasahitza" | sha256sum
```

Ikusi emaitza berdina dela.

OpenSSL-rekin gatzaren erabilera:

```bash
openssl passwd -6 -salt SAL001 pasahitza
openssl passwd -6 -salt SAL002 pasahitza
```

Hash-ak aldatzen dira?

## Hash-ak eta Git

Klonatu, oraindik egin ez baduzu, irakasgaiaren biltegia (SSH erabiliz):

```bash
git clone git@github.com:mikel-egana-aranguren/EHU-SGSSI-01.git
cd cd EHU-SGSSI-01/
git log
```

Zerk identifikatzen du commit-aren hash-a? Zergatik detektatzen ditu Git-ek eduki-aldaketak modu eraginkorrean?

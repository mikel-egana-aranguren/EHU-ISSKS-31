# Laborategia: DevSecOps

### Aurretiko baldintzak

- GNU/Linux makina: ordenagailu eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu; `lsi` erabiltzailea soilik erabili beharrezkoa bada, `su - lsi` komandoaren bidez).
- Kode-editorea. Visual Studio Code-n, `Ctrl+Shift+V` sakatuz fitxategi hau modu atseginean bistaratzen da (batez ere irudientzat).
- Irakasgaiaren GitHub biltegia: laborategian garatutako programak igo ditzakezu.

## DevSecOps

DevSecOps-ek (Development, Security, Operations) softwarearen garapenean eta ustiapenean segurtasuna integratzen du. Laborategi honetan aplikazio txiki bat eraikiko dugu, probak eta segurtasun-analisiak exekutatuko ditugu, eta egiaztapen horiek GitHub Actions bidez automatizatuko ditugu.

Geure kodearen eta dependentzien gaineko tresnak erabiliko ditugu. Ez sartu pasahitzik, tokenik edo bestelako sekreturik biltegian. Analisi batek arazoren bat aurkitzen badu, aztertu emaitza eta zuzendu jatorrian, kontrolak berriro exekutatu aurretik.

## Proiektua prestatu

Sortu devsecops-demo izeneko GitHub biltegi bat eta klonatu. Egiaztatu Python 3 eta Docker instalatuta dituzula:

```bash
python3 --version
docker --version
```

Sortu ingurune birtual bat, proiektuaren dependentziak sistemakoekin ez nahasteko:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Ziurtatu `(.venv)` terminalean agertzen dela, prompt-aren aurretik:

```bash
[bgpegarm@U113356 DevSecOpsDemo]$ source .venv/bin/activate
(.venv) [bgpegarm@U113356 DevSecOpsDemo]$
```

## Aplikazioa sortu eta probatu

Sortu `app.py` fitxategia:

```python
from flask import Flask

app = Flask(__name__)


@app.get("/")
def index():
    return {"message": "DevSecOps demo aplikazioa"}
```

Sortu `requirements.txt` fitxategia aplikazioaren dependentziekin:

```text
Flask>=3,<4
```

Instalatu dependentziak eta exekutatu aplikazioa lokalean:

```bash
python -m pip install -r requirements.txt
flask --app app run
```

Bisitatu <http://127.0.0.1:5000/> eta egiaztatu erantzuna. Gelditu zerbitzaria `Ctrl+C` eginez.

Sortu `tests/test_app.py`:

```python
from app import app


def test_index():
    response = app.test_client().get("/")

    assert response.status_code == 200
    assert response.json == {
        "message": "DevSecOps demo aplikazioa"
    }
```

Instalatu garapen-tresnak eta exekutatu proba:

```bash
python -m pip install pytest bandit pip-audit
python -m pytest
```

> Zer egiaztatzen du probak, eta zer informazio ematen du huts egiten badu?

> Zergatik instalatzen ditugu dependentziak ingurune birtual batean?

> Zein diferentzia dago aplikazioaren dependentzien eta garapen-tresnen dependentzien artean?

## Kodea eta dependentziak aztertu

Bandit-ek Python kodean segurtasun-arazoak izan ditzaketen patroiak bilatzen ditu. Exekutatu analisia aplikazioaren fitxategian:

```bash
bandit app.py
```

`pip-audit`-ek adierazitako dependentziek ahultasun ezagunik duten egiaztatzen du:

```bash
pip-audit -r requirements.txt
```

Tresna batek zerbait aurkitzen badu, irakurri xehetasuna, identifikatu eragindako fitxategia edo paketea eta aplikatu zuzenketa bat. Exekutatu berriro probak eta analisiak emaitza egiaztatzeko.

> Zer nolako arazoak aurki ditzake Bandit-ek? Zer arazo ezin ditu baztertu?

> Zergatik ez da nahikoa proba zuzen bakarra frogatzeko aplikazioa segurua denik?

> Zer informazio behar duzu dependentzia baten ahultasun bati nola erantzun erabakitzeko?

## Edukiontzi bat eraiki eta exekutatu

Sortu `Dockerfile` fitxategia proiektuaren direktorioan:

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

COPY app.py .

USER 10001
EXPOSE 5000
CMD ["flask", "--app", "app", "run", "--host=0.0.0.0", "--port=5000"]
```

Eraiki irudia:

```bash
docker build -t devsecops-demo .
```

Exekutatu edukiontzia eta argitaratu zerbitzua makinaren interfaze lokalean soilik:

```bash
docker run --rm -p 127.0.0.1:5000:5000 devsecops-demo
```

Bisitatu <http://127.0.0.1:5000/> eta gelditu edukiontzia `Ctrl+C` eginez.

> Dockerfile-ko zein instrukziok instalatzen dute dependentzia eta kopiatzen dute kodea?

> Zein erabiltzailek exekutatzen du aplikazioa edukiontziaren barruan?

> Zergatik argitaratzen da `127.0.0.1`-en bakarrik, eta ez sareko interfaze guztietan?

> Zein arrisku dakar irudian kredentzialak edo behar ez diren fitxategiak sartzeak?

Egiaztapen gehigarri gisa, [Trivy](https://trivy.dev/) erabiliz irudia azter dezakezu. Instalatzeko, jarraitu [jarraibideak](https://trivy.dev/docs/latest/getting-started/installation/#debianubuntu-official):

```bash
sudo apt-get install wget gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
```

Irudia aztertu:

```bash
trivy image devsecops-demo
```

Aztertu laburpena eta gomendioak. Eskaner batek arriskuak lehenesten laguntzen du, baina ez du ordezten oinarrizko irudiaren berrikuspena, ezta ahultasunik ez dagoela bermatzen ere.

## Kontrolak GitHub Actions bidez automatizatu (DevSecOps)

Atal honetan aurreko lana GitHub Actions-eko workflow batean automatizatuko dugu, benetako DevSecOps soluzioa balitz bezala. Sortu `.github/workflows` direktorio ezkutua eta `.github/workflows/security.yml` fitxategia biltegiaren erroan:

```yaml
name: Probak eta segurtasuna

on:
  push:
  pull_request:

permissions:
  contents: read

jobs:
  checks:
    runs-on: ubuntu-latest
    steps:
      - name: Kodea eskuratu
        uses: actions/checkout@v4

      - name: Python prestatu
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Dependentziak eta tresnak instalatu
        run: |
          python -m pip install --upgrade pip
          python -m pip install -r requirements.txt pytest bandit pip-audit

      - name: Probak exekutatu
        run: pytest

      - name: Kodea aztertu
        run: bandit app.py

      - name: Dependentziak auditatu
        run: pip-audit -r requirements.txt

      - name: Irudia eraiki
        run: docker build -t devsecops-demo .
```

Gorde eta igo fitxategiak biltegira:

```bash
git add .github/ Dockerfile app.py requirements.txt test_app.py
git commit -m "DevSecOps laborategia gehitu"
git push
```

Begiratu GitHub biltegiaren **Actions** fitxa eta egiaztatu urrats bakoitzaren emaitza. Kontrolen bat huts egiten badu, aztertu mezuak, zuzendu arazoa eta igo berriro aldaketak.

> Zein gertaeratan exekutatzen da workflow hau?

> Zer gertatzen da workflow-arekin proba edo analisi batek huts egiten badu? (Probatu testa aldatuz)

> Zergatik deklaratzen du workflow-ak `contents: read`, baimen zabalak eman beharrean?

> Zein kontrolak gehituko zenituzke sekretuak egiaztatzeko edo eraikitako irudia aztertzeko?

## Hobekuntza jarraia

Automatizazioak feedback errepikagarria ematen du, baina garatzaileak du ardura emaitzak interpretatu eta kontrolak mantentzeko. Benetako proiektu batean:

- Finkatu eta eguneratu dependentzien bertsioak era kontrolatuan.
- Berrikusi workflow-eko baimenak eta eman beharrezkoak bakarrik.
- Babestu sekretuak CI sistemaren biltegiarekin; ez idatzi kodean ezta logetan ere.
- Berrikusi aldizka oinarrizko irudiak eta birreraiki irudiak eguneratzeak txertatzeko.
- Lehenetsi aurkikuntzak haien inpaktuaren eta esposizioaren arabera, eta dokumentatu erabakiak.

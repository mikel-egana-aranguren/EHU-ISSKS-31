# Laborategia: Google Colab

### Aurretiko baldintzak

- GNU/Linux makina: ordenagailu eramangarria, makina birtuala edo laborategiko PCa (LDAP kredentzialarekin sartu; `lsi` erabiltzailea soilik erabili beharrezkoa bada, `su - lsi` komandoaren bidez).
- Kode-editorea. Visual Studio Code-n, `Ctrl+Shift+V` sakatuz fitxategi hau modu atseginean bistaratzen da (batez ere irudientzat).
- Irakasgaiaren GitHub biltegia: laborategian garatutako programak igo ditzakezu.
- Google kontua, Google Cloud zerbitzaria sortzeko erabilia.

## Google Colab

### Sarrera

[Google Colab](https://colab.research.google.com) [Jupyter Notebooks](https://jupyter.org)-en oinarritutako garapen-ingurunea da, softwarerik instalatu gabe hodeian Python kodea exekutatzea ahalbidetzen duena.

Laborategi honetan honako hauek ikasiko ditugu:

- Google Colab-en notebookak sortzen eta exekutatzen.
- Kode-gelaxkak eta Markdown testu-gelaxkak erabiltzen.
- Datuak kargatzen eta aztertzen.
- Machine Learning eredu sinple bat entrenatzen.
- Bere errendimendua ebaluatzen.
- Machine Learning ereduekin lotutako segurtasun-arrisku batzuk identifikatzen.

Tresna eta datu-multzo publikoekin lan egingo dugu. Ez igo informazio pertsonalik, datu sentikorrik ez eta kredentzialik Google Colab-era.

### Colab-en notebook bat sortu

Sartu [Colab](https://colab.research.google.com)-en, Google Cloud zerbitzaria sortzeko erabili zenuen Google kontu berarekin. Sortu notebook berria (File; New Notebook) eta izena aldatu: `ml-sec.ipynb`.

Exekutatu honako gelaxka hau:

```python
print("Hi Colab World")
```

Gehitu testu-gelaxka bat.

> Zein diferentzia dago kode-gelaxka baten eta testu-gelaxka baten artean?

> Zer gertatzen da gelaxka bera hainbat aldiz exekutatzen baduzu?

### Exekuzio-ingurunea ezagutu

Exekutatu:

```python
import platform

print(platform.platform())
print(platform.python_version())
```

Egiaztatu erabilgarri dagoen memoria:

```python
!free -h
```

Egiaztatu uneko karpetaren edukia:

```python
!ls
```

> Non exekutatzen da benetan kodea?

> Zein diferentzia dago zure ordenagailu lokalaren eta Colab-en exekuzio-ingurunearen artean?

### Datuekin lan egin

Inportatu beharrezko liburutegiak:

```python
import pandas as pd
```

Kargatu datu-multzo publiko bat:

```python
url = "https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv"

df = pd.read_csv(url)

df.head()
```

Lortu informazio orokorra:

```python
df.info()
```

Lortu estatistika deskribatzaileak:

```python
df.describe()
```

> Zenbat errenkada eta zutabe ditu datu-multzoak?

> Zer adierazten du zutabe bakoitzak?

### Datuak bistaratu

Instalatu eta erabili bistaratze-liburutegiak:

```python
import seaborn as sns
import matplotlib.pyplot as plt
```

Bistaratu aldagaien arteko erlazioak:

```python
sns.pairplot(df, hue="species")
plt.show()
```

> Begibistaz bereizten al dira espezie desberdinak?

> Zein aldagai dirudite erabilgarrienak sailkatzeko?

### Machine Learning eredu bat entrenatu

Inportatu beharrezko tresnak:

```python
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
```

Bereizi datuak eta etiketak:

```python
X = df.drop("species", axis=1)
y = df["species"]
```

Zatitu entrenamendua eta proba:

```python
X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.3,
    random_state=42
)
```

Sortu eta entrenatu eredua:

```python
model = DecisionTreeClassifier()
model.fit(X_train, y_train)
```

Egin aurreikuspenak:

```python
predictions = model.predict(X_test)
```

Kalkulatu zehaztasuna:

```python
accuracy_score(y_test, predictions)
```

> Zer esan nahi du lortutako zehaztasunak?

> Nahikoa al da zehaztasun altua eredua guztiz fidagarritzat jotzeko?

### Eredua interpretatu

Bistaratu erabaki-zuhaitza:

```python
from sklearn.tree import plot_tree

plt.figure(figsize=(12,8))

plot_tree(
    model,
    feature_names=X.columns,
    class_names=model.classes_,
    filled=True
)

plt.show()
```

> Zein aldagai agertzen dira zuhaitzaren sustraitik gertu?

> Zergatik izan daiteke erabilgarria eredu batek erabakiak nola hartzen dituen ulertzea?

### Notebooka GitHub-en gorde

Hautatu: File; Save a copy in GitHub

Edo deskargatu notebooka: File; Download; Download .ipynb

Igo notebooka zure GitHub biltegira.

> Zer abantaila dauka notebooka bertsio-kontrolpean gordetzeak?

### Segurtasuna Machine Learning-en

Machine Learning ereduek ere segurtasun-arriskuak dituzte. Atal honetan adibide batzuk aztertuko ditugu.

#### Datuen pozoitzea (Data Poisoning)

Erasotzaile batek entrenamendu-datuen zati bat aldatzen du, ereduaren portaera eraldatzeko.

Exekutatu:

```python
df_poisoned = df.copy()

df_poisoned.loc[0:10, "species"] = "setosa"
```

Behatu lehen errenkadak:

```python
df_poisoned.head(15)
```

> Zein eragin izan dezake entrenamendu-etiketak aldatzeak?

> Zergatik da garrantzitsua datuen jatorria eta kalitatea egiaztatzea?

#### Alborapena duten ereduak

Kalkulatu zenbat lagin dauden klase bakoitzeko:

```python
df["species"].value_counts()
```

> Zein arazo ager litezke klase bat oso gutxi ordezkatuta badago?

> Nola eragingo luke honek aurreikuspenen kalitatean?



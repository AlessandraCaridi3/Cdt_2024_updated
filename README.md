# Codifica TEI-XML di tre articoli tratti da "La Rassegna Settimanale di politica, scienze, lettere ed arti" (1878-1882)
Realizzata da Matilde Campanardi e Alessandra Caridi</br>
CdL Informatica Umanistica, a.a. 2023/2024</br>

# <h3>Validazione del file TEI-XML con Xerces:</h3>
Comando da terminale:
```bash
java -cp "xerces-2_12_1/*" dom.Counter -v articoli.xml
```
Risultato:
```bash
articoli.xml: 443;85;1 ms (3652 elems, 9719 attrs, 22227 spaces, 125843 chars)
```

# <h3>Trasformazione in file HTML del file TEI-XML con il processore Saxon:</h3>

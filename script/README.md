# Indicazioni generali

La cartella contiene due sottocartelle, rispettivamente:

- *linux-based*: File originale, scaricato per primo 
- *MacOS*: Versione migliorata del file originario, compatibile con MacOS.

In caso di errore irreparabile, sono sempre disponibili anche dei backup in formato *.zip*.

## Eseguire lo script

Per lanciare lo script seguire i seguenti passaggi:

1. Navigare nella cartella desiderata
2. Modificare file *workspace.conf* con le configurazioni desiderate
3. Aprire terminale nella cartella dove è presente il file *workspace.conf* precedentemente modificato
4. Concedere permessi di esecuzione allo script (cambia in base al SO) il seguente comando è valido per sistemi Linux-based e MacOS:

```console
`chmod 777 makeWorkspace.sh`
```

5. Eseguire lo script, il seguente comando è valido per sistemi Linux-based e MacOS: 
```console
./makeWorkspace.sh
```

### Output
Verrà creata una cartella lab con all'interno le configurazioni desiderate.

## Misc

Una versione del repository del corso con lab funzionanti, appunti e topologie è disponibile sul mio [repository personale](https://github.com/fede-da/IDC).   

Se volete contribuire ad aggiornare i laboratori siete i benvenuti, non esitate a contattarmi.

N.B.: Non sono stato io a creare lo script, ho solo provveduto a fornire una versione compatibile con MacOS e ho scritto la documentazione, prima inesistente.

Happy coding!
# Notes

## 1

### Phenomena
| World Phenomena | Description | 
|:----------------------:|:------------------------------------|
| WP1 | Danni al raccolto per calamità naturali |  
| WP2 | Condizioni meteorologiche particolarmente avverse |  
| WP3 | Operazioni agricole  |  
| WP4 | Raccolta prodotti agricoli |  
| WP5 | Visite di controllo ai farmers |  

| Shared Phenomena | Description | Controlled by
|:----------------------:|:------------------------------------|:----:|
| SP1 | Inserimento dati raccolto | W |
| SP2 | Visualizzazione previsioni meteo | M |
| SP3 | Visualizzazione delle suggestions | M |
| SP4 | Invio notifica dal PM | W |
| SP5 | Ricezione notifica da parte del farmer | M |
| SP6 | Invio richieste d'aiuto | W |
| SP7 | Intervento sul forum | W |
| SP8 | Visualizzazione dati raccolto dei farmer | M |
| SP9 | Richiesta di interview | W |
| SP10 | Richiesta di consulenza ad agronomists | W |
| SP11 | Login/Registration dei farmer sulla piattaforma | W |

### Goals
| Goal | Description | 
|:----------------------:|:------------------------------------|
| G1 | Permettere ai farmer di ricevere assistenza sul loro lavoro |  
| G2 | Permettere ai policy makers di tenere sotto controllo l'agricoltura locale |  
| G3 | Premiare i migliori agricoltori attraverso incentivi ad altre iniziative|  
| G4 | Permettere ai farmer di creare un *network collaborativo* con gli altri farmers |  
| G5 | Agevolare la gestione dei daily plan degli agronomists |  
 
## 2

2.1 - Product perspective
- Scenarios
- Domain Model

2.2 - Product functions
- Requirements

2.3 - User characteristics

2.4 - Domain assumptions, dependencies and constraints

### Assumptions
| ID | Assumptions | 
|:----------------------:|:------------------------------------|
| D1 | Ogni PM ha una e UNA SOLA area di competenza |  
| D2 | Ogni trimestre sono selezionati 10 agricoltori in base a degli indici definiti dal governo| 
| D3 | I farmer inseriscono sempre e in modo corretto i dati relativi al raccolto | 
| D4 | Il contadino che partecipa a DREAM, deve disporre di un dispostivo in grado di connettersi alla piattaforma | 
| D5 | Ad ogni contadino vengono forniti tutti i sensori necessari per il rilevamento dell'acqua utlizzata nell'irrigazione | 
| D6 | I sensori del farmer vengono installati direttamente nella centralina del sistema di irrigazione |
| D7 | I sensori dell'irrigazione inviano automaticamente i dati relativi al consumo di acqua al momento della compilazione del report |
| D8 | I sensori di rilevazione dell'umidità del terreno vengono installati dal governo in maniera tale da coprire tutta l'area di interesse |
| D9 | Il sistema di weather forecasting è già implementato e funzionante |
| D10 | I PM effettuano data-driven decisions |

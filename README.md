# DDU_Racecar

## Resumé

Skrevet af Emil Boesgaard Nørbjerg & Christian Vedel Petersen, H. C. Ørsted Gymnasiet.
Opgaven er en del af faget Digitalt design og udvikling.

###Fitness-funktion og Ændring i Banen
Opgaven startede med en skabelon fra underviserne, hvorefter der blev lavet en række ændringer og tilføjelser.
Den første tilføjelse er en fitness-funktion, der finder de bedste biler ved hver generation.
Denne fitness er baseret ud fra hvor mange frames en bil har bevæget sig i den rigtige retning, altså mod uret i denne bane.
Fitness bliver derefter ganget med den runde som bilen er på. Hvis bilen har kørt over målstregen 5 gange, bliver dens fitness ganget med 5.
Dette giver i første omgang mulighed for bilerne at snyde systemet, da de bare kan bevæge sig frem og tilbage over målstregen.
Dette problem bliver løst ved at tilføje en rød streg oveni. Denne streg bruges til at tjekke om bilerne bevæger sig den rigtige retning over målstregen.
Hvis bilen sidste frame var på en grøn pixel og nu er på en rød pixel, har den passeret i den rigtige retning. Hvis en bil går den modsatte retning ryger de en
runde ned. Hvis en bil derfor kører rigtigt over målstregen 5 gange, men den forkerte vej 3, har den som nettoresultat kørt 2 omgange.
Når bilerne rammer kanten af banen dør de helt. Dette gør, at en bil ikke kan køre en kortere vej rundt om banen og over målstregen.

###Mutation og Generationsdannelse
Når der dannes en ny generation, bliver de 10 bedste biler taget, og den nye generation bliver lavet ud fra disse.
Hver bil får automatisk en plads selv i den nye generation. Resten af bilerne er direkte mutationer af hver bil.
Med en population på 1000, danner hver bil altså 100 nye biler. Altså biler bliver muteret fra den originale.
Mutationsintensiteten er på 0.1. Det vil sige at hver vægt og bias kan øges og reduceres med op til 10% af den originale
Desuden er der også 1% chance for at bilens vægt eller bias bliver ganget med -1. Dette gør at der kan komme gode biler,
selv hvis startgenerationen er dårlig, da der kan ske radikale mutationer.

###Sensors og Neuralt Netværk
Sensorerne er også blevet ændret fra den originale skabelon. Originalt kunne hver sensor enten give sandt eller falskt som resultat.
Dette simplificerede hjernen markant, da der kun er 2^3=8 forskellige inputs, hjernen kan få.
Her blev sensorne ændret, så de nu måler distancen til kanten af banen. Dette giver en større varians i inputtet til hjernen,
og giver derfor mulighed for mere variation for input, og også giver mulighed for bedre biler, da de bedre kan vide om de ligger tæt på kanten eller i midten af banen.
Dette gør dog, at der også måtte ske nogle ændringer til hjernen. Dette er nødvendigt, da inputtet kan være op til omkring 200, hvor det før kun kunne være 0 eller 1.
Derfor bliver først mappet ned til mindre værdier, hvorefter det bliver kørt igennem en sigmoid funktion, for at give et tal mellem 0 og 1.
Sigmoid funktionen bliver også brugt på det hemmelige lag, og en modificeret sigmoid funktion bliver brugt på outputtet.
Denne modifikation gør, at funktionen plotter outputtet til et tal mellem -pi og pi. Dette giver et output i radianer, der ikke er kæmpestore.
Dette resulterer i biler, der kører mere blødt på banen, da de kan variere deres rotation meget mere end før, og ved en simpel analyse er hastigheden af programmet,
blev det fundet, at disse ændringer ikke havde en signifikant effekt på hastigheden af programmet.
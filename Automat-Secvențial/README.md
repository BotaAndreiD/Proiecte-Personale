Bota Andrei-Daniel 
Grupra. 2126-1 
Documentatie Proiect Cid  
În cadrul acestui proiect, am început prin rezolvarea 
problemei pe hârtie pentru a obține o înțelegere clară a 
cerințelor și a modului de abordare a implementării. Acest 
proces a implicat încercarea de a vizualiza și de a planifica 
soluția înainte de a trece la etapa de codare. 

După ce am avut un plan clar, am trecut la implementarea MUX 
2:1 în Vivado. Acesta a fost un proces esențial care a implicat 
crearea unui circuit de multiplexare care să selecteze între 
două intrări bazate pe o condiție. Acest lucru a fost realizat 
prin utilizarea unui MUX 2:1, care este un dispozitiv care 
permite transmiterea unui semnal din două surse diferite la o 
singură ieșire. 

După implementarea MUX 2:1, am trecut la simularea acestuia 
pentru a verifica dacă funcționează conform așteptărilor. 
Aceasta a fost o etapă crucială care a implicat testarea și 
validarea funcționării corecte a circuitului prin simularea 
comportamentului său.  

Putem remarca în cadrul multiplexorului (mux) prezența 
intrărilor i0 și i1, care influențează iesirea în funcție de valoarea 
adresei. Această relație este confirmată și în simulare. Atunci 
când adresa 'a' este 0, iesirea 'y' este strict egală cu i0. În 
schimb, când 'a' este 1, iesirea 'y' corespunde cu i1. 
În urma validării MUX 2:1, m-am apucat de procesarea 
counterului. Acest proces a implicat inițializarea counterului 
cu anumite valori pentru a începe numărătoarea. Acest lucru a 
fost realizat prin setarea counterului la o valoare inițială și 
apoi incrementarea sau decrementarea acestuia în funcție de 
cerințele specifice ale proiectului. 

După procesarea counterului, am realizat o simulare pentru a 
verifica dacă funcționează corect. Acest lucru a implicat 
simularea comportamentului counterului și verificarea dacă 
numărătoarea se comportă conform așteptărilor. 

În final, am adăugat MUX-urile la intrările counterului. Acest 
proces a implicat conectarea MUX-urilor la counter pentru a 

permite selectarea între diferite intrări. Prin utilizarea MUX
urilor, am putut controla ce intrare este selectată pentru 
counter, permițând un control mai mare asupra funcționării 
acestuia. 
Observăm cum contorul (counter) validează tabelul de adevăr. 
Atunci când semnalul de încărcare (load) este setat pe 1 și 
ceasul (clk) este într-o tendință ascendentă, se încarcă valorile 
specifice din secvență. De asemenea, remarcăm faptul că iesirile 
corespund perfect cu ceea ce ne așteptăm de la iesirile 
multiplexoarelor (mux). 

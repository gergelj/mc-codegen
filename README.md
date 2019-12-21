# Generator koda za MiniC jezik

## Vezba07

### Zadatak 1 - `global_vars`

Proširiti miniC gramatiku globalnim promenljivim i napraviti generisanje koda za njih.

Primer deklaracije:

```c
int a;
```

Izgenerisani kod za datu deklaraciju:

```asm
a:
     WORD    1
```

Ako je `a` globalna promenljiva, tada za iskaz dodele:

```c
    a = a + 1;
```

treba da bude izgenerisan sledeći kod:

```asm
    ADDS    a,$1,%0
    MOV     %0,a
```

Realizovati semantičku proveru:
- promenljiva ne sme biti prethodno deklarisana.

> POMOĆ:
> 
> Globalni i lokalni identifikatori mogu imati isto ime, pa se u tabeli simbola moraju razlikovati.

### Zadatak 2 - `postincrement_statement`

Napraviti generisanje koda za postinkrement iskaz.

Primer iskaza:

```c
  x++;
```

Primer izgenerisanog koda (za prvu lokalnu promenljivu):

```asm
  ADDS    -4(%14),$1,-4(%14)
```

Primer izgenerisanog koda (za globalnu promenljivu):

```asm
  ADDS    x,$1,x
```

Realizovati semantičku proveru: 
- postinkrement operator može da se primeni samo na promenljive (lokalne i globalne) i parametre.

### Zadatak 3 - `postincrement_exp`

Napraviti generisanje koda za postinkrement unutar numeričkih izraza.

Primer:

```c
int main() {
    int x;
    int y;
    x = 3;
    y = x++ + x++ + 42;
    return x + y;
}
```

Izlazni kod treba da proizvede rezultat 53. 

Generisanje operacije za inkrement treba da bude nakon obrade kompletnog numeričkog izraza.

Izgenerisani kod za `y = x++ + x++`:

```asm
    ADDS    -4(%14),-4(%14),%0  //num_exp
    ADDS    %0,$42,%0           //num_exp
    ADDS    -4(%14),$1,-4(%14)  //++
    ADDS    -4(%14),$1,-4(%14)  //++
    MOV      %0,-8(%14)         //assign
```

Realizovati semantičku proveru: 
- postinkrement operator može da se primeni samo na promenljive (lokalne i globalne) i parametre.

## Vezba08

### Zadatak 4 - `conditional_operator`

Proširiti miniC izraze conditional operatorom:

```
    "(" <uslov> ")" "?" <izraz1> ":" <izraz2>
```

`<uslov>` predstavlja relacioni izraz

`<izraz1>` i `<izraz2>` predstavljaju promenljivu, parametar ili konstantu

`<izraz1>` i `<izraz2>` su istog tipa

Realizovati generisanje koda za conditional operator.

Primer 1:

```c
    a = (a == b) ? a : 0;
```

Primer 2:

```c
    a = a + (a == b) ? a : b + 3;
```

### Zadatak 5 - nije implementirano

Proširiti miniC numeričke izraze operacijama `*` i `/`.

Operacije `*` i `/` treba da budu većeg prioriteta od `+` i `-`.

## Vezba09

### Zadatak 6 - `for_statement`

Proširiti miniC iskaze for petljom koja izgleda ovako:

```
  "for" _LPAREN <name> "=" <lit> ";" <rel> ";" <name> "++")
      <statement>
```

gde je:

`<name>` ime lokalne promenljive ili parametra

`<lit>`  literal

`<rel>`  relacioni izraz

`"++"`   inkrement operator


`<name>` mora biti deklarisano pre upotrebe

`<name>` i `<lit>` treba da budu istog tipa

Realizovati generisanje koda za for petlju.
- Inicijalizacija iteratora se vrši samo jednom, pre prvog izvršavanja tela petlje.
- Tačnost relacije se proverava na početku svake iteracije.
- Inkrementiranje iteratora se vrši na kraju svake iteracije.

> Napomena: Petlje mogu biti i ugnježdene.

Primer:

```c
  int suma;
  int i;
  suma = 0;
  for(i = 0; i < 5; i++)
    suma = suma + i;
```

### Zadatak 7 - `switch_statement`

Proširiti miniC gramatiku switch iskazom. Sintaksa switch iskaza ima oblik:

```
  "switch" "(" switch_expression ")" "{"
    "case" constant_expression ":" case_body [ "break" ";" ]
    "case" constant_expression ":" case_body [ "break" ";" ]
       ...
    [ "default" ":" default_body ]
  "}"
```

- `switch_expression` predstavlja ime promenljive koja prethodno mora biti deklarisana
- `constant_expression` predstavlja konstantu
- `case_body` i `default_body` predstavljaju iskaz

Postoji bar jedna case naredba.
- `default` naredba se može pojaviti samo nakon `case` naredbi (kao poslednja).
- `break` naredba se može pojaviti samo na kraju `case` naredbe.

Izvršavanje:
- na početku `switch` iskaza se izvrši provera vrednosti promenljive u zagradama
- u zavisnosti od te vrednosti preusmerava se tok izvršavanja na telo odgovarajuće case naredbe
- ukoliko se na kraju `case` naredbe nalazi `break` naredba, tok izvršavanja se preusmerava na kraj switch iskaza; a ako je `break` naredba izostavljena, "propada" se na izvršavanje sledeće `case` naredbe
- `default` naredba se izvršava ukoliko se vrednost `switch` promenljive razlikuje od svih konstanti navedenih u svim `case` naredbama

Primer1:

```c
  switch (state) {
    case 10: { s = 1; } break;
    case 20: s = 2;
    default: s = 0;
  } 
```

Primer2:

```c
  switch (state) {
    case 10: s = 1; break;
    case 20: { s = 2; }
  }
```

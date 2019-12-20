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

### Zadatak 4

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



# Oppgave
Oppgaver for workshop i Infrastructure-as-code. Det er viktig at oppgavene gjøres i rekkefølge da noen ressurser baserer seg på andre ressurser. Lykke til!

## Oppgave 1

Start et cluster enten via docker desktop eller kind create cluster

Verfiser at du har et kjørende cluster med å kjøre kubectl get nodes


## Oppgave 2

Installer siste versjon av terraform ved bruk av tfenv. Se til dokumentasjon for hvordan dette gjøres.

Se https://github.com/tfutils/tfenv

## Oppgave 3

Deploy vault basert på skjelettkode og dokumentasjon.
Se vault.tf for skjelettkode og bruk https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment for dokumentasjon
Nb: Husk terraform validate, terraform plan, terraform apply

Sjekk localhost-vault (Sett inn rett adresse) for å se om vault er oppe

## Oppgave 4

Deploy infrastruktur for å hente en vits fra en nettside med http provideren basert på skjelettkode og dokumentasjon.
Se http.tf for skjelettkode og bruk https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http. Denne vitsen skal så legges inn i vault. Bruk https://registry.terraform.io/providers/hashicorp/vault/latest/docs for dokumentasjon.
Nb: Husk terraform validate, terraform plan, terraform apply

Sjekk vault for å se om dataen er blitt lagt inn. 

## Oppgave 5

Deploy infrastruktur for å vise frem vitsen som ligger i vault basert på skjelettkode og dokumentasjon. Dette gjøres gjennom å deploye et image.
Se frontend.tf for skjelettkode og https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment for dokumentasjon.
Nb: Husk terraform validate, terraform plan, terraform apply

## Oppgave 6

Deploy en secret til namespacet roma med terraform.
Legg inn terraform kode for en kubernetes-secret ([Terraform dokumentasjon](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret))
### Verifiser at secret ble lagt inn:
```
Lister alle secrets i namespacet: 
kubectl get secrets -n roma

Viser innholdet i en secret:
kubectl get secret test-secret -o jsonpath='{.data.thesecret}' -n roma | base64 --decode
```
### Fjern/Kommenter ut secreten og kjør kun plan
Gå inn i konfigen og kommenter ut kodeblokken med kubernetes-secreten.
Når du kjører terraform plan nå, hva ser du da?
Hvis terraform har lyst til å kjøre destroy på secreten har du gjort det riktig.

For å unngå at den blir destroyed kan vi fjerne den fra state, da blir det som om den aldri har eksistert i terraform sine øyne.
Dette kan vi gjøre via terraform kommandoer i terminalen, start med å kjøre:
```
terraform state
```
Først vil vi liste ut alle ressursene vi har i staten og identifisere den ressursen vi ser etter i den listen.
Deretter bruker vi terraform state kommandoen for sletting på den ressursen.
```
terraform plan
```
Hva ser du nå?

## Oppgave 7
I forrige oppgave lærte vi hvordan fjerne en ressurs fra state, i denne oppgaven lærer man hvordan å legge det til.

For at terraform skal klare å importere en ressurs som ligger utenfor terraform er vi nødt til å ha
konfig for den typen ressurs vi ønsker å importere.

Vi kan starte med å kommentere inn secreten fra forrige oppgave uten "innmaten".
Nederst i [terraform dokumentasjonen](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret#import) for kubernetes-secret ser vi eksempel bruk på kommandoen vi trenger.

Etter import er fullført kan vi verifisere at secreten er tilbake i state ved å kjøre:
```
terraform show
```
Om vi kjører plan igjen nå kan vi støte på feilmeldinger siden konfigurasjonen ikke er lik det vi ser i state.
For å løse dette kan vi enten kommentere inn igjen resten av konfigen til secreten, eller bruke terraform koden fra terraform show kommandoen å kopiere inn i konfigen vår.


## Oppgave 8

Både frontend.tf og vault.tf bruker en del lignende konfigurasjon. Se om du kan forenkle denne konfigurasjonen med å lage en modul.
# Oppgave
Oppgaver for workshop i Infrastructure-as-code. Det er viktig at oppgavene gjøres i rekkefølge da noen ressurser baserer seg på andre ressurser. Lykke til!

## Oppgave 1

Start et cluster enten via docker desktop eller kind create cluster

Verfiser at du har et kjørende cluster med å kjøre kubectl get nodes


## Oppgave 2

Installer siste versjon av terraform ved bruk av tfenv. Se til dokumentasjon for hvordan dette gjøres.

Se https://github.com/tfutils/tfenv

## Oppgave 3


## Oppgave 4

Deploy vault basert på skjelettkode og dokumentasjon.
Se vault.tf for skjelettkode og bruk https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment for dokumentasjon
Nb: Husk terraform validate, terraform plan, terraform apply

Sjekk localhost-vault (Sett inn rett adresse) for å se om vault er oppe

## Oppgave 5

Deploy infrastruktur for å hente en vits fra en nettside med http provideren basert på skjelettkode og dokumentasjon.
Se http.tf for skjelettkode og bruk https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http. Denne vitsen skal så legges inn i vault. Bruk https://registry.terraform.io/providers/hashicorp/vault/latest/docs for dokumentasjon.
Nb: Husk terraform validate, terraform plan, terraform apply

Sjekk vault for å se om dataen er blitt lagt inn. 

## Oppgave 6

  

Deploy infrastruktur for å vise frem vitsen som ligger i vault basert på skjelettkode og dokumentasjon. Dette gjøres gjennom å deploye et image.
Se frontend.tf for skjelettkode og https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment for dokumentasjon.
Nb: Husk terraform validate, terraform plan, terraform apply

  

## Oppgave 7

  
  

## Oppgave 8

  
  

## Oppgave 9

  

Både frontend.tf og vault.tf bruker en del lignende konfigurasjon. Se om du kan forenkle denne konfigurasjonen med å lage en modul.
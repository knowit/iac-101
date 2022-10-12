# Oppgave
Oppgaver for workshop i Infrastructure-as-code. Det er viktig at oppgavene gjøres i rekkefølge da noen ressurser baserer seg på andre ressurser. Lykke til!

## Oppgave 1

Start et cluster enten via docker desktop eller kind create cluster

Verfiser at du har et kjørende cluster med å kjøre kubectl get nodes


Løsning:
Har man noder oppe å kjøre når man kjører kubectl get nodes har man et fungerende cluster

## Oppgave 2

Installer siste versjon av terraform ved bruk av tfenv. Se til dokumentasjon for hvordan dette gjøres.

Se https://github.com/tfutils/tfenv

Løsning:
Installer terraform, kjør terraform -help plan eller lignende for å verifiser at det fungerer.

## Oppgave 3

Deploy vault basert på skjelettkode og dokumentasjon.
Se vault.tf for skjelettkode og bruk https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment for dokumentasjon
Nb: Husk terraform validate, terraform plan, terraform apply

Sjekk localhost-vault (Sett inn rett adresse) for å se om vault er oppe

Løsning:

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

Opprett en ingress gjennom kubectl apply -f ingress.yaml og sett opp ingressen fra ingress.tf. Importer staten fra ingress.yaml inn i terraform staten. 

Sjekk om staten er importert gjennom å liste opp innholdet i staten ved å bruke terraform CLI. 
## Oppgave 7

Deploy en secret som ligger i secret.tf. Slett denne fra staten gjennom å bruke terraform CLI. Hint: Start med å liste opp hva som er i staten. 

Løsning:

1. Kjør terraform apply secret.tf
2. Terraform state list
3. Terraform state rm kubernetes_secret.roma-secret
4. Terraform state list og se om secreten er slettet
  

## Oppgave 8

  

Både frontend.tf og vault.tf bruker en del lignende konfigurasjon. Se om du kan forenkle denne konfigurasjonen med å lage en modul.
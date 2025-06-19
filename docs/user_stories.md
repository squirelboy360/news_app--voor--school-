# User Stories met Acceptatie Criteria

## 1. Nieuwslijst bekijken
**Als gebruiker wil ik een lijst van nieuwsartikelen kunnen zien.**

**Acceptatie Criteria:**
- **Gegeven** de app is geopend
- **Wanneer** de startpagina geladen wordt
- **Dan** zie ik een lijst met nieuwsartikelen
- **En** elk artikel toont een titel
- **En** elk artikel toont een beschrijving
- **En** elk artikel toont een afbeelding (of placeholder)
- **En** de lijst bevat minimaal 1 artikel (indien data beschikbaar)

## 2. Artikel details zien
**Als gebruiker wil ik de titel, afbeelding en een korte beschrijving van elk artikel zien.**

**Acceptatie Criteria:**
- **Gegeven** ik bekijk de nieuwslijst
- **Wanneer** er artikelen geladen zijn
- **Dan** is elke titel leesbaar en volledig zichtbaar
- **En** is elke beschrijving beknopt maar informatief
- **En** wordt elke afbeelding correct weergegeven
- **En** zijn alle elementen goed uitgelijnd en leesbaar

## 3. Artikel details openen
**Als gebruiker wil ik op een artikel kunnen tikken om de volledige inhoud te bekijken.**

**Acceptatie Criteria:**
- **Gegeven** ik zie de nieuwslijst
- **Wanneer** ik op een artikel tik
- **Dan** opent er een detailpagina
- **En** zie ik de volledige artikelinhoud
- **En** zie ik alle artikel metadata (auteur, datum, bron)
- **En** kan ik terug naar de lijst

## 4. Publicatiedatum zien
**Als gebruiker wil ik kunnen zien wanneer een artikel is gepubliceerd.**

**Acceptatie Criteria:**
- **Gegeven** ik bekijk een artikel
- **Wanneer** het artikel een publicatiedatum heeft
- **Dan** wordt de datum leesbaar weergegeven
- **En** is het datumformaat consistent
- **En** is de datum recent en realistisch

## 5. Foutafhandeling internetverbinding
**Als gebruiker wil ik een foutmelding zien als er geen internetverbinding is.**

**Acceptatie Criteria:**
- **Gegeven** er is geen internetverbinding
- **Wanneer** de app probeert nieuws te laden
- **Dan** zie ik een duidelijke foutmelding
- **En** wordt uitgelegd wat het probleem is
- **En** zie ik een "Opnieuw proberen" knop
- **En** kan ik het opnieuw proberen wanneer internet terugkeert

## 6. Nieuws vernieuwen
**Als gebruiker wil ik dat het nieuws automatisch vernieuwd wordt.**

**Acceptatie Criteria:**
- **Gegeven** ik ben op de nieuwspagina
- **Wanneer** ik naar beneden trek (pull-to-refresh)
- **Dan** wordt er nieuwe data opgehaald
- **En** zie ik een loading indicator
- **En** wordt de lijst bijgewerkt met nieuwe artikelen
- **En** verdwijnt de loading indicator na voltooiing
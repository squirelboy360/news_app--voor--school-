# Handmatige Integratie Test Checklist

## Instructies
Run `flutter run` en test de volgende scenario's handmatig:

---

## ✅ AT001: App Opstarten
**Gegeven:** App is geïnstalleerd
**Wanneer:** Ik tik op app icoon
**Dan:** 
- [ ] App opent binnen 3 seconden
- [ ] Hoofdscherm wordt getoond
- [ ] Geen crashes of errors
- [ ] Loading indicator zichtbaar (kort)

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT002: Nieuws Lijst Laden
**Gegeven:** App is geopend
**Wanneer:** Hoofdscherm laadt
**Dan:**
- [ ] Nieuwsartikelen worden getoond
- [ ] Elke artikel heeft titel
- [ ] Elke artikel heeft beschrijving  
- [ ] Elke artikel heeft afbeelding (of placeholder)
- [ ] Minimaal 1 artikel zichtbaar

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT003: Navigatie Testen
**Gegeven:** Ik zie de nieuwslijst
**Wanneer:** Ik interacteer met navigatie elementen
**Dan:**
- [ ] Bottom navigation werkt (indien aanwezig)
- [ ] Tabs switchten correct (indien aanwezig)  
- [ ] App bar is zichtbaar
- [ ] Menu items reageren op tikken

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT004: Artikel Interactie
**Gegeven:** Ik zie nieuwsartikelen
**Wanneer:** Ik tik op een artikel
**Dan:**
- [ ] Detail pagina opent
- [ ] Volledige artikel content zichtbaar
- [ ] Terug knop werkt
- [ ] Geen crashes

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT005: Pull-to-Refresh
**Gegeven:** Ik ben op nieuws pagina
**Wanneer:** Ik trek naar beneden
**Dan:**
- [ ] Refresh indicator verschijnt
- [ ] Nieuwe data wordt geladen
- [ ] Indicator verdwijnt na laden
- [ ] Lijst wordt bijgewerkt

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT006: Scroll Functionaliteit
**Gegeven:** Er zijn meerdere artikelen
**Wanneer:** Ik scroll door de lijst
**Dan:**
- [ ] Scrollen is vloeiend (>50 FPS)
- [ ] Geen lag of stuttering
- [ ] Alle content blijft zichtbaar
- [ ] App reageert direct

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT007: Foutafhandeling Testen
**Instructie:** Zet WiFi uit en test app

**Gegeven:** Geen internetverbinding
**Wanneer:** App probeert data te laden
**Dan:**
- [ ] Duidelijke foutmelding
- [ ] "Opnieuw proberen" knop zichtbaar
- [ ] App crasht niet
- [ ] Gebruiksvriendelijke tekst

**Test 2:** Zet WiFi weer aan en tik "Opnieuw proberen"
- [ ] Data laadt succesvol
- [ ] Foutmelding verdwijnt
- [ ] Normale functionaliteit hersteld

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT008: Responsive Design
**Instructie:** Roteer device tussen portrait/landscape

**Gegeven:** App is open
**Wanneer:** Ik roteer het scherm
**Dan:**
- [ ] Layout past zich aan
- [ ] Geen content verdwijnt
- [ ] Navigatie blijft functioneel
- [ ] Geen visual glitches

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT009: Memory Management
**Instructie:** Gebruik app 5+ minuten, switch tussen apps

**Gegeven:** App draait langere tijd
**Wanneer:** Ik switch naar andere apps en terug
**Dan:**
- [ ] App behoudt state
- [ ] Geen memory crashes
- [ ] Performance blijft goed
- [ ] Data blijft beschikbaar

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## ✅ AT010: Edge Cases
**Test verschillende scenario's:**

### Lege/Geen Data:
- [ ] Graceful handling van lege response
- [ ] Duidelijke melding "Geen nieuws beschikbaar"

### Lange Teksten:
- [ ] Lange titels worden correct afgekapt
- [ ] Layout breekt niet bij veel tekst

### Afbeelding Problemen:
- [ ] Placeholder bij ontbrekende afbeeldingen
- [ ] Geen crashes bij ongeldige image URLs

**Resultaat:** ✅ / ❌
**Opmerkingen:** ___________

---

## 📊 Test Samenvatting

| Test ID | Beschrijving | Status | Opmerkingen |
|---------|-------------|--------|-------------|
| AT001 | App Opstarten | ✅ / ❌ | |
| AT002 | Nieuws Lijst | ✅ / ❌ | |
| AT003 | Navigatie | ✅ / ❌ | |
| AT004 | Artikel Interactie | ✅ / ❌ | |
| AT005 | Pull-to-Refresh | ✅ / ❌ | |
| AT006 | Scroll Functionaliteit | ✅ / ❌ | |
| AT007 | Foutafhandeling | ✅ / ❌ | |
| AT008 | Responsive Design | ✅ / ❌ | |
| AT009 | Memory Management | ✅ / ❌ | |
| AT010 | Edge Cases | ✅ / ❌ | |

**Totaal Geslaagd:** ___/10
**Success Rate:** ___%

---

## 🎯 Acceptatie Beslissing

- [ ] **GEACCEPTEERD** - Alle kritieke tests geslaagd
- [ ] **VOORWAARDELIJK** - Kleine issues gevonden
- [ ] **AFGEKEURD** - Kritieke problemen gevonden

**Handtekening Tester:** _______________
**Datum:** 19 juni 2025

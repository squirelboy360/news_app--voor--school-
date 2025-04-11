# Ontwerpen

## Gebruikte schema's
- **ERD / JSON-structuur** voor API-data
- **Wireframes** voor UI-lay-out
- **Flowchart / Activiteitendiagram** voor logica zoals data ophalen & error handling

## Technische keuzes
- iOS en android app in flutter
- REST API (Saurav Tech NewsAPI)
- GitHub voor versiebeheer

## Code Architectuur
- Gedeeld NewsArticle model voor alle nieuwstypen
- Gecentraliseerde API endpoints in links.dart
- Error handling consistent geïmplementeerd in alle schermen

## Privacy & Security
- Geen persoonsgegevens opgeslagen
- Alleen lezen van externe API (geen risico op lekken)
- Geen tracking of analytics
# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

## [1.0.0] - 2025-12-30

### ✨ Ajouté
- Logger principal avec 20+ catégories d'emojis
- Extension BuildContext pour accès facile (`context.log`)
- Support des timers de performance avec statistiques
- Configuration flexible (dev, prod, custom)
- Logs structurés (tables, JSON, sections)
- Support des niveaux de log (verbose, debug, info, warning, error, success)
- Catégories spécialisées :
    - 🌐 Network (HTTP requests/responses)
    - 💾 Database
    - 🔑 Authentication
    - 🧭 Navigation
    - 🎨 UI/UX
    - 💳 Payment
    - 💬 Chat
    - 🔥 Firebase
    - 🚀 API
    - 📁 File operations
    - 🔔 Notifications
    - ⏱️ Performance
    - 📊 Analytics
    - 🛡️ Security
- Tracking des actions utilisateur
- Logging des changements d'état
- Support des stack traces formatées
- Méthodes `measure()` pour timing automatique
- Statistiques détaillées des timers
- Logging du cycle de vie des widgets
- HTTP status code logging
- HTTP body logging avec truncation
- Utilisation de `developer.log` au lieu de `print`

### 📝 Documentation
- README complet avec exemples
- Documentation inline des méthodes
- Exemples d'utilisation pratiques
- Guide des bonnes pratiques

### ⚙️ Configuration
- Mode développement (tous les logs)
- Mode production (logs minimaux)
- Configuration personnalisée
- Désactivation de catégories spécifiques
- Contrôle du niveau minimum de log
- Options de formatage (timestamp, stack trace, etc.)

### 🎯 Fonctionnalités avancées
- Timer avec historique et statistiques
- Formatage de tables
- Logging JSON structuré
- Sections visuelles pour organiser les logs
- Support des méthodes entry/exit tracking
- User action tracking avec contexte
- State change tracking
- Widget lifecycle logging
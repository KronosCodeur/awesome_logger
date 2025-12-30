# 🎨 Awesome Logger

Un package de logging élégant et puissant pour Flutter avec des emojis, des catégories, et un accès facile via le `BuildContext`.

## ✨ Fonctionnalités

- 🎯 **Emojis contextuels** pour chaque type de log
- 📱 **Accès via context** pour un logging simplifié
- ⏱️ **Timers intégrés** pour mesurer les performances
- 🎨 **Catégories spécialisées** (Network, Database, Auth, etc.)
- 📊 **Formatage structuré** (tables, JSON, sections)
- 🚫 **N'utilise PAS `print()`** mais `developer.log()`
- ⚙️ **Configuration flexible** (dev, prod, custom)
- 🎭 **Niveaux de log** (success, info, warning, error, etc.)
- 📈 **Statistiques de timers** pour l'analyse de performance

## 📦 Installation

Ajoutez ce package à votre `pubspec.yaml`:

```yaml
dependencies:
  awesome_logger: ^1.0.0
```

## 🚀 Utilisation rapide

### Configuration initiale

```dart
import 'package:awesome_logger/awesome_logger.dart';

void main() {
  // Configuration pour le développement
  AwesomeLogger.configure(AwesomeLoggerConfig.development());
  
  // Ou configuration personnalisée
  AwesomeLogger.configure(AwesomeLoggerConfig(
    enabled: true,
    showTimestamp: true,
    logHttpBodies: true,
    maxBodyLength: 500,
  ));
  
  runApp(MyApp());
}
```

### Utilisation avec le Context (Recommandé ✅)

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Logger accessible via context.log
    context.log.info('Widget construit');
    context.log.success('Opération réussie');
    context.log.error('Une erreur est survenue');
    
    return Container();
  }
}
```

### Utilisation statique

```dart
// Logs de base
AwesomeLogger.success('Utilisateur connecté');
AwesomeLogger.info('Chargement des données');
AwesomeLogger.warning('Cache expiré');
AwesomeLogger.error('Échec de connexion', error: e, stackTrace: stack);

// Logs par catégorie
AwesomeLogger.network('GET /api/users');
AwesomeLogger.database('Query executed: SELECT * FROM users');
AwesomeLogger.auth('Token refreshed');
AwesomeLogger.firebase('Event logged: user_login');
AwesomeLogger.payment('Payment processed: \$99.99');
```

## 📚 Exemples détaillés

### 1. Logs basiques

```dart
// Niveaux de log
context.log.verbose('Détails techniques');
context.log.debug('Information de débogage');
context.log.info('Information générale');
context.log.warning('Attention requise');
context.log.error('Erreur critique');
context.log.success('Opération réussie');
```

### 2. Logs par catégorie

```dart
// Network
context.log.network('API call started');
context.log.httpStatus(200, '/api/users', method: 'GET');
context.log.httpBody(jsonEncode(responseData), type: 'RESPONSE');

// Database
context.log.database('User saved to local DB');

// Authentication
context.log.auth('User logged in with email');

// Navigation
context.log.navigation('Navigated to ProfileScreen');

// UI
context.log.ui('Button rendered with animation');

// Analytics
context.log.analytics('Event tracked: button_clicked');

// Security
context.log.security('JWT token validated');
```

### 3. Timers et Performance

```dart
// Timer simple
context.log.startTimer('data_load');
await loadData();
context.log.stopTimer('data_load'); // Affiche: Timer data_load: 1234ms

// Avec measure (recommandé)
await context.log.measure('api_call', () async {
  final result = await fetchFromApi();
  return result;
});

// Statistiques des timers
final stats = AwesomeLogger.getTimerStats('api_call');
// { count: 5, average: '234.5ms', min: '120ms', max: '450ms' }
```

### 4. Logging structuré

```dart
// Table
AwesomeLogger.table({
  'User ID': '12345',
  'Name': 'John Doe',
  'Email': 'john@example.com',
  'Status': 'Active',
}, title: 'User Information');

// JSON
AwesomeLogger.json({
  'users': [1, 2, 3],
  'total': 100,
}, description: 'API Response');

// Section
AwesomeLogger.section('USER AUTHENTICATION');
AwesomeLogger.info('Checking credentials...');
AwesomeLogger.success('Authentication successful');
AwesomeLogger.separator();
```

### 5. Tracking des actions utilisateur

```dart
context.log.userAction('button_pressed', context: {
  'button_id': 'submit_form',
  'screen': 'ProfileScreen',
});

context.log.stateChange('loading', 'loaded');

context.log.lifecycle('initState');
```

### 6. Gestion des erreurs

```dart
try {
  await riskyOperation();
} catch (e, stack) {
  context.log.error(
    'Operation failed',
    error: e,
    stackTrace: stack,
  );
}
```

## ⚙️ Configuration

### Modes prédéfinis

```dart
// Développement (tous les logs)
AwesomeLogger.configure(AwesomeLoggerConfig.development());

// Production (logs minimaux)
AwesomeLogger.configure(AwesomeLoggerConfig.production());
```

### Configuration personnalisée

```dart
AwesomeLogger.configure(AwesomeLoggerConfig(
  enabled: true,                    // Activer/désactiver les logs
  forceEnable: false,               // Forcer même en release
  showTimestamp: true,              // Afficher les timestamps
  showStackTrace: true,             // Afficher les stack traces
  logHttpBodies: true,              // Logger les corps HTTP
  logMethodCalls: false,            // Logger entrée/sortie méthodes
  maxBodyLength: 1000,              // Longueur max des corps HTTP
  disabledCategories: {'DEBUG'},    // Catégories désactivées
  minLevel: 0,                      // Niveau minimum (0-1000)
));
```

### Désactiver des catégories spécifiques

```dart
AwesomeLogger.configure(
  AwesomeLoggerConfig.withDisabledCategories({
    'VERBOSE',
    'DEBUG',
    'UI',
  }),
);
```

## 🎨 Liste complète des emojis

| Catégorie | Emoji | Méthode |
|-----------|-------|---------|
| Success | ✅ | `success()` |
| Error | ❌ | `error()` |
| Warning | ⚠️ | `warning()` |
| Info | ℹ️ | `info()` |
| Debug | 🔍 | `debug()` |
| Verbose | 📝 | `verbose()` |
| Network | 🌐 | `network()` |
| Database | 💾 | `database()` |
| Auth | 🔑 | `auth()` |
| Navigation | 🧭 | `navigation()` |
| UI | 🎨 | `ui()` |
| Payment | 💳 | `payment()` |
| Chat | 💬 | `chat()` |
| Firebase | 🔥 | `firebase()` |
| API | 🚀 | `api()` |
| File | 📁 | `file()` |
| Notification | 🔔 | `notification()` |
| Performance | ⏱️ | `performance()` |
| Analytics | 📊 | `analytics()` |
| Security | 🛡️ | `security()` |

## 🎯 Bonnes pratiques

1. **Configuration au démarrage** - Configurez le logger dans `main()`
2. **Utilisez context.log** - Plus pratique et contextuel
3. **Catégories appropriées** - Utilisez la bonne catégorie pour chaque log
4. **Timers pour la performance** - Mesurez les opérations critiques
5. **Erreurs avec stack traces** - Toujours inclure le stack trace
6. **Production mode** - Désactivez les logs verbeux en production

## 📝 Exemple complet

```dart
class UserService {
  Future<User> loginUser(String email, String password) async {
    AwesomeLogger.section('USER LOGIN');
    AwesomeLogger.auth('Attempting login for: $email');
    
    AwesomeLogger.startTimer('login_process');
    
    try {
      // API Call
      AwesomeLogger.network('POST /api/auth/login');
      final response = await api.login(email, password);
      
      AwesomeLogger.httpStatus(response.statusCode, '/api/auth/login', method: 'POST');
      
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        
        // Save to database
        AwesomeLogger.database('Saving user to local DB');
        await db.saveUser(user);
        
        // Track analytics
        AwesomeLogger.analytics('Event: user_login_success');
        
        AwesomeLogger.success('User logged in successfully');
        AwesomeLogger.stopTimer('login_process');
        
        return user;
      } else {
        throw Exception('Login failed');
      }
    } catch (e, stack) {
      AwesomeLogger.error('Login failed', error: e, stackTrace: stack);
      AwesomeLogger.stopTimer('login_process');
      rethrow;
    }
  }
}
```

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou une pull request.

## 📄 Licence

MIT License - voir le fichier LICENSE pour plus de détails.

## 👨‍💻 Auteur

Créé avec ❤️ pour la communauté Flutter

---

**Note**: Ce package utilise `dart:developer` au lieu de `print()` pour une meilleure intégration avec les outils de développement Flutter et des performances optimales.
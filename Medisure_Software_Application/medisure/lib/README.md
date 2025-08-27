## <img src="https://github.com/user-attachments/assets/f3dcee8e-e008-457a-97fb-d3848b425713" height="30px" style="vertical-align:text-bottom;"> Repository Structure – medisure/lib/

- `medisure/lib/models` → Defines the **data models** used across the app. Structures application data and ensures consistent handling of entities. Example: user_model.dart manages user-related information, parsing, and interactions.  
- `medisure/lib/screens` → Contains all the **UI screens (pages)** of the app. Each screen represents a distinct feature or flow. Example: levels.dart displays user levels, progress, or health-related data.  
- `medisure/lib/services` → Holds **backend service integrations and configurations** such as API calls and Firebase/Firestore setup. Example: firestore_options.dart manages Firebase/Firestore initialization and configuration.  
- `medisure/lib/utils` → Provides **helper functions, constants, and reusable logic** for cleaner code and consistency. Example: UI_helper.dart centralizes UI helpers like text styles, paddings, or form fields.  
- `medisure/lib/widgets` → Stores **custom reusable widgets** that promote a component-based architecture. Examples include buttons, input fields, loaders, and cards.  
- `main.dart` → The **entry point** of the Flutter app. Initializes the app, sets up themes, manages routing, and defines the root widget. Example tasks: configuring MaterialApp, applying global themes, and handling navigation.  

### ✨ Features – `medisure/lib/`

- **Models (`medisure/lib/models/`)** → 📑 Consistent entity management (users, health stats, etc.)  
- **Screens (`medisure/lib/screens/`)** → 🖥️ Interactive app flows (levels, progress tracking, dashboards)  
- **Services (`medisure/lib/services/`)** → ☁️ Real-time backend integration (Firebase, Firestore, APIs)  
- **Utils (`medisure/lib/utils/`)** → 🛠️ Centralized helpers (UI styles, constants, form validation)  
- **Widgets (`medisure/lib/widgets/`)** → 🎨 Reusable UI components (buttons, cards, loaders)  
- **Main (`medisure/lib/main.dart`)** → 🚀 App entry point with themes, routing, and navigation  
- **General** → 🔐 Secure login & profile management, 💾 Local + Cloud storage, 🔗 Real-time data sync with Medisure device  

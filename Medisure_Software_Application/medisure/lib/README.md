## <img src="https://github.com/user-attachments/assets/f3dcee8e-e008-457a-97fb-d3848b425713" height="30px" style="vertical-align:text-bottom;"> Repository Structure – medisure/lib/

- `medisure/lib/models` → Defines the **data models** used across the app. Structures application data and ensures consistent handling of entities. Example: user_model.dart manages user-related information, parsing, and interactions.  
- `medisure/lib/screens` → Contains all the **UI screens (pages)** of the app. Each screen represents a distinct feature or flow. Example: levels.dart displays user levels, progress, or health-related data.  
- `medisure/lib/services` → Holds **backend service integrations and configurations** such as API calls and Firebase/Firestore setup. Example: firestore_options.dart manages Firebase/Firestore initialization and configuration.  
- `medisure/lib/utils` → Provides **helper functions, constants, and reusable logic** for cleaner code and consistency. Example: UI_helper.dart centralizes UI helpers like text styles, paddings, or form fields.  
- `medisure/lib/widgets` → Stores **custom reusable widgets** that promote a component-based architecture. Examples include buttons, input fields, loaders, and cards.  
- `README.md` → Local documentation specific to the `lib/` directory, helping developers quickly understand its structure and conventions.  
- `main.dart` → The **entry point** of the Flutter app. Initializes the app, sets up themes, manages routing, and defines the root widget. Example tasks: configuring MaterialApp, applying global themes, and handling navigation.  

## ✨ Features

- 📊 **Health Tracking** – Monitor user progress, levels, and health-related stats.  
- 🔐 **Authentication & User Management** – Secure login, registration, and user profile handling.  
- ☁️ **Cloud Integration** – Firebase/Firestore support for real-time data storage and retrieval.  
- 🎨 **Reusable UI Components** – Consistent design with custom widgets for buttons, forms, and cards.  
- ⚡ **Optimized Performance** – Centralized utilities for smooth and efficient app execution.  
- 🛠️ **Scalable Architecture** – Clean separation of models, services, utils, and widgets for maintainability.  


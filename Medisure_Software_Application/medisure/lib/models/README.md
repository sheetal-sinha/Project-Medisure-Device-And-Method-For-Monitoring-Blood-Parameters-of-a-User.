## <img src="https://github.com/user-attachments/assets/f3dcee8e-e008-457a-97fb-d3848b425713" height="30px" style="vertical-align:text-bottom;"> Repository Structure – medisure/lib/models

👤 `user_model.dart`: Defines the structure for **user-related data**. Includes fields such as `id`, `name`, `email`, and other authentication/profile details. Ensures consistent handling of user information across the app. Example usage: when signing in, user data is parsed & stored using this model.  

📊 `record_model.dart` : Represents **health-related records** such as blood glucose levels and SpO₂ readings. Defines fields for measurement values, units, and timestamps. Ensures accurate storage and retrieval of test data for each user. Example usage: saving a new health record to **Firebase** or displaying past records in **History Screen**.  

---

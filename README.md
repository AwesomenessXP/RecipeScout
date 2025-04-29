# RecipeScout

### Summary: Include screen shots or a video of your app highlighting its features
I built a recipe app that fetches and displays a list of recipes from the provided API. I structured the project using MVVM + Clean Architecture approach, separating networking, caching, domain logic, and UI. The app shows each recipe’s name, cuisine type, and photo. It supports pull-to-refresh to reload recipes at any time and efficiently loads pre-loads the images for the cells. I implemented an image cache system by reading and writing to a thread-safe disk cache. The app gracefully handles empty data and malformed data cases by displaying appropriate empty or error states. Unit tests are included for core functionality such as data fetching and image caching. Overall, the app is fast, memory-efficient, and adheres closely to best practices for modern iOS development.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I focused on structuring the code with a clear separation of concerns using MVVM combined with a lightweight Clean Architecture approach. This allowed me to isolate networking, caching, domain models, and UI layers cleanly, with proper dependency injection. I chose to emphasize architecture because it ensures the app is maintainable, testable, and easy to extend as new features are added. I also prioritized writing modular, testable core components (such as the network client, disk cache, and image loader) to demonstrate production-ready code practices.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent around 5 hours on the core features. I then invested a bit of additional time refining architecture, caching strategies, and adding extra polish to align with production-level practices.”

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I made deliberate trade-offs to prioritize scalable architecture, clean separation of concerns, and robust core logic over UI/UX polish, and decided not to follow Clean Architecture strictly for convenience. I didn't use a service for fetching recipes for the sake of simplicity. I chose not to over-engineer areas like adding in-memory cache or cache eviction policies. In a production setting, these areas could be extended further depending on scale and feature requirements. I also chose not to test or mock the network client implementation because it wraps around default networking library, which is stable. For the sake of simplicity, I assume that only 2XX status codes are valid. When designing the ImageLoader, I chose not to inject it into FetchRecipesUseCase, which makes testing easier so I don't have to worry about testing nested tasks, which are would take additional testing setup.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of the project is that the clean architecture approach introduces additional upfront complexity compared to a simpler, flatter project structure. While this layered architecture (separating Data, Domain, and Presentation layers) makes the app more scalable and maintainable over time, it can make adding very small features feel heavier than necessary, especially at the current early stage of the project. If the app were to remain a very small project, a flatter MVVM structure might have been more pragmatic. However, I chose to prioritize scalability and testability to reflect how I would structure a real production application.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I really enjoyed the challenge of balancing clean code structure with practical project scope.

![Simulator Screenshot - iPhone 16 Pro - 2025-04-28 at 19 22 26](https://github.com/user-attachments/assets/14586ec5-0a9e-4429-bc9e-b4c52e049d10)

![Simulator Screenshot - iPhone 16 Pro - 2025-04-28 at 19 22 59](https://github.com/user-attachments/assets/07861fe2-983e-401d-b7e5-c097c60a7c29)

![Simulator Screenshot - iPhone 16 Pro - 2025-04-28 at 19 23 11](https://github.com/user-attachments/assets/cc0da621-277e-4819-b047-6445059f11c7)

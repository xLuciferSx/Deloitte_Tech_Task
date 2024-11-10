# Project Tasks

Please use the following checklist to track the progress of the project tasks:

- [ ] **Task 1**: Remove the dependencies `Alamofire` and `AlamofireImage` added via Swift Package Manager. Replace their usage with native frameworks, ensuring existing functionality is maintained.

- [ ] **Task 2**: Replace the images in the assets folder with native SF Symbols, using images similar to those provided.

- [ ] **Task 3**: Replace the use of string identifiers throughout the app (e.g., `let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailContainer") as! DetailViewContainerViewController`) with a type-safe approach using enumerations.

- [ ] **Task 4**: Implement the following features for the wish list and basket:
  - Allow users to add products to a wish list and a basket.
  - Display added products in the wish list view with an option to remove them.
  - Enable users to move products from the wish list to the basket, removing them from the wish list upon action.
  - Adjust the product available count when a product is added to the basket.
  - Include a basket cost total.
  - Ensure an item can only be added to the wish list once.
  - Increase the count of an item in the basket if it's added more than once.
  - Prevent adding out-of-stock items to the basket.

- [ ] **Task 5**: Convert the main catalogue page from a UIKit `UICollectionView` to a SwiftUI view, maintaining all existing functionality and look and feel.

- [ ] **Task 6**: Use the Combine framework to make the `tabBar` reactive:
  - Display a badge on the `tabBar` item with a product count when a product is added to the wish list or basket.
  - Update the badge to reflect the number of items in the wish list or basket as items are added or removed.

- [ ] **Task 7**: Refactor the project by:
  - Separating views into separate Storyboards as necessary.
  - Implementing the Coordinator pattern for all navigation within the app.

- [ ] **Task 8**: Develop offline capability using Core Data:
  - On first load, save the contents of the catalogue to a persistent store.
  - Display catalogue contents when the device is in airplane mode (simulate offline mode).
  - Refactor the app to accommodate this functionality.
  - Maintain product availability counts throughout the app (e.g., updating counts when items are added to the basket but not when added to the wish list).

- [ ] **Task 9**: Add one appropriate Unit or UI test of your choice to the project.

- [ ] **Task 10**: Make additional UI tweaks and adjustments to improve the user interface. (Tip: A few UI issues have been intentionally left to facilitate this.)

---

Feel free to check off each task as you complete them. If you have any questions or need clarification on any task, please don't hesitate to ask.

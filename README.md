# NTBanker

NTBanker aims to streamline the Monopoly experience by removing the need for paper money and a dedicated banker. Each player now has a customizable card that displays their current balance and allows users to send money to other players, react to in-game events, and keep up-to-date rankings.


This is a rewrite for the original version which used UIKit + MVVM. The goal with this project was to create an updated version using my newly acquired experience from Lyft plus use newer technologies like SwiftUI + The Composable Architecture. This resulted in a more modern codebase that follows a coding style and consists of isolated features that are unit tested.


## Screenshots
<table>
  <thead>
    <tr>
      <th colspan="5">English</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>
            <img src="https://github.com/0xJavier/NTBanker/assets/20247642/f384115d-9dc9-494e-8223-c4441404ba6a" height="550"/>
        </td>
        <td>
            <img src="https://github.com/0xJavier/NTBanker/assets/20247642/ae8f5ae1-6ce1-4a73-ab9a-6d7f057f01ed" height="550"/>
        </td>
        <td>
            <img src="https://github.com/0xJavier/NTBanker/assets/20247642/59af0336-1bb1-486c-be8d-cef816b5b92c" height="550"/>
        </td>
    </tr>
  </tbody>
</table>

<table>
  <thead>
    <tr>
      <th colspan="5">Spanish</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>
            <img src="https://github.com/0xJavier/NTBanker/assets/20247642/ca8532d4-a086-4e05-9e9b-82e8f96d845a" height="550"/>
        </td>
        <td>
            <img src="https://github.com/0xJavier/NTBanker/assets/20247642/fc22527f-ea50-497b-a7fe-eb48d6786a7c" height="550"/>
        </td>
        <td>
            <img src="https://github.com/0xJavier/NTBanker/assets/20247642/cc745bda-3df3-4c7b-ac94-3823b7e2c816" height="550"/>
        </td>
    </tr>
  </tbody>
</table>

## App Features
* Keep track of your balance with color customizable cards.
* Streamline in-game events with quick actions and keep track of your spending with the transaction history.
* Quickly send money to the bank, lottery, or other players.
* Always know who is leading the game with up to date rankings.
* Win big through the lottery as it grows throughout the game.

## Technologies Used
* Swift + SwiftUI.
* Unidirectional data flow using [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture).
* Features backed with unit tests (WIP).
* Async/await networking layer.
* Dependency Injection allowing for a mock service layer to power SwiftUI previews + unit tests.
* Firebase backend through Swift Package Manager.
* Localization for Spanish-speaking users.

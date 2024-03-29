# Lodgify - Flutter Technical Challenge

## The project was develop in Flutter 2.8.0 and tested in mobile and desktop devices, following the requirements.

### Screenshots
<p float="left">
  <img width="180" height="360" src="https://user-images.githubusercontent.com/70621340/147396099-1a5f2e8e-15f1-4c07-bf34-0cf12145426c.png">
  <img width="520" height="360" src="https://user-images.githubusercontent.com/70621340/147396100-26ef89eb-6392-4c78-9fe9-32e39920bc38.png">
</p>


### CI/CD
The project has a simple CI/CD workflow, using GitHub Actions.

Each time a main branch push is made:
- The project will be recompiled,
- All tests will be run,
- An android app will be generated and stored in the Artifacts section of the [workflow run](https://github.com/LuisMaGit/lodgify-flutter-test/actions/runs/1627087048).

### Architecture
The app follows a simplification of the [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) architecture, for simplicity reasons the project consists of only 3 parts. Views (Home), ViewModels (HomeVM) and Services (Data from Api). The Home View on top, the closest to the user, the Home ViewModel below that, taking input from the View and the Network Service which is what the ViewModel make use of to provide functionality.

<p float="left">
  <img width="800" height="240" src="https://user-images.githubusercontent.com/70621340/147396116-ee8c3514-e2eb-4672-a168-2cf8be57993f.png">
</p>

__With this architecture the project achieves__:
* _Separation of concerns and cleaner code:_ the view (Home) and the reusable widgets are the only elements where there is UI code (Flutter code), both the ViewModel and the Service are purely dart code (business logic of the app). Also the ViewModel only exposes to the View the methods and state that this requires to operate, and the service only expose an interface, that is accessed by the ViewModel.
* _UI state maintenance_: the state, being decoupled from the UI (it is kept in the ViewModel) allows, that no matter how the widget tree is recomposed, the state will always remain unchanged. For example, being this a responsive app, the layout can change from mobile to desktop and it will not affect the user experience, the state will remain unchanged.
* _Clear unit testing_: the logic that controls the View in the ViewModel can and it is easily tested in the `[test\viewmodel_tests\home_vm_test]` file.
* _Scalability_. 

### External libraries:
This project no needs any specific resource of the native platforms, so it can be done with no dependencies (I did something similar [here (app with no dependencies)](https://github.com/LuisMaGit/flutter_crypto), but the libraries used avoid some boilerplate code and in general make a better app.

_Production dependencies_
* http: clean network call
* provider: painless state management
* flutter_svg: all icons were exported as svg (infinity quality and very small size)
* get_it: painless dependency injection

_Dev dependencies_
* mockito: mocking in test
* build_runner: code generation
* flutter_lints: better code


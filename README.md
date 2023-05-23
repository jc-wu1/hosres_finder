
# HosRes Finder

*The project uses the Google Maps API to fetch map data*
*This project is not tested in iOS, consider using Android to run this project*

## App Overview

The application is composed by one primary screens: **Home Page**.
On first launch, the app asks the user to enable location service and permission.

You can see your current address and location in the headers. You can change your location to desired location by clicking at your location, then **Map Page** will open and you can drag and drop Marker to desired location then click Save.

On the right of your location, you can find Fav button to see the list of favorites place.

The **Home Page** page loads a list of current hospitals and restaurants nearby from the Google Map API. Results are adjusted to ensure the accuracy.

## Features

- Find nearby hospital and restaurant from your location
- Save favorites places to local storage
- Change your location easily by drag and drop

## Project Structure

This project was made using Clean Architecture approach and bloc pattern

<img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?ssl=1" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

### Bloc

![Bloc Architecture](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_architecture_full.png)

A `Bloc` is a more advanced class which relies on `events` to trigger `state` changes rather than functions. `Bloc` also extends `BlocBase` which means it has a similar public API as `Cubit`. However, rather than calling a `function` on a `Bloc` and directly emitting a new `state`, `Blocs` receive `events` and convert the incoming `events` into outgoing `states`.

![Bloc Flow](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_flow.png)

State changes in bloc begin when events are added which triggers `onEvent`. The events are then funnelled through an `EventTransformer`. By default, each event is processed concurrently but a custom `EventTransformer` can be provided to manipulate the incoming event stream. All registered `EventHandlers` for that event type are then invoked with the incoming event. Each `EventHandler` is responsible for emitting zero or more states in response to the event. Lastly, `onTransition` is called just before the state is updated and contains the current state, event, and next state.

#### Creating a Bloc

```dart
/// The events which `CounterBloc` will react to.
sealed class CounterEvent {}

/// Notifies bloc to increment state.
final class CounterIncrementPressed extends CounterEvent {}

/// A `CounterBloc` which handles converting `CounterEvent`s into `int`s.
class CounterBloc extends Bloc<CounterEvent, int> {
  /// The initial state of the `CounterBloc` is 0.
  CounterBloc() : super(0) {
    /// When a `CounterIncrementPressed` event is added,
    /// the current `state` of the bloc is accessed via the `state` property
    /// and a new state is emitted via `emit`.
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }
}
```

#### Using a Bloc

```dart
Future<void> main() async {
  /// Create a `CounterBloc` instance.
  final bloc = CounterBloc();

  /// Access the state of the `bloc` via `state`.
  print(bloc.state); // 0

  /// Interact with the `bloc` to trigger `state` changes.
  bloc.add(CounterIncrementPressed());

  /// Wait for next iteration of the event-loop
  /// to ensure event has been processed.
  await Future.delayed(Duration.zero);

  /// Access the new `state`.
  print(bloc.state); // 1

  /// Close the `bloc` when it is no longer needed.
  await bloc.close();
}
```

### Project Structure

```
/lib
	/core
		/dependency_injector
			dependency_injector.dart
		/error
			exceptions.dart
			failures.dart
		/network
			dio_wrapper.dart
			network_info.dart
		/usecase
			usecase.dart
		constants.dart
	/features
		/fav_places
			/data
			/display		<--- presentation
			/domain
		/geocoder
			/bloc
			/data
			/domain
		/geolocator
			/bloc
			/data
			/domain
		/home
			/widgets
			home_page.dart
		/map
			map_page.dart
		/permission
			permission_page.dart
		/places
			/bloc
			/data
			/domain
		/search
			/data
			/display		<--- presentation
			/domain
	hosres_app.dart
	main.dart
```

## State Management

State management used in this project is:

- [x] [flutter_bloc](https://pub.dev/packages/flutter_bloc) (using `BloC`)
 

## Future Roadmap

- Add more screens
- Polish the UI
- Fix bugs

## Other packages in use

The "core" package of the app uses the following packages:

- [Google Map](https://pub.dev/packages/google_maps_flutter) for map provider
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) for state management
- [dio](https://pub.dev/packages/dio) for the API client and [Retrofit](https://pub.dev/packages/dio) for generate API client
- [Equatable](https://pub.dev/packages/equatable) for comparing two classes
- [Shared Preferences](https://pub.dev/packages/shared_preferences) for local storage
- [Permission](https://pub.dev/packages/permission_handler) for handling permission
- [GetIt](https://pub.dev/packages/get_it) dependency injector packages
  
## Google API

This project uses the Google Map API to get the map data.

Before running the app you need to [enable Google Map API](https://www.themoviedb.org/signup), then obtain an API key on the [credential page](https://www.themoviedb.org/settings/api).

Once you have this, update API key in `constant.dart` file inside `lib/core/`, and add your key:

```dart
/// Restricted Google Map API Key
const  String  apiKey = 'YOUR_API_KEY';
```
Congratulations, you're good to go. 😎
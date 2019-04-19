<img src="https://static.mparticle.com/sdk/mp_logo_black.svg" width="280">

## Inspector Gadget

Inspector Gadget is a UI widget which attaches to the [mParticle Apple SDK](https://github.com/mParticle/mparticle-apple-sdk). It's designed to help you debug your mParticle implementation and API usage, as well as the inner workings of the mParticle Apple SDK.

#### Requirements:

- 'mParticle-Apple-SDK' Version 7.9.3

## Adding Inspector

In your app-level `Podfile` file, add the following dependency:

```ruby
target '<Your Target>' do
    pod 'mParticle-Apple-SDK'
    pod 'mParticle-Apple-Inspector'
end
```

> **Note**: You should not ship Inspector to a production app. For this reason you should only add the dependency to a debug or test target.

## Initializing Inspector

Inspector uses a new `MPListenerProtocol` protocol exposed by the mParticle Apple SDK. 

This `MPListenerProtocol` interface will only be used if:

- You initialize an instance of the InspectorViewController in this SDK, OR
- You create a class that confirms to the MPInspectorProtocol and set the delegate on MPInspectorController yourself

```swift
let inspectorVC =  InspectorViewController.init()
```

```swift
// This method of using the protocol does not make use of this sdk.
let sdkListener = someClassThatImplementsProtocol()

MPListenerController.sharedInstance().addSdkListener(sdkListener)
```

## Viewing Inspector

When the application starts, Inspector will not be visible and no data will be collected until you initialize the InspectorViewController. We reccomend you instantiate the class as early as possible and retain the instance to display as you need.

####  Swift

```swift
let inspectorVC =  InspectorViewController.init()
let navigator = UINavigationController(rootViewController: inspectorVC)

self.show(navigator, sender: self)
```

#### Objective-C

```objective-c
InspectorViewController *inspectorVC =  [[InspectorViewController alloc] init];
UINavigationController *navigator = [[UINavigationController alloc] initWithRootViewController:inspectorVC];

[self showViewController:navigator sender: self];
```

### Exploring Inspector's Views

There are three main views in Inspector. You can navigate between the three by swiping vertically. All three will not necessarily be present at any given time.

Most events that populate these views are expandable, which is done with a simple click. When an event is expanded, you might notice that some have fields with an orange background. **This indicates that the event is "followable" in the PathFinder view**. If you click the orange area, you will be taken to the PathFinder View for that event. Events that are followable currently consist of certain API and network events.

#### Feed View

This is a real-time chronological list of SDK events. Events populate from the bottom in chronological order

#### All Events View

This list is a categorized collection of all the events that have been collected since the SDK was started. Most categories are arranged chronologically and some such as "state" are pinned.

#### PathFinder View

The PathFinder view is used to show the causal relationship between related events. This is where you will see the events that occurred because of another event, or the events that went into an event. This view exposed the inner working of the mParticle Android SDK for dissection.

For example, if your code calls `MParticle.sharedInstance().logEvent()` you can select the resulting "API call" event and you should see the resulting "message" that was created as a result of the API call. Then an "upload" message that was created as a result of the "message", and finally the "events" network request that was completed as a result of the upload message.

**Click** the orange area of a "followable" event to be taken to the PathFinder view

# NetworkManagerSwiftUI
* AppStuff: https://www.youtube.com/watch?v=YIx3e0xWKtk
* Paul Hudson: https://www.hackingwithswift.com/example-code/networking/how-to-check-for-internet-connectivity-using-nwpathmonitor

Internet Connection        |  No Internet Connection   |
:-------------------------:|:-------------------------:|
<img src="https://github.com/Brian-McIntosh/NetworkManagerSwiftUI/blob/main/images/1.png" width="120"/>  |  <img src="https://github.com/Brian-McIntosh/NetworkManagerSwiftUI/blob/main/images/2.png" width="120"/>


### ContentView.swift
```swift
@ObservedObject var networkManager = NetworkManager()
.
.
Image(systemName: networkManager.imageName) //<-- computed property
Text(networkManager.connectionDescription) //<-- computed property
if !networkManager.isConnected {...}
```

### NetworkManager.swift
```swift
class NetworkManager: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = false
    
    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    var connectionDescription: String {
        if isConnected {
            return "Internet connection looks good!"
        }else{
            return "It looks like you're not connected to the Internet."
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            
            // another way to write?? this is not more clear!
            // self.isConnected = path.status == .satisfied
            
            if path.status == .satisfied {
                // b/c isConnected affects the main UI
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            }else{
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
        
        monitor.start(queue: queue)
    }
}
```

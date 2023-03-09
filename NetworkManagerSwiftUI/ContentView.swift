//
//  ContentView.swift
//  NetworkManagerSwiftUI
//
//  Created by Brian McIntosh on 3/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        /*
         In a real-world app, you might want a Group like this:
         
         Group {
             if networkManager.isConnected {
                 // show main Content
             }else{
                 // show failed Internet screen
                 // could be a banner, the implementation is up to you
             }
         }
         */
        
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            
            VStack {
                /*
                 Conditional Logic here? Or, Computed Properties in NetworkManager!!
                 */
                Image(systemName: networkManager.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                
                Text(networkManager.connectionDescription)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding()
                
                if !networkManager.isConnected {
                    /*
                     We wouldn't actually need a Retry button b/c our monitor is periodically listening in some sort of short polling or long polling fashion (like DSS!)
                     */
                    Button {
                        print("Handle action..")
                    }label: {
                        Text("Retry") // "Go to settings", "Reenable WIFI", "Dismiss", etc.
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .frame(width: 140)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  TimerApp
//
//  Created by Marin Todorov on 4/5/20.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    var start: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Text(viewModel.countdown)
                        .font(.largeTitle)
                    Circle()
                        .trim(from: 0.0, to: viewModel.progress)
                        .stroke(lineWidth: 10)
                        .padding(60)
                        .foregroundColor(.red)
                        .animation(.easeIn)
                        .navigationBarTitle("Timer App")
                }
                Button(action: start) {
                    Text("Start")
                        .font(.largeTitle)
                        .padding(10)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

//
//  ContentView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    
    @StateObject var viewModel = HomeViewModel()
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Button {
                viewModel.isGameViewPresented = true
            } label: {
                GameButton(title: "Play", backgroundColor: Color(.systemGreen))
            }

        }
        .fullScreenCover(isPresented: $viewModel.isGameViewPresented) {
            GameView()
        }
    }
}

//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

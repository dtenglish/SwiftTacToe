//
//  PopupMessageView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/31/22.
//

import SwiftUI

struct PopupMessageView: View {
    //MARK: - PROPERTIES
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            if viewModel.showPopup {
                VStack {
                    Text(viewModel.popupTitle)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    Text(viewModel.popupMessage)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    HStack {
                        Button {
                            // Rematch
                        } label: {
                            GameButton(title: "Rematch", backgroundColor: Color(.systemGreen), width: 160)
                        }
                        Button {
                            viewModel.quitGame()
                            viewModel.showPopup = false
                            dismiss()
                        } label: {
                            GameButton(title: "Quit", backgroundColor: Color(.systemRed), width: 160)
                        }
                    }
                } //: VSTACK
                .frame(width: 360, height: 240)
                .background(Color(red: 0.6, green: 0.7, blue: 0.9))
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5) , radius: 4, x: 4, y: 4)
            }
        } //: ZSTACK
    }
}

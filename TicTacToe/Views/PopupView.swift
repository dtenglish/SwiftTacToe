//
//  PopupView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/31/22.
//

import SwiftUI

struct PopupView: View {
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
                        if let title = viewModel.button1Title, let color = viewModel.button1Color {
                            GameButton(title: title, backgroundColor: color, width: 160, action: {
                                playSound(sound: "sound-tap", type: "mp3")
                                viewModel.button1Action()
                            })
                        }
                        if let title = viewModel.button2Title, let color = viewModel.button2Color  {
                            GameButton(title: title, backgroundColor: color, width: 160, action: {
                                playSound(sound: "sound-tap", type: "mp3")
                                viewModel.button2Action()
                            })
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

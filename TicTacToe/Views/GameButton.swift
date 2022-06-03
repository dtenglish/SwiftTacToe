//
//  GameButton.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct GameButton: View {
    //MARK: - PROPERTIES
    
    let title: String
    let backgroundColor: Color
    let width: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: width, height: 50)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(20)
        }
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(title: "Test", backgroundColor: .red, width: 300, action: { return })
    }
}

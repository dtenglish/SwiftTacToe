//
//  PlayerIndicatorView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct PlayerIndicatorView: View {
    
    //MARK: - PROPERTIES
    var imageName: String
    
    //MARK: - BODY
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

struct PlayerIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIndicatorView(imageName: "xmark")
    }
}

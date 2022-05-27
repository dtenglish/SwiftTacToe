//
//  PlayerMarkerView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct PlayerMarkerView: View {
    
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

struct PlayerMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerMarkerView(imageName: "xmark")
    }
}

//
//  GameGrid.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct GameGridView: View {
    
    //MARK: - PROPERTIES
    
    @State var imageName: String = ""

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var screenWidth: CGFloat
    
    //MARK: - BODY
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing:  5) {
                ForEach(0..<9) { i in
                    ZStack {
                        Circle()
                            .foregroundColor(Color(.systemBlue).opacity(0.7))
                            .frame(width: screenWidth / 3 - 15, height: screenWidth / 3 - 15)
                        PlayerIndicatorView(imageName: "")
                    }
                }
            } //: VGRID
            .padding()
        } //: VSTACK
    }
}

//struct GameGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        GameGrid()
//    }
//}

//
//  ExpandableFBView.swift
//  Noodle
//
//  Created by Dean Thompson on 2022/01/23.
//

import SwiftUI

struct ExapandableFB: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var text: String
    @Binding var show: Bool
    @Binding var tokenOrTag: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            
            if self.show {
                
                Button {
                    tokenOrTag = false
                    self.show = false
                } label: {
                    
                    Image(systemName: "scissors.circle")
                        .font(.title2)
//                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(22)
                    
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .opacity(0.6)
                
                Button {
                    self.show = false
                    tokenOrTag = true
                } label: {
                    
                    Image(systemName: "tag")
                        .font(.title2)
//                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(22)
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .opacity(0.6)
                
                
            }
            
            
            
            Button {
                if text.isEmpty {
                    self.show.toggle()
                } else {
                    viewModel.tokenizedWords = []
                    viewModel.tags = []
                    viewModel.tag(text: text)
                    text = ""
                }
            } label: {
            
                Image(systemName: text.isEmpty ? "chevron.up" : "play.fill")
                        .font(.largeTitle)
//                        .resizable()
                        .frame(width: text.isEmpty ? 35 : 40, height: text.isEmpty ? 22 : 40)
                        .padding(22)
        
            }
            .background(text.isEmpty ? Color.blue : Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotationEffect(.init(degrees: self.show ? 180 : 0))
            
        }
        .animation(.spring())
        .padding([.trailing, .bottom], 30)
        
    }
}

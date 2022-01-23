//
//  ContentView.swift
//  Noodle
//
//  Created by Dean Thompson on 2022/01/23.
//

import SwiftUI
import NaturalLanguage

struct TokenizerView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var tokenOrTag = false
    @State var show = false
    @FocusState private var nameIsFocused: Bool
    
    @State var text = ""
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text(tokenOrTag ? "Text to be tagged" : "Text to be tokenized")) {
                        TextEditor(text: $text)
                            .focused($nameIsFocused)
                    }
                                          

                    List(Array(zip(viewModel.tokenizedWords, viewModel.tags)), id: \.self.0) { (word, tag) in
                        if tokenOrTag {
                            VStack(alignment: .leading) {
                                Text(word)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(tag)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            Text(word)
                        }
                        
                    }
                    
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ExapandableFB(viewModel: viewModel, text: $text, show: $show, tokenOrTag: $tokenOrTag)
                    }
                }

            }
            .navigationTitle(tokenOrTag ?  "WordTagger" : "WordTokenizer")
        }
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TokenizerView()
    }
}

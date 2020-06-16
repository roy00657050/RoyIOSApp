//
//  NotesList.swift
//  MyAPP
//
//  Created by Roy on 2020/6/15.
//  Copyright © 2020 Roy. All rights reserved.
//

// NO USE.

import SwiftUI

struct NotesList: View {
    @State var text1: String = ""
    @State var text2: String = ""
    
    var body: some View {
        VStack {
            TextField("Text Field 1", text: $text1)
            TextField("Text Field 2", text: $text2)
        }
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
    }
}

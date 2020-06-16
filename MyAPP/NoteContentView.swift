//
//  NoteContentView.swift
//  MyAPP
//
//  Created by Roy on 2020/6/15.
//  Copyright © 2020 Roy. All rights reserved.
//

// NO USE.

import SwiftUI

struct NoteContentView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    func makeUIView(context: UIViewRepresentableContext<NoteContentView>) -> UITextView {
        
        let textView = UITextView()
        
        textView.textContainer.lineFragmentPadding = 0
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<NoteContentView>) {
        
    }
    
}

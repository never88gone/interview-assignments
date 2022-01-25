//
//  SearchBar.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/25.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: String
    
    @Binding var text: String
  
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
            if text != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color(.systemGray3))
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.text = ""
                          }
                    }
            }
        }.padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.vertical, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(placeholder: "请输入查询内容", text: .constant(""))
    }
}

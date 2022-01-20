//
//  TextFieldAlert.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/20.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @State var showText: String = ""
    @Binding var text: String
    @State var placeholder: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)

                ZStack {
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    self.isShowing.toggle()
                                }
                            }) {
                                Image(systemName: "xmark.circle").resizable().frame(width: 40, height: 40).foregroundColor(Color("ngtextback"))
                            }.padding()
                        }
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.5))
                    
                    VStack {
                        Text(self.title).foregroundColor(Color("ngtextback"))
                        TextField(placeholder, text: $showText)
                        Divider()
                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.text=self.showText
                                    self.isShowing.toggle()
                                }
                            }) {
                                Text("OK").foregroundColor(Color("ngtextback"))
                            }
                        }
                    }.padding()
                        .background(Color.white)
                        .frame(
                            width: deviceSize.size.width*0.7,
                            height: deviceSize.size.height*0.7
                        )
                        .cornerRadius(5)
                        .shadow(radius: 1)
                }
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}

extension View {
    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        placeholder: String,
                        title: String) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text, placeholder: placeholder,
                       presenting: self,
                       title: title)
    }

}
struct TextFieldAlert_Previews: PreviewProvider {
    @State static var  showAlert : Bool = true
    @State  static var  curGroupName : String = "分组"
    
    static var previews: some View {
        return ZStack{}.previewLayout(.fixed(width: 375, height: 60)).textFieldAlert(isShowing: $showAlert, text: $curGroupName, placeholder: "添加分组名称", title: "设置当前分组名称")
    }
}

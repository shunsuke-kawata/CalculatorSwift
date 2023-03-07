//
//  ContentView.swift
//  tutorial
//
// 電卓を作成してSwiftUIの演習をする
//  Created by 川田　隼輔 on 2022/10/16.
//

import SwiftUI

struct ContentView: View {
    //iphoneの高さと幅
    let screenSizeHeight = UIScreen.main.bounds.height
    let screenSizeWidth = UIScreen.main.bounds.width
    
    //電卓のボタンの中身を配列として保持する
    let inputItem = [["9","8","7","÷"],
                    ["6","5","4","×"],
                    ["3","2","1","-"],
                    ["0","C","=","+"]]
    
    //可変である結果１、結果２、演算子を保持する変数
    @State var result_view1 = ""
    @State var result_view2 = ""
    @State var oper = ""
    
    
    func buttonClick(row:Int,col:Int)->Void{
        if(col==3){
            if(self.result_view1.isEmpty){
                if(row==2){
                    self.result_view1+=self.inputItem[row][col]
                }else{
                    return
                }
            }else{
                if(self.result_view2.isEmpty && row==2 && !(self.oper.isEmpty)){
                    self.result_view2+=inputItem[row][col]
                }else{
                    self.oper=inputItem[row][col]
                }
            }
                
        }else{
            if(row<3){
                if(col<3){
                    if(self.oper.isEmpty){
                        self.result_view1+=self.inputItem[row][col]
                    }else{
                        self.result_view2+=self.inputItem[row][col]
                    }
                }
            }else{
                if(col==0){
                    if(self.oper.isEmpty){
                        self.result_view1+=self.inputItem[row][col]
                    }else{
                        self.result_view2+=self.inputItem[row][col]
                    }
                }else if(col==1){
                    if(!self.result_view2.isEmpty){
                        self.result_view2=""
                    }else if(!self.oper.isEmpty){
                        self.oper=""
                    }else{
                        self.result_view1=""
                    }
                }else{
                    if(self.result_view1.isEmpty || self.oper.isEmpty || self.result_view2.isEmpty){
                        return
                    }else{
                        var result:Double = 0.0
                        switch self.oper {
                        case "+":
                            result=NSString(string:self.result_view1).doubleValue+NSString(string:self.result_view2).doubleValue
                        case "-":
                            result=NSString(string:self.result_view1).doubleValue-NSString(string:self.result_view2).doubleValue
                        case "×":
                            result=NSString(string:self.result_view1).doubleValue*NSString(string:self.result_view2).doubleValue
                        case "÷":
                            if(result_view2=="0"){
                                self.result_view2=""
                                return
                            }else{
                                result=NSString(string:self.result_view1).doubleValue/NSString(string:self.result_view2).doubleValue
                            }
                        default:
                            return
                        }
                        self.result_view1=String(result)
                        self.oper=""
                        self.result_view2=""
                    }
                }
            }
        }
        //1~9の演算
        
    }
    //演算を行う関数
    //ビューを生成する場所　関数などは記述しない
    var body: some View {
        //演算結果を表示する場所
        VStack{
            Text("CalculatorApp")
                .font(.system(size: 54))
                .foregroundColor(Color.blue)
                
                
            TextField("", text: $result_view1)
                .font(.system(size: 36))
                .frame(width: screenSizeWidth/5*4)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 4)
                )
                
                
            TextField("", text: $result_view2)
                .font(.system(size: 36))
                .frame(width: screenSizeWidth/5*4)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 4)
                )
        }
            
        ForEach((0...3), id: \.self) { row in
                HStack{
                    ForEach((0...3), id: \.self){ col in
                        Button(action: {
                            // 条件分岐を加え、処理内容を変化させる
                            buttonClick(row:row, col:col)
                            
                        }){
                            if(self.inputItem[row][col]==self.oper){
                                
                                Spacer()
                                Text(self.inputItem[row][col])
                                    .font(.system(size: 36))
                                    .foregroundColor(Color.red)
                                    .padding(screenSizeWidth/16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.red, lineWidth: 4)
                                    )
                                    
                                Spacer()
                            
                            
                            }else{
                                Spacer()
                                Text(self.inputItem[row][col])
                                    .font(.system(size: 36))
                                    .padding(screenSizeWidth/16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.black, lineWidth: 4)
                                    )
                                Spacer()
                            }
                        }
                    }
                }
                .padding(12)
            }
        }
}

//プレビューを表示する機能
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

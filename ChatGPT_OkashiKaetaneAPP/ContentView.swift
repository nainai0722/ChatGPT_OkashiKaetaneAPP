//
//  ContentView.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/03/24.
//
import SwiftUI
import VisionKit


struct ContentView: View {
    @ObservedObject var input1 = PriceData(price: 0, id: 1)
    @ObservedObject var input2 = PriceData(price: 0, id: 2)
    @ObservedObject var input3 = PriceData(price: 0, id: 3)
    @ObservedObject var input4 = PriceData(price: 0, id: 4)
    @ObservedObject var input5 = PriceData(price: 0, id: 5)
    @ObservedObject var input6 = PriceData(price: 0, id: 6)
    @ObservedObject var budget = BudgetData(budget: 0, inputBudget: 0)
    
    @State private var showSplash = true
    @State var answer : String = ""
    @State var isJustAnswer = false
    @State var isOverAnswer = false
    @State var isNotEnoughAnswer = false
    @State var textFields: [PriceData] = []
    @State var textFieldsID : Int = 3
    @State var isButtonHidden = false
    @State private var text = ""
    @State private var isShowingText = false
    @State private var isAnimationText = false

    var body: some View {
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ScrollView(.vertical) {
                    
                    ZStack{
                        VStack {
                            // 表題部分
                            TitleView(budget: self.budget.budget)

                            HStack{
                                // 予算の入力フォーム
                                CustomTextFieldWithPrice(budget: self.budget, answer: $answer)
                                // 予算の決定ボタン
                                Button(action: {
                                    self.budget.inputBudget = self.budget.budget
                                    withAnimation {
                                        isShowingText.toggle()
                                    }
                                }) {
                                    CustomButtonView(ButtonText: "決める", backgroundColor: Color.blue, foregroundColor: .white)
                                }
                            }
                            
//                            InputBudgetMessageView(budget: self.budget.inputBudget, isAnimationText: $isAnimationText)
                            
                            if(self.budget.inputBudget == 0){
                                Text("")
                            }else{
                                if isAnimationText {
                                    Text("\(self.budget.inputBudget)円のお買い物をしよう")
                                        .font(.title)
                                        .foregroundColor(.pink)
                                        .animation(.easeIn(duration: 0.3))
                                }
                            }
                            // 水平にお菓子の金額を入力するテキストフィールドを並べる
                            HStack {
                                CustomTextField(priceData: self.input1, answer: $answer)
                                CustomTextField(priceData: self.input2, answer: $answer)
                                CustomTextField(priceData: self.input3, answer: $answer)
                            }.padding()
                            
                            // にゅうりょくをふやすボタンを押すと、水平にお菓子の金額を入力するテキストフィールドを一つずつ並べる。3つ並べば、ボタンは消失する
                            HStack {
                                ForEach(Array(textFields.enumerated()), id: \.offset) { index, textField in
                                    CustomTextField(priceData: textField, answer: $answer)
                                }
                                
                                if !isButtonHidden {
                                    Button(action: {
                                        if textFields.count < 3 {
                                            switch textFields.count {
                                            case 0:
                                                textFields.append(self.input4)
                                            case 1:
                                                textFields.append(self.input5)
                                            case 2:
                                                textFields.append(self.input6)
                                            default:
                                                break
                                            }
                                        }
                                        if textFields.count == 3 {
                                            isButtonHidden = true
                                        }
                                    }) {
                                        Text("入力をふやす")
                                            .font(.title)
                                    }
                                }
                            }.padding()
                            
                            let total = self.input1.price + self.input2.price + self.input3.price + self.input4.price + self.input5.price + self.input6.price
                            Text("合計金額は\(total)円")
                                .font(.title)
                                .padding()
                            
                            Button(action: {
                                
                            }) {
                                let halfHundredprice = total - (total / 100) * 100
                                let tenprice = halfHundredprice - (halfHundredprice / 50) * 50
                                let oneprice = tenprice - (tenprice / 10) * 10
                                
                                VStack{
                                    
                                    CoinListView(price: total, coinUnit:100, imageName: "money_100")
                                    CoinListView(price: halfHundredprice, coinUnit:50, imageName: "money_50")
                                    CoinListView(price: tenprice, coinUnit:10, imageName: "money_10")
                                    CoinListView(price: oneprice, coinUnit:1, imageName: "money_1")
                                }
                            }
                            
                            Button(action: {
                                isJustAnswer = false
                                isOverAnswer = false
                                isNotEnoughAnswer = false
                                if(self.budget.inputBudget == 0 || total == 0){
                                    answer = "金額を入れよう"
                                }else{
                                    if(total < self.budget.inputBudget){
                                        answer = "まだ\(self.budget.inputBudget - total)円分買えるよ"
                                        isNotEnoughAnswer = true
                                    }else if (total > self.budget.inputBudget){
                                        answer = "\(total - self.budget.inputBudget)円多いよ。\n減らしてみて！"
                                        isOverAnswer = true
                                    }else{
                                        answer = "ぴったりだよ"
                                        isJustAnswer = true
                                    }
                                }
                                
                            }) {
                                if(self.budget.inputBudget != 0 && total != 0){
                                    CustomButtonView(ButtonText: "くらべる", backgroundColor: Color.blue, foregroundColor: .white)
                                }else{
                                    CustomButtonView(ButtonText: "押せない", backgroundColor: Color.gray, foregroundColor: .black)
                                }
                            }.padding()
                            VStack{
                                Text(answer)
                                    .font(.title)
                                    .foregroundColor( .pink)
                                HStack{
                                    Button(action: {
                                        // これではクリアできない。
                                        self.budget.inputBudget = 0
                                        self.input1.price = 0
                                        self.input2.price = 0
                                        self.input3.price = 0
                                        self.input4.price = 0
                                        self.input5.price = 0
                                        self.input6.price = 0
                                        withAnimation {
                                            isShowingText.toggle()
                                        }
                                    }){
                                        CustomButtonView(ButtonText: "やりなおす", backgroundColor: Color.blue, foregroundColor: .white)
                                    }
                                    Button(action: {
                                        //購入したメモを別のViewに載せる。
                                    }){
                                        CustomButtonView(ButtonText: "買う", backgroundColor: Color.blue, foregroundColor: .white)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .onAppear {
                        let tapGesture = UITapGestureRecognizer(target: UIApplication.shared.windows.first { $0.isKeyWindow }!, action: #selector(UIView.endEditing(_:)))
                        tapGesture.cancelsTouchesInView = false
                        UIApplication.shared.windows.first { $0.isKeyWindow }!.addGestureRecognizer(tapGesture)
                        
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                            isAnimationText = true
                        }
                    }
                    .opacity(showSplash ? 0 : 1)
                    .animation(.easeOut(duration: 0.5))
                }
            }
            
        }
    }
}

struct TitleView: View {
    let budget :Int
    var body: some View {
        Image("syokuji6_oyatsu")
            .resizable()
            .frame(width: 400,height: 99)
        // 予算金額なければ、表示される。
        if(budget == 0){
            Text("買う金額を決めよう")
                .font(.title.bold())
                .foregroundColor(.pink)
                .minimumScaleFactor(0.5)
        } else {
            Text("")
        }
    }
}

struct CoinListView: View {
    let price: Int
    let coinUnit: Int
    let imageName: String
    

    var body: some View {
        let priceInHundred = price / coinUnit
        let coinsArrys = Array(repeating:imageName, count: priceInHundred)

        return VStack {
            ForEach(0..<coinsArrys.count / 5 + 1, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(coinsArrys.indices, id: \.self) { index in
                        if index >= rowIndex * 5 && index < (rowIndex + 1) * 5 {
                            Image(coinsArrys[index])
                                .resizable()
                                .frame(width: 75, height: 75)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct CustomButtonView: View {
    let ButtonText: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Text(ButtonText)
            .font(.title)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


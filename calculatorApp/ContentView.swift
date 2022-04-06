//
//  ContentView.swift
//  calculatorApp
//
//  Created by Mihir Sangameswar on 4/3/22.
//

import SwiftUI

enum calcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .plus,.minus,.divide,.multiply,.equal:
                return .orange
        case .clear, .negative,.percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case plus, minus, multiply, divide, none
    
}


struct ContentView: View {
    
    @State var value = "0"
    
    @State var runningNumber = 0
    
    @State var currOperation: Operation = .none
    
    let buttons:[[calcButton]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.minus],
        [.one,.two,.three,.plus],
        [.zero,.decimal,.equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                //Text Display
                HStack{
                Spacer()
                Text(value)
                    .bold()
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    
                }
                .padding()
                
                //Buttons
                ForEach(buttons, id: \.self) {row in
                    HStack(spacing: 12) {
                    ForEach(row, id: \.self) {item in
                        Button(action: {
                            self.didTap(button: item)
                        }, label:
                                { Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                        })
                    }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: calcButton) {
        switch button {
        case .plus,.minus,.multiply,.divide,.equal:
            if button == .plus {
                self.currOperation = .plus
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .minus {
                self.currOperation = .minus
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currOperation {
                case .plus: self.value = "\(runningValue + currentValue)"
                case .minus: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none: break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal,.negative,.percent:
            break
        default:
            let number = button.rawValue
            if(self.value == "0") {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: calcButton) -> CGFloat {
        if(item == .zero) {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

//
//  fishUI.swift
//  M21
//
//  Created by Дмитрий Богданов on 10.08.2024.
//

import SwiftUI

struct Fish {
    var img: AnyView
    var pos: (x: CGFloat, y: CGFloat)?
    var ang: Double
}

struct FishUI: View {
    @State var fishs: [Fish] = []
    @State var capturesFish:Int = 0
    @State private var showAlert = false
    
    var body: some View {
        if #available(iOS 17.0, *) {
            
            NavigationView{
                ZStack {
                    if(!fishs.isEmpty){
                        ForEach(0..<fishs.count, id: \.self) { index in
                            fishs[index].img
                            //                            .border(.black)
                                .rotationEffect(.degrees(fishs[index].ang)) // Применение угла поворота
                                .position(x: fishs[index].pos?.x ?? 0, y: fishs[index].pos?.y ?? 0)
                                .onTapGesture {
                                    withAnimation {
                                        print("fish\(index) pos x:\(fishs[index].pos?.x ?? 0)  y:\( fishs[index].pos?.y ?? 0)")
                                        rotateFish(at: index,angle:400) // Поворот рыбы при нажатии
                                        let pos = CGPoint(x: fishs[index].pos?.x ?? 0, y: fishs[index].pos?.y ?? 0)
                                        goAwayAllFish(from: pos)
                                        capturesFish+=1
                                        fishs.remove(at: index)
                                    }
                                }
                        }
                        VStack{
                            Spacer()
                            Button{
                                for _ in 1..<6 {
                                    fishs.append(CreateFish())
                                }
                            }label: {
                                Text("Добавить БОЛЬШЕ РЫБОК!").bold().colorInvert()
                            }
                        }
                    }else{
                        VStack{
                            Text("Поздравляю! Вы поймали всех рыбок!")
                            Button{
                                for _ in 1..<6 {
                                    fishs.append(CreateFish())
                                }
                            }label: {
                                Text("спавн новых рыбок")
                            }
                        }
                    }
                }
                .background(Color(.systemBlue).opacity(0.25))
                .onTapGesture { location in
                    withAnimation {
                        rotateAllFishAway(from: location)
                        goAwayAllFish(from: location)
                    }
                }
                .onAppear {
                    // Инициализация рыбок при появлении вида
                    showAlert = true
                    for _ in 1..<6 {
                        fishs.append(CreateFish())
                    }
                    
                }
                .navigationTitle("Поймано рыбок: \(capturesFish)")
          
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Предупреждение!"), message: Text("Рыбки плавоют в рандомную сторону и на рандомное растояние, так что если все рыбки уплыли то просто тыкайте на экран в надежде что они вернуться :3 тут точно так же как и н рыбалке, спассет только ввера в рыбок."),     dismissButton: .default(Text("Я всё понял!")))
            }
        } else {
            Text("Please use iOS 17.0+")
        }
    }
    
    func CreateFish() -> Fish {
        let ang = Double.random(in: 0...360)
        let f = Image("Fish\(Int.random(in: 1...5))")
            .resizable()
            .scaledToFit()
            .frame(width: CGFloat.random(in: 75...275), height: CGFloat.random(in: 75...275))
        
        let fish = Fish(img: AnyView(f), pos: (x: CGFloat.random(in: 25...350), y: CGFloat.random(in: 100...500)), ang: ang)
        return fish
    }
    
    func rotateFish(at index: Int,angle:Double = 45) {
        // Изменение угла поворота для конкретной рыбы
        fishs[index].ang += angle // Например, поворот на 45 градусов
    }
    
    func rotateAllFishAway(from location: CGPoint) {
        for index in 0..<fishs.count {
            guard let fishPos = fishs[index].pos else { continue }
            
            // Вычисляем угол между вектором от точки нажатия к рыбке и горизонтальной осью
            let deltaX = fishPos.x - location.x
            let deltaY = fishPos.y - location.y
            let angle = atan2(deltaY, deltaX) * 180 / .pi // Преобразуем радианы в градусы
            
            // Разворот рыбы на противоположный угол
            fishs[index].ang = angle
        }
    }
    
    func goAwayAllFish(from location:CGPoint){
        for index in 0..<fishs.count {

            print("pos - \(fishs[index].pos!)")
            print("angle - \(fishs[index].ang * .pi / 90)")
            
            let x = ((fishs[index].pos?.x ?? 0) + CGFloat(Int.random(in: Range(-100...100))) ) - (fishs[index].ang * .pi )
            let y = ((fishs[index].pos?.y ?? 0) + CGFloat(Int.random(in: Range(-100...100))) ) - (fishs[index].ang * .pi )
            
            fishs[index].pos?.x = x
            fishs[index].pos?.y = y
            
            print("pos x - \(x)")
            print("pos y - \(y)")
        }
    }
}



#Preview {
    FishUI()
}



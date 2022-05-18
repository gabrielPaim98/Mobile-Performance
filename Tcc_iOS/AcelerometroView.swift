//
//  AcelerometroView.swift
//  Tcc iOS
//
//  Created by Ibira Junior on 09/05/22.
//

import SwiftUI
import CoreMotion

struct AcelerometroView: View {
    let manager = CMMotionManager()
    @ObservedObject var acelerometroManager = AcelerometroManager()
    
    var timeDiffD: Double {
        return acelerometroManager.timeDiff * 1000.0
        
    }
    var body: some View {
        VStack {
            HStack {
                Text("Tempo decorrido: ")
                Text(timeDiffD.rounded().description)
                Text(" ms")
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            Button("BUSCAR ACELEROMETRO") {
                acelerometroManager.before = Date()
                manager.startAccelerometerUpdates()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    if let data = self.manager.accelerometerData {
                        self.acelerometroManager.x = data.acceleration.x
                        self.acelerometroManager.y = data.acceleration.y
                        self.acelerometroManager.z = data.acceleration.z
                        self.manager.stopAccelerometerUpdates()
                        timer.invalidate()
                        self.acelerometroManager.after = Date()
                        print(self.acelerometroManager)
                    }
                })
            }
            HStack{
                Text("Acelerometro: ")
                Text("x: \(acelerometroManager.x ?? 0.0), y: \(acelerometroManager.y ?? 0.0), z: \(acelerometroManager.z ?? 0.0)")
            }
        }
    }
}

struct AcelerometroView_Previews: PreviewProvider {
    static var previews: some View {
        AcelerometroView()
    }
}

class AcelerometroManager: ObservableObject {
    var before: Date?
    var after: Date?
    @Published var x:Double?
    @Published var y:Double?
    @Published var z:Double?
    var timeDiff: TimeInterval {
        if before != nil && after != nil {
            return before!.distance(to: after!)
        }
        return 0.0
    }
    
    
}

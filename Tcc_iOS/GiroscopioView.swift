
import SwiftUI
import CoreMotion

struct GiroscopioView: View {
    let manager = CMMotionManager()
    @ObservedObject var giroscopioManager = GiroscopioManager()
    
    var timeDiffD: Double {
        return giroscopioManager.timeDiff * 1000.0
        
    }
    var body: some View {
        VStack {
            HStack {
                Text("Tempo decorrido: ")
                Text(timeDiffD.rounded().description)
                Text(" ms")
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            Button("BUSCAR ACELEROMETRO") {
                giroscopioManager.before = Date()
                manager.startGyroUpdates()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    if let data = self.manager.gyroData {
                        self.giroscopioManager.x = data.rotationRate.x
                        self.giroscopioManager.y = data.rotationRate.y
                        self.giroscopioManager.z = data.rotationRate.z
                        self.manager.stopGyroUpdates()
                        timer.invalidate()
                        self.giroscopioManager.after = Date()
                        print(self.giroscopioManager)
                    }
                })
            }
            HStack{
                Text("Giroscopio: ")
                Text(
                    """
x: \(giroscopioManager.x ?? 0.0),
y: \(giroscopioManager.y ?? 0.0),
z: \(giroscopioManager.z ?? 0.0)
""")
            }
        }
    }
}
class GiroscopioManager: ObservableObject {
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

struct GiroscopioView_Previews: PreviewProvider {
    static var previews: some View {
        GiroscopioView()
    }
}

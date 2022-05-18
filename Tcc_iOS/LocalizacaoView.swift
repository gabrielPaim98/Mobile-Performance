

import SwiftUI

struct LocalizacaoView: View {
   @ObservedObject var locationManager = LocationManager()
    var timeDiff: Double {
        if locationManager.timeDiff != nil{
            return locationManager.timeDiff! * 1000.0
        }
        return 0.0
        
        
    }
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("Tempo decorrido: ")
                    Text(timeDiff.rounded().description)
                    Text(" ms")
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                Button("BUSCAR LOCALIZAÇÃO") {
                    locationManager.requestLocation()
                }
                HStack{
                    Text("Localização: ")
                    Text("\(locationManager.lat), \(locationManager.lon)")
                }
                
            }
            
            .navigationTitle("LOCALIZAÇÃO")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LocalizacaoView_Previews: PreviewProvider {
    static var previews: some View {
        LocalizacaoView()
    }
}

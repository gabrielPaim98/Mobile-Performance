
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                   NavigationLink("LISTAGEM", destination: ListagemView()).padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                NavigationLink("LOCALIZAÇÃO", destination: LocalizacaoView()).padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                   NavigationLink("ACELEROMETRO", destination: AcelerometroView()).padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                   NavigationLink("GIROSCOPIO", destination: GiroscopioView()).padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
               }
            .navigationTitle("Tcc iOS")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

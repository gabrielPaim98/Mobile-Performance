
import SwiftUI

struct ListagemView: View {
    let listJson = JsonHandler()
    
    var body: some View {
        let list = listJson.fetchData()
        return NavigationView{
            List(list){ element in
                VStack {
                    AsyncImage(url: URL(string: element.image_url))
                    Text(element.first_name).padding(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                }
            }
            .navigationTitle("LISTAGEM")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

struct ListagemView_Previews: PreviewProvider {
    static var previews: some View {
        ListagemView()
    }
}


import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        SpriteView(scene: GameController.shared.initialScene)
            .statusBarHidden(true)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

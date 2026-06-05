import SwiftUI

struct ContentView: View {
    @State private var focusTask: String = ""
    @State private var isFocusing: Bool = false
    @State private var timeRemaining = 25 * 60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("Founder Focus")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if !isFocusing {
                    TextField("What is the ONE thing?", text: $focusTask)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                    
                    Button(action: {
                        if !focusTask.isEmpty {
                            isFocusing = true
                            timeRemaining = 25 * 60
                        }
                    }) {
                        Text("Start Deep Work")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                } else {
                    Text(focusTask)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text(timeString(time: timeRemaining))
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                        .foregroundColor(.cyan)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            } else {
                                isFocusing = false
                            }
                        }
                    
                    Button(action: {
                        isFocusing = false
                    }) {
                        Text("Stop")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                }
            }
        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

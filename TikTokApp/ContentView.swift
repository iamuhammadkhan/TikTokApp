//
//  ContentView.swift
//  TikTokApp
//
//  Created by Muhammad Khan on 10/22/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State private var index = 0
    @State private var top = 0
    @State private var data = [
                                Video(id: 1, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "1", ofType: "mp4")!)), playing: false),
                                Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "2", ofType: "mp4")!)), playing: false),
                                Video(id: 3, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "3", ofType: "mp4")!)), playing: false),
                                Video(id: 4, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "4", ofType: "mp4")!)), playing: false),
                                Video(id: 5, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "5", ofType: "mp4")!)), playing: false),
                                Video(id: 6, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "6", ofType: "mp4")!)), playing: false) ]
    
    var body: some View {
        ZStack {
            
            PlayerScrollView(data: self.$data)
            
            VStack {
                HStack(spacing: 15) {
                    Button {
                        self.top = 0
                    } label: {
                        Text("Following")
                            .foregroundColor(self.top == 0 ? .white : .white.opacity(0.45))
                            .fontWeight(self.top == 0 ? .bold : .regular)
                            .padding(.vertical)
                    }
                    Button {
                        self.top = 1
                    } label: {
                        Text("For You")
                            .foregroundColor(self.top == 1 ? .white : .white.opacity(0.45))
                            .fontWeight(self.top == 1 ? .bold : .regular)
                            .padding(.vertical)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 35) {
                        Button {
                            //
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 55, height: 55, alignment: .center)
                                .foregroundColor(.white)
                        }
                        Button {
                            //
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "suit.heart.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .foregroundColor(.white)
                                Text("22k")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                            }
                        }
                        Button {
                            //
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "message.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .foregroundColor(.white)
                                Text("1021")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                            }
                        }
                        Button {
                            //
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .foregroundColor(.white)
                                Text("Share")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                    .padding(.bottom, 55)
                    .padding(.trailing)
                }
                HStack(spacing: 0) {
                    Button {
                        self.index = 0
                    } label: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(self.index == 0 ? .white : .white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        self.index = 1
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(self.index == 1 ? .white : .white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        self.index = 4
                    } label: {
                        Image(systemName: "plus.rectangle.fill")
                            .resizable()
                            .frame(width: 50, height: 35, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        self.index = 2
                    } label: {
                        Image(systemName: "text.bubble.fill")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(self.index == 2 ? .white : .white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        self.index = 3
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(self.index == 3 ? .white : .white.opacity(0.35))
                            .padding(.horizontal)
                    }
                }.padding(.horizontal)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 + 5)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct PlayerView: View {
    
    @Binding var data: [Video]
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(self.data) { video in
                ZStack {
                    Player(player: video.player)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -6.66)
                        .onTapGesture {
                            changePlayingState(video)
                        }
                    if isPlaying {
                        Button {
                            changePlayingState(video)
                        } label: {
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            self.data[0].player.play()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.data[0].player.currentItem, queue: .main) { [self] _ in
                data[0].player.seek(to: .zero)
                data[0].player.play()
            }
        }
    }
    
    private func changePlayingState(_ video: Video) {
        isPlaying.toggle()
        if isPlaying {
            video.player.pause()
        } else {
            video.player.play()
        }
    }
}

struct Player: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        //
    }
}

class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

struct Video: Identifiable {
    let id: Int
    let player: AVPlayer
    let playing: Bool
}

struct PlayerScrollView: UIViewRepresentable {
    
    @Binding var data: [Video]
    
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        let childView = UIHostingController(rootView: PlayerView(data: self.$data))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        view.bounces = false
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        
        for index in 0..<uiView.subviews.count {
            uiView.subviews[index].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: PlayerScrollView
        var index = 0
        
        init(parent: PlayerScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            if index != currentIndex {
                index = currentIndex
                for i in 0..<parent.data.count {
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                }
                parent.data[index].player.play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { [self] _ in
                    parent.data[index].player.seek(to: .zero)
                    parent.data[index].player.play()
                }
            }
        }
    }
}

//
//  IdeaDrawingView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/03.
//

import SwiftUI

struct IdeaDrawingView: View {
    @State var scale: CGFloat = 1.0
    
    @State var model: TextViews = TextViews()
    @State var viewSub: [StickyParts] = [StickyParts]()
    
    @State var scrollable: Bool = true
    @State var dragable: Bool = false
    @State var viewNum: Int = 0
    
    @State private var location: [CGPoint] = [CGPoint(x: 50, y: 50)]
    
    var srickes: [TextViews.Stick] {model.srickes}
    
    func add(v: StickyParts) {
        viewSub.append(v)
        location.append(CGPoint(x: 50, y: 50))
        viewNum += 1
    }
    
    func move(num: Int, point: CGPoint) {
        location[num] = point
    }
    
    var body: some View {
            
        if #available(iOS 16.0, *) {
            GeometryReader { proxy in
                ScrollView([.vertical, .horizontal]) {
                        VStack {
                            ForEach(viewSub) { item in
                                item
                                    .position(location[item.id])
                                    .gesture(
                                        LongPressGesture().onChanged{ value in
                                            scrollable = false
                                        }.sequenced(
                                            before: DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                                .onChanged{ value in
                                                    move(num: item.id, point: value.location)
                                                }
                                                .onEnded { value in
                                                    scrollable = true
                                                }
                                        )
                                        .onEnded{ value in
                                            print("LONG PRESS END \(value)")
                                        })
                            }
                        }
                        .scaleEffect(scale, anchor: .topLeading)
                        .frame(width: proxy.size.width + (proxy.size.width * scale), height: proxy.size.height + (proxy.size.height * scale), alignment: .topLeading)
                }
                .scrollDisabled(!scrollable)
                .gesture(MagnificationGesture()
                    .onChanged { value in
                        let max: CGFloat = 2.0
                        let min: CGFloat = 0.5
                        if value > max {
                            scale = max
                        }
                        else if value < min {
                            scale = min
                        }
                        else {
                            scale = value
                        }
                        
                    }
                    .onEnded { value in
                        print("on ended \(value)")
                        
                    })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            add(v: StickyParts(id: viewNum))
                        }, label: {
                            Text("ADDVIEW")
                        })
                    }
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct TextViews {
    var srickes: [Stick] = [Stick]()
    
    struct Stick: Identifiable {
        static func == (lhs: TextViews.Stick, rhs: TextViews.Stick) -> Bool {
            return lhs.id == rhs.id
        }
        
        
        let id: Int
        var point: CGPoint
        var text: StickyParts
        
        fileprivate init(id: Int, point: CGPoint, text: StickyParts) {
            self.id = id
            self.point = point
            self.text = text
        }
    }
    
    private var uniquePictureId = 0
    
    mutating func add(v: StickyParts, point: CGPoint) {
        uniquePictureId += 1
        srickes.append(Stick(id: uniquePictureId, point: point, text: v))
    }
}

struct IdeaDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaDrawingView()
    }
}

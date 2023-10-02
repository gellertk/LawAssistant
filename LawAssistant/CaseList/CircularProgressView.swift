//
//  CircularProgressBarView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 12.11.2022.
//

import SwiftUI

struct CircularProgressView: View {
    
    @State var state: DocumentItemViewState
    
    let progress: Double
    
    var body: some View {
        ZStack {
            switch state {
            case .uploading:
                Circle()
                    .stroke(
                        Color.maroon.opacity(0.5),
                        lineWidth: 2.5
                    )
                Circle()
                    .trim(from: 0, to: self.progress)
                    .stroke(
                        Color.maroon,
                        style: StrokeStyle(
                            lineWidth: 2.5,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: self.progress)
            case .downloading:
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .tint(Color.maroon)
                    .frame(width: 13, height: 13)
                Circle()
                    .stroke(
                        Color.maroon.opacity(0.5),
                        lineWidth: 2.5
                    )
                Circle()
                    .trim(from: 0, to: self.progress)
                    .stroke(
                        Color.maroon,
                        style: StrokeStyle(
                            lineWidth: 2.5,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: self.progress)
            case .uploaded:
                Image(systemName: "arrow.down.circle")
                    .resizable()
                    .scaledToFit()
                    .tint(Color.maroon)
                    .frame(width: 25, height: 25)
            case .downloaded:
                let asd = 1
            }
        }
    }
}

struct CircularProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(state: .downloaded(.previewUnknown), progress: 10)
    }
}

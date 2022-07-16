//
//  homeView.swift
//  DroPhMap
//
//  Created by Jakub Chodara on 15/07/2022.
//

import SwiftUI

struct homeView: View {
    @EnvironmentObject var imageData: ImageData
    
    var body: some View {
        List{
            ForEach(imageData.imageNote) {
                note in NavigationLink(destination: NoteDataView(note: note)){
                    HStack{
                        Image(uiImage: UIImage(data: note.image)!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        
                        VStack(alignment: .leading){
                            Text(note.title)
                                .lineLimit(2)
                            
                        }
                    }
                }
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
            .environmentObject(ImageData())
    }
}

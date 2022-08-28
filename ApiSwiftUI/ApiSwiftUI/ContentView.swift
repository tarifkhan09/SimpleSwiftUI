//
//  ContentView.swift
//  ApiSwiftUI
//
//  Created by MD Tarif khan on 26/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses, id: \.self){ courses in
                    HStack{
                        URLImage(urlString: courses.image)
                        
                        Text(courses.name)
                            .bold()
                    }
                    .padding()
                }
                
            }
            .navigationTitle("SwiftUI Api")
            .onAppear(){
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct URLImage: View{
    let urlString: String
    @State var data: Data?
    
    var body: some View{
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .background(Color.gray)
                .padding(.trailing, 20)
        }
        else{
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .background(Color.gray)
                .onAppear(){
                    fetchData()
                }
                .padding(.trailing, 20)
        }
    }
    private func fetchData(){
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            self.data = data
        }
        task.resume()
    }
}

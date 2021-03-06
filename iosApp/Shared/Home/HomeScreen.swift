//
//  HomeScreen.swift
//  iosApp
//
//  Created by Marco Gomiero on 30/08/2020.
//

import SwiftUI
import shared

struct HomeScreen: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var showingSheet = false
    @State private var showingFilePicker = false
    



    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if (viewModel.homeModel is HomeModel.Loading) {
                    Loader().edgesIgnoringSafeArea(.all)
                } else if (viewModel.homeModel is HomeModel.HomeState) {
                    
                    HomeRecap(balanceRecap: (viewModel.homeModel as! HomeModel.HomeState).balanceRecap)
                    HeaderNavigator()
                    
                    List {
                        ForEach((viewModel.homeModel as! HomeModel.HomeState).latestTransactions, id: \.self) { transaction in
                            TransactionCard(transaction: transaction)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle(Text("Wallet"), displayMode: .automatic)
            .navigationBarItems(leading: Button(action: {
                print("tapped")
                showingSheet.toggle()
            }) {
                Text("Export db")
                
            }, trailing: Button(action: {
                print("tapped")
                showingFilePicker.toggle()
            }) {
                Text("Import db")
                
            })
            .onAppear {
                self.viewModel.startObserving()
            }.onDisappear {
                self.viewModel.stopObserving()
            }
//            .sheet(isPresented: $showingSheet,
//                     content: {
//                        ActivityView(activityItems: [viewModel.getDBURL()] as [Any], applicationActivities: nil) })
            .sheet(isPresented: $showingFilePicker, content: { FilePickerController { url in
                print("Selected: \(url)")
                self.viewModel.replaceDB(url: url)
            }})
        }
    }
}

//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen()
//    }
//}

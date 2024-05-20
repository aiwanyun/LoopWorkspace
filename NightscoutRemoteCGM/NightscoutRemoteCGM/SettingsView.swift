//
//  SettingsView.swift
//  NightscoutRemoteCGM
//
//  Created by Ivan Valkou on 18.10.2019.
//  Copyright © 2019 Ivan Valkou. All rights reserved.
//

import SwiftUI
import Combine

private let frameworkBundle = Bundle(for: SettingsViewModel.self)

final class SettingsViewModel: ObservableObject {
    let nightscoutService: NightscoutAPIService
    @Published var serviceStatus: SettingsViewServiceStatus = .unknown
    var url: String {
        return nightscoutService.url?.absoluteString ?? ""
    }
    let onDelete = PassthroughSubject<Void, Never>()
    let onClose = PassthroughSubject<Void, Never>()

    init(nightscoutService: NightscoutAPIService) {
        self.nightscoutService = nightscoutService
    }
    
    func viewDidAppear(){
        updateServiceStatus()
    }
    
    private func updateServiceStatus(){
        nightscoutService.checkServiceStatus { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self.serviceStatus = .ok
                case .failure(let err):
                    self.serviceStatus = .error(err)
                }
            }
        }
    }
    
    enum SettingsViewServiceStatus {
        case unknown
        case ok
        case error(Error)
        
        func localizedString() -> String {
            switch self {
            case .unknown:
                return ""
            case .ok:
                return "OK"
            case.error(let err):
                return err.localizedDescription
            }
        }
    }
}

public struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State private var showingDeletionSheet = false
    
    public var body: some View {
        VStack {
            Spacer()
            Text(LocalizedString("NightScout远程CGM", comment: "Title for the CGMManager option"))
                .font(.title)
                .fontWeight(.semibold)
            Image("nightscout", bundle: frameworkBundle)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
            Form {
                Section {
                    HStack {
                        Text("URL")
                            .padding(.leading, 10)
                        Spacer()
                        Text(viewModel.url)
                            .padding(.leading, 10)
                    }
                    HStack {
                        Text("状态")
                            .padding(.leading, 10)
                        Spacer()
                        Text(String(describing: viewModel.serviceStatus.localizedString()))
                            .padding(.leading, 10)
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        deleteCGMButton
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle(Text("CGM设置", bundle: frameworkBundle))
        .navigationBarItems(
            trailing: Button(action: {
                self.viewModel.onClose.send()
            }, label: {
                Text("完毕", bundle: frameworkBundle)
            })
        ).onAppear {
            viewModel.viewDidAppear()
        }
    }
    
    private var deleteCGMButton: some View {
        Button(action: {
            showingDeletionSheet = true
        }, label: {
            Text("删除CGM", bundle: frameworkBundle).foregroundColor(.red)
        }).actionSheet(isPresented: $showingDeletionSheet) {
            ActionSheet(
                title: Text("您确定要删除此CGM吗？"),
                buttons: [
                    .destructive(Text("删除CGM")) {
                        self.viewModel.onDelete.send()
                    },
                    .cancel(),
                ]
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(nightscoutService: NightscoutAPIService())).environment(\.colorScheme, .dark)
    }
}

//
//  ServicesManager.swift
//  VkApps
//
//  Created by Георгий Бутров on 14.07.2022.
//

import Foundation

protocol ServicesManagerProtocol {
    var output: ServicesManagerOutput? { get set }
    var networkManager: NetworkManagerProtocol! { get }
    func load<T:Codable>(ofType: T.Type)
    
}

protocol ServicesManagerOutput: AnyObject {
    func success<T>(result: T)
    func failure(error: Error)
}

final class ServicesManager: ServicesManagerProtocol {
    static let shared: ServicesManagerProtocol = ServicesManager(networkManager: NetworkManager())
    
    weak var output: ServicesManagerOutput?
    let networkManager: NetworkManagerProtocol!
    
    
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    
    
    func load<T:Codable>(ofType: T.Type) {
        self.networkManager.get(ofType: T.self){[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let items):
                    self.output?.success(result: items)

            case .failure(let error):
                self.output?.failure(error: error)
            }
        }
    }
}

//
//  Presenter.swift
//  VkApps
//
//  Created by Георгий Бутров on 13.07.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var output: HomePresetnerOutput? { get set }
    var response: Response { get set }
    var services: [Service] { get set }
    func setUpData()
}

protocol HomePresetnerOutput: AnyObject {
    func success()
    func failure()
}

final class HomePresenter: HomePresenterProtocol {
    
    
    weak var view: HomeViewControllerProtocol!
    weak var output: HomePresetnerOutput?
    
    private var servicesManger: ServicesManagerProtocol =  ServicesManager.shared
    
    init(view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    var response: Response = Response(body: Services(services: []))
    var services: [Service] = []
    func setUpData() {
        getServices()
        
    }
    
}

extension HomePresenter {
    
    func getServices() {
        servicesManger.load(ofType: Response.self)
        servicesManger.output = self
    }
}

extension HomePresenter: ServicesManagerOutput {
    func success<T>(result: T) {
        if let result = result as? Response {
            self.response = result
            self.services = (result.body?.services)!
            self.output?.success()
        }
    }
    
    func failure(error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.output?.failure()
        }
    }
}


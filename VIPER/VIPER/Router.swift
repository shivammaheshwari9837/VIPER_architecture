//
//  Router.swift
//  VIPER
//
//  Created by Shivam Maheshwari on 18/05/23.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get set }
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //Assign VIP
        var view: AnyView = UserView()
        var interactor: AnyInteractor = UserInteractor()
        var presentor: AnyPresenter = UserPresenter()
        
        view.presenter = presentor
        
        interactor.presentor = presentor
        
        presentor.router = router
        presentor.view = view
        presentor.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
}

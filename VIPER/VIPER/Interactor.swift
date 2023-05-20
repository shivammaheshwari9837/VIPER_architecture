//
//  Interactor.swift
//  VIPER
//
//  Created by Shivam Maheshwari on 18/05/23.
//

import Foundation

protocol AnyInteractor {
    var presentor: AnyPresenter? { get set }
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presentor: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presentor?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presentor?.interactorDidFetchUsers(with: .success(entities))
            }
            catch {
                self?.presentor?.interactorDidFetchUsers(with: .failure(error))
            }

        }
        
        task.resume()
        
    }
    
}

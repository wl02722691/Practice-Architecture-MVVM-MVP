//
//  Presenter.swift
//  MVP
//
//  Created by 張書涵 on 2021/6/28.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    weak var delegate: PresenterDelegate?
    
    public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: users)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    public func setViewDelegate(delegate:PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTap(user: User) {
        let title = user.name
        let message = "\(user.name) has an email of \(user.email) & username of \(user.username)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true, completion: nil)
// put alert in presenter or controller is two way, just keep it consistent
        
//        delegate?.presentAlert(title: user.name, message: "\(user.name) has an email of \(user.email) & username of \(user.username)")
    }
}

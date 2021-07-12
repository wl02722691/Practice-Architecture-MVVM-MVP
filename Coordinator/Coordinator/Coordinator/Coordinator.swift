//
//  Coordinator.swift
//  Coordinator
//
//  Created by 張書涵 on 2021/7/13.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

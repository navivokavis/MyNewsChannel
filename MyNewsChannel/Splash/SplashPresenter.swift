//
//  SplashPresenter.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 22.10.22.
//

import UIKit

protocol SplashPresenterDescription {
    func present()
    func dismiss(completion: (() -> Void)?)
}

final class SplashPresenter: SplashPresenterDescription {
    
    private lazy var foregroundSplashWindow: UIWindow = {
        
        let splashViewController = SplashViewController()

        // создаю окно, которое находится на 1 уровень выше главного окна приложения
        let splashWindow = UIWindow()
        
        splashWindow.windowLevel = .normal + 1
        splashWindow.rootViewController = splashViewController
        
        return splashWindow
        
    }()
    
func present() {
//    foregroundSplashWindow.isHidden = false
    
    let splashViewController = SplashViewController()
    
    splashViewController.mainTextImage.transform = CGAffineTransform(translationX: 0, y: 250)

    UIView.animate(withDuration: 0.5) {
        splashViewController.mainTextImage.transform = .identity

    }
    
//    UIView.animate(withDuration: 0.3) {
//        splashViewController?.mainTextImage.transform = .identity
//    }
}

func dismiss(completion: (() -> Void)?) {
    UIView.animate(withDuration: 0.3) {
        self.foregroundSplashWindow.alpha = 0
    } completion: { _ in
        completion?()
    }

}

}

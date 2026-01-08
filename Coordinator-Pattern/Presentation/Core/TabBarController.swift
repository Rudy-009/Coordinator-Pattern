//
//  TabBarController.swift
//  Smashing-Assignment
//
//  Created by 이승준 on 12/24/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Properties
    
    var factory: TabBarSceneFactory = DefaultTabBarSceneFactory()
    
    static weak var shared: TabBarController?
    
    private let defaultTab: Tab = .searchMatch
    
    enum Tab: Int, CaseIterable {
        case home = 0
        case searchMatch
        case manageMatch
        case profile
        
        var imageName: UIImage {
            switch self {
            case .home: return UIImage(systemName: "figure.basketball")!
            case .searchMatch: return UIImage(systemName: "figure.table.tennis")!
            case .manageMatch: return UIImage(systemName: "figure.badminton")!
            case .profile: return UIImage(systemName: "person")!
            }
        }
        
        var selectedImageName: UIImage {
            switch self {
            case .home: return UIImage(systemName: "figure.basketball.circle.fill")!
            case .searchMatch: return UIImage(systemName: "figure.table.tennis.circle.fill")!
            case .manageMatch: return UIImage(systemName: "figure.badminton.circle.fill")!
            case .profile: return UIImage(systemName: "person.fill")!
            }
        }
        
        var color: UIColor {
            switch self {
            case .home:
                return .systemRed
            case .searchMatch:
                return .systemBlue
            case .manageMatch:
                return .systemYellow
            case .profile:
                return .systemGreen
            }
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabBarController.shared = self // 인스턴스 할당 필수!
        self.delegate = self
        
        setViewControllers()
        setTabBarAppearance()
        selectedIndex = defaultTab.rawValue
    }
    
    // MARK: - Public Methods
    
    func switchToTab(_ tab: Tab) { // 외부에서 호출할 탭 전환 메서드
        self.selectedIndex = tab.rawValue
        // 필요한 경우 해당 탭의 내비게이션 스택을 루트로 초기화
        if let nav = self.selectedViewController as? UINavigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    
    //MARK: - Private Methods
    
    private func setViewControllers() {
        let topMargin: CGFloat = 7.0
        
        self.viewControllers = Tab.allCases.map { tab in
            let nav = factory.makeViewController(for: tab)
            
            let icon = resizeImage(image: tab.imageName).withRenderingMode(.alwaysOriginal)
            let selectedIcon = resizeImage(image: tab.selectedImageName).withRenderingMode(.alwaysOriginal)
            
            nav.tabBarItem = UITabBarItem(title: nil, image: icon, selectedImage: selectedIcon)
            nav.tabBarItem.tag = tab.rawValue
            nav.tabBarItem.imageInsets = UIEdgeInsets(top: topMargin, left: 0, bottom: -topMargin, right: 0)
            
            return nav
        }
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .darkGray
        
        let itemAppearance = UITabBarItemAppearance()
        
        appearance.stackedLayoutAppearance = itemAppearance
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func resizeImage(image: UIImage) -> UIImage {
        let targetSize = CGSize(width: 48, height: 48)
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
}

#Preview {
    TabBarController()
}

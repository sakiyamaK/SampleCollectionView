//
//  ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/06.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

enum SegueButton: String, CaseIterable {
    case stoppableHeaderCollection, stoppableHeaderPageCollection, waterfallLayoutCollection, mosaicCollection
    case sample1, sample2, sample3, sample4, sample5, sample6

    var button: UIButton {
        let button = UIButton()
        button.setTitle(rawValue, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }

    func segue(viewController: UIViewController) {
        switch self {
        case .waterfallLayoutCollection:
            let vc = UIStoryboard.waterfallLayoutCollection
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .stoppableHeaderPageCollection:
            let tab = UITabBarController()
            let appearance = UITabBarAppearance()
            appearance.backgroundColor =  UIColor.white
            tab.tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tab.tabBar.scrollEdgeAppearance = appearance
            }
            let vc = UIStoryboard.stoppableHeaderPageCollection
            tab.setViewControllers([vc], animated: false)
            viewController.navigationController?.pushViewController(tab, animated: true)
        case .mosaicCollection:
            let vc = UIStoryboard.mosaicCollection
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .sample1:
            let vc = UIStoryboard.sample1Collection
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .sample2:
            let vc = UIStoryboard.sample2Collection
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .sample3:
            let vc = UIStoryboard.sample3Collection
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .sample4:
            let vc = UIStoryboard.sample4Collection
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .sample5:
            let vc = UIStoryboard.sample5Collection
            viewController.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}


final class MainViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView! {
        didSet {
            SegueButton.allCases.map({$0.button}).forEach({ button in
                button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
                stackView.addArrangedSubview(button)
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
}


@objc extension MainViewController {
    func tapButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        SegueButton(rawValue: text)?.segue(viewController: self)
    }
    func tapStoppableHeaderPageCollectionButton() {
        let tab = UITabBarController()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  UIColor.white
        tab.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tab.tabBar.scrollEdgeAppearance = appearance
        }
        let vc = UIStoryboard.stoppableHeaderPageCollection
        tab.setViewControllers([vc], animated: false)
        self.navigationController?.pushViewController(tab, animated: true)
    }
}


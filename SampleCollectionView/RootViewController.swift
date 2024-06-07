//
//  ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/06.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import DeclarativeUIKit

enum ViewType: String, CaseIterable {
    
    case Sample1
    case Sample2
    case Sample3
    case Sample4
    case Sample5
    case Sample6
    case CompositionalLayout01
    case CompositionalLayout02
    case CompositionalLayout03
    case CompositionalLayout04
    case CompositionalLayout05
    case CompositionalLayout06
    case CompositionalLayout07
    case CompositionalLayout08
    case CompositionalLayout09
    case DiffableDataSources01
    case DiffableDataSources02
    case VHScrollCollection
    case StoppableHeaderCollection
    case StoppableHeaderPageCollection
    case WWDC2018
    case WaterfalCompositionallLayout
    case AppStore

    var viewController: UIViewController {
        switch self {
        case .Sample1:
            R.storyboard.sample1Collection(bundle: .main).instantiateInitialViewController()!
        case .Sample2:
            R.storyboard.sample2Collection(bundle: .main).instantiateInitialViewController()!
        case .Sample3:
            R.storyboard.sample3Collection(bundle: .main).instantiateInitialViewController()!
        case .Sample4:
            R.storyboard.sample4Collection(bundle: .main).instantiateInitialViewController()!
        case .Sample5:
            R.storyboard.sample5Collection(bundle: .main).instantiateInitialViewController()!
        case .Sample6:
            R.storyboard.sample6Collection(bundle: .main).instantiateInitialViewController()!
        case .WWDC2018:
            R.storyboard.mosaicCollection(bundle: .main).instantiateInitialViewController()!
        case .CompositionalLayout01:
            CompositionalLayout01ViewController()
        case .CompositionalLayout02:
            CompositionalLayout02ViewController()
        case .CompositionalLayout03:
            CompositionalLayout03ViewController()
        case .CompositionalLayout04:
            CompositionalLayout04ViewController()
        case .CompositionalLayout05:
            CompositionalLayout05ViewController()
        case .CompositionalLayout06:
            CompositionalLayout06ViewController()
        case .CompositionalLayout07:
            CompositionalLayout07ViewController()
        case .CompositionalLayout08:
            CompositionalLayout08ViewController()
        case .CompositionalLayout09:
            CompositionalLayout09ViewController()
        case .DiffableDataSources01:
            DiffableDataSources01ViewController()
        case .DiffableDataSources02:
            DiffableDataSources02ViewController()
        case .AppStore:
            R.storyboard.appStoreTop(bundle: .main).instantiateInitialViewController()!
        case .WaterfalCompositionallLayout:
            WaterfalCompositionallLayoutCollectionViewController()
        default:
            UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController()!
        }
    }
    
    func button(from: UIViewController) -> UIButton {
        UIButton(self.rawValue)
            .contentEdgeInsets(.init(top: 10, left: 10, bottom: 10, right: 10))
            .font(UIFont.systemFont(ofSize: 20))
            .backgroundColor(.systemBlue)
            .cornerRadius(10)
            .add(target: from, for: .touchUpInside) { _ in
                from.navigationController?.pushViewController(self.viewController, animated: true)
            }
    }
}


final class RootViewController: UIViewController {
        
    override func loadView() {
        super.loadView()

        self.applyView({
            $0.backgroundColor(.white)
        }).applyNavigationItem({
            $0.title = "Root"
        }).declarative {
            UIScrollView.vertical {
                UIStackView.vertical {
                    ViewType.allCases.compactMap({ $0.button(from: self).height(40) })
                }
                .spacing(20)
                .distribution(.fillEqually)
                .padding(insets: .init(horizontal: 16))
            }
            .showsScrollIndicator(false)
        }
    }
}


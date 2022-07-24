//
//  ViewController.swift
//  InterfaceBuilder.swift Demo
//
//  Created by Maximilian Mackh on 24.07.22.
//

import UIKit
import BaseComponents

class ViewController: UIViewController, UICollectionViewDelegate {
    let data: [String: AnyClass] = [
        "Login": LoginViewController.self,
        "Music Player": MusicPlayerViewController.self,
        "Number Pad": NumberPadViewController.self,
        "Web Browser": WebBrowserViewController.self,
    ]
    
    lazy var componentRender: ComponentRender<String> = {
        let componentRender: ComponentRender<String> = .init(layout: .list(style: .grouped))
        componentRender.collectionView.delegate = self
        return componentRender
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UI Demo"
        
        view.build { [unowned self] in
            Equal {
                self.componentRender
            }
        }
        self.reloadData()
    }
    
    func reloadData() {
        class Cell: UICollectionViewListCell {
            override func bindObject(_ obj: AnyObject) {
                guard let string = obj as? String else { return }
                var configuration = self.defaultContentConfiguration()
                configuration.text = string
                contentConfiguration = configuration
                accessories = [.disclosureIndicator()]
            }
        }
        
        componentRender.updateSnapshot { builder in
            builder.appendSection(using: Cell.self, items: Array(data.keys))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        guard let vcClass = data[Array(data.keys)[indexPath.row]] as? UIViewController.Type else { return }
        self.present(vcClass.init().embedInNavigationController(), animated: true)
    }
}


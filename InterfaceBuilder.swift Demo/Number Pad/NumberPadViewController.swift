//
//  NumberPadViewController.swift
//  InterfaceBuilder.swift Demo
//
//  Created by Maximilian Mackh on 24.07.22.
//

import UIKit
import BaseComponents

class NumberPadViewController: UIViewController {
    let numberLabel: UILabel = UILabel().align(.center).size(using: .monospacedDigitSystemFont(ofSize: 45, weight: .bold)).color(.background, .systemBackground)
    
    var number: String = "0" {
        didSet {
            
            
            numberLabel.text = "$ \(number)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Number Pad"
        
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .close, { [unowned self] barButtonItem in
            self.dismiss(animated: true)
        })
        
        view.color(.background, .systemGroupedBackground)
        
        view.build { [unowned self] in
            Equal {
                self.numberLabel
            }
            Separator()
            VSplit {
                HSplit {
                    Equal {
                        self.numberButton("1")
                    }
                    Separator()
                    Equal {
                        self.numberButton("2")
                    }
                    Separator()
                    Equal {
                        self.numberButton("3")
                    }
                }
                Separator()
                HSplit {
                    Equal {
                        self.numberButton("4")
                    }
                    Separator()
                    Equal {
                        self.numberButton("5")
                    }
                    Separator()
                    Equal {
                        self.numberButton("6")
                    }
                }
                Separator()
                HSplit {
                    Equal {
                        self.numberButton("7")
                    }
                    Separator()
                    Equal {
                        self.numberButton("8")
                    }
                    Separator()
                    Equal {
                        self.numberButton("9")
                    }
                }
                Separator()
                HSplit {
                    Equal {
                        UIView()
                    }
                    Separator()
                    Equal {
                        self.numberButton("0")
                    }
                    Separator()
                    Equal {
                        UIButton(symbol: "delete.left")
                    }
                }
                Separator()
            }
            
            Padding(observe: self.view, .safeAreaInsets(direction: .bottom))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func numberButton(_ numberString: String) -> UIView {
        UIButton(numberString).size(using: .monospacedDigitSystemFont(ofSize: 25, weight: .medium)).color(.text, .label)
    }
}

//
//  WebBrowserViewController.swift
//  InterfaceBuilder.swift Demo
//
//  Created by Maximilian Mackh on 24.07.22.
//

import UIKit
import BaseComponents

import WebKit

class WebBrowserViewController: UIViewController {
    let webView: WKWebView = {
        let webView: WKWebView = .init(frame: .zero, configuration: WKWebViewConfiguration())
        webView.load(.init(url: URL(string: "https://apple.com")!))
        return webView
    }()
    var inputSplitView: SplitView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.color(.background, .systemBackground)
        
        let barHeight: CGFloat = 54 + 44
        additionalSafeAreaInsets = .init(bottom: barHeight)
        
        view.build { [unowned self] in
            Equal {
                self.webView
            }
        }
        
        view.build { [unowned self] in
            VSplit {
                Equal {
                    UIView().userInteractionEnabled(false)
                }
                Separator()
                Dynamic {
                    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
                    visualEffectView.contentView.build {
                        VSplit {
                            Padding(8)
                            HSplit {
                                HSplit {
                                    Padding(10)
                                    Fixed(34) {
                                        UIButton(symbol: "textformat.size", pointSize: 18).tint(.label)
                                    }
                                    Padding(15)
                                    Percentage(100) {
                                        UITextField(placeholder: "apple.com")
                                    }
                                    Fixed(34) {
                                        UIButton(symbol: "arrow.clockwise", pointSize: 18).tint(.label)
                                    }
                                    Padding(5)
                                } modifier: { splitView in
                                    splitView.color(.background, .systemBackground).cornerRadius(8)
                                    
                                    self.inputSplitView = splitView
                                }
                            } size: {
                                .init(.fixed, 44, insets: .init(horizontal: self.view.layoutMargins.left))
                            }
                            Padding(10)
                            HSplit {
                                Equal {
                                    UIButton(symbol: "chevron.backward")
                                }
                                Equal {
                                    UIButton(symbol: "chevron.forward")
                                }
                                Equal {
                                    UIButton(symbol: "square.and.arrow.up")
                                }
                                Equal {
                                    UIButton(symbol: "book")
                                }
                                Equal {
                                    UIButton(symbol: "square.on.square")
                                }
                            } size: {
                                .init(.fixed, KeyboardManager.visibility == .visible ? 0 : 44)
                            }
                            Dynamic {
                                UIView()
                            } size: {
                                .init(.fixed, KeyboardManager.visibility == .visible ? 0 : self.initialSafeAreaInsets.bottom)
                            }
                        }
                    }
                    return visualEffectView
                } size: {
                    .init(.fixed, KeyboardManager.visibility == .visible ? 64 : self.initialSafeAreaInsets.bottom + 54 + 44)
                }
            } modifier: { splitView in
                KeyboardManager.manage(rootView: self.view, resizableChildSplitView: splitView)
            }
        }
        
        updateInputSplitViewUI()
    }
    
    func updateInputSplitViewUI() {
        inputSplitView?.layer.shadowOpacity = 0.2
        inputSplitView?.layer.shadowColor = UIColor.label.cgColor
        inputSplitView?.layer.shadowRadius = 8
        inputSplitView?.layer.shadowOffset = .init(width: 0, height: 3)
        
        inputSplitView?.clipsToBounds = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateInputSplitViewUI()
    }
}

//
//  MusicPlayerViewController.swift
//  InterfaceBuilder.swift Demo
//
//  Created by Maximilian Mackh on 24.07.22.
//

import UIKit
import BaseComponents

class MusicPlayerViewController: UIViewController {
    let albumArtworkImage: UIImage = UIImage(named: "cover.jpg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Now Playing"
        
        navigationItem.rightBarButtonItem = {
            let barButtonItem: UIBarButtonItem = .init(image: UIImage(systemName: "chevron.down"), style: .plain, { [unowned self] barButtonItem in
                self.dismiss(animated: true)
            })
            barButtonItem.tintColor = .label
            return barButtonItem
        }()
        
        navigationController?.overrideUserInterfaceStyle = .dark
        
        view.color(.background, .systemBackground)
        
        // Vibrancy Background
        view.build {
            Equal {
                let imageView = UIImageView(image: self.albumArtworkImage).mode(.scaleAspectFill)
                imageView.build {
                    Equal {
                        UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
                    }
                }
                return imageView
            }
        }
        
        // Music Player UI
        view.build { [unowned self] in
            Split {
                self.view.isLandscape ? .horizontal : .vertical
            } builder: {
                Padding(observe: self.view, .layoutMargins(direction: .top))
                Padding(20)
                
                // Artwork
                HSplit {
                    Equal {
                        UIImageView(image: self.albumArtworkImage).mode(.scaleAspectFit)
                    }
                } size: {
                    let isLandscape = self.view.isLandscape
                    let layoutMargins: UIEdgeInsets = self.view.layoutMargins
                    return .init(.fixed, (isLandscape ? self.view.height - layoutMargins.top - layoutMargins.bottom : (self.view.width - layoutMargins.left * 2)), insets: isLandscape ? .init(vertical: layoutMargins.top) : .init(horizontal: layoutMargins.left))
                }
                
                VSplit {
                    Equal {
                        UIView()
                    }
                    
                    // Track slider
                    Fixed(20) {
                        let slider = UISlider().tint(.label)
                        slider.value = 0.5
                        return slider
                    } insets: {
                        .init(horizontal: .maximum(20, self.view.layoutMargins.left))
                    }
                    
                    Padding(25)
                    
                    // Track info
                    Automatic {
                        UILabel("Demo Tape #1 B-Side").align(.center).size(.title2, .bold)
                    }
                    Padding(10)
                    Automatic {
                        UILabel("Unkown").align(.center).size(.footnote, .bold).color(.text, .secondaryLabel)
                    }
                    Padding(15)
                    
                    // Player Controls
                    HSplit {
                        Padding(20)
                        Equal {
                            UIButton(symbol: "backward.fill", pointSize: 23).tint(.label)
                        }
                        Equal {
                            UIButton(symbol: "play.fill", pointSize: 50).tint(.label)
                        }
                        Equal {
                            UIButton(symbol: "forward.fill", pointSize: 23).tint(.label)
                        }
                        Padding(20)
                    }
                    
                    Equal {
                        UIView()
                    }
                    
                    Fixed(40) {
                        UIButton(symbol: "airplayaudio", pointSize: 25).tint(.label)
                    }
                    
                    Padding {
                        .init(.fixed, self.view.isLandscape ? self.view.safeAreaInsets.bottom : 0)
                    }
                }
                
                Padding(observe: self.view, .layoutMargins(direction: .bottom))
            }

        }
    }
}

fileprivate extension UIView {
    var isLandscape: Bool {
        bounds.width > bounds.height
    }
}

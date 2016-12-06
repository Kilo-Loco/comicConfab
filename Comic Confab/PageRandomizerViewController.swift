//
//  PageRandomizerViewController.swift
//  Comic Confab
//
//  Created by Kyle Lee on 12/1/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import UIKit

class PageRandomizerViewController: UIViewController {
    
    @IBOutlet weak var marvelPageLabel: UILabel!
    @IBOutlet weak var dcPageLabel: UILabel!
    
    @IBOutlet weak var randomizerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onRandomizerButtonTapped(sender: UIButton) {
        var marvelNumbers = [Int]()
        var dcNumbers = [Int]()
        
        while marvelNumbers.count < 25 {
            let marvelRandom = arc4random_uniform(432) + 1
            let dcRandom = arc4random_uniform(368) + 1
            marvelNumbers.append(Int(marvelRandom))
            dcNumbers.append(Int(dcRandom))
        }
        
        func animate(index: Int) {
            guard index < marvelNumbers.count else { return }
            self.marvelPageLabel.text = "\(marvelNumbers[index])"
            self.dcPageLabel.text = "\(dcNumbers[index])"
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                animate(index: index + 1)
            }
            
        }
        animate(index: 0)
    }

}

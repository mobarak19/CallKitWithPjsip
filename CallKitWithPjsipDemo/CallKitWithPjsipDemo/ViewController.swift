//
//  ViewController.swift
//  CallKitWithPjsipDemo
//
//  Created by Genusys Inc on 6/23/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var callNowBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pjsip Demo"

        setCallNowBtn()
    }

    func setCallNowBtn()  {
        callNowBtn.layer.cornerRadius = 10
        callNowBtn.addTarget(self, action: #selector(onCallNowTapped), for: .touchUpInside)
    }
    
    @objc func onCallNowTapped()  {
       
      
    }

}


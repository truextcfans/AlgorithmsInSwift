//
//  ViewController.swift
//  AlgorithmsInSwift
//
//  Created by xlzj on 2024/6/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Sort().insertSort()
        print("=============")
        Sort().selectionSort()
        print("=============")
        Sort().MergeSort()
        print("=============")
        Sort().insert_recurve()
        print("=============")
        Sort().bubbleSort()
        
        // Do any additional setup after loading the view.
    }


}


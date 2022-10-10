//
//  ViewController.swift
//  QueueExample
//
//  Created by 두부라니 on 2022/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){
            timer in
            
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }
    }

    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            DispatchQueue.main.async {
                self.finishLabel.text = "끝"
            }
        }
    }
    
    func simpleClosure(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            for index in 0..<10{
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            completion()
        }
    }
    
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        let queque1 = DispatchQueue(label: "q1")
        let queque2 = DispatchQueue(label: "q2")
        let queque3 = DispatchQueue(label: "q3")
        
        queque1.async(group: dispatchGroup, qos: .background){
            for index in 0..<10{
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        queque2.async(group: dispatchGroup, qos: .userInteractive){
            for index in 10..<20{
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        queque3.async(group: dispatchGroup){
            for index in 20..<30{
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main){
            print("끝")
        }
    }
    
    
    
    @IBAction func action3(_ sender: Any) {
        let queque1 = DispatchQueue(label: "q1")
        let queque2 = DispatchQueue(label: "q2")
        
        queque1.sync{
            for index in 0..<10{
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        queque2.sync{
            for index in 10..<20{
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
    }
}


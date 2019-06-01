//
//  ViewController.swift
//  sampleList
//
//  Created by 石川佑樹 on 2019/06/01.
//  Copyright © 2019 石川佑樹. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var animall: [String] = ["里親募集種類", "種類", "都道府県", "市町村", "駅"]
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animall.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = animall[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(animall[indexPath.row])
        let sb = UIStoryboard(name: "Second", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! SecondViewController
        present(vc, animated: true, completion: nil)
    }
    
    

}


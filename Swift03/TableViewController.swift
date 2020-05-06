//
//  TableViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/04/05.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit

let sectionTitle = ["A","B","C"]
let sectionColor = [UIColor.systemPink,UIColor.systemYellow,UIColor.orange]
let section0 = [("a1title","a1detail"),("a2title","a2detail")]
let section1 = [("b1title","b1detail"),("b2title","b2detail"),("b3title","b3detail")]
let section2 = [("c1title","c1detail"),("c2title","c2detail")]
let tableData = [section0,section1,section2]

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let cellData = tableData[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        cell.backgroundColor = sectionColor[indexPath.section]
        return cell
    }
    
}

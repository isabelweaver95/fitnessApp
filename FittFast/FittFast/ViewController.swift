//
//  ViewController.swift
//  FittFast
//
//  Created by Isabel Kamphaus on 6/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var workOuts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
    }
    
    
    func updateTasks(){
        guard let count = UserDefaults.value(forKey: "count") as? Int else{
            return
        }
        
        for i in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(i+1)") as? String{
                workOuts.append(task)
            }
        }
    }
    
    
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async{
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        //get all workouts
        // this will probably hard coded currently for my app
        

    }
}

extension ViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workOuts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ab Work Outs", for: indexPath)
            
        cell.textLabel?.text = workOuts[indexPath.row]
        return cell
    }
    
}

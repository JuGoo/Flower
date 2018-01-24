//
//  MainViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func mainViewDidClickLogout(_ mainViewModel: MainViewModel)
    func mainViewDidClickCreateNewContest(_ mainViewModel: MainViewModel)
    func mainView(_ mainViewModel: MainViewModel, didSelectContest contest: Any)
    func mainView(_ mainViewModel: MainViewModel, didSelectMedia media: Any)
}

protocol MainViewModelType {
    func loadStartersAndDrinks() -> Dictionary<String, Array<Orderable>>
}

struct MainViewModel: MainViewModelType {
    
    var startersAndDrinks: Dictionary<String, Array<Orderable>>?
    
    init() {
        startersAndDrinks = self.loadStartersAndDrinks()
    }
    
    func loadStartersAndDrinks() -> Dictionary<String, Array<Orderable>> {
        let orangeJuice = Drink(name: "Orange Juice", price: 5.0, diet: .Soft)
        let appleJuice = Drink(name: "Apple Juice", price: 5.0, diet: .Soft)
        let mojito = Drink(name: "Mojito", price: 7.0, diet: .Alcohol)
        let onionRings = Snack(name: "Onion Rings", price: 4.0, temperature: .Hot)
        let ceasarSalad = Snack(name: "Ceasar Salad", price: 10.0, temperature: .Cold)
        let barList: [Orderable] = [orangeJuice, appleJuice, mojito, onionRings, ceasarSalad]
        
        let softDrinks: [Orderable] = barList.filter { (order) -> Bool in
            if let myOrder = order as? Drinkable {
                return myOrder.diet == .Soft
            }
            return false
        }
        
        let alcoholDrinks: [Orderable] = barList.filter { (order) -> Bool in
            if let myOrder = order as? Drinkable {
                return myOrder.diet == .Alcohol
            }
            return false
        }
        
        let hotSnack: [Orderable] = barList.filter { (order) -> Bool in
            if let myOrder = order as? Snack {
                return myOrder.temperature == .Hot
            }
            return false
        }
        
        let coldSnack: [Orderable] = barList.filter { (order) -> Bool in
            if let myOrder = order as? Snack {
                return myOrder.temperature == .Cold
            }
            return false
        }
        
        return ["Soft": softDrinks, "Alcohol": alcoholDrinks, "Hot": hotSnack, "Cold": coldSnack]
    }
}

protocol MainViewControllerDelegate: class {
    func mainViewControllerDidClickCreateContest(_ mainViewController: MainViewController)
    func mainViewController(_ mainViewController: MainViewController, didSelectContest contest: Any)
}

class MainViewController: UIViewController {

    private(set) var viewModel: MainViewModel
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        configure(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: MainViewModel) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        if let startersAndDrinks = viewModel.startersAndDrinks {
            cell.textLabel?.text = ((Array(startersAndDrinks)[indexPath.section].value[indexPath.row])).name
        }
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.startersAndDrinks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let startersAndDrinks = viewModel.startersAndDrinks else {
            return 0
        }
        return Array(startersAndDrinks)[section].value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let startersAndDrinks = viewModel.startersAndDrinks else {
            return ""
        }
        return Array(startersAndDrinks)[section].key
    }
    
}

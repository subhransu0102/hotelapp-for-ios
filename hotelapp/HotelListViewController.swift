//
//  HotelListViewController.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 21/02/23.
//

import UIKit

class HotelListViewController: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    var hotelList :[hotel]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        
        setupView()
        let anonymousFunction = {
            (fetchHotelList:[hotel]) in
            DispatchQueue.main.async {
                self.hotelList = fetchHotelList
                self.tableView.reloadData()
            }
            
        }
        hotelAPI.shared.fetchhotellist(onCompletion: anonymousFunction)

        // Do any additional setup after loading the view.
    }
    
    
    func setupView()  {
        view.addSubview(tableView)
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HotelListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let amiibo = hotelList[indexPath.row]
        cell.textLabel?.text = amiibo.name
        return cell
    }
     
    
}

//
//  hotelViewController.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 09/02/23.
//

import UIKit

class hotelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    private let apiCaller = APICaller()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame:.zero,style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame  = view.bounds
        apiCaller.fetchData(completion:{ [weak self]result in
            switch result{
            case.success(let data): 
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(_):
                break
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
      
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height){
            guard !apiCaller.isPagination else {
                return
            }
            apiCaller.fetchData(pagination:true){ [weak self] result in
                
                switch result {
                case.success(let moreData):
                    self?.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }

                    
                case .failure(_):
                    break
                }
            }
        }
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

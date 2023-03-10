//
//  ContentViewController.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 13/02/23.
//

import UIKit
import AVFoundation

class ContentViewController: UIViewController{
    
    
    
    private let table :UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    private var models = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpModels()

        // Do any additional setup after loading the view.
        view.addSubview(table)
        table.tableHeaderView = createTableHeader()
        table.delegate = self
        table.dataSource = self
    }
    
    private func createTableHeader()-> UIView? {
        
        guard let path = Bundle.main.path(forResource: "hotel", ofType: "mp4") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url )
        player.volume = 0
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: view.frame.size.width))
        let playerLayer = AVPlayerLayer(player: player )
        playerLayer.frame = headerView.bounds
        headerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        return headerView
    }
    
    private func setUpModels(){
        models.append(.collectionView(models: [CollectionTableCellModel(title: "Hotel1",
                                                                        imageName: "hotel1"),
                                                CollectionTableCellModel(title: "Hotel2",
                                                                         imageName: "hotel2"),
                                                CollectionTableCellModel(title: "Hotel3",
                                                                         imageName: "hotel3"),
                                                CollectionTableCellModel(title: "Hotel4",
                                                                          imageName: "hotel4"),
                                               CollectionTableCellModel(title: "Hotel5",
                                                                        imageName: "hotel5"),
                                                 CollectionTableCellModel(title: "Hotel6",
                                                                          imageName: "hotel6"),
                                                CollectionTableCellModel(title: "Hotel7",
                                                                         imageName: "hotel7"),
                                                CollectionTableCellModel(title: "Hotel8",
                                                                        imageName: "hotel8"),
                                                CollectionTableCellModel(title: "Hotel9",
                                                                          imageName: "hotel9")],
                                      rows: 2))
        models.append(.list(models: [
                ListCellModel(title: "All the hotels are here"),
                ListCellModel(title: "view services"),
                ListCellModel(title: "with swiming pool "),
                ListCellModel(title: "game area is present"),
                ListCellModel(title: "upto 7* hotels are present")
        ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
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
extension ContentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section]{
        case.list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
            
        case.collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section]{
        case.list(let models):return models.count
        case.collectionView(_, _):return 1
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Didselect normal list item")
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section]{
        case.list(_):return 50
        case.collectionView(_,let rows):return 180 * CGFloat(rows)
        }
    }
    
}
extension ContentViewController:CollectionTableViewCellDelegate{
    func didSelectItem(with model: CollectionTableCellModel) {
        print("selected \(model.title)")
    }
}

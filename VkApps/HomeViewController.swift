//
//  ViewController.swift
//  VkApps
//
//  Created by Георгий Бутров on 13.07.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    var presenter: HomePresenterProtocol! { get set }
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    var presenter: HomePresenterProtocol!
    
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Сервисы VK"
        lbl.font.withSize(35)
        return lbl
    }()
    
    let tableView: UITableView = {
        let tab = UITableView()
        tab.translatesAutoresizingMaskIntoConstraints = false
        tab.showsVerticalScrollIndicator = false
        tab.register(classCell: HomeTableViewCell.self)
        return tab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
//        let Try = Try()
        
//        Try.get()
        
        presenter = HomePresenter(view: self)
        setUpUI()
        presenter.setUpData()
        presenter.output = self
    }
    
    
    func setUpUI() {
        
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(cell: HomeTableViewCell.self, at: indexPath)
        cell.titleLabel.text = presenter.services[indexPath.row].name
        cell.descriptionLabel.text = presenter.services[indexPath.row].description
        cell.icon.load(url: URL(string: presenter.services[indexPath.row].icon_url ?? "https://www.apple.com/ac/globalnav/7/ru_RU/images/be15095f-5a20-57d0-ad14-cf4c638e223a/globalnav_apple_image__b5er5ngrzxqq_large.svg")! )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height
        
        return  height / 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: presenter.services[indexPath.row].link ?? "https://www.apple.com/ru/")!
        UIApplication.shared.open(url, options: [ : ] , completionHandler: nil)
    }
}

extension HomeViewController: HomePresetnerOutput {
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("succ")
        print("setUpData \(presenter.services)")
    }
    
    func failure() {
        print("err")
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

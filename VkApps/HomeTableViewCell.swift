//
//  HomeTableViewCell.swift
//  VkApps
//
//  Created by Георгий Бутров on 13.07.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell, CellProtocol {
    
    static var name: String {
        return "HomeTableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "ВКонтакте"
        lbl.font = UIFont(name:"HelveticaNeue-Bold", size: 17)
        return lbl
    }()
    
    var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Игры для ПК, консолей и смартфонов, в которые играют сотни миллионов геймеров"
        lbl.font = UIFont(name: "HelveticaNeue", size: 14)
        return lbl
    }()
    
    var icon: UIImageView = {
        let imgV = UIImageView(image: UIImage(systemName: "person"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 15
        imgV.contentMode = .scaleToFill
        return imgV
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        let heigth = contentView.frame.height
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            icon.heightAnchor.constraint(equalToConstant: heigth - 15),
            icon.widthAnchor.constraint(equalToConstant: heigth - 15),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
            
            descriptionLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
}

extension UITableView {
    
    func create<A: CellProtocol>(cell: A.Type) -> A {
        self.dequeueReusableCell(withIdentifier: cell.name) as! A
    }
    
    func create<A: CellProtocol>(cell: A.Type, at index: IndexPath) -> A {
        self.dequeueReusableCell(withIdentifier: cell.name, for: index) as! A
    }
    
    func register<A: CellProtocol>(classCell: A.Type) {
        self.register(classCell.self, forCellReuseIdentifier: classCell.name)
    }
    
    func register(nibName name: String, forCellReuseIdentifier identifier: String) {
        let someNib = UINib(nibName: name, bundle: nil)
        self.register(someNib, forCellReuseIdentifier: identifier)
    }
}

protocol CellProtocol: UIView {
    static var name: String { get }
}

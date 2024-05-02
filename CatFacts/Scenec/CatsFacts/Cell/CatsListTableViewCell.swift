//
//  CatsListTableViewCell.swift
//  CatFacts
//
//  Created by Bakar Kharabadze on 5/1/24.
//

import UIKit

class CatsListTableViewCell: UITableViewCell {
    
    //MARK: Properties
    private let mainStackView = UIStackView()
    private let factLabel = UILabel()
    private let lengthLabel = UILabel()
    private let separatorView = UIView()
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainStackView()
        setupFactLabel()
        setupLengthLabel()
        setupSeparatorView()
        
        mainStackView.setCustomSpacing(20, after: factLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    private func setupMainStackView() {
        addSubview(mainStackView)
        
        backgroundColor = .systemBackground
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .fill
        mainStackView.axis = .vertical
        
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        mainStackView.spacing = 50
        
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    private func setupFactLabel() {
        factLabel.text = "gela"
        factLabel.font = .systemFont(ofSize: 17)
        factLabel.textColor = .darkGray
        factLabel.numberOfLines = 0
        
        mainStackView.addArrangedSubview(factLabel)
    }
    
    private func setupLengthLabel() {
        lengthLabel.font = .systemFont(ofSize: 20, weight: .bold)
        lengthLabel.textColor = .black
        lengthLabel.textAlignment = .right
        
        mainStackView.addArrangedSubview(lengthLabel)
    }
    
    private func setupSeparatorView() {
        addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.backgroundColor = .lightGray
    }
    
    func configure(with catFact: CatFact) {
        factLabel.text = catFact.fact
        lengthLabel.text = "Length: \(catFact.length)"
    }
}


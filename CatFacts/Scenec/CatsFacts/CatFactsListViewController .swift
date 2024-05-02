//
//  CatFactsListViewController  .swift
//  CatFacts
//
//  Created by Bakar Kharabadze on 5/1/24.
//


import UIKit

class CatFactsListViewController: UIViewController {
    
    //MARK: - Properties
    private let tableView = UITableView()
    private let addButton = UIButton()
    private let contentView = UIView()
    var viewModel = CatsFactsViewModel()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    private func setup() {
        setupContentView()
        viewModel.viewDidLoad()
        setupTableView()
        setupNavigationController()
        viewModel.delegate = self
        setupAddButton()
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -90).isActive = true
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(CatsListTableViewCell.self, forCellReuseIdentifier: "CatsListTableViewCell")
        tableView.backgroundColor = .clear
        tableView.reloadData()
    }
    
    private func setupNavigationController() {
        title = "Cats Facts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupAddButton() {
        contentView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 15
        addButton.setTitle("დაამატე ახალი ფაქტი", for: .normal)
        
        let action = UIAction { [weak self] _ in
            let shouldShowAlert = self?.viewModel.addNewFact()
            if shouldShowAlert ?? false {
                self?.showAlert()
            }
        }
        self.addButton.addAction(action, for: .touchUpInside)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "შეჩერდი ძამი", message: "შენ უკვე იხილე ყველა საჭირო ფაქტი კატებზე", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension CatFactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatsListTableViewCell", for: indexPath) as! CatsListTableViewCell
        let catFact = viewModel.catFacts[indexPath.row]
        cell.configure(with: catFact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.catFacts.count
    }
}

extension CatFactsListViewController: CatsFactsViewModelDelegate {
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

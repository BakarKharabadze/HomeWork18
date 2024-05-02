//
//  CatsFactsViewModel.swift
//  CatFacts
//
//  Created by Bakar Kharabadze on 5/1/24.
//
import Networking
import Foundation

//MARK: - Protocol
protocol CatsFactsViewModelDelegate: AnyObject {
    func tableViewReloadData()
}

final class CatsFactsViewModel {
    
    //MARK: Properties
    var listInfo = [CatFactsList]()
    var catFacts: [CatFact] = []
    weak var delegate: CatsFactsViewModelDelegate?
    var currentIndex = 0
    
    //MARK: - View Lifecycle
    func viewDidLoad() {
        fetchFacts()
    }
    
    func addNewFact() -> Bool {
        guard let facts = listInfo.first?.data, currentIndex < facts.count else {
            return true
        }
        let newFact = facts[currentIndex]
        catFacts.append(newFact)
        currentIndex += 1
        delegate?.tableViewReloadData()
        
        return currentIndex == facts.count
    }
    
    //MARK: - Networking
    private func fetchFacts() {
        let url = "https://catfact.ninja/facts"
        NetworkManager.shared.request(url: url) { [weak self] (result: Result<CatFactsList, NetworkError>) in
            switch result {
            case .success(let factsList):
                self?.listInfo = [factsList]
                if let firstFact = factsList.data.first {
                    self?.catFacts = [firstFact]
                }
                self?.delegate?.tableViewReloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

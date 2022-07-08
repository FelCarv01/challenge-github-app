//
//  ListView.swift
//  GitHubApp
//
//  Created by Rodrigo Borges on 30/09/21.
//

import UIKit

struct ListViewConfiguration {

    let listItems: [String]
}

final class ListView: UIView {

    private lazy var listSearchBar: UISearchBar = {
        let listSearchBar = UISearchBar()
        listSearchBar.placeholder = "Type a GitHub user name"
        listSearchBar.translatesAutoresizingMaskIntoConstraints = false
        return listSearchBar
    }()

    private lazy var tableView: UITableView = {

        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepositoryViewCell.self, forCellReuseIdentifier: listViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: private properties
    
    private let listViewCellIdentifier = "ListViewCellIdentifier"
    private var listItems: [String] = []
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListView: ViewCode {
    func setupSubviews() {
        self.addSubview(self.listSearchBar)
        self.addSubview(self.tableView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.listSearchBar.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.listSearchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.listSearchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.listSearchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setupExtraConfiguration() {
        self.backgroundColor = .systemBackground
    }
}


extension ListView {

    func updateView(with repositories: [String]) {

        self.listItems = repositories
        self.tableView.reloadData()
    }
}

extension ListView: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: listViewCellIdentifier, for: indexPath) as? RepositoryViewCell
        
        
        cell?.updateCell(configuration: .init(repositoryName: self.listItems[indexPath.row], repsitoryOwnerName: "Owner"))
        
        return cell ?? UITableViewCell()
    }
}


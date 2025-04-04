import UIKit

final class MainScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barTintColor = .clear
        searchBar.searchTextField.backgroundColor = UIColor(white: 0.3, alpha: 1)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .darkGray
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let footerView: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let countLabel = LabelFactory.createSubOrdinaryLabel()
    private let addButton = ButtonFactory.createFloatingActionButton()
    
    var onBttnTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainScreenView {
    func setupView() {
        backgroundColor = .black
        
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(footerView)
        
        footerView.addSubview(countLabel)
        footerView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        searchBar.searchTextField.frame = bounds.inset(by: UIEdgeInsets.zero)
    }
}

private extension MainScreenView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20 - 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20 + 8),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.heightAnchor.constraint(equalToConstant: 83),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            addButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 28),
            addButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}

private extension MainScreenView {
    @objc func addButtonTapped() {
        onBttnTapped?()
    }
}

extension MainScreenView {
    func setupTitle(with title: String) {
        titleLabel.text = title
    }
    
    func updateTaskCount(_ count: Int) {
        countLabel.text = "\(count) задач"
    }
}

extension MainScreenView {
    func setDataSource(_ dataSource: NoteTableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func setDelegate(_ delegate: NoteTableViewDelegate) {
        tableView.delegate = delegate
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

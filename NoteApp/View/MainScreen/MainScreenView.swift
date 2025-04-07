import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showTasks()
    func showEmptyState()
    func showError(_ message: String)
}

final class MainScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = ColorExtension.accentGray
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: MainScreenEnum.View.String.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: ColorExtension.accentLightWhite]
        )
        searchBar.searchTextField.textColor = ColorExtension.accentLightWhite
        searchBar.searchTextField.leftView?.tintColor = ColorExtension.accentLightWhite
        searchBar.barTintColor = .clear
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorColor = ColorExtension.accentLightGray
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let footerView: UIView = {
        let view =  UIView()
        view.backgroundColor = ColorExtension.accentGray
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
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: MainScreenEnum.View.Constr.titleTopConstr),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.View.Constr.titleLeadingConstr),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MainScreenEnum.View.Constr.spacingConstr),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.View.Constr.searchLeadingConstr),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MainScreenEnum.View.Constr.searchTrailingConstr),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: MainScreenEnum.View.Constr.spacingConstr),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.heightAnchor.constraint(equalToConstant: MainScreenEnum.View.Constr.footerHeightConstr),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: MainScreenEnum.View.Constr.countTopConstr),
            
            addButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: MainScreenEnum.View.Constr.bttnTrailingConstr),
            addButton.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: MainScreenEnum.View.Constr.bttnWidthConstr),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor)
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
    
    func updateTaskCount(for count: Int) {
        let name = taskWord(for: count)
        countLabel.text = "\(count) \(name)"
    }
}

private extension MainScreenView {
    func taskWord(for count: Int) -> String {
        let lastTwoDigits = count % 100
        let lastDigit = count % 10
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
            return "Задач"
        }
        
        switch lastDigit {
        case 1:
            return "Задача"
        case 2...4:
            return "Задачи"
        default:
            return "Задач"
        }
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

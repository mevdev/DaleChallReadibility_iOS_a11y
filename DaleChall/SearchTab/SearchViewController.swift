//
//  SearchViewController.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/5/22.
//

import UIKit

class SearchViewController: UIViewController {

  let tableView = UITableView()
  let searchBar = UISearchBar()
  let viewModel: SearchViewModel

  init(viewModel: SearchViewModel = SearchViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  override func viewDidLoad() {
    addViews()
    connectDelegates()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
//    self.searchBar.searchTextField.tokens = self.viewModel.tokens
  }

  func addViews() {
    self.view.addSubview(searchBar)
    self.view.addSubview(tableView)
    //
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    //
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }

  func connectDelegates() {
    searchBar.delegate = self
    searchBar.searchTextField.allowsDeletingTokens = true
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellDefault")
  }

}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.viewModel.searchText = searchText
    self.tableView.reloadData()
  }
}

//extension SearchViewController: UISearch

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let defineWord = self.viewModel.filteredWords[indexPath.row]
//    self.viewModel.addToken(defineWord)
    let wordDetailViewController = WordDetailViewController(wordDetailViewModel: WordDetailViewModel(word: defineWord))
    self.navigationController?.pushViewController(wordDetailViewController, animated: true)
  }
}

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.filteredWords.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellDefault")!
    cell.textLabel?.text = self.viewModel.filteredWords[indexPath.row]
    return cell
  }

}

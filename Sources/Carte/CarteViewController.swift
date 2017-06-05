// The MIT License (MIT)
//
// Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS)
import UIKit

open class CarteViewController: UITableViewController {

  open var items = [CarteItem]()
  open var configureDetailViewController: ((CarteDetailViewController) -> Void)?


  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = NSLocalizedString("Open Source Licenses", comment: "Open Source Licenses")
    self.loadCartesFromInfoDictionary()
  }

  public convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  public required convenience init(coder aDecoder: NSCoder) {
    self.init()
  }

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if self.navigationController?.viewControllers.count ?? 0 > 1 { // pushed
      self.navigationItem.leftBarButtonItem = nil
    } else if self.presentingViewController != nil && self.navigationItem.leftBarButtonItem == nil { // presented
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(doneButtonDidTap)
      )
    }
  }

  open func loadCartesFromInfoDictionary() {
    if let carteDicts = Bundle.main.infoDictionary?["Carte"] as? [[String: Any]] {
      for dict in carteDicts {
        guard let name = dict["name"] as? String else { continue }
        var item = CarteItem(name: name)
        if let base64EncodedText = dict["text"] as? String,
          let data = Data(base64Encoded: base64EncodedText) {
          item.licenseText = String(data: data, encoding: .utf8)
        }
        self.items.append(item)
      }
    }
    if self.items.filter({ $0.name == "Carte" }).count == 0 {
      var item = CarteItem(name: "Carte")
      item.licenseText = [
        "The MIT License (MIT)",
        "",
        "Copyright (c) 2015 Suyeol Jeon (xoul.kr)",
        "Permission is hereby granted, free of charge, to any person obtaining a copy",
        "of this software and associated documentation files (the \"Software\"), to deal",
        "in the Software without restriction, including without limitation the rights",
        "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell",
        "copies of the Software, and to permit persons to whom the Software is",
        "furnished to do so, subject to the following conditions:",
        "",
        "The above copyright notice and this permission notice shall be included in all",
        "copies or substantial portions of the Software.",
        "",
        "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR",
        "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,",
        "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE",
        "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER",
        "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,",
        "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE",
        "SOFTWARE.",
        ].joined(separator: "\n")
      self.items.append(item)
      self.items.sort { $0.name < $1.name }
    }
  }

  internal func doneButtonDidTap() {
    self.dismiss(animated: true)
  }

}


extension CarteViewController {

  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }

  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
      ?? UITableViewCell(style: .value1, reuseIdentifier: "Cell")
    let item = self.items[indexPath.row]
    cell.textLabel?.text = item.displayName
    cell.detailTextLabel?.text = item.licenseName
    cell.accessoryType = .disclosureIndicator
    return cell
  }

  open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let detailViewController = CarteDetailViewController()
    detailViewController.carteItem = self.items[indexPath.row]
    self.configureDetailViewController?(detailViewController)
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }

}


public class CarteDetailViewController: UIViewController {

  open var textView: UITextView = {
    let textView = UITextView()
    textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    textView.font = UIFont.preferredFont(forTextStyle: .footnote)
    textView.isEditable = false
    textView.dataDetectorTypes = .link
    return textView
  }()
  open var carteItem: CarteItem? {
    didSet {
      self.title = carteItem?.displayName
      self.textView.text = carteItem?.licenseText
    }
  }

  public convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  open override func viewDidLoad() {
    self.view.backgroundColor = UIColor.white
    self.textView.frame = self.view.bounds
    self.textView.contentOffset = .zero
    self.view.addSubview(self.textView)
  }

}
#endif

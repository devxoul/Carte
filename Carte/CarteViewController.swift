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

public class CarteViewController: UITableViewController {

    public var items = [CarteItem]()
    public var configureDetailViewController: ((CarteDetailViewController) -> Void)?


    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.title = NSLocalizedString("Open Source Licenses", comment: "Open Source Licenses")
        self.loadCartesFromInfoDictionary()
    }

    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    public required convenience init(coder aDecoder: NSCoder!) {
        self.init()
    }

    public override func viewWillAppear(animated: Bool) {
        if self.presentingViewController != nil && self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done,
                target: self,
                action: "doneButtonDidTap"
            )
        }
    }

    public func loadCartesFromInfoDictionary() {
        if let carteDicts = NSBundle.mainBundle().infoDictionary?["Carte"] as? [[String: AnyObject]] {
            for dict in carteDicts {
                let item = CarteItem()
                item.name = dict["name"] as? String
                if let base64EncodedText = dict["text"] as? String,
                   let data = NSData(base64EncodedString: base64EncodedText, options: .allZeros) {
                    item.licenseText = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                }
                self.items.append(item)
            }
        }
        if self.items.filter({ $0.name == "Carte" }).count == 0 {
            let item = CarteItem()
            item.name = "Carte"
            item.licenseText = "\n".join([
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
            ])
            self.items.append(item)
            self.items.sort { $0.name < $1.name }
        }
    }

    internal func doneButtonDidTap() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}


extension CarteViewController {

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    public override func tableView(tableView: UITableView,
                                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
            ?? UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        let item = self.items[indexPath.row]
        cell.textLabel?.text = item.displayName
        cell.detailTextLabel?.text = item.licenseName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let detailViewController = CarteDetailViewController()
        detailViewController.carteItem = self.items[indexPath.row]
        self.configureDetailViewController?(detailViewController)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}


public class CarteDetailViewController: UIViewController {

    public var textView: UITextView = {
        let textView = UITextView()
        textView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        textView.editable = false
        textView.dataDetectorTypes = .Link
        return textView
    }()
    public var carteItem: CarteItem? {
        didSet {
            self.title = carteItem?.displayName
            self.textView.text = carteItem?.licenseText
        }
    }

    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    public override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.textView.frame = self.view.bounds
        self.view.addSubview(self.textView)
    }

}
#endif

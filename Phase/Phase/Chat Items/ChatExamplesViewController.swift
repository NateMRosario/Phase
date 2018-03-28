/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit

class ChatExamplesViewController: CellsViewController {
        
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = item1
        
        self.title = "Examples"
        self.cellItems = [
            self.makeOverviewCellItem(),
            self.makeChatCellItem(title: "Empty chat", messagesCount: 0),
        ]
    }
    
    // MARK: - Cells
    private func makeOverviewCellItem() -> CellItem {
        return CellItem(title: "Overview", action: { [weak self] in
            let dataSource = DemoChatDataSource(messages: DemoChatMessageFactory.makeOverviewMessages(), pageSize: 50)
            let viewController = AddRandomMessagesChatViewController()
            viewController.dataSource = dataSource
            self?.navigationController?.pushViewController(viewController, animated: true)
        })
    }
    
    private func makeChatCellItem(title: String, messagesCount: Int) -> CellItem {
        return CellItem(title: title, action: { [weak self] in
            let dataSource = DemoChatDataSource(count: messagesCount, pageSize: 50)
            let viewController = AddRandomMessagesChatViewController()
            viewController.dataSource = dataSource
            self?.navigationController?.pushViewController(viewController, animated: true)
        })
    }
    
    @objc
    private func dismissPresentedController() {
        self.dismiss(animated: true, completion: nil)
    }
}

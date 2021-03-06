//
// This file is part of Canvas.
// Copyright (C) 2019-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import UIKit

class PageListCell: UITableViewCell {
    @IBOutlet weak var accessIconView: AccessIconView?
    @IBOutlet weak var titleLabel: DynamicLabel?
    @IBOutlet weak var dateLabel: DynamicLabel?

    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    func update(page: Page, color: UIColor?) {
        dateLabel?.text = page.lastUpdated.map(PageListCell.dateFormatter.string)
        titleLabel?.text = page.title
        accessIconView?.icon = UIImage.icon(.document, .line)
        accessIconView?.tintColor = color
        if Bundle.main.isTeacherApp {
            accessIconView?.published = page.published
        } else {
            accessIconView?.state = nil
        }
    }
}

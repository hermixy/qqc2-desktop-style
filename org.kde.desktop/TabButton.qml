/*
 * Copyright 2017 Marco Martin <mart@kde.org>
 * Copyright 2017 The Qt Company Ltd.
 *
 * GNU Lesser General Public License Usage
 * Alternatively, this file may be used under the terms of the GNU Lesser
 * General Public License version 3 as published by the Free Software
 * Foundation and appearing in the file LICENSE.LGPLv3 included in the
 * packaging of this file. Please review the following information to
 * ensure the GNU Lesser General Public License version 3 requirements
 * will be met: https://www.gnu.org/licenses/lgpl.html.
 *
 * GNU General Public License Usage
 * Alternatively, this file may be used under the terms of the GNU
 * General Public License version 2.0 or later as published by the Free
 * Software Foundation and appearing in the file LICENSE.GPL included in
 * the packaging of this file. Please review the following information to
 * ensure the GNU General Public License version 2.0 requirements will be
 * met: http://www.gnu.org/licenses/gpl-2.0.html.
 */


import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQml.Models 2.1
//QQC1 is needed for StyleItem to fully work
import QtQuick.Controls 1.0 as QQC1
import QtQuick.Controls.Private 1.0
import QtQuick.Templates 2.0 as T

T.TabButton {
    id: control

    implicitWidth: styleitem.implicitWidth
    implicitHeight: styleitem.implicitHeight
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 0

    hoverEnabled: true

    contentItem: Item {}

    background: StyleItem {
        id: styleitem

        anchors.fill: parent
        elementType: "tab"
        paintMargins: 0
        property Item tabBar: control.parent.parent.parent

        property string orientation: tabBar.position == TabBar.Header ? "Top" : "Bottom"
        property string selectedpos: tabBar.currentIndex == control.ObjectModel.index + 1 ? "next" :
                                    tabBar.currentIndex == control.ObjectModel.index - 1 ? "previous" : ""
        property string tabpos: tabBar.count === 1 ? "only" : control.ObjectModel.index === 0 ? "beginning" : control.ObjectModel.index === tabBar.count - 1 ? "end" : "middle"

        properties: {
            "hasFrame" : true,
            "orientation": orientation,
            "tabpos": tabpos,
            "selectedpos": selectedpos
        }

        enabled: control.enabled
        selected: control.checked
        text: control.text
        hover: control.hovered
        hasFocus: control.activeFocus
    }
}

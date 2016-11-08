/*
 *   Copyright 2016 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.6
import QtQuick.Templates 2.0 as T
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0 as Controls
import QtQuick.Controls.Private 1.0

T.SpinBox {
    id: control

    implicitWidth: Math.max(48, contentItem.implicitWidth + 2 * padding +  up.indicator.implicitWidth)
    implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding

    padding: 6
    leftPadding: padding + (control.mirrored ? (up.indicator ? up.indicator.width : 0) : 0)
    rightPadding: padding + (control.mirrored ? 0 : (up.indicator ? up.indicator.width : 0))


    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        z: 2
        text: control.textFromValue(control.value, control.locale)
        opacity: control.enabled ? 1 : 0.3

        font: control.font
        color: SystemPaletteSingleton.text(control.enabled)
        selectionColor: SystemPaletteSingleton.highlight(control.enabled)
        selectedTextColor: SystemPaletteSingleton.highlightedText(control.enabled)
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }

    up.indicator: Item {
        implicitWidth: parent.height/2
        implicitHeight: implicitWidth
        x: control.mirrored ? 0 : parent.width - width
    }
    down.indicator: Item {
        implicitWidth: parent.height/2
        implicitHeight: implicitWidth
 
        x: control.mirrored ? 0 : parent.width - width
        y: parent.height - height
    }


    background: StyleItem {
        id: styleitem
        elementType: "spinbox"
        anchors.fill: parent
        sunken: (styleData.downEnabled && styleData.downPressed) || (styleData.upEnabled && styleData.upPressed)
        hover: control.hovered
        hasFocus: control.activeFocus
        enabled: control.enabled
        value: control.textFromValue(control.value, control.locale)
        border {
            top: 6
            bottom: 6
        }
    }
}

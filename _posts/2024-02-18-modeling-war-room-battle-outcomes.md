---
layout: post
title: Modeling War Room Battle Outcomes
date: 2024-02-18 12:00
description: ""
tags: programming data-science
readtime: 20 min
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.10/require.min.js"></script>
<style type="text/css">
    pre { line-height: 125%; }
td.linenos .normal { color: inherit; background-color: transparent; padding-left: 5px; padding-right: 5px; }
span.linenos { color: inherit; background-color: transparent; padding-left: 5px; padding-right: 5px; }
td.linenos .special { color: #000000; background-color: #ffffc0; padding-left: 5px; padding-right: 5px; }
span.linenos.special { color: #000000; background-color: #ffffc0; padding-left: 5px; padding-right: 5px; }
.highlight .hll { background-color: var(--jp-cell-editor-active-background) }
.highlight { background: var(--jp-cell-editor-background); color: var(--jp-mirror-editor-variable-color) }
.highlight .c { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment */
.highlight .err { color: var(--jp-mirror-editor-error-color) } /* Error */
.highlight .k { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword */
.highlight .o { color: var(--jp-mirror-editor-operator-color); font-weight: bold } /* Operator */
.highlight .p { color: var(--jp-mirror-editor-punctuation-color) } /* Punctuation */
.highlight .ch { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment.Hashbang */
.highlight .cm { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment.Multiline */
.highlight .cp { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment.Preproc */
.highlight .cpf { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment.PreprocFile */
.highlight .c1 { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment.Single */
.highlight .cs { color: var(--jp-mirror-editor-comment-color); font-style: italic } /* Comment.Special */
.highlight .kc { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword.Constant */
.highlight .kd { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword.Declaration */
.highlight .kn { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword.Namespace */
.highlight .kp { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword.Pseudo */
.highlight .kr { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword.Reserved */
.highlight .kt { color: var(--jp-mirror-editor-keyword-color); font-weight: bold } /* Keyword.Type */
.highlight .m { color: var(--jp-mirror-editor-number-color) } /* Literal.Number */
.highlight .s { color: var(--jp-mirror-editor-string-color) } /* Literal.String */
.highlight .ow { color: var(--jp-mirror-editor-operator-color); font-weight: bold } /* Operator.Word */
.highlight .pm { color: var(--jp-mirror-editor-punctuation-color) } /* Punctuation.Marker */
.highlight .w { color: var(--jp-mirror-editor-variable-color) } /* Text.Whitespace */
.highlight .mb { color: var(--jp-mirror-editor-number-color) } /* Literal.Number.Bin */
.highlight .mf { color: var(--jp-mirror-editor-number-color) } /* Literal.Number.Float */
.highlight .mh { color: var(--jp-mirror-editor-number-color) } /* Literal.Number.Hex */
.highlight .mi { color: var(--jp-mirror-editor-number-color) } /* Literal.Number.Integer */
.highlight .mo { color: var(--jp-mirror-editor-number-color) } /* Literal.Number.Oct */
.highlight .sa { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Affix */
.highlight .sb { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Backtick */
.highlight .sc { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Char */
.highlight .dl { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Delimiter */
.highlight .sd { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Doc */
.highlight .s2 { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Double */
.highlight .se { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Escape */
.highlight .sh { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Heredoc */
.highlight .si { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Interpol */
.highlight .sx { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Other */
.highlight .sr { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Regex */
.highlight .s1 { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Single */
.highlight .ss { color: var(--jp-mirror-editor-string-color) } /* Literal.String.Symbol */
.highlight .il { color: var(--jp-mirror-editor-number-color) } /* Literal.Number.Integer.Long */
  </style>
<style type="text/css">
/*-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------*/

/\*

- Mozilla scrollbar styling
  \*/

/_ use standard opaque scrollbars for most nodes _/
[data-jp-theme-scrollbars='true'] {
scrollbar-color: rgb(var(--jp-scrollbar-thumb-color))
var(--jp-scrollbar-background-color);
}

/\* for code nodes, use a transparent style of scrollbar. These selectors

- will match lower in the tree, and so will override the above \*/
  [data-jp-theme-scrollbars='true'] .CodeMirror-hscrollbar,
  [data-jp-theme-scrollbars='true'] .CodeMirror-vscrollbar {
  scrollbar-color: rgba(var(--jp-scrollbar-thumb-color), 0.5) transparent;
  }

/_ tiny scrollbar _/

.jp-scrollbar-tiny {
scrollbar-color: rgba(var(--jp-scrollbar-thumb-color), 0.5) transparent;
scrollbar-width: thin;
}

/_ tiny scrollbar _/

.jp-scrollbar-tiny::-webkit-scrollbar,
.jp-scrollbar-tiny::-webkit-scrollbar-corner {
background-color: transparent;
height: 4px;
width: 4px;
}

.jp-scrollbar-tiny::-webkit-scrollbar-thumb {
background: rgba(var(--jp-scrollbar-thumb-color), 0.5);
}

.jp-scrollbar-tiny::-webkit-scrollbar-track:horizontal {
border-left: 0 solid transparent;
border-right: 0 solid transparent;
}

.jp-scrollbar-tiny::-webkit-scrollbar-track:vertical {
border-top: 0 solid transparent;
border-bottom: 0 solid transparent;
}

/\*

- Lumino
  \*/

.lm-ScrollBar[data-orientation='horizontal'] {
min-height: 16px;
max-height: 16px;
min-width: 45px;
border-top: 1px solid #a0a0a0;
}

.lm-ScrollBar[data-orientation='vertical'] {
min-width: 16px;
max-width: 16px;
min-height: 45px;
border-left: 1px solid #a0a0a0;
}

.lm-ScrollBar-button {
background-color: #f0f0f0;
background-position: center center;
min-height: 15px;
max-height: 15px;
min-width: 15px;
max-width: 15px;
}

.lm-ScrollBar-button:hover {
background-color: #dadada;
}

.lm-ScrollBar-button.lm-mod-active {
background-color: #cdcdcd;
}

.lm-ScrollBar-track {
background: #f0f0f0;
}

.lm-ScrollBar-thumb {
background: #cdcdcd;
}

.lm-ScrollBar-thumb:hover {
background: #bababa;
}

.lm-ScrollBar-thumb.lm-mod-active {
background: #a0a0a0;
}

.lm-ScrollBar[data-orientation='horizontal'] .lm-ScrollBar-thumb {
height: 100%;
min-width: 15px;
border-left: 1px solid #a0a0a0;
border-right: 1px solid #a0a0a0;
}

.lm-ScrollBar[data-orientation='vertical'] .lm-ScrollBar-thumb {
width: 100%;
min-height: 15px;
border-top: 1px solid #a0a0a0;
border-bottom: 1px solid #a0a0a0;
}

.lm-ScrollBar[data-orientation='horizontal']
.lm-ScrollBar-button[data-action='decrement'] {
background-image: var(--jp-icon-caret-left);
background-size: 17px;
}

.lm-ScrollBar[data-orientation='horizontal']
.lm-ScrollBar-button[data-action='increment'] {
background-image: var(--jp-icon-caret-right);
background-size: 17px;
}

.lm-ScrollBar[data-orientation='vertical']
.lm-ScrollBar-button[data-action='decrement'] {
background-image: var(--jp-icon-caret-up);
background-size: 17px;
}

.lm-ScrollBar[data-orientation='vertical']
.lm-ScrollBar-button[data-action='increment'] {
background-image: var(--jp-icon-caret-down);
background-size: 17px;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-Widget {
box-sizing: border-box;
position: relative;
overflow: hidden;
}

.lm-Widget.lm-mod-hidden {
display: none !important;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

.lm-AccordionPanel[data-orientation='horizontal'] > .lm-AccordionPanel-title {
/_ Title is rotated for horizontal accordion panel using CSS _/
display: block;
transform-origin: top left;
transform: rotate(-90deg) translate(-100%);
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-CommandPalette {
display: flex;
flex-direction: column;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.lm-CommandPalette-search {
flex: 0 0 auto;
}

.lm-CommandPalette-content {
flex: 1 1 auto;
margin: 0;
padding: 0;
min-height: 0;
overflow: auto;
list-style-type: none;
}

.lm-CommandPalette-header {
overflow: hidden;
white-space: nowrap;
text-overflow: ellipsis;
}

.lm-CommandPalette-item {
display: flex;
flex-direction: row;
}

.lm-CommandPalette-itemIcon {
flex: 0 0 auto;
}

.lm-CommandPalette-itemContent {
flex: 1 1 auto;
overflow: hidden;
}

.lm-CommandPalette-itemShortcut {
flex: 0 0 auto;
}

.lm-CommandPalette-itemLabel {
overflow: hidden;
white-space: nowrap;
text-overflow: ellipsis;
}

.lm-close-icon {
border: 1px solid transparent;
background-color: transparent;
position: absolute;
z-index: 1;
right: 3%;
top: 0;
bottom: 0;
margin: auto;
padding: 7px 0;
display: none;
vertical-align: middle;
outline: 0;
cursor: pointer;
}
.lm-close-icon:after {
content: 'X';
display: block;
width: 15px;
height: 15px;
text-align: center;
color: #000;
font-weight: normal;
font-size: 12px;
cursor: pointer;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-DockPanel {
z-index: 0;
}

.lm-DockPanel-widget {
z-index: 0;
}

.lm-DockPanel-tabBar {
z-index: 1;
}

.lm-DockPanel-handle {
z-index: 2;
}

.lm-DockPanel-handle.lm-mod-hidden {
display: none !important;
}

.lm-DockPanel-handle:after {
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
content: '';
}

.lm-DockPanel-handle[data-orientation='horizontal'] {
cursor: ew-resize;
}

.lm-DockPanel-handle[data-orientation='vertical'] {
cursor: ns-resize;
}

.lm-DockPanel-handle[data-orientation='horizontal']:after {
left: 50%;
min-width: 8px;
transform: translateX(-50%);
}

.lm-DockPanel-handle[data-orientation='vertical']:after {
top: 50%;
min-height: 8px;
transform: translateY(-50%);
}

.lm-DockPanel-overlay {
z-index: 3;
box-sizing: border-box;
pointer-events: none;
}

.lm-DockPanel-overlay.lm-mod-hidden {
display: none !important;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-Menu {
z-index: 10000;
position: absolute;
white-space: nowrap;
overflow-x: hidden;
overflow-y: auto;
outline: none;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.lm-Menu-content {
margin: 0;
padding: 0;
display: table;
list-style-type: none;
}

.lm-Menu-item {
display: table-row;
}

.lm-Menu-item.lm-mod-hidden,
.lm-Menu-item.lm-mod-collapsed {
display: none !important;
}

.lm-Menu-itemIcon,
.lm-Menu-itemSubmenuIcon {
display: table-cell;
text-align: center;
}

.lm-Menu-itemLabel {
display: table-cell;
text-align: left;
}

.lm-Menu-itemShortcut {
display: table-cell;
text-align: right;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-MenuBar {
outline: none;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.lm-MenuBar-content {
margin: 0;
padding: 0;
display: flex;
flex-direction: row;
list-style-type: none;
}

.lm-MenuBar-item {
box-sizing: border-box;
}

.lm-MenuBar-itemIcon,
.lm-MenuBar-itemLabel {
display: inline-block;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-ScrollBar {
display: flex;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.lm-ScrollBar[data-orientation='horizontal'] {
flex-direction: row;
}

.lm-ScrollBar[data-orientation='vertical'] {
flex-direction: column;
}

.lm-ScrollBar-button {
box-sizing: border-box;
flex: 0 0 auto;
}

.lm-ScrollBar-track {
box-sizing: border-box;
position: relative;
overflow: hidden;
flex: 1 1 auto;
}

.lm-ScrollBar-thumb {
box-sizing: border-box;
position: absolute;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-SplitPanel-child {
z-index: 0;
}

.lm-SplitPanel-handle {
z-index: 1;
}

.lm-SplitPanel-handle.lm-mod-hidden {
display: none !important;
}

.lm-SplitPanel-handle:after {
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
content: '';
}

.lm-SplitPanel[data-orientation='horizontal'] > .lm-SplitPanel-handle {
cursor: ew-resize;
}

.lm-SplitPanel[data-orientation='vertical'] > .lm-SplitPanel-handle {
cursor: ns-resize;
}

.lm-SplitPanel[data-orientation='horizontal'] > .lm-SplitPanel-handle:after {
left: 50%;
min-width: 8px;
transform: translateX(-50%);
}

.lm-SplitPanel[data-orientation='vertical'] > .lm-SplitPanel-handle:after {
top: 50%;
min-height: 8px;
transform: translateY(-50%);
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-TabBar {
display: flex;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.lm-TabBar[data-orientation='horizontal'] {
flex-direction: row;
align-items: flex-end;
}

.lm-TabBar[data-orientation='vertical'] {
flex-direction: column;
align-items: flex-end;
}

.lm-TabBar-content {
margin: 0;
padding: 0;
display: flex;
flex: 1 1 auto;
list-style-type: none;
}

.lm-TabBar[data-orientation='horizontal'] > .lm-TabBar-content {
flex-direction: row;
}

.lm-TabBar[data-orientation='vertical'] > .lm-TabBar-content {
flex-direction: column;
}

.lm-TabBar-tab {
display: flex;
flex-direction: row;
box-sizing: border-box;
overflow: hidden;
touch-action: none; /_ Disable native Drag/Drop _/
}

.lm-TabBar-tabIcon,
.lm-TabBar-tabCloseIcon {
flex: 0 0 auto;
}

.lm-TabBar-tabLabel {
flex: 1 1 auto;
overflow: hidden;
white-space: nowrap;
}

.lm-TabBar-tabInput {
user-select: all;
width: 100%;
box-sizing: border-box;
}

.lm-TabBar-tab.lm-mod-hidden {
display: none !important;
}

.lm-TabBar-addButton.lm-mod-hidden {
display: none !important;
}

.lm-TabBar.lm-mod-dragging .lm-TabBar-tab {
position: relative;
}

.lm-TabBar.lm-mod-dragging[data-orientation='horizontal'] .lm-TabBar-tab {
left: 0;
transition: left 150ms ease;
}

.lm-TabBar.lm-mod-dragging[data-orientation='vertical'] .lm-TabBar-tab {
top: 0;
transition: top 150ms ease;
}

.lm-TabBar.lm-mod-dragging .lm-TabBar-tab.lm-mod-dragging {
transition: none;
}

.lm-TabBar-tabLabel .lm-TabBar-tabInput {
user-select: all;
width: 100%;
box-sizing: border-box;
background: inherit;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-TabPanel-tabBar {
z-index: 1;
}

.lm-TabPanel-stackedPanel {
z-index: 0;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-Collapse {
display: flex;
flex-direction: column;
align-items: stretch;
}

.jp-Collapse-header {
padding: 1px 12px;
background-color: var(--jp-layout-color1);
border-bottom: solid var(--jp-border-width) var(--jp-border-color2);
color: var(--jp-ui-font-color1);
cursor: pointer;
display: flex;
align-items: center;
font-size: var(--jp-ui-font-size0);
font-weight: 600;
text-transform: uppercase;
user-select: none;
}

.jp-Collapser-icon {
height: 16px;
}

.jp-Collapse-header-collapsed .jp-Collapser-icon {
transform: rotate(-90deg);
margin: auto 0;
}

.jp-Collapser-title {
line-height: 25px;
}

.jp-Collapse-contents {
padding: 0 12px;
background-color: var(--jp-layout-color1);
color: var(--jp-ui-font-color1);
overflow: auto;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_ This file was auto-generated by ensureUiComponents() in @jupyterlab/buildutils _/

/\*\*

- (DEPRECATED) Support for consuming icons as CSS background images
  \*/

/_ Icons urls _/

:root {
--jp-icon-add-above: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIHZpZXdCb3g9IjAgMCAxNCAxNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGcgY2xpcC1wYXRoPSJ1cmwoI2NsaXAwXzEzN18xOTQ5MikiPgo8cGF0aCBjbGFzcz0ianAtaWNvbjMiIGQ9Ik00Ljc1IDQuOTMwNjZINi42MjVWNi44MDU2NkM2LjYyNSA3LjAxMTkxIDYuNzkzNzUgNy4xODA2NiA3IDcuMTgwNjZDNy4yMDYyNSA3LjE4MDY2IDcuMzc1IDcuMDExOTEgNy4zNzUgNi44MDU2NlY0LjkzMDY2SDkuMjVDOS40NTYyNSA0LjkzMDY2IDkuNjI1IDQuNzYxOTEgOS42MjUgNC41NTU2NkM5LjYyNSA0LjM0OTQxIDkuNDU2MjUgNC4xODA2NiA5LjI1IDQuMTgwNjZINy4zNzVWMi4zMDU2NkM3LjM3NSAyLjA5OTQxIDcuMjA2MjUgMS45MzA2NiA3IDEuOTMwNjZDNi43OTM3NSAxLjkzMDY2IDYuNjI1IDIuMDk5NDEgNi42MjUgMi4zMDU2NlY0LjE4MDY2SDQuNzVDNC41NDM3NSA0LjE4MDY2IDQuMzc1IDQuMzQ5NDEgNC4zNzUgNC41NTU2NkM0LjM3NSA0Ljc2MTkxIDQuNTQzNzUgNC45MzA2NiA0Ljc1IDQuOTMwNjZaIiBmaWxsPSIjNjE2MTYxIiBzdHJva2U9IiM2MTYxNjEiIHN0cm9rZS13aWR0aD0iMC43Ii8+CjwvZz4KPHBhdGggY2xhc3M9ImpwLWljb24zIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgOS41VjExLjVMMi41IDExLjVWOS41TDExLjUgOS41Wk0xMiA4QzEyLjU1MjMgOCAxMyA4LjQ0NzcyIDEzIDlWMTJDMTMgMTIuNTUyMyAxMi41NTIzIDEzIDEyIDEzTDIgMTNDMS40NDc3MiAxMyAxIDEyLjU1MjMgMSAxMlY5QzEgOC40NDc3MiAxLjQ0NzcxIDggMiA4TDEyIDhaIiBmaWxsPSIjNjE2MTYxIi8+CjxkZWZzPgo8Y2xpcFBhdGggaWQ9ImNsaXAwXzEzN18xOTQ5MiI+CjxyZWN0IGNsYXNzPSJqcC1pY29uMyIgd2lkdGg9IjYiIGhlaWdodD0iNiIgZmlsbD0id2hpdGUiIHRyYW5zZm9ybT0ibWF0cml4KC0xIDAgMCAxIDEwIDEuNTU1NjYpIi8+CjwvY2xpcFBhdGg+CjwvZGVmcz4KPC9zdmc+Cg==);
--jp-icon-add-below: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIHZpZXdCb3g9IjAgMCAxNCAxNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGcgY2xpcC1wYXRoPSJ1cmwoI2NsaXAwXzEzN18xOTQ5OCkiPgo8cGF0aCBjbGFzcz0ianAtaWNvbjMiIGQ9Ik05LjI1IDEwLjA2OTNMNy4zNzUgMTAuMDY5M0w3LjM3NSA4LjE5NDM0QzcuMzc1IDcuOTg4MDkgNy4yMDYyNSA3LjgxOTM0IDcgNy44MTkzNEM2Ljc5Mzc1IDcuODE5MzQgNi42MjUgNy45ODgwOSA2LjYyNSA4LjE5NDM0TDYuNjI1IDEwLjA2OTNMNC43NSAxMC4wNjkzQzQuNTQzNzUgMTAuMDY5MyA0LjM3NSAxMC4yMzgxIDQuMzc1IDEwLjQ0NDNDNC4zNzUgMTAuNjUwNiA0LjU0Mzc1IDEwLjgxOTMgNC43NSAxMC44MTkzTDYuNjI1IDEwLjgxOTNMNi42MjUgMTIuNjk0M0M2LjYyNSAxMi45MDA2IDYuNzkzNzUgMTMuMDY5MyA3IDEzLjA2OTNDNy4yMDYyNSAxMy4wNjkzIDcuMzc1IDEyLjkwMDYgNy4zNzUgMTIuNjk0M0w3LjM3NSAxMC44MTkzTDkuMjUgMTAuODE5M0M5LjQ1NjI1IDEwLjgxOTMgOS42MjUgMTAuNjUwNiA5LjYyNSAxMC40NDQzQzkuNjI1IDEwLjIzODEgOS40NTYyNSAxMC4wNjkzIDkuMjUgMTAuMDY5M1oiIGZpbGw9IiM2MTYxNjEiIHN0cm9rZT0iIzYxNjE2MSIgc3Ryb2tlLXdpZHRoPSIwLjciLz4KPC9nPgo8cGF0aCBjbGFzcz0ianAtaWNvbjMiIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMi41IDUuNUwyLjUgMy41TDExLjUgMy41TDExLjUgNS41TDIuNSA1LjVaTTIgN0MxLjQ0NzcyIDcgMSA2LjU1MjI4IDEgNkwxIDNDMSAyLjQ0NzcyIDEuNDQ3NzIgMiAyIDJMMTIgMkMxMi41NTIzIDIgMTMgMi40NDc3MiAxMyAzTDEzIDZDMTMgNi41NTIyOSAxMi41NTIzIDcgMTIgN0wyIDdaIiBmaWxsPSIjNjE2MTYxIi8+CjxkZWZzPgo8Y2xpcFBhdGggaWQ9ImNsaXAwXzEzN18xOTQ5OCI+CjxyZWN0IGNsYXNzPSJqcC1pY29uMyIgd2lkdGg9IjYiIGhlaWdodD0iNiIgZmlsbD0id2hpdGUiIHRyYW5zZm9ybT0ibWF0cml4KDEgMS43NDg0NmUtMDcgMS43NDg0NmUtMDcgLTEgNCAxMy40NDQzKSIvPgo8L2NsaXBQYXRoPgo8L2RlZnM+Cjwvc3ZnPgo=);
--jp-icon-add: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTE5IDEzaC02djZoLTJ2LTZINXYtMmg2VjVoMnY2aDZ2MnoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-bell: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE2IDE2IiB2ZXJzaW9uPSIxLjEiPgogICA8cGF0aCBjbGFzcz0ianAtaWNvbjIganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjMzMzMzMzIgogICAgICBkPSJtOCAwLjI5Yy0xLjQgMC0yLjcgMC43My0zLjYgMS44LTEuMiAxLjUtMS40IDMuNC0xLjUgNS4yLTAuMTggMi4yLTAuNDQgNC0yLjMgNS4zbDAuMjggMS4zaDVjMC4wMjYgMC42NiAwLjMyIDEuMSAwLjcxIDEuNSAwLjg0IDAuNjEgMiAwLjYxIDIuOCAwIDAuNTItMC40IDAuNi0xIDAuNzEtMS41aDVsMC4yOC0xLjNjLTEuOS0wLjk3LTIuMi0zLjMtMi4zLTUuMy0wLjEzLTEuOC0wLjI2LTMuNy0xLjUtNS4yLTAuODUtMS0yLjItMS44LTMuNi0xLjh6bTAgMS40YzAuODggMCAxLjkgMC41NSAyLjUgMS4zIDAuODggMS4xIDEuMSAyLjcgMS4yIDQuNCAwLjEzIDEuNyAwLjIzIDMuNiAxLjMgNS4yaC0xMGMxLjEtMS42IDEuMi0zLjQgMS4zLTUuMiAwLjEzLTEuNyAwLjMtMy4zIDEuMi00LjQgMC41OS0wLjcyIDEuNi0xLjMgMi41LTEuM3ptLTAuNzQgMTJoMS41Yy0wLjAwMTUgMC4yOCAwLjAxNSAwLjc5LTAuNzQgMC43OS0wLjczIDAuMDAxNi0wLjcyLTAuNTMtMC43NC0wLjc5eiIgLz4KPC9zdmc+Cg==);
--jp-icon-bug-dot: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiM2MTYxNjEiPgogICAgICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTcuMTkgOEgyMFYxMEgxNy45MUMxNy45NiAxMC4zMyAxOCAxMC42NiAxOCAxMVYxMkgyMFYxNEgxOC41SDE4VjE0LjAyNzVDMTUuNzUgMTQuMjc2MiAxNCAxNi4xODM3IDE0IDE4LjVDMTQgMTkuMjA4IDE0LjE2MzUgMTkuODc3OSAxNC40NTQ5IDIwLjQ3MzlDMTMuNzA2MyAyMC44MTE3IDEyLjg3NTcgMjEgMTIgMjFDOS43OCAyMSA3Ljg1IDE5Ljc5IDYuODEgMThINFYxNkg2LjA5QzYuMDQgMTUuNjcgNiAxNS4zNCA2IDE1VjE0SDRWMTJINlYxMUM2IDEwLjY2IDYuMDQgMTAuMzMgNi4wOSAxMEg0VjhINi44MUM3LjI2IDcuMjIgNy44OCA2LjU1IDguNjIgNi4wNEw3IDQuNDFMOC40MSAzTDEwLjU5IDUuMTdDMTEuMDQgNS4wNiAxMS41MSA1IDEyIDVDMTIuNDkgNSAxMi45NiA1LjA2IDEzLjQyIDUuMTdMMTUuNTkgM0wxNyA0LjQxTDE1LjM3IDYuMDRDMTYuMTIgNi41NSAxNi43NCA3LjIyIDE3LjE5IDhaTTEwIDE2SDE0VjE0SDEwVjE2Wk0xMCAxMkgxNFYxMEgxMFYxMloiIGZpbGw9IiM2MTYxNjEiLz4KICAgICAgICA8cGF0aCBkPSJNMjIgMTguNUMyMiAyMC40MzMgMjAuNDMzIDIyIDE4LjUgMjJDMTYuNTY3IDIyIDE1IDIwLjQzMyAxNSAxOC41QzE1IDE2LjU2NyAxNi41NjcgMTUgMTguNSAxNUMyMC40MzMgMTUgMjIgMTYuNTY3IDIyIDE4LjVaIiBmaWxsPSIjNjE2MTYxIi8+CiAgICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-bug: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIj4KICAgIDxwYXRoIGQ9Ik0yMCA4aC0yLjgxYy0uNDUtLjc4LTEuMDctMS40NS0xLjgyLTEuOTZMMTcgNC40MSAxNS41OSAzbC0yLjE3IDIuMTdDMTIuOTYgNS4wNiAxMi40OSA1IDEyIDVjLS40OSAwLS45Ni4wNi0xLjQxLjE3TDguNDEgMyA3IDQuNDFsMS42MiAxLjYzQzcuODggNi41NSA3LjI2IDcuMjIgNi44MSA4SDR2MmgyLjA5Yy0uMDUuMzMtLjA5LjY2LS4wOSAxdjFINHYyaDJ2MWMwIC4zNC4wNC42Ny4wOSAxSDR2MmgyLjgxYzEuMDQgMS43OSAyLjk3IDMgNS4xOSAzczQuMTUtMS4yMSA1LjE5LTNIMjB2LTJoLTIuMDljLjA1LS4zMy4wOS0uNjYuMDktMXYtMWgydi0yaC0ydi0xYzAtLjM0LS4wNC0uNjctLjA5LTFIMjBWOHptLTYgOGgtNHYtMmg0djJ6bTAtNGgtNHYtMmg0djJ6Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-build: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTE0LjkgMTcuNDVDMTYuMjUgMTcuNDUgMTcuMzUgMTYuMzUgMTcuMzUgMTVDMTcuMzUgMTMuNjUgMTYuMjUgMTIuNTUgMTQuOSAxMi41NUMxMy41NCAxMi41NSAxMi40NSAxMy42NSAxMi40NSAxNUMxMi40NSAxNi4zNSAxMy41NCAxNy40NSAxNC45IDE3LjQ1Wk0yMC4xIDE1LjY4TDIxLjU4IDE2Ljg0QzIxLjcxIDE2Ljk1IDIxLjc1IDE3LjEzIDIxLjY2IDE3LjI5TDIwLjI2IDE5LjcxQzIwLjE3IDE5Ljg2IDIwIDE5LjkyIDE5LjgzIDE5Ljg2TDE4LjA5IDE5LjE2QzE3LjczIDE5LjQ0IDE3LjMzIDE5LjY3IDE2LjkxIDE5Ljg1TDE2LjY0IDIxLjdDMTYuNjIgMjEuODcgMTYuNDcgMjIgMTYuMyAyMkgxMy41QzEzLjMyIDIyIDEzLjE4IDIxLjg3IDEzLjE1IDIxLjdMMTIuODkgMTkuODVDMTIuNDYgMTkuNjcgMTIuMDcgMTkuNDQgMTEuNzEgMTkuMTZMOS45NjAwMiAxOS44NkM5LjgxMDAyIDE5LjkyIDkuNjIwMDIgMTkuODYgOS41NDAwMiAxOS43MUw4LjE0MDAyIDE3LjI5QzguMDUwMDIgMTcuMTMgOC4wOTAwMiAxNi45NSA4LjIyMDAyIDE2Ljg0TDkuNzAwMDIgMTUuNjhMOS42NTAwMSAxNUw5LjcwMDAyIDE0LjMxTDguMjIwMDIgMTMuMTZDOC4wOTAwMiAxMy4wNSA4LjA1MDAyIDEyLjg2IDguMTQwMDIgMTIuNzFMOS41NDAwMiAxMC4yOUM5LjYyMDAyIDEwLjEzIDkuODEwMDIgMTAuMDcgOS45NjAwMiAxMC4xM0wxMS43MSAxMC44NEMxMi4wNyAxMC41NiAxMi40NiAxMC4zMiAxMi44OSAxMC4xNUwxMy4xNSA4LjI4OTk4QzEzLjE4IDguMTI5OTggMTMuMzIgNy45OTk5OCAxMy41IDcuOTk5OThIMTYuM0MxNi40NyA3Ljk5OTk4IDE2LjYyIDguMTI5OTggMTYuNjQgOC4yODk5OEwxNi45MSAxMC4xNUMxNy4zMyAxMC4zMiAxNy43MyAxMC41NiAxOC4wOSAxMC44NEwxOS44MyAxMC4xM0MyMCAxMC4wNyAyMC4xNyAxMC4xMyAyMC4yNiAxMC4yOUwyMS42NiAxMi43MUMyMS43NSAxMi44NiAyMS43MSAxMy4wNSAyMS41OCAxMy4xNkwyMC4xIDE0LjMxTDIwLjE1IDE1TDIwLjEgMTUuNjhaIi8+CiAgICA8cGF0aCBkPSJNNy4zMjk2NiA3LjQ0NDU0QzguMDgzMSA3LjAwOTU0IDguMzM5MzIgNi4wNTMzMiA3LjkwNDMyIDUuMjk5ODhDNy40NjkzMiA0LjU0NjQzIDYuNTA4MSA0LjI4MTU2IDUuNzU0NjYgNC43MTY1NkM1LjM5MTc2IDQuOTI2MDggNS4xMjY5NSA1LjI3MTE4IDUuMDE4NDkgNS42NzU5NEM0LjkxMDA0IDYuMDgwNzEgNC45NjY4MiA2LjUxMTk4IDUuMTc2MzQgNi44NzQ4OEM1LjYxMTM0IDcuNjI4MzIgNi41NzYyMiA3Ljg3OTU0IDcuMzI5NjYgNy40NDQ1NFpNOS42NTcxOCA0Ljc5NTkzTDEwLjg2NzIgNC45NTE3OUMxMC45NjI4IDQuOTc3NDEgMTEuMDQwMiA1LjA3MTMzIDExLjAzODIgNS4xODc5M0wxMS4wMzg4IDYuOTg4OTNDMTEuMDQ1NSA3LjEwMDU0IDEwLjk2MTYgNy4xOTUxOCAxMC44NTUgNy4yMTA1NEw5LjY2MDAxIDcuMzgwODNMOS4yMzkxNSA4LjEzMTg4TDkuNjY5NjEgOS4yNTc0NUM5LjcwNzI5IDkuMzYyNzEgOS42NjkzNCA5LjQ3Njk5IDkuNTc0MDggOS41MzE5OUw4LjAxNTIzIDEwLjQzMkM3LjkxMTMxIDEwLjQ5MiA3Ljc5MzM3IDEwLjQ2NzcgNy43MjEwNSAxMC4zODI0TDYuOTg3NDggOS40MzE4OEw2LjEwOTMxIDkuNDMwODNMNS4zNDcwNCAxMC4zOTA1QzUuMjg5MDkgMTAuNDcwMiA1LjE3MzgzIDEwLjQ5MDUgNS4wNzE4NyAxMC40MzM5TDMuNTEyNDUgOS41MzI5M0MzLjQxMDQ5IDkuNDc2MzMgMy4zNzY0NyA5LjM1NzQxIDMuNDEwNzUgOS4yNTY3OUwzLjg2MzQ3IDguMTQwOTNMMy42MTc0OSA3Ljc3NDg4TDMuNDIzNDcgNy4zNzg4M0wyLjIzMDc1IDcuMjEyOTdDMi4xMjY0NyA3LjE5MjM1IDIuMDQwNDkgNy4xMDM0MiAyLjA0MjQ1IDYuOTg2ODJMMi4wNDE4NyA1LjE4NTgyQzIuMDQzODMgNS4wNjkyMiAyLjExOTA5IDQuOTc5NTggMi4yMTcwNCA0Ljk2OTIyTDMuNDIwNjUgNC43OTM5M0wzLjg2NzQ5IDQuMDI3ODhMMy40MTEwNSAyLjkxNzMxQzMuMzczMzcgMi44MTIwNCAzLjQxMTMxIDIuNjk3NzYgMy41MTUyMyAyLjYzNzc2TDUuMDc0MDggMS43Mzc3NkM1LjE2OTM0IDEuNjgyNzYgNS4yODcyOSAxLjcwNzA0IDUuMzU5NjEgMS43OTIzMUw2LjExOTE1IDIuNzI3ODhMNi45ODAwMSAyLjczODkzTDcuNzI0OTYgMS43ODkyMkM3Ljc5MTU2IDEuNzA0NTggNy45MTU0OCAxLjY3OTIyIDguMDA4NzkgMS43NDA4Mkw5LjU2ODIxIDIuNjQxODJDOS42NzAxNyAyLjY5ODQyIDkuNzEyODUgMi44MTIzNCA5LjY4NzIzIDIuOTA3OTdMOS4yMTcxOCA0LjAzMzgzTDkuNDYzMTYgNC4zOTk4OEw5LjY1NzE4IDQuNzk1OTNaIi8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-caret-down-empty-thin: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIwIDIwIj4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSIgc2hhcGUtcmVuZGVyaW5nPSJnZW9tZXRyaWNQcmVjaXNpb24iPgoJCTxwb2x5Z29uIGNsYXNzPSJzdDEiIHBvaW50cz0iOS45LDEzLjYgMy42LDcuNCA0LjQsNi42IDkuOSwxMi4yIDE1LjQsNi43IDE2LjEsNy40ICIvPgoJPC9nPgo8L3N2Zz4K);
--jp-icon-caret-down-empty: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE4IDE4Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiIHNoYXBlLXJlbmRlcmluZz0iZ2VvbWV0cmljUHJlY2lzaW9uIj4KICAgIDxwYXRoIGQ9Ik01LjIsNS45TDksOS43bDMuOC0zLjhsMS4yLDEuMmwtNC45LDVsLTQuOS01TDUuMiw1Ljl6Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-caret-down: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE4IDE4Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiIHNoYXBlLXJlbmRlcmluZz0iZ2VvbWV0cmljUHJlY2lzaW9uIj4KICAgIDxwYXRoIGQ9Ik01LjIsNy41TDksMTEuMmwzLjgtMy44SDUuMnoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-caret-left: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE4IDE4Ij4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSIgc2hhcGUtcmVuZGVyaW5nPSJnZW9tZXRyaWNQcmVjaXNpb24iPgoJCTxwYXRoIGQ9Ik0xMC44LDEyLjhMNy4xLDlsMy44LTMuOGwwLDcuNkgxMC44eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-caret-right: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE4IDE4Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiIHNoYXBlLXJlbmRlcmluZz0iZ2VvbWV0cmljUHJlY2lzaW9uIj4KICAgIDxwYXRoIGQ9Ik03LjIsNS4yTDEwLjksOWwtMy44LDMuOFY1LjJINy4yeiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-caret-up-empty-thin: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIwIDIwIj4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSIgc2hhcGUtcmVuZGVyaW5nPSJnZW9tZXRyaWNQcmVjaXNpb24iPgoJCTxwb2x5Z29uIGNsYXNzPSJzdDEiIHBvaW50cz0iMTUuNCwxMy4zIDkuOSw3LjcgNC40LDEzLjIgMy42LDEyLjUgOS45LDYuMyAxNi4xLDEyLjYgIi8+Cgk8L2c+Cjwvc3ZnPgo=);
--jp-icon-caret-up: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE4IDE4Ij4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSIgc2hhcGUtcmVuZGVyaW5nPSJnZW9tZXRyaWNQcmVjaXNpb24iPgoJCTxwYXRoIGQ9Ik01LjIsMTAuNUw5LDYuOGwzLjgsMy44SDUuMnoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-case-sensitive: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIwIDIwIj4KICA8ZyBjbGFzcz0ianAtaWNvbjIiIGZpbGw9IiM0MTQxNDEiPgogICAgPHJlY3QgeD0iMiIgeT0iMiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjE2Ii8+CiAgPC9nPgogIDxnIGNsYXNzPSJqcC1pY29uLWFjY2VudDIiIGZpbGw9IiNGRkYiPgogICAgPHBhdGggZD0iTTcuNiw4aDAuOWwzLjUsOGgtMS4xTDEwLDE0SDZsLTAuOSwySDRMNy42LDh6IE04LDkuMUw2LjQsMTNoMy4yTDgsOS4xeiIvPgogICAgPHBhdGggZD0iTTE2LjYsOS44Yy0wLjIsMC4xLTAuNCwwLjEtMC43LDAuMWMtMC4yLDAtMC40LTAuMS0wLjYtMC4yYy0wLjEtMC4xLTAuMi0wLjQtMC4yLTAuNyBjLTAuMywwLjMtMC42LDAuNS0wLjksMC43Yy0wLjMsMC4xLTAuNywwLjItMS4xLDAuMmMtMC4zLDAtMC41LDAtMC43LTAuMWMtMC4yLTAuMS0wLjQtMC4yLTAuNi0wLjNjLTAuMi0wLjEtMC4zLTAuMy0wLjQtMC41IGMtMC4xLTAuMi0wLjEtMC40LTAuMS0wLjdjMC0wLjMsMC4xLTAuNiwwLjItMC44YzAuMS0wLjIsMC4zLTAuNCwwLjQtMC41QzEyLDcsMTIuMiw2LjksMTIuNSw2LjhjMC4yLTAuMSwwLjUtMC4xLDAuNy0wLjIgYzAuMy0wLjEsMC41LTAuMSwwLjctMC4xYzAuMiwwLDAuNC0wLjEsMC42LTAuMWMwLjIsMCwwLjMtMC4xLDAuNC0wLjJjMC4xLTAuMSwwLjItMC4yLDAuMi0wLjRjMC0xLTEuMS0xLTEuMy0xIGMtMC40LDAtMS40LDAtMS40LDEuMmgtMC45YzAtMC40LDAuMS0wLjcsMC4yLTFjMC4xLTAuMiwwLjMtMC40LDAuNS0wLjZjMC4yLTAuMiwwLjUtMC4zLDAuOC0wLjNDMTMuMyw0LDEzLjYsNCwxMy45LDQgYzAuMywwLDAuNSwwLDAuOCwwLjFjMC4zLDAsMC41LDAuMSwwLjcsMC4yYzAuMiwwLjEsMC40LDAuMywwLjUsMC41QzE2LDUsMTYsNS4yLDE2LDUuNnYyLjljMCwwLjIsMCwwLjQsMCwwLjUgYzAsMC4xLDAuMSwwLjIsMC4zLDAuMmMwLjEsMCwwLjIsMCwwLjMsMFY5Ljh6IE0xNS4yLDYuOWMtMS4yLDAuNi0zLjEsMC4yLTMuMSwxLjRjMCwxLjQsMy4xLDEsMy4xLTAuNVY2Ljl6Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-check: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIj4KICAgIDxwYXRoIGQ9Ik05IDE2LjE3TDQuODMgMTJsLTEuNDIgMS40MUw5IDE5IDIxIDdsLTEuNDEtMS40MXoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-circle-empty: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTEyIDJDNi40NyAyIDIgNi40NyAyIDEyczQuNDcgMTAgMTAgMTAgMTAtNC40NyAxMC0xMFMxNy41MyAyIDEyIDJ6bTAgMThjLTQuNDEgMC04LTMuNTktOC04czMuNTktOCA4LTggOCAzLjU5IDggOC0zLjU5IDgtOCA4eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-circle: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTggMTgiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPGNpcmNsZSBjeD0iOSIgY3k9IjkiIHI9IjgiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-clear: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8bWFzayBpZD0iZG9udXRIb2xlIj4KICAgIDxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgZmlsbD0id2hpdGUiIC8+CiAgICA8Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSI4IiBmaWxsPSJibGFjayIvPgogIDwvbWFzaz4KCiAgPGcgY2xhc3M9ImpwLWljb24zIiBmaWxsPSIjNjE2MTYxIj4KICAgIDxyZWN0IGhlaWdodD0iMTgiIHdpZHRoPSIyIiB4PSIxMSIgeT0iMyIgdHJhbnNmb3JtPSJyb3RhdGUoMzE1LCAxMiwgMTIpIi8+CiAgICA8Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSIxMCIgbWFzaz0idXJsKCNkb251dEhvbGUpIi8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-close: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbi1ub25lIGpwLWljb24tc2VsZWN0YWJsZS1pbnZlcnNlIGpwLWljb24zLWhvdmVyIiBmaWxsPSJub25lIj4KICAgIDxjaXJjbGUgY3g9IjEyIiBjeT0iMTIiIHI9IjExIi8+CiAgPC9nPgoKICA8ZyBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIGpwLWljb24tYWNjZW50Mi1ob3ZlciIgZmlsbD0iIzYxNjE2MSI+CiAgICA8cGF0aCBkPSJNMTkgNi40MUwxNy41OSA1IDEyIDEwLjU5IDYuNDEgNSA1IDYuNDEgMTAuNTkgMTIgNSAxNy41OSA2LjQxIDE5IDEyIDEzLjQxIDE3LjU5IDE5IDE5IDE3LjU5IDEzLjQxIDEyeiIvPgogIDwvZz4KCiAgPGcgY2xhc3M9ImpwLWljb24tbm9uZSBqcC1pY29uLWJ1c3kiIGZpbGw9Im5vbmUiPgogICAgPGNpcmNsZSBjeD0iMTIiIGN5PSIxMiIgcj0iNyIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-code-check: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBzaGFwZS1yZW5kZXJpbmc9Imdlb21ldHJpY1ByZWNpc2lvbiI+CiAgICA8cGF0aCBkPSJNNi41OSwzLjQxTDIsOEw2LjU5LDEyLjZMOCwxMS4xOEw0LjgyLDhMOCw0LjgyTDYuNTksMy40MU0xMi40MSwzLjQxTDExLDQuODJMMTQuMTgsOEwxMSwxMS4xOEwxMi40MSwxMi42TDE3LDhMMTIuNDEsMy40MU0yMS41OSwxMS41OUwxMy41LDE5LjY4TDkuODMsMTZMOC40MiwxNy40MUwxMy41LDIyLjVMMjMsMTNMMjEuNTksMTEuNTlaIiAvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-code: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjIiIGhlaWdodD0iMjIiIHZpZXdCb3g9IjAgMCAyOCAyOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CgkJPHBhdGggZD0iTTExLjQgMTguNkw2LjggMTRMMTEuNCA5LjRMMTAgOEw0IDE0TDEwIDIwTDExLjQgMTguNlpNMTYuNiAxOC42TDIxLjIgMTRMMTYuNiA5LjRMMTggOEwyNCAxNEwxOCAyMEwxNi42IDE4LjZWMTguNloiLz4KCTwvZz4KPC9zdmc+Cg==);
--jp-icon-collapse-all: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGgKICAgICAgICAgICAgZD0iTTggMmMxIDAgMTEgMCAxMiAwczIgMSAyIDJjMCAxIDAgMTEgMCAxMnMwIDItMiAyQzIwIDE0IDIwIDQgMjAgNFMxMCA0IDYgNGMwLTIgMS0yIDItMnoiIC8+CiAgICAgICAgPHBhdGgKICAgICAgICAgICAgZD0iTTE4IDhjMC0xLTEtMi0yLTJTNSA2IDQgNnMtMiAxLTIgMmMwIDEgMCAxMSAwIDEyczEgMiAyIDJjMSAwIDExIDAgMTIgMHMyLTEgMi0yYzAtMSAwLTExIDAtMTJ6bS0yIDB2MTJINFY4eiIgLz4KICAgICAgICA8cGF0aCBkPSJNNiAxM3YyaDh2LTJ6IiAvPgogICAgPC9nPgo8L3N2Zz4K);
--jp-icon-console: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIwMCAyMDAiPgogIDxnIGNsYXNzPSJqcC1jb25zb2xlLWljb24tYmFja2dyb3VuZC1jb2xvciBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiMwMjg4RDEiPgogICAgPHBhdGggZD0iTTIwIDE5LjhoMTYwdjE1OS45SDIweiIvPgogIDwvZz4KICA8ZyBjbGFzcz0ianAtY29uc29sZS1pY29uLWNvbG9yIGpwLWljb24tc2VsZWN0YWJsZS1pbnZlcnNlIiBmaWxsPSIjZmZmIj4KICAgIDxwYXRoIGQ9Ik0xMDUgMTI3LjNoNDB2MTIuOGgtNDB6TTUxLjEgNzdMNzQgOTkuOWwtMjMuMyAyMy4zIDEwLjUgMTAuNSAyMy4zLTIzLjNMOTUgOTkuOSA4NC41IDg5LjQgNjEuNiA2Ni41eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-copy: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTggMTgiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTExLjksMUgzLjJDMi40LDEsMS43LDEuNywxLjcsMi41djEwLjJoMS41VjIuNWg4LjdWMXogTTE0LjEsMy45aC04Yy0wLjgsMC0xLjUsMC43LTEuNSwxLjV2MTAuMmMwLDAuOCwwLjcsMS41LDEuNSwxLjVoOCBjMC44LDAsMS41LTAuNywxLjUtMS41VjUuNEMxNS41LDQuNiwxNC45LDMuOSwxNC4xLDMuOXogTTE0LjEsMTUuNWgtOFY1LjRoOFYxNS41eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-copyright: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDI0IDI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCI+CiAgPGcgY2xhc3M9ImpwLWljb24zIiBmaWxsPSIjNjE2MTYxIj4KICAgIDxwYXRoIGQ9Ik0xMS44OCw5LjE0YzEuMjgsMC4wNiwxLjYxLDEuMTUsMS42MywxLjY2aDEuNzljLTAuMDgtMS45OC0xLjQ5LTMuMTktMy40NS0zLjE5QzkuNjQsNy42MSw4LDksOCwxMi4xNCBjMCwxLjk0LDAuOTMsNC4yNCwzLjg0LDQuMjRjMi4yMiwwLDMuNDEtMS42NSwzLjQ0LTIuOTVoLTEuNzljLTAuMDMsMC41OS0wLjQ1LDEuMzgtMS42MywxLjQ0QzEwLjU1LDE0LjgzLDEwLDEzLjgxLDEwLDEyLjE0IEMxMCw5LjI1LDExLjI4LDkuMTYsMTEuODgsOS4xNHogTTEyLDJDNi40OCwyLDIsNi40OCwyLDEyczQuNDgsMTAsMTAsMTBzMTAtNC40OCwxMC0xMFMxNy41MiwyLDEyLDJ6IE0xMiwyMGMtNC40MSwwLTgtMy41OS04LTggczMuNTktOCw4LThzOCwzLjU5LDgsOFMxNi40MSwyMCwxMiwyMHoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-cut: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTkuNjQgNy42NGMuMjMtLjUuMzYtMS4wNS4zNi0xLjY0IDAtMi4yMS0xLjc5LTQtNC00UzIgMy43OSAyIDZzMS43OSA0IDQgNGMuNTkgMCAxLjE0LS4xMyAxLjY0LS4zNkwxMCAxMmwtMi4zNiAyLjM2QzcuMTQgMTQuMTMgNi41OSAxNCA2IDE0Yy0yLjIxIDAtNCAxLjc5LTQgNHMxLjc5IDQgNCA0IDQtMS43OSA0LTRjMC0uNTktLjEzLTEuMTQtLjM2LTEuNjRMMTIgMTRsNyA3aDN2LTFMOS42NCA3LjY0ek02IDhjLTEuMSAwLTItLjg5LTItMnMuOS0yIDItMiAyIC44OSAyIDItLjkgMi0yIDJ6bTAgMTJjLTEuMSAwLTItLjg5LTItMnMuOS0yIDItMiAyIC44OSAyIDItLjkgMi0yIDJ6bTYtNy41Yy0uMjggMC0uNS0uMjItLjUtLjVzLjIyLS41LjUtLjUuNS4yMi41LjUtLjIyLjUtLjUuNXpNMTkgM2wtNiA2IDIgMiA3LTdWM3oiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-delete: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjE2cHgiIGhlaWdodD0iMTZweCI+CiAgICA8cGF0aCBkPSJNMCAwaDI0djI0SDB6IiBmaWxsPSJub25lIiAvPgogICAgPHBhdGggY2xhc3M9ImpwLWljb24zIiBmaWxsPSIjNjI2MjYyIiBkPSJNNiAxOWMwIDEuMS45IDIgMiAyaDhjMS4xIDAgMi0uOSAyLTJWN0g2djEyek0xOSA0aC0zLjVsLTEtMWgtNWwtMSAxSDV2MmgxNFY0eiIgLz4KPC9zdmc+Cg==);
--jp-icon-download: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTE5IDloLTRWM0g5djZINWw3IDcgNy03ek01IDE4djJoMTR2LTJINXoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-duplicate: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIHZpZXdCb3g9IjAgMCAxNCAxNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggY2xhc3M9ImpwLWljb24zIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTIuNzk5OTggMC44NzVIOC44OTU4MkM5LjIwMDYxIDAuODc1IDkuNDQ5OTggMS4xMzkxNCA5LjQ0OTk4IDEuNDYxOThDOS40NDk5OCAxLjc4NDgyIDkuMjAwNjEgMi4wNDg5NiA4Ljg5NTgyIDIuMDQ4OTZIMy4zNTQxNUMzLjA0OTM2IDIuMDQ4OTYgMi43OTk5OCAyLjMxMzEgMi43OTk5OCAyLjYzNTk0VjkuNjc5NjlDMi43OTk5OCAxMC4wMDI1IDIuNTUwNjEgMTAuMjY2NyAyLjI0NTgyIDEwLjI2NjdDMS45NDEwMyAxMC4yNjY3IDEuNjkxNjUgMTAuMDAyNSAxLjY5MTY1IDkuNjc5NjlWMi4wNDg5NkMxLjY5MTY1IDEuNDAzMjggMi4xOTA0IDAuODc1IDIuNzk5OTggMC44NzVaTTUuMzY2NjUgMTEuOVY0LjU1SDExLjA4MzNWMTEuOUg1LjM2NjY1Wk00LjE0MTY1IDQuMTQxNjdDNC4xNDE2NSAzLjY5MDYzIDQuNTA3MjggMy4zMjUgNC45NTgzMiAzLjMyNUgxMS40OTE3QzExLjk0MjcgMy4zMjUgMTIuMzA4MyAzLjY5MDYzIDEyLjMwODMgNC4xNDE2N1YxMi4zMDgzQzEyLjMwODMgMTIuNzU5NCAxMS45NDI3IDEzLjEyNSAxMS40OTE3IDEzLjEyNUg0Ljk1ODMyQzQuNTA3MjggMTMuMTI1IDQuMTQxNjUgMTIuNzU5NCA0LjE0MTY1IDEyLjMwODNWNC4xNDE2N1oiIGZpbGw9IiM2MTYxNjEiLz4KPHBhdGggY2xhc3M9ImpwLWljb24zIiBkPSJNOS40MzU3NCA4LjI2NTA3SDguMzY0MzFWOS4zMzY1QzguMzY0MzEgOS40NTQzNSA4LjI2Nzg4IDkuNTUwNzggOC4xNTAwMiA5LjU1MDc4QzguMDMyMTcgOS41NTA3OCA3LjkzNTc0IDkuNDU0MzUgNy45MzU3NCA5LjMzNjVWOC4yNjUwN0g2Ljg2NDMxQzYuNzQ2NDUgOC4yNjUwNyA2LjY1MDAyIDguMTY4NjQgNi42NTAwMiA4LjA1MDc4QzYuNjUwMDIgNy45MzI5MiA2Ljc0NjQ1IDcuODM2NSA2Ljg2NDMxIDcuODM2NUg3LjkzNTc0VjYuNzY1MDdDNy45MzU3NCA2LjY0NzIxIDguMDMyMTcgNi41NTA3OCA4LjE1MDAyIDYuNTUwNzhDOC4yNjc4OCA2LjU1MDc4IDguMzY0MzEgNi42NDcyMSA4LjM2NDMxIDYuNzY1MDdWNy44MzY1SDkuNDM1NzRDOS41NTM2IDcuODM2NSA5LjY1MDAyIDcuOTMyOTIgOS42NTAwMiA4LjA1MDc4QzkuNjUwMDIgOC4xNjg2NCA5LjU1MzYgOC4yNjUwNyA5LjQzNTc0IDguMjY1MDdaIiBmaWxsPSIjNjE2MTYxIiBzdHJva2U9IiM2MTYxNjEiIHN0cm9rZS13aWR0aD0iMC41Ii8+Cjwvc3ZnPgo=);
--jp-icon-edit: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTMgMTcuMjVWMjFoMy43NUwxNy44MSA5Ljk0bC0zLjc1LTMuNzVMMyAxNy4yNXpNMjAuNzEgNy4wNGMuMzktLjM5LjM5LTEuMDIgMC0xLjQxbC0yLjM0LTIuMzRjLS4zOS0uMzktMS4wMi0uMzktMS40MSAwbC0xLjgzIDEuODMgMy43NSAzLjc1IDEuODMtMS44M3oiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-ellipses: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPGNpcmNsZSBjeD0iNSIgY3k9IjEyIiByPSIyIi8+CiAgICA8Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSIyIi8+CiAgICA8Y2lyY2xlIGN4PSIxOSIgY3k9IjEyIiByPSIyIi8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-error: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KPGcgY2xhc3M9ImpwLWljb24zIiBmaWxsPSIjNjE2MTYxIj48Y2lyY2xlIGN4PSIxMiIgY3k9IjE5IiByPSIyIi8+PHBhdGggZD0iTTEwIDNoNHYxMmgtNHoiLz48L2c+CjxwYXRoIGZpbGw9Im5vbmUiIGQ9Ik0wIDBoMjR2MjRIMHoiLz4KPC9zdmc+Cg==);
--jp-icon-expand-all: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGgKICAgICAgICAgICAgZD0iTTggMmMxIDAgMTEgMCAxMiAwczIgMSAyIDJjMCAxIDAgMTEgMCAxMnMwIDItMiAyQzIwIDE0IDIwIDQgMjAgNFMxMCA0IDYgNGMwLTIgMS0yIDItMnoiIC8+CiAgICAgICAgPHBhdGgKICAgICAgICAgICAgZD0iTTE4IDhjMC0xLTEtMi0yLTJTNSA2IDQgNnMtMiAxLTIgMmMwIDEgMCAxMSAwIDEyczEgMiAyIDJjMSAwIDExIDAgMTIgMHMyLTEgMi0yYzAtMSAwLTExIDAtMTJ6bS0yIDB2MTJINFY4eiIgLz4KICAgICAgICA8cGF0aCBkPSJNMTEgMTBIOXYzSDZ2MmgzdjNoMnYtM2gzdi0yaC0zeiIgLz4KICAgIDwvZz4KPC9zdmc+Cg==);
--jp-icon-extension: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTIwLjUgMTFIMTlWN2MwLTEuMS0uOS0yLTItMmgtNFYzLjVDMTMgMi4xMiAxMS44OCAxIDEwLjUgMVM4IDIuMTIgOCAzLjVWNUg0Yy0xLjEgMC0xLjk5LjktMS45OSAydjMuOEgzLjVjMS40OSAwIDIuNyAxLjIxIDIuNyAyLjdzLTEuMjEgMi43LTIuNyAyLjdIMlYyMGMwIDEuMS45IDIgMiAyaDMuOHYtMS41YzAtMS40OSAxLjIxLTIuNyAyLjctMi43IDEuNDkgMCAyLjcgMS4yMSAyLjcgMi43VjIySDE3YzEuMSAwIDItLjkgMi0ydi00aDEuNWMxLjM4IDAgMi41LTEuMTIgMi41LTIuNVMyMS44OCAxMSAyMC41IDExeiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-fast-forward: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTQgMThsOC41LTZMNCA2djEyem05LTEydjEybDguNS02TDEzIDZ6Ii8+CiAgICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-file-upload: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTkgMTZoNnYtNmg0bC03LTctNyA3aDR6bS00IDJoMTR2Mkg1eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-file: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8cGF0aCBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBkPSJNMTkuMyA4LjJsLTUuNS01LjVjLS4zLS4zLS43LS41LTEuMi0uNUgzLjljLS44LjEtMS42LjktMS42IDEuOHYxNC4xYzAgLjkuNyAxLjYgMS42IDEuNmgxNC4yYy45IDAgMS42LS43IDEuNi0xLjZWOS40Yy4xLS41LS4xLS45LS40LTEuMnptLTUuOC0zLjNsMy40IDMuNmgtMy40VjQuOXptMy45IDEyLjdINC43Yy0uMSAwLS4yIDAtLjItLjJWNC43YzAtLjIuMS0uMy4yLS4zaDcuMnY0LjRzMCAuOC4zIDEuMWMuMy4zIDEuMS4zIDEuMS4zaDQuM3Y3LjJzLS4xLjItLjIuMnoiLz4KPC9zdmc+Cg==);
--jp-icon-filter-dot: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiNGRkYiPgogICAgPHBhdGggZD0iTTE0LDEyVjE5Ljg4QzE0LjA0LDIwLjE4IDEzLjk0LDIwLjUgMTMuNzEsMjAuNzFDMTMuMzIsMjEuMSAxMi42OSwyMS4xIDEyLjMsMjAuNzFMMTAuMjksMTguN0MxMC4wNiwxOC40NyA5Ljk2LDE4LjE2IDEwLDE3Ljg3VjEySDkuOTdMNC4yMSw0LjYyQzMuODcsNC4xOSAzLjk1LDMuNTYgNC4zOCwzLjIyQzQuNTcsMy4wOCA0Ljc4LDMgNSwzVjNIMTlWM0MxOS4yMiwzIDE5LjQzLDMuMDggMTkuNjIsMy4yMkMyMC4wNSwzLjU2IDIwLjEzLDQuMTkgMTkuNzksNC42MkwxNC4wMywxMkgxNFoiIC8+CiAgPC9nPgogIDxnIGNsYXNzPSJqcC1pY29uLWRvdCIgZmlsbD0iI0ZGRiI+CiAgICA8Y2lyY2xlIGN4PSIxOCIgY3k9IjE3IiByPSIzIj48L2NpcmNsZT4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-filter-list: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTEwIDE4aDR2LTJoLTR2MnpNMyA2djJoMThWNkgzem0zIDdoMTJ2LTJINnYyeiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-filter: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiNGRkYiPgogICAgPHBhdGggZD0iTTE0LDEyVjE5Ljg4QzE0LjA0LDIwLjE4IDEzLjk0LDIwLjUgMTMuNzEsMjAuNzFDMTMuMzIsMjEuMSAxMi42OSwyMS4xIDEyLjMsMjAuNzFMMTAuMjksMTguN0MxMC4wNiwxOC40NyA5Ljk2LDE4LjE2IDEwLDE3Ljg3VjEySDkuOTdMNC4yMSw0LjYyQzMuODcsNC4xOSAzLjk1LDMuNTYgNC4zOCwzLjIyQzQuNTcsMy4wOCA0Ljc4LDMgNSwzVjNIMTlWM0MxOS4yMiwzIDE5LjQzLDMuMDggMTkuNjIsMy4yMkMyMC4wNSwzLjU2IDIwLjEzLDQuMTkgMTkuNzksNC42MkwxNC4wMywxMkgxNFoiIC8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-folder-favorite: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAwIDI0IDI0IiB3aWR0aD0iMjRweCIgZmlsbD0iIzAwMDAwMCI+CiAgPHBhdGggZD0iTTAgMGgyNHYyNEgwVjB6IiBmaWxsPSJub25lIi8+PHBhdGggY2xhc3M9ImpwLWljb24zIGpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iIzYxNjE2MSIgZD0iTTIwIDZoLThsLTItMkg0Yy0xLjEgMC0yIC45LTIgMnYxMmMwIDEuMS45IDIgMiAyaDE2YzEuMSAwIDItLjkgMi0yVjhjMC0xLjEtLjktMi0yLTJ6bS0yLjA2IDExTDE1IDE1LjI4IDEyLjA2IDE3bC43OC0zLjMzLTIuNTktMi4yNCAzLjQxLS4yOUwxNSA4bDEuMzQgMy4xNCAzLjQxLjI5LTIuNTkgMi4yNC43OCAzLjMzeiIvPgo8L3N2Zz4K);
--jp-icon-folder: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBkPSJNMTAgNEg0Yy0xLjEgMC0xLjk5LjktMS45OSAyTDIgMThjMCAxLjEuOSAyIDIgMmgxNmMxLjEgMCAyLS45IDItMlY4YzAtMS4xLS45LTItMi0yaC04bC0yLTJ6Ii8+Cjwvc3ZnPgo=);
--jp-icon-home: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAwIDI0IDI0IiB3aWR0aD0iMjRweCIgZmlsbD0iIzAwMDAwMCI+CiAgPHBhdGggZD0iTTAgMGgyNHYyNEgweiIgZmlsbD0ibm9uZSIvPjxwYXRoIGNsYXNzPSJqcC1pY29uMyBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiM2MTYxNjEiIGQ9Ik0xMCAyMHYtNmg0djZoNXYtOGgzTDEyIDMgMiAxMmgzdjh6Ii8+Cjwvc3ZnPgo=);
--jp-icon-html5: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDUxMiA1MTIiPgogIDxwYXRoIGNsYXNzPSJqcC1pY29uMCBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiMwMDAiIGQ9Ik0xMDguNCAwaDIzdjIyLjhoMjEuMlYwaDIzdjY5aC0yM1Y0NmgtMjF2MjNoLTIzLjJNMjA2IDIzaC0yMC4zVjBoNjMuN3YyM0gyMjl2NDZoLTIzbTUzLjUtNjloMjQuMWwxNC44IDI0LjNMMzEzLjIgMGgyNC4xdjY5aC0yM1YzNC44bC0xNi4xIDI0LjgtMTYuMS0yNC44VjY5aC0yMi42bTg5LjItNjloMjN2NDYuMmgzMi42VjY5aC01NS42Ii8+CiAgPHBhdGggY2xhc3M9ImpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iI2U0NGQyNiIgZD0iTTEwNy42IDQ3MWwtMzMtMzcwLjRoMzYyLjhsLTMzIDM3MC4yTDI1NS43IDUxMiIvPgogIDxwYXRoIGNsYXNzPSJqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiNmMTY1MjkiIGQ9Ik0yNTYgNDgwLjVWMTMxaDE0OC4zTDM3NiA0NDciLz4KICA8cGF0aCBjbGFzcz0ianAtaWNvbi1zZWxlY3RhYmxlLWludmVyc2UiIGZpbGw9IiNlYmViZWIiIGQ9Ik0xNDIgMTc2LjNoMTE0djQ1LjRoLTY0LjJsNC4yIDQ2LjVoNjB2NDUuM0gxNTQuNG0yIDIyLjhIMjAybDMuMiAzNi4zIDUwLjggMTMuNnY0Ny40bC05My4yLTI2Ii8+CiAgPHBhdGggY2xhc3M9ImpwLWljb24tc2VsZWN0YWJsZS1pbnZlcnNlIiBmaWxsPSIjZmZmIiBkPSJNMzY5LjYgMTc2LjNIMjU1Ljh2NDUuNGgxMDkuNm0tNC4xIDQ2LjVIMjU1Ljh2NDUuNGg1NmwtNS4zIDU5LTUwLjcgMTMuNnY0Ny4ybDkzLTI1LjgiLz4KPC9zdmc+Cg==);
--jp-icon-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8cGF0aCBjbGFzcz0ianAtaWNvbi1icmFuZDQganAtaWNvbi1zZWxlY3RhYmxlLWludmVyc2UiIGZpbGw9IiNGRkYiIGQ9Ik0yLjIgMi4yaDE3LjV2MTcuNUgyLjJ6Ii8+CiAgPHBhdGggY2xhc3M9ImpwLWljb24tYnJhbmQwIGpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iIzNGNTFCNSIgZD0iTTIuMiAyLjJ2MTcuNWgxNy41bC4xLTE3LjVIMi4yem0xMi4xIDIuMmMxLjIgMCAyLjIgMSAyLjIgMi4ycy0xIDIuMi0yLjIgMi4yLTIuMi0xLTIuMi0yLjIgMS0yLjIgMi4yLTIuMnpNNC40IDE3LjZsMy4zLTguOCAzLjMgNi42IDIuMi0zLjIgNC40IDUuNEg0LjR6Ii8+Cjwvc3ZnPgo=);
--jp-icon-info: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDUwLjk3OCA1MC45NzgiPgoJPGcgY2xhc3M9ImpwLWljb24zIiBmaWxsPSIjNjE2MTYxIj4KCQk8cGF0aCBkPSJNNDMuNTIsNy40NThDMzguNzExLDIuNjQ4LDMyLjMwNywwLDI1LjQ4OSwwQzE4LjY3LDAsMTIuMjY2LDIuNjQ4LDcuNDU4LDcuNDU4CgkJCWMtOS45NDMsOS45NDEtOS45NDMsMjYuMTE5LDAsMzYuMDYyYzQuODA5LDQuODA5LDExLjIxMiw3LjQ1NiwxOC4wMzEsNy40NThjMCwwLDAuMDAxLDAsMC4wMDIsMAoJCQljNi44MTYsMCwxMy4yMjEtMi42NDgsMTguMDI5LTcuNDU4YzQuODA5LTQuODA5LDcuNDU3LTExLjIxMiw3LjQ1Ny0xOC4wM0M1MC45NzcsMTguNjcsNDguMzI4LDEyLjI2Niw0My41Miw3LjQ1OHoKCQkJIE00Mi4xMDYsNDIuMTA1Yy00LjQzMiw0LjQzMS0xMC4zMzIsNi44NzItMTYuNjE1LDYuODcyaC0wLjAwMmMtNi4yODUtMC4wMDEtMTIuMTg3LTIuNDQxLTE2LjYxNy02Ljg3MgoJCQljLTkuMTYyLTkuMTYzLTkuMTYyLTI0LjA3MSwwLTMzLjIzM0MxMy4zMDMsNC40NCwxOS4yMDQsMiwyNS40ODksMmM2LjI4NCwwLDEyLjE4NiwyLjQ0LDE2LjYxNyw2Ljg3MgoJCQljNC40MzEsNC40MzEsNi44NzEsMTAuMzMyLDYuODcxLDE2LjYxN0M0OC45NzcsMzEuNzcyLDQ2LjUzNiwzNy42NzUsNDIuMTA2LDQyLjEwNXoiLz4KCQk8cGF0aCBkPSJNMjMuNTc4LDMyLjIxOGMtMC4wMjMtMS43MzQsMC4xNDMtMy4wNTksMC40OTYtMy45NzJjMC4zNTMtMC45MTMsMS4xMS0xLjk5NywyLjI3Mi0zLjI1MwoJCQljMC40NjgtMC41MzYsMC45MjMtMS4wNjIsMS4zNjctMS41NzVjMC42MjYtMC43NTMsMS4xMDQtMS40NzgsMS40MzYtMi4xNzVjMC4zMzEtMC43MDcsMC40OTUtMS41NDEsMC40OTUtMi41CgkJCWMwLTEuMDk2LTAuMjYtMi4wODgtMC43NzktMi45NzljLTAuNTY1LTAuODc5LTEuNTAxLTEuMzM2LTIuODA2LTEuMzY5Yy0xLjgwMiwwLjA1Ny0yLjk4NSwwLjY2Ny0zLjU1LDEuODMyCgkJCWMtMC4zMDEsMC41MzUtMC41MDMsMS4xNDEtMC42MDcsMS44MTRjLTAuMTM5LDAuNzA3LTAuMjA3LDEuNDMyLTAuMjA3LDIuMTc0aC0yLjkzN2MtMC4wOTEtMi4yMDgsMC40MDctNC4xMTQsMS40OTMtNS43MTkKCQkJYzEuMDYyLTEuNjQsMi44NTUtMi40ODEsNS4zNzgtMi41MjdjMi4xNiwwLjAyMywzLjg3NCwwLjYwOCw1LjE0MSwxLjc1OGMxLjI3OCwxLjE2LDEuOTI5LDIuNzY0LDEuOTUsNC44MTEKCQkJYzAsMS4xNDItMC4xMzcsMi4xMTEtMC40MSwyLjkxMWMtMC4zMDksMC44NDUtMC43MzEsMS41OTMtMS4yNjgsMi4yNDNjLTAuNDkyLDAuNjUtMS4wNjgsMS4zMTgtMS43MywyLjAwMgoJCQljLTAuNjUsMC42OTctMS4zMTMsMS40NzktMS45ODcsMi4zNDZjLTAuMjM5LDAuMzc3LTAuNDI5LDAuNzc3LTAuNTY1LDEuMTk5Yy0wLjE2LDAuOTU5LTAuMjE3LDEuOTUxLTAuMTcxLDIuOTc5CgkJCUMyNi41ODksMzIuMjE4LDIzLjU3OCwzMi4yMTgsMjMuNTc4LDMyLjIxOHogTTIzLjU3OCwzOC4yMnYtMy40ODRoMy4wNzZ2My40ODRIMjMuNTc4eiIvPgoJPC9nPgo8L3N2Zz4K);
--jp-icon-inspector: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBjbGFzcz0ianAtaW5zcGVjdG9yLWljb24tY29sb3IganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBkPSJNMjAgNEg0Yy0xLjEgMC0xLjk5LjktMS45OSAyTDIgMThjMCAxLjEuOSAyIDIgMmgxNmMxLjEgMCAyLS45IDItMlY2YzAtMS4xLS45LTItMi0yem0tNSAxNEg0di00aDExdjR6bTAtNUg0VjloMTF2NHptNSA1aC00VjloNHY5eiIvPgo8L3N2Zz4K);
--jp-icon-json: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8ZyBjbGFzcz0ianAtanNvbi1pY29uLWNvbG9yIGpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iI0Y5QTgyNSI+CiAgICA8cGF0aCBkPSJNMjAuMiAxMS44Yy0xLjYgMC0xLjcuNS0xLjcgMSAwIC40LjEuOS4xIDEuMy4xLjUuMS45LjEgMS4zIDAgMS43LTEuNCAyLjMtMy41IDIuM2gtLjl2LTEuOWguNWMxLjEgMCAxLjQgMCAxLjQtLjggMC0uMyAwLS42LS4xLTEgMC0uNC0uMS0uOC0uMS0xLjIgMC0xLjMgMC0xLjggMS4zLTItMS4zLS4yLTEuMy0uNy0xLjMtMiAwLS40LjEtLjguMS0xLjIuMS0uNC4xLS43LjEtMSAwLS44LS40LS43LTEuNC0uOGgtLjVWNC4xaC45YzIuMiAwIDMuNS43IDMuNSAyLjMgMCAuNC0uMS45LS4xIDEuMy0uMS41LS4xLjktLjEgMS4zIDAgLjUuMiAxIDEuNyAxdjEuOHpNMS44IDEwLjFjMS42IDAgMS43LS41IDEuNy0xIDAtLjQtLjEtLjktLjEtMS4zLS4xLS41LS4xLS45LS4xLTEuMyAwLTEuNiAxLjQtMi4zIDMuNS0yLjNoLjl2MS45aC0uNWMtMSAwLTEuNCAwLTEuNC44IDAgLjMgMCAuNi4xIDEgMCAuMi4xLjYuMSAxIDAgMS4zIDAgMS44LTEuMyAyQzYgMTEuMiA2IDExLjcgNiAxM2MwIC40LS4xLjgtLjEgMS4yLS4xLjMtLjEuNy0uMSAxIDAgLjguMy44IDEuNC44aC41djEuOWgtLjljLTIuMSAwLTMuNS0uNi0zLjUtMi4zIDAtLjQuMS0uOS4xLTEuMy4xLS41LjEtLjkuMS0xLjMgMC0uNS0uMi0xLTEuNy0xdi0xLjl6Ii8+CiAgICA8Y2lyY2xlIGN4PSIxMSIgY3k9IjEzLjgiIHI9IjIuMSIvPgogICAgPGNpcmNsZSBjeD0iMTEiIGN5PSI4LjIiIHI9IjIuMSIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-julia: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDMyNSAzMDAiPgogIDxnIGNsYXNzPSJqcC1icmFuZDAganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjY2IzYzMzIj4KICAgIDxwYXRoIGQ9Ik0gMTUwLjg5ODQzOCAyMjUgQyAxNTAuODk4NDM4IDI2Ni40MjE4NzUgMTE3LjMyMDMxMiAzMDAgNzUuODk4NDM4IDMwMCBDIDM0LjQ3NjU2MiAzMDAgMC44OTg0MzggMjY2LjQyMTg3NSAwLjg5ODQzOCAyMjUgQyAwLjg5ODQzOCAxODMuNTc4MTI1IDM0LjQ3NjU2MiAxNTAgNzUuODk4NDM4IDE1MCBDIDExNy4zMjAzMTIgMTUwIDE1MC44OTg0MzggMTgzLjU3ODEyNSAxNTAuODk4NDM4IDIyNSIvPgogIDwvZz4KICA8ZyBjbGFzcz0ianAtYnJhbmQwIGpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iIzM4OTgyNiI+CiAgICA8cGF0aCBkPSJNIDIzNy41IDc1IEMgMjM3LjUgMTE2LjQyMTg3NSAyMDMuOTIxODc1IDE1MCAxNjIuNSAxNTAgQyAxMjEuMDc4MTI1IDE1MCA4Ny41IDExNi40MjE4NzUgODcuNSA3NSBDIDg3LjUgMzMuNTc4MTI1IDEyMS4wNzgxMjUgMCAxNjIuNSAwIEMgMjAzLjkyMTg3NSAwIDIzNy41IDMzLjU3ODEyNSAyMzcuNSA3NSIvPgogIDwvZz4KICA8ZyBjbGFzcz0ianAtYnJhbmQwIGpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iIzk1NThiMiI+CiAgICA8cGF0aCBkPSJNIDMyNC4xMDE1NjIgMjI1IEMgMzI0LjEwMTU2MiAyNjYuNDIxODc1IDI5MC41MjM0MzggMzAwIDI0OS4xMDE1NjIgMzAwIEMgMjA3LjY3OTY4OCAzMDAgMTc0LjEwMTU2MiAyNjYuNDIxODc1IDE3NC4xMDE1NjIgMjI1IEMgMTc0LjEwMTU2MiAxODMuNTc4MTI1IDIwNy42Nzk2ODggMTUwIDI0OS4xMDE1NjIgMTUwIEMgMjkwLjUyMzQzOCAxNTAgMzI0LjEwMTU2MiAxODMuNTc4MTI1IDMyNC4xMDE1NjIgMjI1Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-jupyter-favicon: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTUyIiBoZWlnaHQ9IjE2NSIgdmlld0JveD0iMCAwIDE1MiAxNjUiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgPGcgY2xhc3M9ImpwLWp1cHl0ZXItaWNvbi1jb2xvciIgZmlsbD0iI0YzNzcyNiI+CiAgICA8cGF0aCB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwLjA3ODk0NywgMTEwLjU4MjkyNykiIGQ9Ik03NS45NDIyODQyLDI5LjU4MDQ1NjEgQzQzLjMwMjM5NDcsMjkuNTgwNDU2MSAxNC43OTY3ODMyLDE3LjY1MzQ2MzQgMCwwIEM1LjUxMDgzMjExLDE1Ljg0MDY4MjkgMTUuNzgxNTM4OSwyOS41NjY3NzMyIDI5LjM5MDQ5NDcsMzkuMjc4NDE3MSBDNDIuOTk5Nyw0OC45ODk4NTM3IDU5LjI3MzcsNTQuMjA2NzgwNSA3NS45NjA1Nzg5LDU0LjIwNjc4MDUgQzkyLjY0NzQ1NzksNTQuMjA2NzgwNSAxMDguOTIxNDU4LDQ4Ljk4OTg1MzcgMTIyLjUzMDY2MywzOS4yNzg0MTcxIEMxMzYuMTM5NDUzLDI5LjU2Njc3MzIgMTQ2LjQxMDI4NCwxNS44NDA2ODI5IDE1MS45MjExNTgsMCBDMTM3LjA4Nzg2OCwxNy42NTM0NjM0IDEwOC41ODI1ODksMjkuNTgwNDU2MSA3NS45NDIyODQyLDI5LjU4MDQ1NjEgTDc1Ljk0MjI4NDIsMjkuNTgwNDU2MSBaIiAvPgogICAgPHBhdGggdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMzczNjgsIDAuNzA0ODc4KSIgZD0iTTc1Ljk3ODQ1NzksMjQuNjI2NDA3MyBDMTA4LjYxODc2MywyNC42MjY0MDczIDEzNy4xMjQ0NTgsMzYuNTUzNDQxNSAxNTEuOTIxMTU4LDU0LjIwNjc4MDUgQzE0Ni40MTAyODQsMzguMzY2MjIyIDEzNi4xMzk0NTMsMjQuNjQwMTMxNyAxMjIuNTMwNjYzLDE0LjkyODQ4NzggQzEwOC45MjE0NTgsNS4yMTY4NDM5IDkyLjY0NzQ1NzksMCA3NS45NjA1Nzg5LDAgQzU5LjI3MzcsMCA0Mi45OTk3LDUuMjE2ODQzOSAyOS4zOTA0OTQ3LDE0LjkyODQ4NzggQzE1Ljc4MTUzODksMjQuNjQwMTMxNyA1LjUxMDgzMjExLDM4LjM2NjIyMiAwLDU0LjIwNjc4MDUgQzE0LjgzMzA4MTYsMzYuNTg5OTI5MyA0My4zMzg1Njg0LDI0LjYyNjQwNzMgNzUuOTc4NDU3OSwyNC42MjY0MDczIEw3NS45Nzg0NTc5LDI0LjYyNjQwNzMgWiIgLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-jupyter: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzkiIGhlaWdodD0iNTEiIHZpZXdCb3g9IjAgMCAzOSA1MSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMTYzOCAtMjI4MSkiPgogICAgIDxnIGNsYXNzPSJqcC1qdXB5dGVyLWljb24tY29sb3IiIGZpbGw9IiNGMzc3MjYiPgogICAgICA8cGF0aCB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNjM5Ljc0IDIzMTEuOTgpIiBkPSJNIDE4LjI2NDYgNy4xMzQxMUMgMTAuNDE0NSA3LjEzNDExIDMuNTU4NzIgNC4yNTc2IDAgMEMgMS4zMjUzOSAzLjgyMDQgMy43OTU1NiA3LjEzMDgxIDcuMDY4NiA5LjQ3MzAzQyAxMC4zNDE3IDExLjgxNTIgMTQuMjU1NyAxMy4wNzM0IDE4LjI2OSAxMy4wNzM0QyAyMi4yODIzIDEzLjA3MzQgMjYuMTk2MyAxMS44MTUyIDI5LjQ2OTQgOS40NzMwM0MgMzIuNzQyNCA3LjEzMDgxIDM1LjIxMjYgMy44MjA0IDM2LjUzOCAwQyAzMi45NzA1IDQuMjU3NiAyNi4xMTQ4IDcuMTM0MTEgMTguMjY0NiA3LjEzNDExWiIvPgogICAgICA8cGF0aCB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNjM5LjczIDIyODUuNDgpIiBkPSJNIDE4LjI3MzMgNS45MzkzMUMgMjYuMTIzNSA1LjkzOTMxIDMyLjk3OTMgOC44MTU4MyAzNi41MzggMTMuMDczNEMgMzUuMjEyNiA5LjI1MzAzIDMyLjc0MjQgNS45NDI2MiAyOS40Njk0IDMuNjAwNEMgMjYuMTk2MyAxLjI1ODE4IDIyLjI4MjMgMCAxOC4yNjkgMEMgMTQuMjU1NyAwIDEwLjM0MTcgMS4yNTgxOCA3LjA2ODYgMy42MDA0QyAzLjc5NTU2IDUuOTQyNjIgMS4zMjUzOSA5LjI1MzAzIDAgMTMuMDczNEMgMy41Njc0NSA4LjgyNDYzIDEwLjQyMzIgNS45MzkzMSAxOC4yNzMzIDUuOTM5MzFaIi8+CiAgICA8L2c+CiAgICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgICA8cGF0aCB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNjY5LjMgMjI4MS4zMSkiIGQ9Ik0gNS44OTM1MyAyLjg0NEMgNS45MTg4OSAzLjQzMTY1IDUuNzcwODUgNC4wMTM2NyA1LjQ2ODE1IDQuNTE2NDVDIDUuMTY1NDUgNS4wMTkyMiA0LjcyMTY4IDUuNDIwMTUgNC4xOTI5OSA1LjY2ODUxQyAzLjY2NDMgNS45MTY4OCAzLjA3NDQ0IDYuMDAxNTEgMi40OTgwNSA1LjkxMTcxQyAxLjkyMTY2IDUuODIxOSAxLjM4NDYzIDUuNTYxNyAwLjk1NDg5OCA1LjE2NDAxQyAwLjUyNTE3IDQuNzY2MzMgMC4yMjIwNTYgNC4yNDkwMyAwLjA4MzkwMzcgMy42Nzc1N0MgLTAuMDU0MjQ4MyAzLjEwNjExIC0wLjAyMTIzIDIuNTA2MTcgMC4xNzg3ODEgMS45NTM2NEMgMC4zNzg3OTMgMS40MDExIDAuNzM2ODA5IDAuOTIwODE3IDEuMjA3NTQgMC41NzM1MzhDIDEuNjc4MjYgMC4yMjYyNTkgMi4yNDA1NSAwLjAyNzU5MTkgMi44MjMyNiAwLjAwMjY3MjI5QyAzLjYwMzg5IC0wLjAzMDcxMTUgNC4zNjU3MyAwLjI0OTc4OSA0Ljk0MTQyIDAuNzgyNTUxQyA1LjUxNzExIDEuMzE1MzEgNS44NTk1NiAyLjA1Njc2IDUuODkzNTMgMi44NDRaIi8+CiAgICAgIDxwYXRoIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE2MzkuOCAyMzIzLjgxKSIgZD0iTSA3LjQyNzg5IDMuNTgzMzhDIDcuNDYwMDggNC4zMjQzIDcuMjczNTUgNS4wNTgxOSA2Ljg5MTkzIDUuNjkyMTNDIDYuNTEwMzEgNi4zMjYwNyA1Ljk1MDc1IDYuODMxNTYgNS4yODQxMSA3LjE0NDZDIDQuNjE3NDcgNy40NTc2MyAzLjg3MzcxIDcuNTY0MTQgMy4xNDcwMiA3LjQ1MDYzQyAyLjQyMDMyIDcuMzM3MTIgMS43NDMzNiA3LjAwODcgMS4yMDE4NCA2LjUwNjk1QyAwLjY2MDMyOCA2LjAwNTIgMC4yNzg2MSA1LjM1MjY4IDAuMTA1MDE3IDQuNjMyMDJDIC0wLjA2ODU3NTcgMy45MTEzNSAtMC4wMjYyMzYxIDMuMTU0OTQgMC4yMjY2NzUgMi40NTg1NkMgMC40Nzk1ODcgMS43NjIxNyAwLjkzMTY5NyAxLjE1NzEzIDEuNTI1NzYgMC43MjAwMzNDIDIuMTE5ODMgMC4yODI5MzUgMi44MjkxNCAwLjAzMzQzOTUgMy41NjM4OSAwLjAwMzEzMzQ0QyA0LjU0NjY3IC0wLjAzNzQwMzMgNS41MDUyOSAwLjMxNjcwNiA2LjIyOTYxIDAuOTg3ODM1QyA2Ljk1MzkzIDEuNjU4OTYgNy4zODQ4NCAyLjU5MjM1IDcuNDI3ODkgMy41ODMzOEwgNy40Mjc4OSAzLjU4MzM4WiIvPgogICAgICA8cGF0aCB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxNjM4LjM2IDIyODYuMDYpIiBkPSJNIDIuMjc0NzEgNC4zOTYyOUMgMS44NDM2MyA0LjQxNTA4IDEuNDE2NzEgNC4zMDQ0NSAxLjA0Nzk5IDQuMDc4NDNDIDAuNjc5MjY4IDMuODUyNCAwLjM4NTMyOCAzLjUyMTE0IDAuMjAzMzcxIDMuMTI2NTZDIDAuMDIxNDEzNiAyLjczMTk4IC0wLjA0MDM3OTggMi4yOTE4MyAwLjAyNTgxMTYgMS44NjE4MUMgMC4wOTIwMDMxIDEuNDMxOCAwLjI4MzIwNCAxLjAzMTI2IDAuNTc1MjEzIDAuNzEwODgzQyAwLjg2NzIyMiAwLjM5MDUxIDEuMjQ2OTEgMC4xNjQ3MDggMS42NjYyMiAwLjA2MjA1OTJDIDIuMDg1NTMgLTAuMDQwNTg5NyAyLjUyNTYxIC0wLjAxNTQ3MTQgMi45MzA3NiAwLjEzNDIzNUMgMy4zMzU5MSAwLjI4Mzk0MSAzLjY4NzkyIDAuNTUxNTA1IDMuOTQyMjIgMC45MDMwNkMgNC4xOTY1MiAxLjI1NDYyIDQuMzQxNjkgMS42NzQzNiA0LjM1OTM1IDIuMTA5MTZDIDQuMzgyOTkgMi42OTEwNyA0LjE3Njc4IDMuMjU4NjkgMy43ODU5NyAzLjY4NzQ2QyAzLjM5NTE2IDQuMTE2MjQgMi44NTE2NiA0LjM3MTE2IDIuMjc0NzEgNC4zOTYyOUwgMi4yNzQ3MSA0LjM5NjI5WiIvPgogICAgPC9nPgogIDwvZz4+Cjwvc3ZnPgo=);
--jp-icon-jupyterlab-wordmark: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMDAiIHZpZXdCb3g9IjAgMCAxODYwLjggNDc1Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjIiIGZpbGw9IiM0RTRFNEUiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDQ4MC4xMzY0MDEsIDY0LjI3MTQ5MykiPgogICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsIDU4Ljg3NTU2NikiPgogICAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwLjA4NzYwMywgMC4xNDAyOTQpIj4KICAgICAgICA8cGF0aCBkPSJNLTQyNi45LDE2OS44YzAsNDguNy0zLjcsNjQuNy0xMy42LDc2LjRjLTEwLjgsMTAtMjUsMTUuNS0zOS43LDE1LjVsMy43LDI5IGMyMi44LDAuMyw0NC44LTcuOSw2MS45LTIzLjFjMTcuOC0xOC41LDI0LTQ0LjEsMjQtODMuM1YwSC00Mjd2MTcwLjFMLTQyNi45LDE2OS44TC00MjYuOSwxNjkuOHoiLz4KICAgICAgPC9nPgogICAgPC9nPgogICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTU1LjA0NTI5NiwgNTYuODM3MTA0KSI+CiAgICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDEuNTYyNDUzLCAxLjc5OTg0MikiPgogICAgICAgIDxwYXRoIGQ9Ik0tMzEyLDE0OGMwLDIxLDAsMzkuNSwxLjcsNTUuNGgtMzEuOGwtMi4xLTMzLjNoLTAuOGMtNi43LDExLjYtMTYuNCwyMS4zLTI4LDI3LjkgYy0xMS42LDYuNi0yNC44LDEwLTM4LjIsOS44Yy0zMS40LDAtNjktMTcuNy02OS04OVYwaDM2LjR2MTEyLjdjMCwzOC43LDExLjYsNjQuNyw0NC42LDY0LjdjMTAuMy0wLjIsMjAuNC0zLjUsMjguOS05LjQgYzguNS01LjksMTUuMS0xNC4zLDE4LjktMjMuOWMyLjItNi4xLDMuMy0xMi41LDMuMy0xOC45VjAuMmgzNi40VjE0OEgtMzEyTC0zMTIsMTQ4eiIvPgogICAgICA8L2c+CiAgICA8L2c+CiAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzOTAuMDEzMzIyLCA1My40Nzk2MzgpIj4KICAgICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMS43MDY0NTgsIDAuMjMxNDI1KSI+CiAgICAgICAgPHBhdGggZD0iTS00NzguNiw3MS40YzAtMjYtMC44LTQ3LTEuNy02Ni43aDMyLjdsMS43LDM0LjhoMC44YzcuMS0xMi41LDE3LjUtMjIuOCwzMC4xLTI5LjcgYzEyLjUtNywyNi43LTEwLjMsNDEtOS44YzQ4LjMsMCw4NC43LDQxLjcsODQuNywxMDMuM2MwLDczLjEtNDMuNywxMDkuMi05MSwxMDkuMmMtMTIuMSwwLjUtMjQuMi0yLjItMzUtNy44IGMtMTAuOC01LjYtMTkuOS0xMy45LTI2LjYtMjQuMmgtMC44VjI5MWgtMzZ2LTIyMEwtNDc4LjYsNzEuNEwtNDc4LjYsNzEuNHogTS00NDIuNiwxMjUuNmMwLjEsNS4xLDAuNiwxMC4xLDEuNywxNS4xIGMzLDEyLjMsOS45LDIzLjMsMTkuOCwzMS4xYzkuOSw3LjgsMjIuMSwxMi4xLDM0LjcsMTIuMWMzOC41LDAsNjAuNy0zMS45LDYwLjctNzguNWMwLTQwLjctMjEuMS03NS42LTU5LjUtNzUuNiBjLTEyLjksMC40LTI1LjMsNS4xLTM1LjMsMTMuNGMtOS45LDguMy0xNi45LDE5LjctMTkuNiwzMi40Yy0xLjUsNC45LTIuMywxMC0yLjUsMTUuMVYxMjUuNkwtNDQyLjYsMTI1LjZMLTQ0Mi42LDEyNS42eiIvPgogICAgICA8L2c+CiAgICA8L2c+CiAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg2MDYuNzQwNzI2LCA1Ni44MzcxMDQpIj4KICAgICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC43NTEyMjYsIDEuOTg5Mjk5KSI+CiAgICAgICAgPHBhdGggZD0iTS00NDAuOCwwbDQzLjcsMTIwLjFjNC41LDEzLjQsOS41LDI5LjQsMTIuOCw0MS43aDAuOGMzLjctMTIuMiw3LjktMjcuNywxMi44LTQyLjQgbDM5LjctMTE5LjJoMzguNUwtMzQ2LjksMTQ1Yy0yNiw2OS43LTQzLjcsMTA1LjQtNjguNiwxMjcuMmMtMTIuNSwxMS43LTI3LjksMjAtNDQuNiwyMy45bC05LjEtMzEuMSBjMTEuNy0zLjksMjIuNS0xMC4xLDMxLjgtMTguMWMxMy4yLTExLjEsMjMuNy0yNS4yLDMwLjYtNDEuMmMxLjUtMi44LDIuNS01LjcsMi45LTguOGMtMC4zLTMuMy0xLjItNi42LTIuNS05LjdMLTQ4MC4yLDAuMSBoMzkuN0wtNDQwLjgsMEwtNDQwLjgsMHoiLz4KICAgICAgPC9nPgogICAgPC9nPgogICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoODIyLjc0ODEwNCwgMC4wMDAwMDApIj4KICAgICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMS40NjQwNTAsIDAuMzc4OTE0KSI+CiAgICAgICAgPHBhdGggZD0iTS00MTMuNywwdjU4LjNoNTJ2MjguMmgtNTJWMTk2YzAsMjUsNywzOS41LDI3LjMsMzkuNWM3LjEsMC4xLDE0LjItMC43LDIxLjEtMi41IGwxLjcsMjcuN2MtMTAuMywzLjctMjEuMyw1LjQtMzIuMiw1Yy03LjMsMC40LTE0LjYtMC43LTIxLjMtMy40Yy02LjgtMi43LTEyLjktNi44LTE3LjktMTIuMWMtMTAuMy0xMC45LTE0LjEtMjktMTQuMS01Mi45IFY4Ni41aC0zMVY1OC4zaDMxVjkuNkwtNDEzLjcsMEwtNDEzLjcsMHoiLz4KICAgICAgPC9nPgogICAgPC9nPgogICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoOTc0LjQzMzI4NiwgNTMuNDc5NjM4KSI+CiAgICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAuOTkwMDM0LCAwLjYxMDMzOSkiPgogICAgICAgIDxwYXRoIGQ9Ik0tNDQ1LjgsMTEzYzAuOCw1MCwzMi4yLDcwLjYsNjguNiw3MC42YzE5LDAuNiwzNy45LTMsNTUuMy0xMC41bDYuMiwyNi40IGMtMjAuOSw4LjktNDMuNSwxMy4xLTY2LjIsMTIuNmMtNjEuNSwwLTk4LjMtNDEuMi05OC4zLTEwMi41Qy00ODAuMiw0OC4yLTQ0NC43LDAtMzg2LjUsMGM2NS4yLDAsODIuNyw1OC4zLDgyLjcsOTUuNyBjLTAuMSw1LjgtMC41LDExLjUtMS4yLDE3LjJoLTE0MC42SC00NDUuOEwtNDQ1LjgsMTEzeiBNLTMzOS4yLDg2LjZjMC40LTIzLjUtOS41LTYwLjEtNTAuNC02MC4xIGMtMzYuOCwwLTUyLjgsMzQuNC01NS43LDYwLjFILTMzOS4yTC0zMzkuMiw4Ni42TC0zMzkuMiw4Ni42eiIvPgogICAgICA8L2c+CiAgICA8L2c+CiAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxMjAxLjk2MTA1OCwgNTMuNDc5NjM4KSI+CiAgICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDEuMTc5NjQwLCAwLjcwNTA2OCkiPgogICAgICAgIDxwYXRoIGQ9Ik0tNDc4LjYsNjhjMC0yMy45LTAuNC00NC41LTEuNy02My40aDMxLjhsMS4yLDM5LjloMS43YzkuMS0yNy4zLDMxLTQ0LjUsNTUuMy00NC41IGMzLjUtMC4xLDcsMC40LDEwLjMsMS4ydjM0LjhjLTQuMS0wLjktOC4yLTEuMy0xMi40LTEuMmMtMjUuNiwwLTQzLjcsMTkuNy00OC43LDQ3LjRjLTEsNS43LTEuNiwxMS41LTEuNywxNy4ydjEwOC4zaC0zNlY2OCBMLTQ3OC42LDY4eiIvPgogICAgICA8L2c+CiAgICA8L2c+CiAgPC9nPgoKICA8ZyBjbGFzcz0ianAtaWNvbi13YXJuMCIgZmlsbD0iI0YzNzcyNiI+CiAgICA8cGF0aCBkPSJNMTM1Mi4zLDMyNi4yaDM3VjI4aC0zN1YzMjYuMnogTTE2MDQuOCwzMjYuMmMtMi41LTEzLjktMy40LTMxLjEtMy40LTQ4Ljd2LTc2IGMwLTQwLjctMTUuMS04My4xLTc3LjMtODMuMWMtMjUuNiwwLTUwLDcuMS02Ni44LDE4LjFsOC40LDI0LjRjMTQuMy05LjIsMzQtMTUuMSw1My0xNS4xYzQxLjYsMCw0Ni4yLDMwLjIsNDYuMiw0N3Y0LjIgYy03OC42LTAuNC0xMjIuMywyNi41LTEyMi4zLDc1LjZjMCwyOS40LDIxLDU4LjQsNjIuMiw1OC40YzI5LDAsNTAuOS0xNC4zLDYyLjItMzAuMmgxLjNsMi45LDI1LjZIMTYwNC44eiBNMTU2NS43LDI1Ny43IGMwLDMuOC0wLjgsOC0yLjEsMTEuOGMtNS45LDE3LjItMjIuNywzNC00OS4yLDM0Yy0xOC45LDAtMzQuOS0xMS4zLTM0LjktMzUuM2MwLTM5LjUsNDUuOC00Ni42LDg2LjItNDUuOFYyNTcuN3ogTTE2OTguNSwzMjYuMiBsMS43LTMzLjZoMS4zYzE1LjEsMjYuOSwzOC43LDM4LjIsNjguMSwzOC4yYzQ1LjQsMCw5MS4yLTM2LjEsOTEuMi0xMDguOGMwLjQtNjEuNy0zNS4zLTEwMy43LTg1LjctMTAzLjcgYy0zMi44LDAtNTYuMywxNC43LTY5LjMsMzcuNGgtMC44VjI4aC0zNi42djI0NS43YzAsMTguMS0wLjgsMzguNi0xLjcsNTIuNUgxNjk4LjV6IE0xNzA0LjgsMjA4LjJjMC01LjksMS4zLTEwLjksMi4xLTE1LjEgYzcuNi0yOC4xLDMxLjEtNDUuNCw1Ni4zLTQ1LjRjMzkuNSwwLDYwLjUsMzQuOSw2MC41LDc1LjZjMCw0Ni42LTIzLjEsNzguMS02MS44LDc4LjFjLTI2LjksMC00OC4zLTE3LjYtNTUuNS00My4zIGMtMC44LTQuMi0xLjctOC44LTEuNy0xMy40VjIwOC4yeiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-kernel: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGNsYXNzPSJqcC1pY29uMiIgZmlsbD0iIzYxNjE2MSIgZD0iTTE1IDlIOXY2aDZWOXptLTIgNGgtMnYtMmgydjJ6bTgtMlY5aC0yVjdjMC0xLjEtLjktMi0yLTJoLTJWM2gtMnYyaC0yVjNIOXYySDdjLTEuMSAwLTIgLjktMiAydjJIM3YyaDJ2MkgzdjJoMnYyYzAgMS4xLjkgMiAyIDJoMnYyaDJ2LTJoMnYyaDJ2LTJoMmMxLjEgMCAyLS45IDItMnYtMmgydi0yaC0ydi0yaDJ6bS00IDZIN1Y3aDEwdjEweiIvPgo8L3N2Zz4K);
--jp-icon-keyboard: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBkPSJNMjAgNUg0Yy0xLjEgMC0xLjk5LjktMS45OSAyTDIgMTdjMCAxLjEuOSAyIDIgMmgxNmMxLjEgMCAyLS45IDItMlY3YzAtMS4xLS45LTItMi0yem0tOSAzaDJ2MmgtMlY4em0wIDNoMnYyaC0ydi0yek04IDhoMnYySDhWOHptMCAzaDJ2Mkg4di0yem0tMSAySDV2LTJoMnYyem0wLTNINVY4aDJ2MnptOSA3SDh2LTJoOHYyem0wLTRoLTJ2LTJoMnYyem0wLTNoLTJWOGgydjJ6bTMgM2gtMnYtMmgydjJ6bTAtM2gtMlY4aDJ2MnoiLz4KPC9zdmc+Cg==);
--jp-icon-launch: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMzIgMzIiIHdpZHRoPSIzMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIj4KICAgIDxwYXRoIGQ9Ik0yNiwyOEg2YTIuMDAyNywyLjAwMjcsMCwwLDEtMi0yVjZBMi4wMDI3LDIuMDAyNywwLDAsMSw2LDRIMTZWNkg2VjI2SDI2VjE2aDJWMjZBMi4wMDI3LDIuMDAyNywwLDAsMSwyNiwyOFoiLz4KICAgIDxwb2x5Z29uIHBvaW50cz0iMjAgMiAyMCA0IDI2LjU4NiA0IDE4IDEyLjU4NiAxOS40MTQgMTQgMjggNS40MTQgMjggMTIgMzAgMTIgMzAgMiAyMCAyIi8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-launcher: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBkPSJNMTkgMTlINVY1aDdWM0g1YTIgMiAwIDAwLTIgMnYxNGEyIDIgMCAwMDIgMmgxNGMxLjEgMCAyLS45IDItMnYtN2gtMnY3ek0xNCAzdjJoMy41OWwtOS44MyA5LjgzIDEuNDEgMS40MUwxOSA2LjQxVjEwaDJWM2gtN3oiLz4KPC9zdmc+Cg==);
--jp-icon-line-form: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGZpbGw9IndoaXRlIiBkPSJNNS44OCA0LjEyTDEzLjc2IDEybC03Ljg4IDcuODhMOCAyMmwxMC0xMEw4IDJ6Ii8+Cjwvc3ZnPgo=);
--jp-icon-link: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTMuOSAxMmMwLTEuNzEgMS4zOS0zLjEgMy4xLTMuMWg0VjdIN2MtMi43NiAwLTUgMi4yNC01IDVzMi4yNCA1IDUgNWg0di0xLjlIN2MtMS43MSAwLTMuMS0xLjM5LTMuMS0zLjF6TTggMTNoOHYtMkg4djJ6bTktNmgtNHYxLjloNGMxLjcxIDAgMy4xIDEuMzkgMy4xIDMuMXMtMS4zOSAzLjEtMy4xIDMuMWgtNFYxN2g0YzIuNzYgMCA1LTIuMjQgNS01cy0yLjI0LTUtNS01eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-list: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGNsYXNzPSJqcC1pY29uMiBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiM2MTYxNjEiIGQ9Ik0xOSA1djE0SDVWNWgxNG0xLjEtMkgzLjljLS41IDAtLjkuNC0uOS45djE2LjJjMCAuNC40LjkuOS45aDE2LjJjLjQgMCAuOS0uNS45LS45VjMuOWMwLS41LS41LS45LS45LS45ek0xMSA3aDZ2MmgtNlY3em0wIDRoNnYyaC02di0yem0wIDRoNnYyaC02ek03IDdoMnYySDd6bTAgNGgydjJIN3ptMCA0aDJ2Mkg3eiIvPgo8L3N2Zz4K);
--jp-icon-markdown: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8cGF0aCBjbGFzcz0ianAtaWNvbi1jb250cmFzdDAganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjN0IxRkEyIiBkPSJNNSAxNC45aDEybC02LjEgNnptOS40LTYuOGMwLTEuMy0uMS0yLjktLjEtNC41LS40IDEuNC0uOSAyLjktMS4zIDQuM2wtMS4zIDQuM2gtMkw4LjUgNy45Yy0uNC0xLjMtLjctMi45LTEtNC4zLS4xIDEuNi0uMSAzLjItLjIgNC42TDcgMTIuNEg0LjhsLjctMTFoMy4zTDEwIDVjLjQgMS4yLjcgMi43IDEgMy45LjMtMS4yLjctMi42IDEtMy45bDEuMi0zLjdoMy4zbC42IDExaC0yLjRsLS4zLTQuMnoiLz4KPC9zdmc+Cg==);
--jp-icon-move-down: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIHZpZXdCb3g9IjAgMCAxNCAxNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggY2xhc3M9ImpwLWljb24zIiBkPSJNMTIuNDcxIDcuNTI4OTlDMTIuNzYzMiA3LjIzNjg0IDEyLjc2MzIgNi43NjMxNiAxMi40NzEgNi40NzEwMVY2LjQ3MTAxQzEyLjE3OSA2LjE3OTA1IDExLjcwNTcgNi4xNzg4NCAxMS40MTM1IDYuNDcwNTRMNy43NSAxMC4xMjc1VjEuNzVDNy43NSAxLjMzNTc5IDcuNDE0MjEgMSA3IDFWMUM2LjU4NTc5IDEgNi4yNSAxLjMzNTc5IDYuMjUgMS43NVYxMC4xMjc1TDIuNTk3MjYgNi40NjgyMkMyLjMwMzM4IDYuMTczODEgMS44MjY0MSA2LjE3MzU5IDEuNTMyMjYgNi40Njc3NFY2LjQ2Nzc0QzEuMjM4MyA2Ljc2MTcgMS4yMzgzIDcuMjM4MyAxLjUzMjI2IDcuNTMyMjZMNi4yOTI4OSAxMi4yOTI5QzYuNjgzNDIgMTIuNjgzNCA3LjMxNjU4IDEyLjY4MzQgNy43MDcxMSAxMi4yOTI5TDEyLjQ3MSA3LjUyODk5WiIgZmlsbD0iIzYxNjE2MSIvPgo8L3N2Zz4K);
--jp-icon-move-up: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIHZpZXdCb3g9IjAgMCAxNCAxNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggY2xhc3M9ImpwLWljb24zIiBkPSJNMS41Mjg5OSA2LjQ3MTAxQzEuMjM2ODQgNi43NjMxNiAxLjIzNjg0IDcuMjM2ODQgMS41Mjg5OSA3LjUyODk5VjcuNTI4OTlDMS44MjA5NSA3LjgyMDk1IDIuMjk0MjYgNy44MjExNiAyLjU4NjQ5IDcuNTI5NDZMNi4yNSAzLjg3MjVWMTIuMjVDNi4yNSAxMi42NjQyIDYuNTg1NzkgMTMgNyAxM1YxM0M3LjQxNDIxIDEzIDcuNzUgMTIuNjY0MiA3Ljc1IDEyLjI1VjMuODcyNUwxMS40MDI3IDcuNTMxNzhDMTEuNjk2NiA3LjgyNjE5IDEyLjE3MzYgNy44MjY0MSAxMi40Njc3IDcuNTMyMjZWNy41MzIyNkMxMi43NjE3IDcuMjM4MyAxMi43NjE3IDYuNzYxNyAxMi40Njc3IDYuNDY3NzRMNy43MDcxMSAxLjcwNzExQzcuMzE2NTggMS4zMTY1OCA2LjY4MzQyIDEuMzE2NTggNi4yOTI4OSAxLjcwNzExTDEuNTI4OTkgNi40NzEwMVoiIGZpbGw9IiM2MTYxNjEiLz4KPC9zdmc+Cg==);
--jp-icon-new-folder: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTIwIDZoLThsLTItMkg0Yy0xLjExIDAtMS45OS44OS0xLjk5IDJMMiAxOGMwIDEuMTEuODkgMiAyIDJoMTZjMS4xMSAwIDItLjg5IDItMlY4YzAtMS4xMS0uODktMi0yLTJ6bS0xIDhoLTN2M2gtMnYtM2gtM3YtMmgzVjloMnYzaDN2MnoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-not-trusted: url(data:image/svg+xml;base64,PHN2ZyBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI1IDI1Ij4KICAgIDxwYXRoIGNsYXNzPSJqcC1pY29uMiIgc3Ryb2tlPSIjMzMzMzMzIiBzdHJva2Utd2lkdGg9IjIiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDMgMykiIGQ9Ik0xLjg2MDk0IDExLjQ0MDlDMC44MjY0NDggOC43NzAyNyAwLjg2Mzc3OSA2LjA1NzY0IDEuMjQ5MDcgNC4xOTkzMkMyLjQ4MjA2IDMuOTMzNDcgNC4wODA2OCAzLjQwMzQ3IDUuNjAxMDIgMi44NDQ5QzcuMjM1NDkgMi4yNDQ0IDguODU2NjYgMS41ODE1IDkuOTg3NiAxLjA5NTM5QzExLjA1OTcgMS41ODM0MSAxMi42MDk0IDIuMjQ0NCAxNC4yMTggMi44NDMzOUMxNS43NTAzIDMuNDEzOTQgMTcuMzk5NSAzLjk1MjU4IDE4Ljc1MzkgNC4yMTM4NUMxOS4xMzY0IDYuMDcxNzcgMTkuMTcwOSA4Ljc3NzIyIDE4LjEzOSAxMS40NDA5QzE3LjAzMDMgMTQuMzAzMiAxNC42NjY4IDE3LjE4NDQgOS45OTk5OSAxOC45MzU0QzUuMzMzMTkgMTcuMTg0NCAyLjk2OTY4IDE0LjMwMzIgMS44NjA5NCAxMS40NDA5WiIvPgogICAgPHBhdGggY2xhc3M9ImpwLWljb24yIiBzdHJva2U9IiMzMzMzMzMiIHN0cm9rZS13aWR0aD0iMiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoOS4zMTU5MiA5LjMyMDMxKSIgZD0iTTcuMzY4NDIgMEwwIDcuMzY0NzkiLz4KICAgIDxwYXRoIGNsYXNzPSJqcC1pY29uMiIgc3Ryb2tlPSIjMzMzMzMzIiBzdHJva2Utd2lkdGg9IjIiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDkuMzE1OTIgMTYuNjgzNikgc2NhbGUoMSAtMSkiIGQ9Ik03LjM2ODQyIDBMMCA3LjM2NDc5Ii8+Cjwvc3ZnPgo=);
--jp-icon-notebook: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8ZyBjbGFzcz0ianAtbm90ZWJvb2staWNvbi1jb2xvciBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiNFRjZDMDAiPgogICAgPHBhdGggZD0iTTE4LjcgMy4zdjE1LjRIMy4zVjMuM2gxNS40bTEuNS0xLjVIMS44djE4LjNoMTguM2wuMS0xOC4zeiIvPgogICAgPHBhdGggZD0iTTE2LjUgMTYuNWwtNS40LTQuMy01LjYgNC4zdi0xMWgxMXoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-numbering: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjIiIGhlaWdodD0iMjIiIHZpZXdCb3g9IjAgMCAyOCAyOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CgkJPHBhdGggZD0iTTQgMTlINlYxOS41SDVWMjAuNUg2VjIxSDRWMjJIN1YxOEg0VjE5Wk01IDEwSDZWNkg0VjdINVYxMFpNNCAxM0g1LjhMNCAxNS4xVjE2SDdWMTVINS4yTDcgMTIuOVYxMkg0VjEzWk05IDdWOUgyM1Y3SDlaTTkgMjFIMjNWMTlIOVYyMVpNOSAxNUgyM1YxM0g5VjE1WiIvPgoJPC9nPgo8L3N2Zz4K);
--jp-icon-offline-bolt: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjE2Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTEyIDIuMDJjLTUuNTEgMC05Ljk4IDQuNDctOS45OCA5Ljk4czQuNDcgOS45OCA5Ljk4IDkuOTggOS45OC00LjQ3IDkuOTgtOS45OFMxNy41MSAyLjAyIDEyIDIuMDJ6TTExLjQ4IDIwdi02LjI2SDhMMTMgNHY2LjI2aDMuMzVMMTEuNDggMjB6Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-palette: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTE4IDEzVjIwSDRWNkg5LjAyQzkuMDcgNS4yOSA5LjI0IDQuNjIgOS41IDRINEMyLjkgNCAyIDQuOSAyIDZWMjBDMiAyMS4xIDIuOSAyMiA0IDIySDE4QzE5LjEgMjIgMjAgMjEuMSAyMCAyMFYxNUwxOCAxM1pNMTkuMyA4Ljg5QzE5Ljc0IDguMTkgMjAgNy4zOCAyMCA2LjVDMjAgNC4wMSAxNy45OSAyIDE1LjUgMkMxMy4wMSAyIDExIDQuMDEgMTEgNi41QzExIDguOTkgMTMuMDEgMTEgMTUuNDkgMTFDMTYuMzcgMTEgMTcuMTkgMTAuNzQgMTcuODggMTAuM0wyMSAxMy40MkwyMi40MiAxMkwxOS4zIDguODlaTTE1LjUgOUMxNC4xMiA5IDEzIDcuODggMTMgNi41QzEzIDUuMTIgMTQuMTIgNCAxNS41IDRDMTYuODggNCAxOCA1LjEyIDE4IDYuNUMxOCA3Ljg4IDE2Ljg4IDkgMTUuNSA5WiIvPgogICAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik00IDZIOS4wMTg5NEM5LjAwNjM5IDYuMTY1MDIgOSA2LjMzMTc2IDkgNi41QzkgOC44MTU3NyAxMC4yMTEgMTAuODQ4NyAxMi4wMzQzIDEySDlWMTRIMTZWMTIuOTgxMUMxNi41NzAzIDEyLjkzNzcgMTcuMTIgMTIuODIwNyAxNy42Mzk2IDEyLjYzOTZMMTggMTNWMjBINFY2Wk04IDhINlYxMEg4VjhaTTYgMTJIOFYxNEg2VjEyWk04IDE2SDZWMThIOFYxNlpNOSAxNkgxNlYxOEg5VjE2WiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-paste: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTE5IDJoLTQuMThDMTQuNC44NCAxMy4zIDAgMTIgMGMtMS4zIDAtMi40Ljg0LTIuODIgMkg1Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDE0YzEuMSAwIDItLjkgMi0yVjRjMC0xLjEtLjktMi0yLTJ6bS03IDBjLjU1IDAgMSAuNDUgMSAxcy0uNDUgMS0xIDEtMS0uNDUtMS0xIC40NS0xIDEtMXptNyAxOEg1VjRoMnYzaDEwVjRoMnYxNnoiLz4KICAgIDwvZz4KPC9zdmc+Cg==);
--jp-icon-pdf: url(data:image/svg+xml;base64,PHN2ZwogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMiAyMiIgd2lkdGg9IjE2Ij4KICAgIDxwYXRoIHRyYW5zZm9ybT0icm90YXRlKDQ1KSIgY2xhc3M9ImpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iI0ZGMkEyQSIKICAgICAgIGQ9Im0gMjIuMzQ0MzY5LC0zLjAxNjM2NDIgaCA1LjYzODYwNCB2IDEuNTc5MjQzMyBoIC0zLjU0OTIyNyB2IDEuNTA4NjkyOTkgaCAzLjMzNzU3NiBWIDEuNjUwODE1NCBoIC0zLjMzNzU3NiB2IDMuNDM1MjYxMyBoIC0yLjA4OTM3NyB6IG0gLTcuMTM2NDQ0LDEuNTc5MjQzMyB2IDQuOTQzOTU0MyBoIDAuNzQ4OTIgcSAxLjI4MDc2MSwwIDEuOTUzNzAzLC0wLjYzNDk1MzUgMC42NzgzNjksLTAuNjM0OTUzNSAwLjY3ODM2OSwtMS44NDUxNjQxIDAsLTEuMjA0NzgzNTUgLTAuNjcyOTQyLC0xLjgzNDMxMDExIC0wLjY3Mjk0MiwtMC42Mjk1MjY1OSAtMS45NTkxMywtMC42Mjk1MjY1OSB6IG0gLTIuMDg5Mzc3LC0xLjU3OTI0MzMgaCAyLjIwMzM0MyBxIDEuODQ1MTY0LDAgMi43NDYwMzksMC4yNjU5MjA3IDAuOTA2MzAxLDAuMjYwNDkzNyAxLjU1MjEwOCwwLjg5MDAyMDMgMC41Njk4MywwLjU0ODEyMjMgMC44NDY2MDUsMS4yNjQ0ODAwNiAwLjI3Njc3NCwwLjcxNjM1NzgxIDAuMjc2Nzc0LDEuNjIyNjU4OTQgMCwwLjkxNzE1NTEgLTAuMjc2Nzc0LDEuNjM4OTM5OSAtMC4yNzY3NzUsMC43MTYzNTc4IC0wLjg0NjYwNSwxLjI2NDQ4IC0wLjY1MTIzNCwwLjYyOTUyNjYgLTEuNTYyOTYyLDAuODk1NDQ3MyAtMC45MTE3MjgsMC4yNjA0OTM3IC0yLjczNTE4NSwwLjI2MDQ5MzcgaCAtMi4yMDMzNDMgeiBtIC04LjE0NTg1NjUsMCBoIDMuNDY3ODIzIHEgMS41NDY2ODE2LDAgMi4zNzE1Nzg1LDAuNjg5MjIzIDAuODMwMzI0LDAuNjgzNzk2MSAwLjgzMDMyNCwxLjk1MzcwMzE0IDAsMS4yNzUzMzM5NyAtMC44MzAzMjQsMS45NjQ1NTcwNiBRIDkuOTg3MTk2MSwyLjI3NDkxNSA4LjQ0MDUxNDUsMi4yNzQ5MTUgSCA3LjA2MjA2ODQgViA1LjA4NjA3NjcgSCA0Ljk3MjY5MTUgWiBtIDIuMDg5Mzc2OSwxLjUxNDExOTkgdiAyLjI2MzAzOTQzIGggMS4xNTU5NDEgcSAwLjYwNzgxODgsMCAwLjkzODg2MjksLTAuMjkzMDU1NDcgMC4zMzEwNDQxLC0wLjI5ODQ4MjQxIDAuMzMxMDQ0MSwtMC44NDExNzc3MiAwLC0wLjU0MjY5NTMxIC0wLjMzMTA0NDEsLTAuODM1NzUwNzQgLTAuMzMxMDQ0MSwtMC4yOTMwNTU1IC0wLjkzODg2MjksLTAuMjkzMDU1NSB6IgovPgo8L3N2Zz4K);
--jp-icon-python: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iLTEwIC0xMCAxMzEuMTYxMzYxNjk0MzM1OTQgMTMyLjM4ODk5OTkzODk2NDg0Ij4KICA8cGF0aCBjbGFzcz0ianAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjMzA2OTk4IiBkPSJNIDU0LjkxODc4NSw5LjE5Mjc0MjFlLTQgQyA1MC4zMzUxMzIsMC4wMjIyMTcyNyA0NS45NTc4NDYsMC40MTMxMzY5NyA0Mi4xMDYyODUsMS4wOTQ2NjkzIDMwLjc2MDA2OSwzLjA5OTE3MzEgMjguNzAwMDM2LDcuMjk0NzcxNCAyOC43MDAwMzUsMTUuMDMyMTY5IHYgMTAuMjE4NzUgaCAyNi44MTI1IHYgMy40MDYyNSBoIC0yNi44MTI1IC0xMC4wNjI1IGMgLTcuNzkyNDU5LDAgLTE0LjYxNTc1ODgsNC42ODM3MTcgLTE2Ljc0OTk5OTgsMTMuNTkzNzUgLTIuNDYxODE5OTgsMTAuMjEyOTY2IC0yLjU3MTAxNTA4LDE2LjU4NjAyMyAwLDI3LjI1IDEuOTA1OTI4Myw3LjkzNzg1MiA2LjQ1NzU0MzIsMTMuNTkzNzQ4IDE0LjI0OTk5OTgsMTMuNTkzNzUgaCA5LjIxODc1IHYgLTEyLjI1IGMgMCwtOC44NDk5MDIgNy42NTcxNDQsLTE2LjY1NjI0OCAxNi43NSwtMTYuNjU2MjUgaCAyNi43ODEyNSBjIDcuNDU0OTUxLDAgMTMuNDA2MjUzLC02LjEzODE2NCAxMy40MDYyNSwtMTMuNjI1IHYgLTI1LjUzMTI1IGMgMCwtNy4yNjYzMzg2IC02LjEyOTk4LC0xMi43MjQ3NzcxIC0xMy40MDYyNSwtMTMuOTM3NDk5NyBDIDY0LjI4MTU0OCwwLjMyNzk0Mzk3IDU5LjUwMjQzOCwtMC4wMjAzNzkwMyA1NC45MTg3ODUsOS4xOTI3NDIxZS00IFogbSAtMTQuNSw4LjIxODc1MDEyNTc5IGMgMi43Njk1NDcsMCA1LjAzMTI1LDIuMjk4NjQ1NiA1LjAzMTI1LDUuMTI0OTk5NiAtMmUtNiwyLjgxNjMzNiAtMi4yNjE3MDMsNS4wOTM3NSAtNS4wMzEyNSw1LjA5Mzc1IC0yLjc3OTQ3NiwtMWUtNiAtNS4wMzEyNSwtMi4yNzc0MTUgLTUuMDMxMjUsLTUuMDkzNzUgLTEwZS03LC0yLjgyNjM1MyAyLjI1MTc3NCwtNS4xMjQ5OTk2IDUuMDMxMjUsLTUuMTI0OTk5NiB6Ii8+CiAgPHBhdGggY2xhc3M9ImpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iI2ZmZDQzYiIgZD0ibSA4NS42Mzc1MzUsMjguNjU3MTY5IHYgMTEuOTA2MjUgYyAwLDkuMjMwNzU1IC03LjgyNTg5NSwxNi45OTk5OTkgLTE2Ljc1LDE3IGggLTI2Ljc4MTI1IGMgLTcuMzM1ODMzLDAgLTEzLjQwNjI0OSw2LjI3ODQ4MyAtMTMuNDA2MjUsMTMuNjI1IHYgMjUuNTMxMjQ3IGMgMCw3LjI2NjM0NCA2LjMxODU4OCwxMS41NDAzMjQgMTMuNDA2MjUsMTMuNjI1MDA0IDguNDg3MzMxLDIuNDk1NjEgMTYuNjI2MjM3LDIuOTQ2NjMgMjYuNzgxMjUsMCA2Ljc1MDE1NSwtMS45NTQzOSAxMy40MDYyNTMsLTUuODg3NjEgMTMuNDA2MjUsLTEzLjYyNTAwNCBWIDg2LjUwMDkxOSBoIC0yNi43ODEyNSB2IC0zLjQwNjI1IGggMjYuNzgxMjUgMTMuNDA2MjU0IGMgNy43OTI0NjEsMCAxMC42OTYyNTEsLTUuNDM1NDA4IDEzLjQwNjI0MSwtMTMuNTkzNzUgMi43OTkzMywtOC4zOTg4ODYgMi42ODAyMiwtMTYuNDc1Nzc2IDAsLTI3LjI1IC0xLjkyNTc4LC03Ljc1NzQ0MSAtNS42MDM4NywtMTMuNTkzNzUgLTEzLjQwNjI0MSwtMTMuNTkzNzUgeiBtIC0xNS4wNjI1LDY0LjY1NjI1IGMgMi43Nzk0NzgsM2UtNiA1LjAzMTI1LDIuMjc3NDE3IDUuMDMxMjUsNS4wOTM3NDcgLTJlLTYsMi44MjYzNTQgLTIuMjUxNzc1LDUuMTI1MDA0IC01LjAzMTI1LDUuMTI1MDA0IC0yLjc2OTU1LDAgLTUuMDMxMjUsLTIuMjk4NjUgLTUuMDMxMjUsLTUuMTI1MDA0IDJlLTYsLTIuODE2MzMgMi4yNjE2OTcsLTUuMDkzNzQ3IDUuMDMxMjUsLTUuMDkzNzQ3IHoiLz4KPC9zdmc+Cg==);
--jp-icon-r-kernel: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8cGF0aCBjbGFzcz0ianAtaWNvbi1jb250cmFzdDMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjMjE5NkYzIiBkPSJNNC40IDIuNWMxLjItLjEgMi45LS4zIDQuOS0uMyAyLjUgMCA0LjEuNCA1LjIgMS4zIDEgLjcgMS41IDEuOSAxLjUgMy41IDAgMi0xLjQgMy41LTIuOSA0LjEgMS4yLjQgMS43IDEuNiAyLjIgMyAuNiAxLjkgMSAzLjkgMS4zIDQuNmgtMy44Yy0uMy0uNC0uOC0xLjctMS4yLTMuN3MtMS4yLTIuNi0yLjYtMi42aC0uOXY2LjRINC40VjIuNXptMy43IDYuOWgxLjRjMS45IDAgMi45LS45IDIuOS0yLjNzLTEtMi4zLTIuOC0yLjNjLS43IDAtMS4zIDAtMS42LjJ2NC41aC4xdi0uMXoiLz4KPC9zdmc+Cg==);
--jp-icon-react: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMTUwIDE1MCA1NDEuOSAyOTUuMyI+CiAgPGcgY2xhc3M9ImpwLWljb24tYnJhbmQyIGpwLWljb24tc2VsZWN0YWJsZSIgZmlsbD0iIzYxREFGQiI+CiAgICA8cGF0aCBkPSJNNjY2LjMgMjk2LjVjMC0zMi41LTQwLjctNjMuMy0xMDMuMS04Mi40IDE0LjQtNjMuNiA4LTExNC4yLTIwLjItMTMwLjQtNi41LTMuOC0xNC4xLTUuNi0yMi40LTUuNnYyMi4zYzQuNiAwIDguMy45IDExLjQgMi42IDEzLjYgNy44IDE5LjUgMzcuNSAxNC45IDc1LjctMS4xIDkuNC0yLjkgMTkuMy01LjEgMjkuNC0xOS42LTQuOC00MS04LjUtNjMuNS0xMC45LTEzLjUtMTguNS0yNy41LTM1LjMtNDEuNi01MCAzMi42LTMwLjMgNjMuMi00Ni45IDg0LTQ2LjlWNzhjLTI3LjUgMC02My41IDE5LjYtOTkuOSA1My42LTM2LjQtMzMuOC03Mi40LTUzLjItOTkuOS01My4ydjIyLjNjMjAuNyAwIDUxLjQgMTYuNSA4NCA0Ni42LTE0IDE0LjctMjggMzEuNC00MS4zIDQ5LjktMjIuNiAyLjQtNDQgNi4xLTYzLjYgMTEtMi4zLTEwLTQtMTkuNy01LjItMjktNC43LTM4LjIgMS4xLTY3LjkgMTQuNi03NS44IDMtMS44IDYuOS0yLjYgMTEuNS0yLjZWNzguNWMtOC40IDAtMTYgMS44LTIyLjYgNS42LTI4LjEgMTYuMi0zNC40IDY2LjctMTkuOSAxMzAuMS02Mi4yIDE5LjItMTAyLjcgNDkuOS0xMDIuNyA4Mi4zIDAgMzIuNSA0MC43IDYzLjMgMTAzLjEgODIuNC0xNC40IDYzLjYtOCAxMTQuMiAyMC4yIDEzMC40IDYuNSAzLjggMTQuMSA1LjYgMjIuNSA1LjYgMjcuNSAwIDYzLjUtMTkuNiA5OS45LTUzLjYgMzYuNCAzMy44IDcyLjQgNTMuMiA5OS45IDUzLjIgOC40IDAgMTYtMS44IDIyLjYtNS42IDI4LjEtMTYuMiAzNC40LTY2LjcgMTkuOS0xMzAuMSA2Mi0xOS4xIDEwMi41LTQ5LjkgMTAyLjUtODIuM3ptLTEzMC4yLTY2LjdjLTMuNyAxMi45LTguMyAyNi4yLTEzLjUgMzkuNS00LjEtOC04LjQtMTYtMTMuMS0yNC00LjYtOC05LjUtMTUuOC0xNC40LTIzLjQgMTQuMiAyLjEgMjcuOSA0LjcgNDEgNy45em0tNDUuOCAxMDYuNWMtNy44IDEzLjUtMTUuOCAyNi4zLTI0LjEgMzguMi0xNC45IDEuMy0zMCAyLTQ1LjIgMi0xNS4xIDAtMzAuMi0uNy00NS0xLjktOC4zLTExLjktMTYuNC0yNC42LTI0LjItMzgtNy42LTEzLjEtMTQuNS0yNi40LTIwLjgtMzkuOCA2LjItMTMuNCAxMy4yLTI2LjggMjAuNy0zOS45IDcuOC0xMy41IDE1LjgtMjYuMyAyNC4xLTM4LjIgMTQuOS0xLjMgMzAtMiA0NS4yLTIgMTUuMSAwIDMwLjIuNyA0NSAxLjkgOC4zIDExLjkgMTYuNCAyNC42IDI0LjIgMzggNy42IDEzLjEgMTQuNSAyNi40IDIwLjggMzkuOC02LjMgMTMuNC0xMy4yIDI2LjgtMjAuNyAzOS45em0zMi4zLTEzYzUuNCAxMy40IDEwIDI2LjggMTMuOCAzOS44LTEzLjEgMy4yLTI2LjkgNS45LTQxLjIgOCA0LjktNy43IDkuOC0xNS42IDE0LjQtMjMuNyA0LjYtOCA4LjktMTYuMSAxMy0yNC4xek00MjEuMiA0MzBjLTkuMy05LjYtMTguNi0yMC4zLTI3LjgtMzIgOSAuNCAxOC4yLjcgMjcuNS43IDkuNCAwIDE4LjctLjIgMjcuOC0uNy05IDExLjctMTguMyAyMi40LTI3LjUgMzJ6bS03NC40LTU4LjljLTE0LjItMi4xLTI3LjktNC43LTQxLTcuOSAzLjctMTIuOSA4LjMtMjYuMiAxMy41LTM5LjUgNC4xIDggOC40IDE2IDEzLjEgMjQgNC43IDggOS41IDE1LjggMTQuNCAyMy40ek00MjAuNyAxNjNjOS4zIDkuNiAxOC42IDIwLjMgMjcuOCAzMi05LS40LTE4LjItLjctMjcuNS0uNy05LjQgMC0xOC43LjItMjcuOC43IDktMTEuNyAxOC4zLTIyLjQgMjcuNS0zMnptLTc0IDU4LjljLTQuOSA3LjctOS44IDE1LjYtMTQuNCAyMy43LTQuNiA4LTguOSAxNi0xMyAyNC01LjQtMTMuNC0xMC0yNi44LTEzLjgtMzkuOCAxMy4xLTMuMSAyNi45LTUuOCA0MS4yLTcuOXptLTkwLjUgMTI1LjJjLTM1LjQtMTUuMS01OC4zLTM0LjktNTguMy01MC42IDAtMTUuNyAyMi45LTM1LjYgNTguMy01MC42IDguNi0zLjcgMTgtNyAyNy43LTEwLjEgNS43IDE5LjYgMTMuMiA0MCAyMi41IDYwLjktOS4yIDIwLjgtMTYuNiA0MS4xLTIyLjIgNjAuNi05LjktMy4xLTE5LjMtNi41LTI4LTEwLjJ6TTMxMCA0OTBjLTEzLjYtNy44LTE5LjUtMzcuNS0xNC45LTc1LjcgMS4xLTkuNCAyLjktMTkuMyA1LjEtMjkuNCAxOS42IDQuOCA0MSA4LjUgNjMuNSAxMC45IDEzLjUgMTguNSAyNy41IDM1LjMgNDEuNiA1MC0zMi42IDMwLjMtNjMuMiA0Ni45LTg0IDQ2LjktNC41LS4xLTguMy0xLTExLjMtMi43em0yMzcuMi03Ni4yYzQuNyAzOC4yLTEuMSA2Ny45LTE0LjYgNzUuOC0zIDEuOC02LjkgMi42LTExLjUgMi42LTIwLjcgMC01MS40LTE2LjUtODQtNDYuNiAxNC0xNC43IDI4LTMxLjQgNDEuMy00OS45IDIyLjYtMi40IDQ0LTYuMSA2My42LTExIDIuMyAxMC4xIDQuMSAxOS44IDUuMiAyOS4xem0zOC41LTY2LjdjLTguNiAzLjctMTggNy0yNy43IDEwLjEtNS43LTE5LjYtMTMuMi00MC0yMi41LTYwLjkgOS4yLTIwLjggMTYuNi00MS4xIDIyLjItNjAuNiA5LjkgMy4xIDE5LjMgNi41IDI4LjEgMTAuMiAzNS40IDE1LjEgNTguMyAzNC45IDU4LjMgNTAuNi0uMSAxNS43LTIzIDM1LjYtNTguNCA1MC42ek0zMjAuOCA3OC40eiIvPgogICAgPGNpcmNsZSBjeD0iNDIwLjkiIGN5PSIyOTYuNSIgcj0iNDUuNyIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-redo: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjE2Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgICA8cGF0aCBkPSJNMCAwaDI0djI0SDB6IiBmaWxsPSJub25lIi8+PHBhdGggZD0iTTE4LjQgMTAuNkMxNi41NSA4Ljk5IDE0LjE1IDggMTEuNSA4Yy00LjY1IDAtOC41OCAzLjAzLTkuOTYgNy4yMkwzLjkgMTZjMS4wNS0zLjE5IDQuMDUtNS41IDcuNi01LjUgMS45NSAwIDMuNzMuNzIgNS4xMiAxLjg4TDEzIDE2aDlWN2wtMy42IDMuNnoiLz4KICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-refresh: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDE4IDE4Ij4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTkgMTMuNWMtMi40OSAwLTQuNS0yLjAxLTQuNS00LjVTNi41MSA0LjUgOSA0LjVjMS4yNCAwIDIuMzYuNTIgMy4xNyAxLjMzTDEwIDhoNVYzbC0xLjc2IDEuNzZDMTIuMTUgMy42OCAxMC42NiAzIDkgMyA1LjY5IDMgMy4wMSA1LjY5IDMuMDEgOVM1LjY5IDE1IDkgMTVjMi45NyAwIDUuNDMtMi4xNiA1LjktNWgtMS41MmMtLjQ2IDItMi4yNCAzLjUtNC4zOCAzLjV6Ii8+CiAgICA8L2c+Cjwvc3ZnPgo=);
--jp-icon-regex: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIwIDIwIj4KICA8ZyBjbGFzcz0ianAtaWNvbjIiIGZpbGw9IiM0MTQxNDEiPgogICAgPHJlY3QgeD0iMiIgeT0iMiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjE2Ii8+CiAgPC9nPgoKICA8ZyBjbGFzcz0ianAtaWNvbi1hY2NlbnQyIiBmaWxsPSIjRkZGIj4KICAgIDxjaXJjbGUgY2xhc3M9InN0MiIgY3g9IjUuNSIgY3k9IjE0LjUiIHI9IjEuNSIvPgogICAgPHJlY3QgeD0iMTIiIHk9IjQiIGNsYXNzPSJzdDIiIHdpZHRoPSIxIiBoZWlnaHQ9IjgiLz4KICAgIDxyZWN0IHg9IjguNSIgeT0iNy41IiB0cmFuc2Zvcm09Im1hdHJpeCgwLjg2NiAtMC41IDAuNSAwLjg2NiAtMi4zMjU1IDcuMzIxOSkiIGNsYXNzPSJzdDIiIHdpZHRoPSI4IiBoZWlnaHQ9IjEiLz4KICAgIDxyZWN0IHg9IjEyIiB5PSI0IiB0cmFuc2Zvcm09Im1hdHJpeCgwLjUgLTAuODY2IDAuODY2IDAuNSAtMC42Nzc5IDE0LjgyNTIpIiBjbGFzcz0ic3QyIiB3aWR0aD0iMSIgaGVpZ2h0PSI4Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-run: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTggNXYxNGwxMS03eiIvPgogICAgPC9nPgo8L3N2Zz4K);
--jp-icon-running: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDUxMiA1MTIiPgogIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICA8cGF0aCBkPSJNMjU2IDhDMTE5IDggOCAxMTkgOCAyNTZzMTExIDI0OCAyNDggMjQ4IDI0OC0xMTEgMjQ4LTI0OFMzOTMgOCAyNTYgOHptOTYgMzI4YzAgOC44LTcuMiAxNi0xNiAxNkgxNzZjLTguOCAwLTE2LTcuMi0xNi0xNlYxNzZjMC04LjggNy4yLTE2IDE2LTE2aDE2MGM4LjggMCAxNiA3LjIgMTYgMTZ2MTYweiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-save: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTE3IDNINWMtMS4xMSAwLTIgLjktMiAydjE0YzAgMS4xLjg5IDIgMiAyaDE0YzEuMSAwIDItLjkgMi0yVjdsLTQtNHptLTUgMTZjLTEuNjYgMC0zLTEuMzQtMy0zczEuMzQtMyAzLTMgMyAxLjM0IDMgMy0xLjM0IDMtMyAzem0zLTEwSDVWNWgxMHY0eiIvPgogICAgPC9nPgo8L3N2Zz4K);
--jp-icon-search: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTggMTgiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTEyLjEsMTAuOWgtMC43bC0wLjItMC4yYzAuOC0wLjksMS4zLTIuMiwxLjMtMy41YzAtMy0yLjQtNS40LTUuNC01LjRTMS44LDQuMiwxLjgsNy4xczIuNCw1LjQsNS40LDUuNCBjMS4zLDAsMi41LTAuNSwzLjUtMS4zbDAuMiwwLjJ2MC43bDQuMSw0LjFsMS4yLTEuMkwxMi4xLDEwLjl6IE03LjEsMTAuOWMtMi4xLDAtMy43LTEuNy0zLjctMy43czEuNy0zLjcsMy43LTMuN3MzLjcsMS43LDMuNywzLjcgUzkuMiwxMC45LDcuMSwxMC45eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-settings: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIiBkPSJNMTkuNDMgMTIuOThjLjA0LS4zMi4wNy0uNjQuMDctLjk4cy0uMDMtLjY2LS4wNy0uOThsMi4xMS0xLjY1Yy4xOS0uMTUuMjQtLjQyLjEyLS42NGwtMi0zLjQ2Yy0uMTItLjIyLS4zOS0uMy0uNjEtLjIybC0yLjQ5IDFjLS41Mi0uNC0xLjA4LS43My0xLjY5LS45OGwtLjM4LTIuNjVBLjQ4OC40ODggMCAwMDE0IDJoLTRjLS4yNSAwLS40Ni4xOC0uNDkuNDJsLS4zOCAyLjY1Yy0uNjEuMjUtMS4xNy41OS0xLjY5Ljk4bC0yLjQ5LTFjLS4yMy0uMDktLjQ5IDAtLjYxLjIybC0yIDMuNDZjLS4xMy4yMi0uMDcuNDkuMTIuNjRsMi4xMSAxLjY1Yy0uMDQuMzItLjA3LjY1LS4wNy45OHMuMDMuNjYuMDcuOThsLTIuMTEgMS42NWMtLjE5LjE1LS4yNC40Mi0uMTIuNjRsMiAzLjQ2Yy4xMi4yMi4zOS4zLjYxLjIybDIuNDktMWMuNTIuNCAxLjA4LjczIDEuNjkuOThsLjM4IDIuNjVjLjAzLjI0LjI0LjQyLjQ5LjQyaDRjLjI1IDAgLjQ2LS4xOC40OS0uNDJsLjM4LTIuNjVjLjYxLS4yNSAxLjE3LS41OSAxLjY5LS45OGwyLjQ5IDFjLjIzLjA5LjQ5IDAgLjYxLS4yMmwyLTMuNDZjLjEyLS4yMi4wNy0uNDktLjEyLS42NGwtMi4xMS0xLjY1ek0xMiAxNS41Yy0xLjkzIDAtMy41LTEuNTctMy41LTMuNXMxLjU3LTMuNSAzLjUtMy41IDMuNSAxLjU3IDMuNSAzLjUtMS41NyAzLjUtMy41IDMuNXoiLz4KPC9zdmc+Cg==);
--jp-icon-share: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTSAxOCAyIEMgMTYuMzU0OTkgMiAxNSAzLjM1NDk5MDQgMTUgNSBDIDE1IDUuMTkwOTUyOSAxNS4wMjE3OTEgNS4zNzcxMjI0IDE1LjA1NjY0MSA1LjU1ODU5MzggTCA3LjkyMTg3NSA5LjcyMDcwMzEgQyA3LjM5ODUzOTkgOS4yNzc4NTM5IDYuNzMyMDc3MSA5IDYgOSBDIDQuMzU0OTkwNCA5IDMgMTAuMzU0OTkgMyAxMiBDIDMgMTMuNjQ1MDEgNC4zNTQ5OTA0IDE1IDYgMTUgQyA2LjczMjA3NzEgMTUgNy4zOTg1Mzk5IDE0LjcyMjE0NiA3LjkyMTg3NSAxNC4yNzkyOTcgTCAxNS4wNTY2NDEgMTguNDM5NDUzIEMgMTUuMDIxNTU1IDE4LjYyMTUxNCAxNSAxOC44MDgzODYgMTUgMTkgQyAxNSAyMC42NDUwMSAxNi4zNTQ5OSAyMiAxOCAyMiBDIDE5LjY0NTAxIDIyIDIxIDIwLjY0NTAxIDIxIDE5IEMgMjEgMTcuMzU0OTkgMTkuNjQ1MDEgMTYgMTggMTYgQyAxNy4yNjc0OCAxNiAxNi42MDE1OTMgMTYuMjc5MzI4IDE2LjA3ODEyNSAxNi43MjI2NTYgTCA4Ljk0MzM1OTQgMTIuNTU4NTk0IEMgOC45NzgyMDk1IDEyLjM3NzEyMiA5IDEyLjE5MDk1MyA5IDEyIEMgOSAxMS44MDkwNDcgOC45NzgyMDk1IDExLjYyMjg3OCA4Ljk0MzM1OTQgMTEuNDQxNDA2IEwgMTYuMDc4MTI1IDcuMjc5Mjk2OSBDIDE2LjYwMTQ2IDcuNzIyMTQ2MSAxNy4yNjc5MjMgOCAxOCA4IEMgMTkuNjQ1MDEgOCAyMSA2LjY0NTAwOTYgMjEgNSBDIDIxIDMuMzU0OTkwNCAxOS42NDUwMSAyIDE4IDIgeiBNIDE4IDQgQyAxOC41NjQxMjkgNCAxOSA0LjQzNTg3MDYgMTkgNSBDIDE5IDUuNTY0MTI5NCAxOC41NjQxMjkgNiAxOCA2IEMgMTcuNDM1ODcxIDYgMTcgNS41NjQxMjk0IDE3IDUgQyAxNyA0LjQzNTg3MDYgMTcuNDM1ODcxIDQgMTggNCB6IE0gNiAxMSBDIDYuNTY0MTI5NCAxMSA3IDExLjQzNTg3MSA3IDEyIEMgNyAxMi41NjQxMjkgNi41NjQxMjk0IDEzIDYgMTMgQyA1LjQzNTg3MDYgMTMgNSAxMi41NjQxMjkgNSAxMiBDIDUgMTEuNDM1ODcxIDUuNDM1ODcwNiAxMSA2IDExIHogTSAxOCAxOCBDIDE4LjU2NDEyOSAxOCAxOSAxOC40MzU4NzEgMTkgMTkgQyAxOSAxOS41NjQxMjkgMTguNTY0MTI5IDIwIDE4IDIwIEMgMTcuNDM1ODcxIDIwIDE3IDE5LjU2NDEyOSAxNyAxOSBDIDE3IDE4LjQzNTg3MSAxNy40MzU4NzEgMTggMTggMTggeiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-spreadsheet: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8cGF0aCBjbGFzcz0ianAtaWNvbi1jb250cmFzdDEganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNENBRjUwIiBkPSJNMi4yIDIuMnYxNy42aDE3LjZWMi4ySDIuMnptMTUuNCA3LjdoLTUuNVY0LjRoNS41djUuNXpNOS45IDQuNHY1LjVINC40VjQuNGg1LjV6bS01LjUgNy43aDUuNXY1LjVINC40di01LjV6bTcuNyA1LjV2LTUuNWg1LjV2NS41aC01LjV6Ii8+Cjwvc3ZnPgo=);
--jp-icon-stop: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgyNHYyNEgweiIgZmlsbD0ibm9uZSIvPgogICAgICAgIDxwYXRoIGQ9Ik02IDZoMTJ2MTJINnoiLz4KICAgIDwvZz4KPC9zdmc+Cg==);
--jp-icon-tab: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTIxIDNIM2MtMS4xIDAtMiAuOS0yIDJ2MTRjMCAxLjEuOSAyIDIgMmgxOGMxLjEgMCAyLS45IDItMlY1YzAtMS4xLS45LTItMi0yem0wIDE2SDNWNWgxMHY0aDh2MTB6Ii8+CiAgPC9nPgo8L3N2Zz4K);
--jp-icon-table-rows: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgyNHYyNEgweiIgZmlsbD0ibm9uZSIvPgogICAgICAgIDxwYXRoIGQ9Ik0yMSw4SDNWNGgxOFY4eiBNMjEsMTBIM3Y0aDE4VjEweiBNMjEsMTZIM3Y0aDE4VjE2eiIvPgogICAgPC9nPgo8L3N2Zz4K);
--jp-icon-tag: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjgiIGhlaWdodD0iMjgiIHZpZXdCb3g9IjAgMCA0MyAyOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KCTxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CgkJPHBhdGggZD0iTTI4LjgzMzIgMTIuMzM0TDMyLjk5OTggMTYuNTAwN0wzNy4xNjY1IDEyLjMzNEgyOC44MzMyWiIvPgoJCTxwYXRoIGQ9Ik0xNi4yMDk1IDIxLjYxMDRDMTUuNjg3MyAyMi4xMjk5IDE0Ljg0NDMgMjIuMTI5OSAxNC4zMjQ4IDIxLjYxMDRMNi45ODI5IDE0LjcyNDVDNi41NzI0IDE0LjMzOTQgNi4wODMxMyAxMy42MDk4IDYuMDQ3ODYgMTMuMDQ4MkM1Ljk1MzQ3IDExLjUyODggNi4wMjAwMiA4LjYxOTQ0IDYuMDY2MjEgNy4wNzY5NUM2LjA4MjgxIDYuNTE0NzcgNi41NTU0OCA2LjA0MzQ3IDcuMTE4MDQgNi4wMzA1NUM5LjA4ODYzIDUuOTg0NzMgMTMuMjYzOCA1LjkzNTc5IDEzLjY1MTggNi4zMjQyNUwyMS43MzY5IDEzLjYzOUMyMi4yNTYgMTQuMTU4NSAyMS43ODUxIDE1LjQ3MjQgMjEuMjYyIDE1Ljk5NDZMMTYuMjA5NSAyMS42MTA0Wk05Ljc3NTg1IDguMjY1QzkuMzM1NTEgNy44MjU2NiA4LjYyMzUxIDcuODI1NjYgOC4xODI4IDguMjY1QzcuNzQzNDYgOC43MDU3MSA3Ljc0MzQ2IDkuNDE3MzMgOC4xODI4IDkuODU2NjdDOC42MjM4MiAxMC4yOTY0IDkuMzM1ODIgMTAuMjk2NCA5Ljc3NTg1IDkuODU2NjdDMTAuMjE1NiA5LjQxNzMzIDEwLjIxNTYgOC43MDUzMyA5Ljc3NTg1IDguMjY1WiIvPgoJPC9nPgo8L3N2Zz4K);
--jp-icon-terminal: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0IiA+CiAgICA8cmVjdCBjbGFzcz0ianAtdGVybWluYWwtaWNvbi1iYWNrZ3JvdW5kLWNvbG9yIGpwLWljb24tc2VsZWN0YWJsZSIgd2lkdGg9IjIwIiBoZWlnaHQ9IjIwIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyIDIpIiBmaWxsPSIjMzMzMzMzIi8+CiAgICA8cGF0aCBjbGFzcz0ianAtdGVybWluYWwtaWNvbi1jb2xvciBqcC1pY29uLXNlbGVjdGFibGUtaW52ZXJzZSIgZD0iTTUuMDU2NjQgOC43NjE3MkM1LjA1NjY0IDguNTk3NjYgNS4wMzEyNSA4LjQ1MzEyIDQuOTgwNDcgOC4zMjgxMkM0LjkzMzU5IDguMTk5MjIgNC44NTU0NyA4LjA4MjAzIDQuNzQ2MDkgNy45NzY1NkM0LjY0MDYyIDcuODcxMDkgNC41IDcuNzc1MzkgNC4zMjQyMiA3LjY4OTQ1QzQuMTUyMzQgNy41OTk2MSAzLjk0MzM2IDcuNTExNzIgMy42OTcyNyA3LjQyNTc4QzMuMzAyNzMgNy4yODUxNiAyLjk0MzM2IDcuMTM2NzIgMi42MTkxNCA2Ljk4MDQ3QzIuMjk0OTIgNi44MjQyMiAyLjAxNzU4IDYuNjQyNTggMS43ODcxMSA2LjQzNTU1QzEuNTYwNTUgNi4yMjg1MiAxLjM4NDc3IDUuOTg4MjggMS4yNTk3NyA1LjcxNDg0QzEuMTM0NzcgNS40Mzc1IDEuMDcyMjcgNS4xMDkzOCAxLjA3MjI3IDQuNzMwNDdDMS4wNzIyNyA0LjM5ODQ0IDEuMTI4OTEgNC4wOTU3IDEuMjQyMTkgMy44MjIyN0MxLjM1NTQ3IDMuNTQ0OTIgMS41MTU2MiAzLjMwNDY5IDEuNzIyNjYgMy4xMDE1NkMxLjkyOTY5IDIuODk4NDQgMi4xNzk2OSAyLjczNDM3IDIuNDcyNjYgMi42MDkzOEMyLjc2NTYyIDIuNDg0MzggMy4wOTE4IDIuNDA0MyAzLjQ1MTE3IDIuMzY5MTRWMS4xMDkzOEg0LjM4ODY3VjIuMzgwODZDNC43NDAyMyAyLjQyNzczIDUuMDU2NjQgMi41MjM0NCA1LjMzNzg5IDIuNjY3OTdDNS42MTkxNCAyLjgxMjUgNS44NTc0MiAzLjAwMTk1IDYuMDUyNzMgMy4yMzYzM0M2LjI1MTk1IDMuNDY2OCA2LjQwNDMgMy43NDAyMyA2LjUwOTc3IDQuMDU2NjRDNi42MTkxNCA0LjM2OTE0IDYuNjczODMgNC43MjA3IDYuNjczODMgNS4xMTEzM0g1LjA0NDkyQzUuMDQ0OTIgNC42Mzg2NyA0LjkzNzUgNC4yODEyNSA0LjcyMjY2IDQuMDM5MDZDNC41MDc4MSAzLjc5Mjk3IDQuMjE2OCAzLjY2OTkyIDMuODQ5NjEgMy42Njk5MkMzLjY1MDM5IDMuNjY5OTIgMy40NzY1NiAzLjY5NzI3IDMuMzI4MTIgMy43NTE5NUMzLjE4MzU5IDMuODAyNzMgMy4wNjQ0NSAzLjg3Njk1IDIuOTcwNyAzLjk3NDYxQzIuODc2OTUgNC4wNjgzNiAyLjgwNjY0IDQuMTc5NjkgMi43NTk3NyA0LjMwODU5QzIuNzE2OCA0LjQzNzUgMi42OTUzMSA0LjU3ODEyIDIuNjk1MzEgNC43MzA0N0MyLjY5NTMxIDQuODgyODEgMi43MTY4IDUuMDE5NTMgMi43NTk3NyA1LjE0MDYyQzIuODA2NjQgNS4yNTc4MSAyLjg4MjgxIDUuMzY3MTkgMi45ODgyOCA1LjQ2ODc1QzMuMDk3NjYgNS41NzAzMSAzLjI0MDIzIDUuNjY3OTcgMy40MTYwMiA1Ljc2MTcyQzMuNTkxOCA1Ljg1MTU2IDMuODEwNTUgNS45NDMzNiA0LjA3MjI3IDYuMDM3MTFDNC40NjY4IDYuMTg1NTUgNC44MjQyMiA2LjMzOTg0IDUuMTQ0NTMgNi41QzUuNDY0ODQgNi42NTYyNSA1LjczODI4IDYuODM5ODQgNS45NjQ4NCA3LjA1MDc4QzYuMTk1MzEgNy4yNTc4MSA2LjM3MTA5IDcuNSA2LjQ5MjE5IDcuNzc3MzRDNi42MTcxOSA4LjA1MDc4IDYuNjc5NjkgOC4zNzUgNi42Nzk2OSA4Ljc1QzYuNjc5NjkgOS4wOTM3NSA2LjYyMzA1IDkuNDA0MyA2LjUwOTc3IDkuNjgxNjRDNi4zOTY0OCA5Ljk1NTA4IDYuMjM0MzggMTAuMTkxNCA2LjAyMzQ0IDEwLjM5MDZDNS44MTI1IDEwLjU4OTggNS41NTg1OSAxMC43NSA1LjI2MTcyIDEwLjg3MTFDNC45NjQ4NCAxMC45ODgzIDQuNjMyODEgMTEuMDY0NSA0LjI2NTYyIDExLjA5OTZWMTIuMjQ4SDMuMzMzOThWMTEuMDk5NkMzLjAwMTk1IDExLjA2ODQgMi42Nzk2OSAxMC45OTYxIDIuMzY3MTkgMTAuODgyOEMyLjA1NDY5IDEwLjc2NTYgMS43NzczNCAxMC41OTc3IDEuNTM1MTYgMTAuMzc4OUMxLjI5Njg4IDEwLjE2MDIgMS4xMDU0NyA5Ljg4NDc3IDAuOTYwOTM4IDkuNTUyNzNDMC44MTY0MDYgOS4yMTY4IDAuNzQ0MTQxIDguODE0NDUgMC43NDQxNDEgOC4zNDU3SDIuMzc4OTFDMi4zNzg5MSA4LjYyNjk1IDIuNDE5OTIgOC44NjMyOCAyLjUwMTk1IDkuMDU0NjlDMi41ODM5OCA5LjI0MjE5IDIuNjg5NDUgOS4zOTI1OCAyLjgxODM2IDkuNTA1ODZDMi45NTExNyA5LjYxNTIzIDMuMTAxNTYgOS42OTMzNiAzLjI2OTUzIDkuNzQwMjNDMy40Mzc1IDkuNzg3MTEgMy42MDkzOCA5LjgxMDU1IDMuNzg1MTYgOS44MTA1NUM0LjIwMzEyIDkuODEwNTUgNC41MTk1MyA5LjcxMjg5IDQuNzM0MzggOS41MTc1OEM0Ljk0OTIyIDkuMzIyMjcgNS4wNTY2NCA5LjA3MDMxIDUuMDU2NjQgOC43NjE3MlpNMTMuNDE4IDEyLjI3MTVIOC4wNzQyMlYxMUgxMy40MThWMTIuMjcxNVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDMuOTUyNjQgNikiIGZpbGw9IndoaXRlIi8+Cjwvc3ZnPgo=);
--jp-icon-text-editor: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBjbGFzcz0ianAtdGV4dC1lZGl0b3ItaWNvbi1jb2xvciBqcC1pY29uLXNlbGVjdGFibGUiIGZpbGw9IiM2MTYxNjEiIGQ9Ik0xNSAxNUgzdjJoMTJ2LTJ6bTAtOEgzdjJoMTJWN3pNMyAxM2gxOHYtMkgzdjJ6bTAgOGgxOHYtMkgzdjJ6TTMgM3YyaDE4VjNIM3oiLz4KPC9zdmc+Cg==);
--jp-icon-toc: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8ZyBjbGFzcz0ianAtaWNvbjMganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjNjE2MTYxIj4KICAgIDxwYXRoIGQ9Ik03LDVIMjFWN0g3VjVNNywxM1YxMUgyMVYxM0g3TTQsNC41QTEuNSwxLjUgMCAwLDEgNS41LDZBMS41LDEuNSAwIDAsMSA0LDcuNUExLjUsMS41IDAgMCwxIDIuNSw2QTEuNSwxLjUgMCAwLDEgNCw0LjVNNCwxMC41QTEuNSwxLjUgMCAwLDEgNS41LDEyQTEuNSwxLjUgMCAwLDEgNCwxMy41QTEuNSwxLjUgMCAwLDEgMi41LDEyQTEuNSwxLjUgMCAwLDEgNCwxMC41TTcsMTlWMTdIMjFWMTlIN000LDE2LjVBMS41LDEuNSAwIDAsMSA1LjUsMThBMS41LDEuNSAwIDAsMSA0LDE5LjVBMS41LDEuNSAwIDAsMSAyLjUsMThBMS41LDEuNSAwIDAsMSA0LDE2LjVaIiAvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-tree-view: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsYXNzPSJqcC1pY29uMyIgZmlsbD0iIzYxNjE2MSI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgyNHYyNEgweiIgZmlsbD0ibm9uZSIvPgogICAgICAgIDxwYXRoIGQ9Ik0yMiAxMVYzaC03djNIOVYzSDJ2OGg3VjhoMnYxMGg0djNoN3YtOGgtN3YzaC0yVjhoMnYzeiIvPgogICAgPC9nPgo8L3N2Zz4K);
--jp-icon-trusted: url(data:image/svg+xml;base64,PHN2ZyBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDI0IDI1Ij4KICAgIDxwYXRoIGNsYXNzPSJqcC1pY29uMiIgc3Ryb2tlPSIjMzMzMzMzIiBzdHJva2Utd2lkdGg9IjIiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDIgMykiIGQ9Ik0xLjg2MDk0IDExLjQ0MDlDMC44MjY0NDggOC43NzAyNyAwLjg2Mzc3OSA2LjA1NzY0IDEuMjQ5MDcgNC4xOTkzMkMyLjQ4MjA2IDMuOTMzNDcgNC4wODA2OCAzLjQwMzQ3IDUuNjAxMDIgMi44NDQ5QzcuMjM1NDkgMi4yNDQ0IDguODU2NjYgMS41ODE1IDkuOTg3NiAxLjA5NTM5QzExLjA1OTcgMS41ODM0MSAxMi42MDk0IDIuMjQ0NCAxNC4yMTggMi44NDMzOUMxNS43NTAzIDMuNDEzOTQgMTcuMzk5NSAzLjk1MjU4IDE4Ljc1MzkgNC4yMTM4NUMxOS4xMzY0IDYuMDcxNzcgMTkuMTcwOSA4Ljc3NzIyIDE4LjEzOSAxMS40NDA5QzE3LjAzMDMgMTQuMzAzMiAxNC42NjY4IDE3LjE4NDQgOS45OTk5OSAxOC45MzU0QzUuMzMzMiAxNy4xODQ0IDIuOTY5NjggMTQuMzAzMiAxLjg2MDk0IDExLjQ0MDlaIi8+CiAgICA8cGF0aCBjbGFzcz0ianAtaWNvbjIiIGZpbGw9IiMzMzMzMzMiIHN0cm9rZT0iIzMzMzMzMyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoOCA5Ljg2NzE5KSIgZD0iTTIuODYwMTUgNC44NjUzNUwwLjcyNjU0OSAyLjk5OTU5TDAgMy42MzA0NUwyLjg2MDE1IDYuMTMxNTdMOCAwLjYzMDg3Mkw3LjI3ODU3IDBMMi44NjAxNSA0Ljg2NTM1WiIvPgo8L3N2Zz4K);
--jp-icon-undo: url(data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTEyLjUgOGMtMi42NSAwLTUuMDUuOTktNi45IDIuNkwyIDd2OWg5bC0zLjYyLTMuNjJjMS4zOS0xLjE2IDMuMTYtMS44OCA1LjEyLTEuODggMy41NCAwIDYuNTUgMi4zMSA3LjYgNS41bDIuMzctLjc4QzIxLjA4IDExLjAzIDE3LjE1IDggMTIuNSA4eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-user: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBjbGFzcz0ianAtaWNvbjMiIGZpbGw9IiM2MTYxNjEiPgogICAgPHBhdGggZD0iTTE2IDdhNCA0IDAgMTEtOCAwIDQgNCAwIDAxOCAwek0xMiAxNGE3IDcgMCAwMC03IDdoMTRhNyA3IDAgMDAtNy03eiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-users: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZlcnNpb249IjEuMSIgdmlld0JveD0iMCAwIDM2IDI0IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogPGcgY2xhc3M9ImpwLWljb24zIiB0cmFuc2Zvcm09Im1hdHJpeCgxLjczMjcgMCAwIDEuNzMyNyAtMy42MjgyIC4wOTk1NzcpIiBmaWxsPSIjNjE2MTYxIj4KICA8cGF0aCB0cmFuc2Zvcm09Im1hdHJpeCgxLjUsMCwwLDEuNSwwLC02KSIgZD0ibTEyLjE4NiA3LjUwOThjLTEuMDUzNSAwLTEuOTc1NyAwLjU2NjUtMi40Nzg1IDEuNDEwMiAwLjc1MDYxIDAuMzEyNzcgMS4zOTc0IDAuODI2NDggMS44NzMgMS40NzI3aDMuNDg2M2MwLTEuNTkyLTEuMjg4OS0yLjg4MjgtMi44ODA5LTIuODgyOHoiLz4KICA8cGF0aCBkPSJtMjAuNDY1IDIuMzg5NWEyLjE4ODUgMi4xODg1IDAgMCAxLTIuMTg4NCAyLjE4ODUgMi4xODg1IDIuMTg4NSAwIDAgMS0yLjE4ODUtMi4xODg1IDIuMTg4NSAyLjE4ODUgMCAwIDEgMi4xODg1LTIuMTg4NSAyLjE4ODUgMi4xODg1IDAgMCAxIDIuMTg4NCAyLjE4ODV6Ii8+CiAgPHBhdGggdHJhbnNmb3JtPSJtYXRyaXgoMS41LDAsMCwxLjUsMCwtNikiIGQ9Im0zLjU4OTggOC40MjE5Yy0xLjExMjYgMC0yLjAxMzcgMC45MDExMS0yLjAxMzcgMi4wMTM3aDIuODE0NWMwLjI2Nzk3LTAuMzczMDkgMC41OTA3LTAuNzA0MzUgMC45NTg5OC0wLjk3ODUyLTAuMzQ0MzMtMC42MTY4OC0xLjAwMzEtMS4wMzUyLTEuNzU5OC0xLjAzNTJ6Ii8+CiAgPHBhdGggZD0ibTYuOTE1NCA0LjYyM2ExLjUyOTQgMS41Mjk0IDAgMCAxLTEuNTI5NCAxLjUyOTQgMS41Mjk0IDEuNTI5NCAwIDAgMS0xLjUyOTQtMS41Mjk0IDEuNTI5NCAxLjUyOTQgMCAwIDEgMS41Mjk0LTEuNTI5NCAxLjUyOTQgMS41Mjk0IDAgMCAxIDEuNTI5NCAxLjUyOTR6Ii8+CiAgPHBhdGggZD0ibTYuMTM1IDEzLjUzNWMwLTMuMjM5MiAyLjYyNTktNS44NjUgNS44NjUtNS44NjUgMy4yMzkyIDAgNS44NjUgMi42MjU5IDUuODY1IDUuODY1eiIvPgogIDxjaXJjbGUgY3g9IjEyIiBjeT0iMy43Njg1IiByPSIyLjk2ODUiLz4KIDwvZz4KPC9zdmc+Cg==);
--jp-icon-vega: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8ZyBjbGFzcz0ianAtaWNvbjEganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjMjEyMTIxIj4KICAgIDxwYXRoIGQ9Ik0xMC42IDUuNGwyLjItMy4ySDIuMnY3LjNsNC02LjZ6Ii8+CiAgICA8cGF0aCBkPSJNMTUuOCAyLjJsLTQuNCA2LjZMNyA2LjNsLTQuOCA4djUuNWgxNy42VjIuMmgtNHptLTcgMTUuNEg1LjV2LTQuNGgzLjN2NC40em00LjQgMEg5LjhWOS44aDMuNHY3Ljh6bTQuNCAwaC0zLjRWNi41aDMuNHYxMS4xeiIvPgogIDwvZz4KPC9zdmc+Cg==);
--jp-icon-word: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIwIDIwIj4KIDxnIGNsYXNzPSJqcC1pY29uMiIgZmlsbD0iIzQxNDE0MSI+CiAgPHJlY3QgeD0iMiIgeT0iMiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjE2Ii8+CiA8L2c+CiA8ZyBjbGFzcz0ianAtaWNvbi1hY2NlbnQyIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSguNDMgLjA0MDEpIiBmaWxsPSIjZmZmIj4KICA8cGF0aCBkPSJtNC4xNCA4Ljc2cTAuMDY4Mi0xLjg5IDIuNDItMS44OSAxLjE2IDAgMS42OCAwLjQyIDAuNTY3IDAuNDEgMC41NjcgMS4xNnYzLjQ3cTAgMC40NjIgMC41MTQgMC40NjIgMC4xMDMgMCAwLjItMC4wMjMxdjAuNzE0cS0wLjM5OSAwLjEwMy0wLjY1MSAwLjEwMy0wLjQ1MiAwLTAuNjkzLTAuMjItMC4yMzEtMC4yLTAuMjg0LTAuNjYyLTAuOTU2IDAuODcyLTIgMC44NzItMC45MDMgMC0xLjQ3LTAuNDcyLTAuNTI1LTAuNDcyLTAuNTI1LTEuMjYgMC0wLjI2MiAwLjA0NTItMC40NzIgMC4wNTY3LTAuMjIgMC4xMTYtMC4zNzggMC4wNjgyLTAuMTY4IDAuMjMxLTAuMzA0IDAuMTU4LTAuMTQ3IDAuMjYyLTAuMjQyIDAuMTE2LTAuMDkxNCAwLjM2OC0wLjE2OCAwLjI2Mi0wLjA5MTQgMC4zOTktMC4xMjYgMC4xMzYtMC4wNDUyIDAuNDcyLTAuMTAzIDAuMzM2LTAuMDU3OCAwLjUwNC0wLjA3OTggMC4xNTgtMC4wMjMxIDAuNTY3LTAuMDc5OCAwLjU1Ni0wLjA2ODIgMC43NzctMC4yMjEgMC4yMi0wLjE1MiAwLjIyLTAuNDQxdi0wLjI1MnEwLTAuNDMtMC4zNTctMC42NjItMC4zMzYtMC4yMzEtMC45NzYtMC4yMzEtMC42NjIgMC0wLjk5OCAwLjI2Mi0wLjMzNiAwLjI1Mi0wLjM5OSAwLjc5OHptMS44OSAzLjY4cTAuNzg4IDAgMS4yNi0wLjQxIDAuNTA0LTAuNDIgMC41MDQtMC45MDN2LTEuMDVxLTAuMjg0IDAuMTM2LTAuODYxIDAuMjMxLTAuNTY3IDAuMDkxNC0wLjk4NyAwLjE1OC0wLjQyIDAuMDY4Mi0wLjc2NiAwLjMyNi0wLjMzNiAwLjI1Mi0wLjMzNiAwLjcwNHQwLjMwNCAwLjcwNCAwLjg2MSAwLjI1MnoiIHN0cm9rZS13aWR0aD0iMS4wNSIvPgogIDxwYXRoIGQ9Im0xMCA0LjU2aDAuOTQ1djMuMTVxMC42NTEtMC45NzYgMS44OS0wLjk3NiAxLjE2IDAgMS44OSAwLjg0IDAuNjgyIDAuODQgMC42ODIgMi4zMSAwIDEuNDctMC43MDQgMi40Mi0wLjcwNCAwLjg4Mi0xLjg5IDAuODgyLTEuMjYgMC0xLjg5LTEuMDJ2MC43NjZoLTAuODV6bTIuNjIgMy4wNHEtMC43NDYgMC0xLjE2IDAuNjQtMC40NTIgMC42My0wLjQ1MiAxLjY4IDAgMS4wNSAwLjQ1MiAxLjY4dDEuMTYgMC42M3EwLjc3NyAwIDEuMjYtMC42MyAwLjQ5NC0wLjY0IDAuNDk0LTEuNjggMC0xLjA1LTAuNDcyLTEuNjgtMC40NjItMC42NC0xLjI2LTAuNjR6IiBzdHJva2Utd2lkdGg9IjEuMDUiLz4KICA8cGF0aCBkPSJtMi43MyAxNS44IDEzLjYgMC4wMDgxYzAuMDA2OSAwIDAtMi42IDAtMi42IDAtMC4wMDc4LTEuMTUgMC0xLjE1IDAtMC4wMDY5IDAtMC4wMDgzIDEuNS0wLjAwODMgMS41LTJlLTMgLTAuMDAxNC0xMS4zLTAuMDAxNC0xMS4zLTAuMDAxNGwtMC4wMDU5Mi0xLjVjMC0wLjAwNzgtMS4xNyAwLjAwMTMtMS4xNyAwLjAwMTN6IiBzdHJva2Utd2lkdGg9Ii45NzUiLz4KIDwvZz4KPC9zdmc+Cg==);
--jp-icon-yaml: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgdmlld0JveD0iMCAwIDIyIDIyIj4KICA8ZyBjbGFzcz0ianAtaWNvbi1jb250cmFzdDIganAtaWNvbi1zZWxlY3RhYmxlIiBmaWxsPSIjRDgxQjYwIj4KICAgIDxwYXRoIGQ9Ik03LjIgMTguNnYtNS40TDMgNS42aDMuM2wxLjQgMy4xYy4zLjkuNiAxLjYgMSAyLjUuMy0uOC42LTEuNiAxLTIuNWwxLjQtMy4xaDMuNGwtNC40IDcuNnY1LjVsLTIuOS0uMXoiLz4KICAgIDxjaXJjbGUgY2xhc3M9InN0MCIgY3g9IjE3LjYiIGN5PSIxNi41IiByPSIyLjEiLz4KICAgIDxjaXJjbGUgY2xhc3M9InN0MCIgY3g9IjE3LjYiIGN5PSIxMSIgcj0iMi4xIi8+CiAgPC9nPgo8L3N2Zz4K);
}

/_ Icon CSS class declarations _/

.jp-AddAboveIcon {
background-image: var(--jp-icon-add-above);
}

.jp-AddBelowIcon {
background-image: var(--jp-icon-add-below);
}

.jp-AddIcon {
background-image: var(--jp-icon-add);
}

.jp-BellIcon {
background-image: var(--jp-icon-bell);
}

.jp-BugDotIcon {
background-image: var(--jp-icon-bug-dot);
}

.jp-BugIcon {
background-image: var(--jp-icon-bug);
}

.jp-BuildIcon {
background-image: var(--jp-icon-build);
}

.jp-CaretDownEmptyIcon {
background-image: var(--jp-icon-caret-down-empty);
}

.jp-CaretDownEmptyThinIcon {
background-image: var(--jp-icon-caret-down-empty-thin);
}

.jp-CaretDownIcon {
background-image: var(--jp-icon-caret-down);
}

.jp-CaretLeftIcon {
background-image: var(--jp-icon-caret-left);
}

.jp-CaretRightIcon {
background-image: var(--jp-icon-caret-right);
}

.jp-CaretUpEmptyThinIcon {
background-image: var(--jp-icon-caret-up-empty-thin);
}

.jp-CaretUpIcon {
background-image: var(--jp-icon-caret-up);
}

.jp-CaseSensitiveIcon {
background-image: var(--jp-icon-case-sensitive);
}

.jp-CheckIcon {
background-image: var(--jp-icon-check);
}

.jp-CircleEmptyIcon {
background-image: var(--jp-icon-circle-empty);
}

.jp-CircleIcon {
background-image: var(--jp-icon-circle);
}

.jp-ClearIcon {
background-image: var(--jp-icon-clear);
}

.jp-CloseIcon {
background-image: var(--jp-icon-close);
}

.jp-CodeCheckIcon {
background-image: var(--jp-icon-code-check);
}

.jp-CodeIcon {
background-image: var(--jp-icon-code);
}

.jp-CollapseAllIcon {
background-image: var(--jp-icon-collapse-all);
}

.jp-ConsoleIcon {
background-image: var(--jp-icon-console);
}

.jp-CopyIcon {
background-image: var(--jp-icon-copy);
}

.jp-CopyrightIcon {
background-image: var(--jp-icon-copyright);
}

.jp-CutIcon {
background-image: var(--jp-icon-cut);
}

.jp-DeleteIcon {
background-image: var(--jp-icon-delete);
}

.jp-DownloadIcon {
background-image: var(--jp-icon-download);
}

.jp-DuplicateIcon {
background-image: var(--jp-icon-duplicate);
}

.jp-EditIcon {
background-image: var(--jp-icon-edit);
}

.jp-EllipsesIcon {
background-image: var(--jp-icon-ellipses);
}

.jp-ErrorIcon {
background-image: var(--jp-icon-error);
}

.jp-ExpandAllIcon {
background-image: var(--jp-icon-expand-all);
}

.jp-ExtensionIcon {
background-image: var(--jp-icon-extension);
}

.jp-FastForwardIcon {
background-image: var(--jp-icon-fast-forward);
}

.jp-FileIcon {
background-image: var(--jp-icon-file);
}

.jp-FileUploadIcon {
background-image: var(--jp-icon-file-upload);
}

.jp-FilterDotIcon {
background-image: var(--jp-icon-filter-dot);
}

.jp-FilterIcon {
background-image: var(--jp-icon-filter);
}

.jp-FilterListIcon {
background-image: var(--jp-icon-filter-list);
}

.jp-FolderFavoriteIcon {
background-image: var(--jp-icon-folder-favorite);
}

.jp-FolderIcon {
background-image: var(--jp-icon-folder);
}

.jp-HomeIcon {
background-image: var(--jp-icon-home);
}

.jp-Html5Icon {
background-image: var(--jp-icon-html5);
}

.jp-ImageIcon {
background-image: var(--jp-icon-image);
}

.jp-InfoIcon {
background-image: var(--jp-icon-info);
}

.jp-InspectorIcon {
background-image: var(--jp-icon-inspector);
}

.jp-JsonIcon {
background-image: var(--jp-icon-json);
}

.jp-JuliaIcon {
background-image: var(--jp-icon-julia);
}

.jp-JupyterFaviconIcon {
background-image: var(--jp-icon-jupyter-favicon);
}

.jp-JupyterIcon {
background-image: var(--jp-icon-jupyter);
}

.jp-JupyterlabWordmarkIcon {
background-image: var(--jp-icon-jupyterlab-wordmark);
}

.jp-KernelIcon {
background-image: var(--jp-icon-kernel);
}

.jp-KeyboardIcon {
background-image: var(--jp-icon-keyboard);
}

.jp-LaunchIcon {
background-image: var(--jp-icon-launch);
}

.jp-LauncherIcon {
background-image: var(--jp-icon-launcher);
}

.jp-LineFormIcon {
background-image: var(--jp-icon-line-form);
}

.jp-LinkIcon {
background-image: var(--jp-icon-link);
}

.jp-ListIcon {
background-image: var(--jp-icon-list);
}

.jp-MarkdownIcon {
background-image: var(--jp-icon-markdown);
}

.jp-MoveDownIcon {
background-image: var(--jp-icon-move-down);
}

.jp-MoveUpIcon {
background-image: var(--jp-icon-move-up);
}

.jp-NewFolderIcon {
background-image: var(--jp-icon-new-folder);
}

.jp-NotTrustedIcon {
background-image: var(--jp-icon-not-trusted);
}

.jp-NotebookIcon {
background-image: var(--jp-icon-notebook);
}

.jp-NumberingIcon {
background-image: var(--jp-icon-numbering);
}

.jp-OfflineBoltIcon {
background-image: var(--jp-icon-offline-bolt);
}

.jp-PaletteIcon {
background-image: var(--jp-icon-palette);
}

.jp-PasteIcon {
background-image: var(--jp-icon-paste);
}

.jp-PdfIcon {
background-image: var(--jp-icon-pdf);
}

.jp-PythonIcon {
background-image: var(--jp-icon-python);
}

.jp-RKernelIcon {
background-image: var(--jp-icon-r-kernel);
}

.jp-ReactIcon {
background-image: var(--jp-icon-react);
}

.jp-RedoIcon {
background-image: var(--jp-icon-redo);
}

.jp-RefreshIcon {
background-image: var(--jp-icon-refresh);
}

.jp-RegexIcon {
background-image: var(--jp-icon-regex);
}

.jp-RunIcon {
background-image: var(--jp-icon-run);
}

.jp-RunningIcon {
background-image: var(--jp-icon-running);
}

.jp-SaveIcon {
background-image: var(--jp-icon-save);
}

.jp-SearchIcon {
background-image: var(--jp-icon-search);
}

.jp-SettingsIcon {
background-image: var(--jp-icon-settings);
}

.jp-ShareIcon {
background-image: var(--jp-icon-share);
}

.jp-SpreadsheetIcon {
background-image: var(--jp-icon-spreadsheet);
}

.jp-StopIcon {
background-image: var(--jp-icon-stop);
}

.jp-TabIcon {
background-image: var(--jp-icon-tab);
}

.jp-TableRowsIcon {
background-image: var(--jp-icon-table-rows);
}

.jp-TagIcon {
background-image: var(--jp-icon-tag);
}

.jp-TerminalIcon {
background-image: var(--jp-icon-terminal);
}

.jp-TextEditorIcon {
background-image: var(--jp-icon-text-editor);
}

.jp-TocIcon {
background-image: var(--jp-icon-toc);
}

.jp-TreeViewIcon {
background-image: var(--jp-icon-tree-view);
}

.jp-TrustedIcon {
background-image: var(--jp-icon-trusted);
}

.jp-UndoIcon {
background-image: var(--jp-icon-undo);
}

.jp-UserIcon {
background-image: var(--jp-icon-user);
}

.jp-UsersIcon {
background-image: var(--jp-icon-users);
}

.jp-VegaIcon {
background-image: var(--jp-icon-vega);
}

.jp-WordIcon {
background-image: var(--jp-icon-word);
}

.jp-YamlIcon {
background-image: var(--jp-icon-yaml);
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/\*\*

- (DEPRECATED) Support for consuming icons as CSS background images
  \*/

.jp-Icon,
.jp-MaterialIcon {
background-position: center;
background-repeat: no-repeat;
background-size: 16px;
min-width: 16px;
min-height: 16px;
}

.jp-Icon-cover {
background-position: center;
background-repeat: no-repeat;
background-size: cover;
}

/\*\*

- (DEPRECATED) Support for specific CSS icon sizes
  \*/

.jp-Icon-16 {
background-size: 16px;
min-width: 16px;
min-height: 16px;
}

.jp-Icon-18 {
background-size: 18px;
min-width: 18px;
min-height: 18px;
}

.jp-Icon-20 {
background-size: 20px;
min-width: 20px;
min-height: 20px;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.lm-TabBar .lm-TabBar-addButton {
align-items: center;
display: flex;
padding: 4px;
padding-bottom: 5px;
margin-right: 1px;
background-color: var(--jp-layout-color2);
}

.lm-TabBar .lm-TabBar-addButton:hover {
background-color: var(--jp-layout-color1);
}

.lm-DockPanel-tabBar .lm-TabBar-tab {
width: var(--jp-private-horizontal-tab-width);
}

.lm-DockPanel-tabBar .lm-TabBar-content {
flex: unset;
}

.lm-DockPanel-tabBar[data-orientation='horizontal'] {
flex: 1 1 auto;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/\*\*

- Support for icons as inline SVG HTMLElements
  \*/

/_ recolor the primary elements of an icon _/
.jp-icon0[fill] {
fill: var(--jp-inverse-layout-color0);
}

.jp-icon1[fill] {
fill: var(--jp-inverse-layout-color1);
}

.jp-icon2[fill] {
fill: var(--jp-inverse-layout-color2);
}

.jp-icon3[fill] {
fill: var(--jp-inverse-layout-color3);
}

.jp-icon4[fill] {
fill: var(--jp-inverse-layout-color4);
}

.jp-icon0[stroke] {
stroke: var(--jp-inverse-layout-color0);
}

.jp-icon1[stroke] {
stroke: var(--jp-inverse-layout-color1);
}

.jp-icon2[stroke] {
stroke: var(--jp-inverse-layout-color2);
}

.jp-icon3[stroke] {
stroke: var(--jp-inverse-layout-color3);
}

.jp-icon4[stroke] {
stroke: var(--jp-inverse-layout-color4);
}

/_ recolor the accent elements of an icon _/
.jp-icon-accent0[fill] {
fill: var(--jp-layout-color0);
}

.jp-icon-accent1[fill] {
fill: var(--jp-layout-color1);
}

.jp-icon-accent2[fill] {
fill: var(--jp-layout-color2);
}

.jp-icon-accent3[fill] {
fill: var(--jp-layout-color3);
}

.jp-icon-accent4[fill] {
fill: var(--jp-layout-color4);
}

.jp-icon-accent0[stroke] {
stroke: var(--jp-layout-color0);
}

.jp-icon-accent1[stroke] {
stroke: var(--jp-layout-color1);
}

.jp-icon-accent2[stroke] {
stroke: var(--jp-layout-color2);
}

.jp-icon-accent3[stroke] {
stroke: var(--jp-layout-color3);
}

.jp-icon-accent4[stroke] {
stroke: var(--jp-layout-color4);
}

/_ set the color of an icon to transparent _/
.jp-icon-none[fill] {
fill: none;
}

.jp-icon-none[stroke] {
stroke: none;
}

/_ brand icon colors. Same for light and dark _/
.jp-icon-brand0[fill] {
fill: var(--jp-brand-color0);
}

.jp-icon-brand1[fill] {
fill: var(--jp-brand-color1);
}

.jp-icon-brand2[fill] {
fill: var(--jp-brand-color2);
}

.jp-icon-brand3[fill] {
fill: var(--jp-brand-color3);
}

.jp-icon-brand4[fill] {
fill: var(--jp-brand-color4);
}

.jp-icon-brand0[stroke] {
stroke: var(--jp-brand-color0);
}

.jp-icon-brand1[stroke] {
stroke: var(--jp-brand-color1);
}

.jp-icon-brand2[stroke] {
stroke: var(--jp-brand-color2);
}

.jp-icon-brand3[stroke] {
stroke: var(--jp-brand-color3);
}

.jp-icon-brand4[stroke] {
stroke: var(--jp-brand-color4);
}

/_ warn icon colors. Same for light and dark _/
.jp-icon-warn0[fill] {
fill: var(--jp-warn-color0);
}

.jp-icon-warn1[fill] {
fill: var(--jp-warn-color1);
}

.jp-icon-warn2[fill] {
fill: var(--jp-warn-color2);
}

.jp-icon-warn3[fill] {
fill: var(--jp-warn-color3);
}

.jp-icon-warn0[stroke] {
stroke: var(--jp-warn-color0);
}

.jp-icon-warn1[stroke] {
stroke: var(--jp-warn-color1);
}

.jp-icon-warn2[stroke] {
stroke: var(--jp-warn-color2);
}

.jp-icon-warn3[stroke] {
stroke: var(--jp-warn-color3);
}

/_ icon colors that contrast well with each other and most backgrounds _/
.jp-icon-contrast0[fill] {
fill: var(--jp-icon-contrast-color0);
}

.jp-icon-contrast1[fill] {
fill: var(--jp-icon-contrast-color1);
}

.jp-icon-contrast2[fill] {
fill: var(--jp-icon-contrast-color2);
}

.jp-icon-contrast3[fill] {
fill: var(--jp-icon-contrast-color3);
}

.jp-icon-contrast0[stroke] {
stroke: var(--jp-icon-contrast-color0);
}

.jp-icon-contrast1[stroke] {
stroke: var(--jp-icon-contrast-color1);
}

.jp-icon-contrast2[stroke] {
stroke: var(--jp-icon-contrast-color2);
}

.jp-icon-contrast3[stroke] {
stroke: var(--jp-icon-contrast-color3);
}

.jp-icon-dot[fill] {
fill: var(--jp-warn-color0);
}

.jp-jupyter-icon-color[fill] {
fill: var(--jp-jupyter-icon-color, var(--jp-warn-color0));
}

.jp-notebook-icon-color[fill] {
fill: var(--jp-notebook-icon-color, var(--jp-warn-color0));
}

.jp-json-icon-color[fill] {
fill: var(--jp-json-icon-color, var(--jp-warn-color1));
}

.jp-console-icon-color[fill] {
fill: var(--jp-console-icon-color, white);
}

.jp-console-icon-background-color[fill] {
fill: var(--jp-console-icon-background-color, var(--jp-brand-color1));
}

.jp-terminal-icon-color[fill] {
fill: var(--jp-terminal-icon-color, var(--jp-layout-color2));
}

.jp-terminal-icon-background-color[fill] {
fill: var(
--jp-terminal-icon-background-color,
var(--jp-inverse-layout-color2)
);
}

.jp-text-editor-icon-color[fill] {
fill: var(--jp-text-editor-icon-color, var(--jp-inverse-layout-color3));
}

.jp-inspector-icon-color[fill] {
fill: var(--jp-inspector-icon-color, var(--jp-inverse-layout-color3));
}

/_ CSS for icons in selected filebrowser listing items _/
.jp-DirListing-item.jp-mod-selected .jp-icon-selectable[fill] {
fill: #fff;
}

.jp-DirListing-item.jp-mod-selected .jp-icon-selectable-inverse[fill] {
fill: var(--jp-brand-color1);
}

/_ stylelint-disable selector-max-class, selector-max-compound-selectors _/

/\*\*

- TODO: come up with non css-hack solution for showing the busy icon on top
- of the close icon
- CSS for complex behavior of close icon of tabs in the main area tabbar
  \*/
  .lm-DockPanel-tabBar
  .lm-TabBar-tab.lm-mod-closable.jp-mod-dirty
  > .lm-TabBar-tabCloseIcon
  > :not(:hover)
  > .jp-icon3[fill] {
  > fill: none;
  > }

.lm-DockPanel-tabBar
.lm-TabBar-tab.lm-mod-closable.jp-mod-dirty

> .lm-TabBar-tabCloseIcon
> :not(:hover)
> .jp-icon-busy[fill] {
> fill: var(--jp-inverse-layout-color3);
> }

/_ stylelint-enable selector-max-class, selector-max-compound-selectors _/

/_ CSS for icons in status bar _/
#jp-main-statusbar .jp-mod-selected .jp-icon-selectable[fill] {
fill: #fff;
}

#jp-main-statusbar .jp-mod-selected .jp-icon-selectable-inverse[fill] {
fill: var(--jp-brand-color1);
}

/_ special handling for splash icon CSS. While the theme CSS reloads during
splash, the splash icon can loose theming. To prevent that, we set a
default for its color variable _/
:root {
--jp-warn-color0: var(--md-orange-700);
}

/_ not sure what to do with this one, used in filebrowser listing _/
.jp-DragIcon {
margin-right: 4px;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/\*\*

- Support for alt colors for icons as inline SVG HTMLElements
  \*/

/_ alt recolor the primary elements of an icon _/
.jp-icon-alt .jp-icon0[fill] {
fill: var(--jp-layout-color0);
}

.jp-icon-alt .jp-icon1[fill] {
fill: var(--jp-layout-color1);
}

.jp-icon-alt .jp-icon2[fill] {
fill: var(--jp-layout-color2);
}

.jp-icon-alt .jp-icon3[fill] {
fill: var(--jp-layout-color3);
}

.jp-icon-alt .jp-icon4[fill] {
fill: var(--jp-layout-color4);
}

.jp-icon-alt .jp-icon0[stroke] {
stroke: var(--jp-layout-color0);
}

.jp-icon-alt .jp-icon1[stroke] {
stroke: var(--jp-layout-color1);
}

.jp-icon-alt .jp-icon2[stroke] {
stroke: var(--jp-layout-color2);
}

.jp-icon-alt .jp-icon3[stroke] {
stroke: var(--jp-layout-color3);
}

.jp-icon-alt .jp-icon4[stroke] {
stroke: var(--jp-layout-color4);
}

/_ alt recolor the accent elements of an icon _/
.jp-icon-alt .jp-icon-accent0[fill] {
fill: var(--jp-inverse-layout-color0);
}

.jp-icon-alt .jp-icon-accent1[fill] {
fill: var(--jp-inverse-layout-color1);
}

.jp-icon-alt .jp-icon-accent2[fill] {
fill: var(--jp-inverse-layout-color2);
}

.jp-icon-alt .jp-icon-accent3[fill] {
fill: var(--jp-inverse-layout-color3);
}

.jp-icon-alt .jp-icon-accent4[fill] {
fill: var(--jp-inverse-layout-color4);
}

.jp-icon-alt .jp-icon-accent0[stroke] {
stroke: var(--jp-inverse-layout-color0);
}

.jp-icon-alt .jp-icon-accent1[stroke] {
stroke: var(--jp-inverse-layout-color1);
}

.jp-icon-alt .jp-icon-accent2[stroke] {
stroke: var(--jp-inverse-layout-color2);
}

.jp-icon-alt .jp-icon-accent3[stroke] {
stroke: var(--jp-inverse-layout-color3);
}

.jp-icon-alt .jp-icon-accent4[stroke] {
stroke: var(--jp-inverse-layout-color4);
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-icon-hoverShow:not(:hover) .jp-icon-hoverShow-content {
display: none !important;
}

/\*\*

- Support for hover colors for icons as inline SVG HTMLElements
  \*/

/\*\*

- regular colors
  \*/

/_ recolor the primary elements of an icon _/
.jp-icon-hover :hover .jp-icon0-hover[fill] {
fill: var(--jp-inverse-layout-color0);
}

.jp-icon-hover :hover .jp-icon1-hover[fill] {
fill: var(--jp-inverse-layout-color1);
}

.jp-icon-hover :hover .jp-icon2-hover[fill] {
fill: var(--jp-inverse-layout-color2);
}

.jp-icon-hover :hover .jp-icon3-hover[fill] {
fill: var(--jp-inverse-layout-color3);
}

.jp-icon-hover :hover .jp-icon4-hover[fill] {
fill: var(--jp-inverse-layout-color4);
}

.jp-icon-hover :hover .jp-icon0-hover[stroke] {
stroke: var(--jp-inverse-layout-color0);
}

.jp-icon-hover :hover .jp-icon1-hover[stroke] {
stroke: var(--jp-inverse-layout-color1);
}

.jp-icon-hover :hover .jp-icon2-hover[stroke] {
stroke: var(--jp-inverse-layout-color2);
}

.jp-icon-hover :hover .jp-icon3-hover[stroke] {
stroke: var(--jp-inverse-layout-color3);
}

.jp-icon-hover :hover .jp-icon4-hover[stroke] {
stroke: var(--jp-inverse-layout-color4);
}

/_ recolor the accent elements of an icon _/
.jp-icon-hover :hover .jp-icon-accent0-hover[fill] {
fill: var(--jp-layout-color0);
}

.jp-icon-hover :hover .jp-icon-accent1-hover[fill] {
fill: var(--jp-layout-color1);
}

.jp-icon-hover :hover .jp-icon-accent2-hover[fill] {
fill: var(--jp-layout-color2);
}

.jp-icon-hover :hover .jp-icon-accent3-hover[fill] {
fill: var(--jp-layout-color3);
}

.jp-icon-hover :hover .jp-icon-accent4-hover[fill] {
fill: var(--jp-layout-color4);
}

.jp-icon-hover :hover .jp-icon-accent0-hover[stroke] {
stroke: var(--jp-layout-color0);
}

.jp-icon-hover :hover .jp-icon-accent1-hover[stroke] {
stroke: var(--jp-layout-color1);
}

.jp-icon-hover :hover .jp-icon-accent2-hover[stroke] {
stroke: var(--jp-layout-color2);
}

.jp-icon-hover :hover .jp-icon-accent3-hover[stroke] {
stroke: var(--jp-layout-color3);
}

.jp-icon-hover :hover .jp-icon-accent4-hover[stroke] {
stroke: var(--jp-layout-color4);
}

/_ set the color of an icon to transparent _/
.jp-icon-hover :hover .jp-icon-none-hover[fill] {
fill: none;
}

.jp-icon-hover :hover .jp-icon-none-hover[stroke] {
stroke: none;
}

/\*\*

- inverse colors
  \*/

/_ inverse recolor the primary elements of an icon _/
.jp-icon-hover.jp-icon-alt :hover .jp-icon0-hover[fill] {
fill: var(--jp-layout-color0);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon1-hover[fill] {
fill: var(--jp-layout-color1);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon2-hover[fill] {
fill: var(--jp-layout-color2);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon3-hover[fill] {
fill: var(--jp-layout-color3);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon4-hover[fill] {
fill: var(--jp-layout-color4);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon0-hover[stroke] {
stroke: var(--jp-layout-color0);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon1-hover[stroke] {
stroke: var(--jp-layout-color1);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon2-hover[stroke] {
stroke: var(--jp-layout-color2);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon3-hover[stroke] {
stroke: var(--jp-layout-color3);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon4-hover[stroke] {
stroke: var(--jp-layout-color4);
}

/_ inverse recolor the accent elements of an icon _/
.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent0-hover[fill] {
fill: var(--jp-inverse-layout-color0);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent1-hover[fill] {
fill: var(--jp-inverse-layout-color1);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent2-hover[fill] {
fill: var(--jp-inverse-layout-color2);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent3-hover[fill] {
fill: var(--jp-inverse-layout-color3);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent4-hover[fill] {
fill: var(--jp-inverse-layout-color4);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent0-hover[stroke] {
stroke: var(--jp-inverse-layout-color0);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent1-hover[stroke] {
stroke: var(--jp-inverse-layout-color1);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent2-hover[stroke] {
stroke: var(--jp-inverse-layout-color2);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent3-hover[stroke] {
stroke: var(--jp-inverse-layout-color3);
}

.jp-icon-hover.jp-icon-alt :hover .jp-icon-accent4-hover[stroke] {
stroke: var(--jp-inverse-layout-color4);
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-IFrame {
width: 100%;
height: 100%;
}

.jp-IFrame > iframe {
border: none;
}

/_
When drag events occur, `lm-mod-override-cursor` is added to the body.
Because iframes steal all cursor events, the following two rules are necessary
to suppress pointer events while resize drags are occurring. There may be a
better solution to this problem.
_/
body.lm-mod-override-cursor .jp-IFrame {
position: relative;
}

body.lm-mod-override-cursor .jp-IFrame::before {
content: '';
position: absolute;
top: 0;
left: 0;
right: 0;
bottom: 0;
background: transparent;
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2016, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-HoverBox {
position: fixed;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-FormGroup-content fieldset {
border: none;
padding: 0;
min-width: 0;
width: 100%;
}

/_ stylelint-disable selector-max-type _/

.jp-FormGroup-content fieldset .jp-inputFieldWrapper input,
.jp-FormGroup-content fieldset .jp-inputFieldWrapper select,
.jp-FormGroup-content fieldset .jp-inputFieldWrapper textarea {
font-size: var(--jp-content-font-size2);
border-color: var(--jp-input-border-color);
border-style: solid;
border-radius: var(--jp-border-radius);
border-width: 1px;
padding: 6px 8px;
background: none;
color: var(--jp-ui-font-color0);
height: inherit;
}

.jp-FormGroup-content fieldset input[type='checkbox'] {
position: relative;
top: 2px;
margin-left: 0;
}

.jp-FormGroup-content button.jp-mod-styled {
cursor: pointer;
}

.jp-FormGroup-content .checkbox label {
cursor: pointer;
font-size: var(--jp-content-font-size1);
}

.jp-FormGroup-content .jp-root > fieldset > legend {
display: none;
}

.jp-FormGroup-content .jp-root > fieldset > p {
display: none;
}

/\*_ copy of `input.jp-mod-styled:focus` style _/
.jp-FormGroup-content fieldset input:focus,
.jp-FormGroup-content fieldset select:focus {
-moz-outline-radius: unset;
outline: var(--jp-border-width) solid var(--md-blue-500);
outline-offset: -1px;
box-shadow: inset 0 0 4px var(--md-blue-300);
}

.jp-FormGroup-content fieldset input:hover:not(:focus),
.jp-FormGroup-content fieldset select:hover:not(:focus) {
background-color: var(--jp-border-color2);
}

/_ stylelint-enable selector-max-type _/

.jp-FormGroup-content .checkbox .field-description {
/_ Disable default description field for checkbox:
because other widgets do not have description fields,
we add descriptions to each widget on the field level.
_/
display: none;
}

.jp-FormGroup-content #root\_\_description {
display: none;
}

.jp-FormGroup-content .jp-modifiedIndicator {
width: 5px;
background-color: var(--jp-brand-color2);
margin-top: 0;
margin-left: calc(var(--jp-private-settingeditor-modifier-indent) \* -1);
flex-shrink: 0;
}

.jp-FormGroup-content .jp-modifiedIndicator.jp-errorIndicator {
background-color: var(--jp-error-color0);
margin-right: 0.5em;
}

/_ RJSF ARRAY style _/

.jp-arrayFieldWrapper legend {
font-size: var(--jp-content-font-size2);
color: var(--jp-ui-font-color0);
flex-basis: 100%;
padding: 4px 0;
font-weight: var(--jp-content-heading-font-weight);
border-bottom: 1px solid var(--jp-border-color2);
}

.jp-arrayFieldWrapper .field-description {
padding: 4px 0;
white-space: pre-wrap;
}

.jp-arrayFieldWrapper .array-item {
width: 100%;
border: 1px solid var(--jp-border-color2);
border-radius: 4px;
margin: 4px;
}

.jp-ArrayOperations {
display: flex;
margin-left: 8px;
}

.jp-ArrayOperationsButton {
margin: 2px;
}

.jp-ArrayOperationsButton .jp-icon3[fill] {
fill: var(--jp-ui-font-color0);
}

button.jp-ArrayOperationsButton.jp-mod-styled:disabled {
cursor: not-allowed;
opacity: 0.5;
}

/_ RJSF form validation error _/

.jp-FormGroup-content .validationErrors {
color: var(--jp-error-color0);
}

/_ Hide panel level error as duplicated the field level error _/
.jp-FormGroup-content .panel.errors {
display: none;
}

/_ RJSF normal content (settings-editor) _/

.jp-FormGroup-contentNormal {
display: flex;
align-items: center;
flex-wrap: wrap;
}

.jp-FormGroup-contentNormal .jp-FormGroup-contentItem {
margin-left: 7px;
color: var(--jp-ui-font-color0);
}

.jp-FormGroup-contentNormal .jp-FormGroup-description {
flex-basis: 100%;
padding: 4px 7px;
}

.jp-FormGroup-contentNormal .jp-FormGroup-default {
flex-basis: 100%;
padding: 4px 7px;
}

.jp-FormGroup-contentNormal .jp-FormGroup-fieldLabel {
font-size: var(--jp-content-font-size1);
font-weight: normal;
min-width: 120px;
}

.jp-FormGroup-contentNormal fieldset:not(:first-child) {
margin-left: 7px;
}

.jp-FormGroup-contentNormal .field-array-of-string .array-item {
/_ Display `jp-ArrayOperations` buttons side-by-side with content except
for small screens where flex-wrap will place them one below the other.
_/
display: flex;
align-items: center;
flex-wrap: wrap;
}

.jp-FormGroup-contentNormal .jp-objectFieldWrapper .form-group {
padding: 2px 8px 2px var(--jp-private-settingeditor-modifier-indent);
margin-top: 2px;
}

/_ RJSF compact content (metadata-form) _/

.jp-FormGroup-content.jp-FormGroup-contentCompact {
width: 100%;
}

.jp-FormGroup-contentCompact .form-group {
display: flex;
padding: 0.5em 0.2em 0.5em 0;
}

.jp-FormGroup-contentCompact
.jp-FormGroup-compactTitle
.jp-FormGroup-description {
font-size: var(--jp-ui-font-size1);
color: var(--jp-ui-font-color2);
}

.jp-FormGroup-contentCompact .jp-FormGroup-fieldLabel {
padding-bottom: 0.3em;
}

.jp-FormGroup-contentCompact .jp-inputFieldWrapper .form-control {
width: 100%;
box-sizing: border-box;
}

.jp-FormGroup-contentCompact .jp-arrayFieldWrapper .jp-FormGroup-compactTitle {
padding-bottom: 7px;
}

.jp-FormGroup-contentCompact
.jp-objectFieldWrapper
.jp-objectFieldWrapper
.form-group {
padding: 2px 8px 2px var(--jp-private-settingeditor-modifier-indent);
margin-top: 2px;
}

.jp-FormGroup-contentCompact ul.error-detail {
margin-block-start: 0.5em;
margin-block-end: 0.5em;
padding-inline-start: 1em;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

.jp-SidePanel {
display: flex;
flex-direction: column;
min-width: var(--jp-sidebar-min-width);
overflow-y: auto;
color: var(--jp-ui-font-color1);
background: var(--jp-layout-color1);
font-size: var(--jp-ui-font-size1);
}

.jp-SidePanel-header {
flex: 0 0 auto;
display: flex;
border-bottom: var(--jp-border-width) solid var(--jp-border-color2);
font-size: var(--jp-ui-font-size0);
font-weight: 600;
letter-spacing: 1px;
margin: 0;
padding: 2px;
text-transform: uppercase;
}

.jp-SidePanel-toolbar {
flex: 0 0 auto;
}

.jp-SidePanel-content {
flex: 1 1 auto;
}

.jp-SidePanel-toolbar,
.jp-AccordionPanel-toolbar {
height: var(--jp-private-toolbar-height);
}

.jp-SidePanel-toolbar.jp-Toolbar-micro {
display: none;
}

.lm-AccordionPanel .jp-AccordionPanel-title {
box-sizing: border-box;
line-height: 25px;
margin: 0;
display: flex;
align-items: center;
background: var(--jp-layout-color1);
color: var(--jp-ui-font-color1);
border-bottom: var(--jp-border-width) solid var(--jp-toolbar-border-color);
box-shadow: var(--jp-toolbar-box-shadow);
font-size: var(--jp-ui-font-size0);
}

.jp-AccordionPanel-title {
cursor: pointer;
user-select: none;
-moz-user-select: none;
-webkit-user-select: none;
text-transform: uppercase;
}

.lm-AccordionPanel[data-orientation='horizontal'] > .jp-AccordionPanel-title {
/_ Title is rotated for horizontal accordion panel using CSS _/
display: block;
transform-origin: top left;
transform: rotate(-90deg) translate(-100%);
}

.jp-AccordionPanel-title .lm-AccordionPanel-titleLabel {
user-select: none;
text-overflow: ellipsis;
white-space: nowrap;
overflow: hidden;
}

.jp-AccordionPanel-title .lm-AccordionPanel-titleCollapser {
transform: rotate(-90deg);
margin: auto 0;
height: 16px;
}

.jp-AccordionPanel-title.lm-mod-expanded .lm-AccordionPanel-titleCollapser {
transform: rotate(0deg);
}

.lm-AccordionPanel .jp-AccordionPanel-toolbar {
background: none;
box-shadow: none;
border: none;
margin-left: auto;
}

.lm-AccordionPanel .lm-SplitPanel-handle:hover {
background: var(--jp-layout-color3);
}

.jp-text-truncated {
overflow: hidden;
text-overflow: ellipsis;
white-space: nowrap;
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2017, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-Spinner {
position: absolute;
display: flex;
justify-content: center;
align-items: center;
z-index: 10;
left: 0;
top: 0;
width: 100%;
height: 100%;
background: var(--jp-layout-color0);
outline: none;
}

.jp-SpinnerContent {
font-size: 10px;
margin: 50px auto;
text-indent: -9999em;
width: 3em;
height: 3em;
border-radius: 50%;
background: var(--jp-brand-color3);
background: linear-gradient(
to right,
#f37626 10%,
rgba(255, 255, 255, 0) 42%
);
position: relative;
animation: load3 1s infinite linear, fadeIn 1s;
}

.jp-SpinnerContent::before {
width: 50%;
height: 50%;
background: #f37626;
border-radius: 100% 0 0;
position: absolute;
top: 0;
left: 0;
content: '';
}

.jp-SpinnerContent::after {
background: var(--jp-layout-color0);
width: 75%;
height: 75%;
border-radius: 50%;
content: '';
margin: auto;
position: absolute;
top: 0;
left: 0;
bottom: 0;
right: 0;
}

@keyframes fadeIn {
0% {
opacity: 0;
}

100% {
opacity: 1;
}
}

@keyframes load3 {
0% {
transform: rotate(0deg);
}

100% {
transform: rotate(360deg);
}
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2017, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

button.jp-mod-styled {
font-size: var(--jp-ui-font-size1);
color: var(--jp-ui-font-color0);
border: none;
box-sizing: border-box;
text-align: center;
line-height: 32px;
height: 32px;
padding: 0 12px;
letter-spacing: 0.8px;
outline: none;
appearance: none;
-webkit-appearance: none;
-moz-appearance: none;
}

input.jp-mod-styled {
background: var(--jp-input-background);
height: 28px;
box-sizing: border-box;
border: var(--jp-border-width) solid var(--jp-border-color1);
padding-left: 7px;
padding-right: 7px;
font-size: var(--jp-ui-font-size2);
color: var(--jp-ui-font-color0);
outline: none;
appearance: none;
-webkit-appearance: none;
-moz-appearance: none;
}

input[type='checkbox'].jp-mod-styled {
appearance: checkbox;
-webkit-appearance: checkbox;
-moz-appearance: checkbox;
height: auto;
}

input.jp-mod-styled:focus {
border: var(--jp-border-width) solid var(--md-blue-500);
box-shadow: inset 0 0 4px var(--md-blue-300);
}

.jp-select-wrapper {
display: flex;
position: relative;
flex-direction: column;
padding: 1px;
background-color: var(--jp-layout-color1);
box-sizing: border-box;
margin-bottom: 12px;
}

.jp-select-wrapper:not(.multiple) {
height: 28px;
}

.jp-select-wrapper.jp-mod-focused select.jp-mod-styled {
border: var(--jp-border-width) solid var(--jp-input-active-border-color);
box-shadow: var(--jp-input-box-shadow);
background-color: var(--jp-input-active-background);
}

select.jp-mod-styled:hover {
cursor: pointer;
color: var(--jp-ui-font-color0);
background-color: var(--jp-input-hover-background);
box-shadow: inset 0 0 1px rgba(0, 0, 0, 0.5);
}

select.jp-mod-styled {
flex: 1 1 auto;
width: 100%;
font-size: var(--jp-ui-font-size2);
background: var(--jp-input-background);
color: var(--jp-ui-font-color0);
padding: 0 25px 0 8px;
border: var(--jp-border-width) solid var(--jp-input-border-color);
border-radius: 0;
outline: none;
appearance: none;
-webkit-appearance: none;
-moz-appearance: none;
}

select.jp-mod-styled:not([multiple]) {
height: 32px;
}

select.jp-mod-styled[multiple] {
max-height: 200px;
overflow-y: auto;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-switch {
display: flex;
align-items: center;
padding-left: 4px;
padding-right: 4px;
font-size: var(--jp-ui-font-size1);
background-color: transparent;
color: var(--jp-ui-font-color1);
border: none;
height: 20px;
}

.jp-switch:hover {
background-color: var(--jp-layout-color2);
}

.jp-switch-label {
margin-right: 5px;
font-family: var(--jp-ui-font-family);
}

.jp-switch-track {
cursor: pointer;
background-color: var(--jp-switch-color, var(--jp-border-color1));
-webkit-transition: 0.4s;
transition: 0.4s;
border-radius: 34px;
height: 16px;
width: 35px;
position: relative;
}

.jp-switch-track::before {
content: '';
position: absolute;
height: 10px;
width: 10px;
margin: 3px;
left: 0;
background-color: var(--jp-ui-inverse-font-color1);
-webkit-transition: 0.4s;
transition: 0.4s;
border-radius: 50%;
}

.jp-switch[aria-checked='true'] .jp-switch-track {
background-color: var(--jp-switch-true-position-color, var(--jp-warn-color0));
}

.jp-switch[aria-checked='true'] .jp-switch-track::before {
/_ track width (35) - margins (3 + 3) - thumb width (10) _/
left: 19px;
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2016, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

:root {
--jp-private-toolbar-height: calc(
28px + var(--jp-border-width)
); /_ leave 28px for content _/
}

.jp-Toolbar {
color: var(--jp-ui-font-color1);
flex: 0 0 auto;
display: flex;
flex-direction: row;
border-bottom: var(--jp-border-width) solid var(--jp-toolbar-border-color);
box-shadow: var(--jp-toolbar-box-shadow);
background: var(--jp-toolbar-background);
min-height: var(--jp-toolbar-micro-height);
padding: 2px;
z-index: 8;
overflow-x: hidden;
}

/_ Toolbar items _/

.jp-Toolbar > .jp-Toolbar-item.jp-Toolbar-spacer {
flex-grow: 1;
flex-shrink: 1;
}

.jp-Toolbar-item.jp-Toolbar-kernelStatus {
display: inline-block;
width: 32px;
background-repeat: no-repeat;
background-position: center;
background-size: 16px;
}

.jp-Toolbar > .jp-Toolbar-item {
flex: 0 0 auto;
display: flex;
padding-left: 1px;
padding-right: 1px;
font-size: var(--jp-ui-font-size1);
line-height: var(--jp-private-toolbar-height);
height: 100%;
}

/_ Toolbar buttons _/

/_ This is the div we use to wrap the react component into a Widget _/
div.jp-ToolbarButton {
color: transparent;
border: none;
box-sizing: border-box;
outline: none;
appearance: none;
-webkit-appearance: none;
-moz-appearance: none;
padding: 0;
margin: 0;
}

button.jp-ToolbarButtonComponent {
background: var(--jp-layout-color1);
border: none;
box-sizing: border-box;
outline: none;
appearance: none;
-webkit-appearance: none;
-moz-appearance: none;
padding: 0 6px;
margin: 0;
height: 24px;
border-radius: var(--jp-border-radius);
display: flex;
align-items: center;
text-align: center;
font-size: 14px;
min-width: unset;
min-height: unset;
}

button.jp-ToolbarButtonComponent:disabled {
opacity: 0.4;
}

button.jp-ToolbarButtonComponent > span {
padding: 0;
flex: 0 0 auto;
}

button.jp-ToolbarButtonComponent .jp-ToolbarButtonComponent-label {
font-size: var(--jp-ui-font-size1);
line-height: 100%;
padding-left: 2px;
color: var(--jp-ui-font-color1);
font-family: var(--jp-ui-font-family);
}

#jp-main-dock-panel[data-mode='single-document']
.jp-MainAreaWidget

> .jp-Toolbar.jp-Toolbar-micro {
> padding: 0;
> min-height: 0;
> }

#jp-main-dock-panel[data-mode='single-document']
.jp-MainAreaWidget

> .jp-Toolbar {
> border: none;
> box-shadow: none;
> }

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

.jp-WindowedPanel-outer {
position: relative;
overflow-y: auto;
}

.jp-WindowedPanel-inner {
position: relative;
}

.jp-WindowedPanel-window {
position: absolute;
left: 0;
right: 0;
overflow: visible;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_ Sibling imports _/

body {
color: var(--jp-ui-font-color1);
font-size: var(--jp-ui-font-size1);
}

/_ Disable native link decoration styles everywhere outside of dialog boxes _/
a {
text-decoration: unset;
color: unset;
}

a:hover {
text-decoration: unset;
color: unset;
}

/_ Accessibility for links inside dialog box text _/
.jp-Dialog-content a {
text-decoration: revert;
color: var(--jp-content-link-color);
}

.jp-Dialog-content a:hover {
text-decoration: revert;
}

/_ Styles for ui-components _/
.jp-Button {
color: var(--jp-ui-font-color2);
border-radius: var(--jp-border-radius);
padding: 0 12px;
font-size: var(--jp-ui-font-size1);

/_ Copy from blueprint 3 _/
display: inline-flex;
flex-direction: row;
border: none;
cursor: pointer;
align-items: center;
justify-content: center;
text-align: left;
vertical-align: middle;
min-height: 30px;
min-width: 30px;
}

.jp-Button:disabled {
cursor: not-allowed;
}

.jp-Button:empty {
padding: 0 !important;
}

.jp-Button.jp-mod-small {
min-height: 24px;
min-width: 24px;
font-size: 12px;
padding: 0 7px;
}

/_ Use our own theme for hover styles _/
.jp-Button.jp-mod-minimal:hover {
background-color: var(--jp-layout-color2);
}

.jp-Button.jp-mod-minimal {
background: none;
}

.jp-InputGroup {
display: block;
position: relative;
}

.jp-InputGroup input {
box-sizing: border-box;
border: none;
border-radius: 0;
background-color: transparent;
color: var(--jp-ui-font-color0);
box-shadow: inset 0 0 0 var(--jp-border-width) var(--jp-input-border-color);
padding-bottom: 0;
padding-top: 0;
padding-left: 10px;
padding-right: 28px;
position: relative;
width: 100%;
-webkit-appearance: none;
-moz-appearance: none;
appearance: none;
font-size: 14px;
font-weight: 400;
height: 30px;
line-height: 30px;
outline: none;
vertical-align: middle;
}

.jp-InputGroup input:focus {
box-shadow: inset 0 0 0 var(--jp-border-width)
var(--jp-input-active-box-shadow-color),
inset 0 0 0 3px var(--jp-input-active-box-shadow-color);
}

.jp-InputGroup input:disabled {
cursor: not-allowed;
resize: block;
background-color: var(--jp-layout-color2);
color: var(--jp-ui-font-color2);
}

.jp-InputGroup input:disabled ~ span {
cursor: not-allowed;
color: var(--jp-ui-font-color2);
}

.jp-InputGroup input::placeholder,
input::placeholder {
color: var(--jp-ui-font-color2);
}

.jp-InputGroupAction {
position: absolute;
bottom: 1px;
right: 0;
padding: 6px;
}

.jp-HTMLSelect.jp-DefaultStyle select {
background-color: initial;
border: none;
border-radius: 0;
box-shadow: none;
color: var(--jp-ui-font-color0);
display: block;
font-size: var(--jp-ui-font-size1);
font-family: var(--jp-ui-font-family);
height: 24px;
line-height: 14px;
padding: 0 25px 0 10px;
text-align: left;
-moz-appearance: none;
-webkit-appearance: none;
}

.jp-HTMLSelect.jp-DefaultStyle select:disabled {
background-color: var(--jp-layout-color2);
color: var(--jp-ui-font-color2);
cursor: not-allowed;
resize: block;
}

.jp-HTMLSelect.jp-DefaultStyle select:disabled ~ span {
cursor: not-allowed;
}

/_ Use our own theme for hover and option styles _/
/_ stylelint-disable-next-line selector-max-type _/
.jp-HTMLSelect.jp-DefaultStyle select:hover,
.jp-HTMLSelect.jp-DefaultStyle select > option {
background-color: var(--jp-layout-color2);
color: var(--jp-ui-font-color0);
}

select {
box-sizing: border-box;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Styles
|----------------------------------------------------------------------------_/

.jp-StatusBar-Widget {
display: flex;
align-items: center;
background: var(--jp-layout-color2);
min-height: var(--jp-statusbar-height);
justify-content: space-between;
padding: 0 10px;
}

.jp-StatusBar-Left {
display: flex;
align-items: center;
flex-direction: row;
}

.jp-StatusBar-Middle {
display: flex;
align-items: center;
}

.jp-StatusBar-Right {
display: flex;
align-items: center;
flex-direction: row-reverse;
}

.jp-StatusBar-Item {
max-height: var(--jp-statusbar-height);
margin: 0 2px;
height: var(--jp-statusbar-height);
white-space: nowrap;
text-overflow: ellipsis;
color: var(--jp-ui-font-color1);
padding: 0 6px;
}

.jp-mod-highlighted:hover {
background-color: var(--jp-layout-color3);
}

.jp-mod-clicked {
background-color: var(--jp-brand-color1);
}

.jp-mod-clicked:hover {
background-color: var(--jp-brand-color0);
}

.jp-mod-clicked .jp-StatusBar-TextItem {
color: var(--jp-ui-inverse-font-color1);
}

.jp-StatusBar-HoverItem {
box-shadow: '0px 4px 4px rgba(0, 0, 0, 0.25)';
}

.jp-StatusBar-TextItem {
font-size: var(--jp-ui-font-size1);
font-family: var(--jp-ui-font-family);
line-height: 24px;
color: var(--jp-ui-font-color1);
}

.jp-StatusBar-GroupItem {
display: flex;
align-items: center;
flex-direction: row;
}

.jp-Statusbar-ProgressCircle svg {
display: block;
margin: 0 auto;
width: 16px;
height: 24px;
align-self: normal;
}

.jp-Statusbar-ProgressCircle path {
fill: var(--jp-inverse-layout-color3);
}

.jp-Statusbar-ProgressBar-progress-bar {
height: 10px;
width: 100px;
border: solid 0.25px var(--jp-brand-color2);
border-radius: 3px;
overflow: hidden;
align-self: center;
}

.jp-Statusbar-ProgressBar-progress-bar > div {
background-color: var(--jp-brand-color2);
background-image: linear-gradient(
-45deg,
rgba(255, 255, 255, 0.2) 25%,
transparent 25%,
transparent 50%,
rgba(255, 255, 255, 0.2) 50%,
rgba(255, 255, 255, 0.2) 75%,
transparent 75%,
transparent
);
background-size: 40px 40px;
float: left;
width: 0%;
height: 100%;
font-size: 12px;
line-height: 14px;
color: #fff;
text-align: center;
animation: jp-Statusbar-ExecutionTime-progress-bar 2s linear infinite;
}

.jp-Statusbar-ProgressBar-progress-bar p {
color: var(--jp-ui-font-color1);
font-family: var(--jp-ui-font-family);
font-size: var(--jp-ui-font-size1);
line-height: 10px;
width: 100px;
}

@keyframes jp-Statusbar-ExecutionTime-progress-bar {
0% {
background-position: 0 0;
}

100% {
background-position: 40px 40px;
}
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Variables
|----------------------------------------------------------------------------_/

:root {
--jp-private-commandpalette-search-height: 28px;
}

/_-----------------------------------------------------------------------------
| Overall styles
|----------------------------------------------------------------------------_/

.lm-CommandPalette {
padding-bottom: 0;
color: var(--jp-ui-font-color1);
background: var(--jp-layout-color1);

/\* This is needed so that all font sizing of children done in ems is

- relative to this base size \*/
  font-size: var(--jp-ui-font-size1);
  }

/_-----------------------------------------------------------------------------
| Modal variant
|----------------------------------------------------------------------------_/

.jp-ModalCommandPalette {
position: absolute;
z-index: 10000;
top: 38px;
left: 30%;
margin: 0;
padding: 4px;
width: 40%;
box-shadow: var(--jp-elevation-z4);
border-radius: 4px;
background: var(--jp-layout-color0);
}

.jp-ModalCommandPalette .lm-CommandPalette {
max-height: 40vh;
}

.jp-ModalCommandPalette .lm-CommandPalette .lm-close-icon::after {
display: none;
}

.jp-ModalCommandPalette .lm-CommandPalette .lm-CommandPalette-header {
display: none;
}

.jp-ModalCommandPalette .lm-CommandPalette .lm-CommandPalette-item {
margin-left: 4px;
margin-right: 4px;
}

.jp-ModalCommandPalette
.lm-CommandPalette
.lm-CommandPalette-item.lm-mod-disabled {
display: none;
}

/_-----------------------------------------------------------------------------
| Search
|----------------------------------------------------------------------------_/

.lm-CommandPalette-search {
padding: 4px;
background-color: var(--jp-layout-color1);
z-index: 2;
}

.lm-CommandPalette-wrapper {
overflow: overlay;
padding: 0 9px;
background-color: var(--jp-input-active-background);
height: 30px;
box-shadow: inset 0 0 0 var(--jp-border-width) var(--jp-input-border-color);
}

.lm-CommandPalette.lm-mod-focused .lm-CommandPalette-wrapper {
box-shadow: inset 0 0 0 1px var(--jp-input-active-box-shadow-color),
inset 0 0 0 3px var(--jp-input-active-box-shadow-color);
}

.jp-SearchIconGroup {
color: white;
background-color: var(--jp-brand-color1);
position: absolute;
top: 4px;
right: 4px;
padding: 5px 5px 1px;
}

.jp-SearchIconGroup svg {
height: 20px;
width: 20px;
}

.jp-SearchIconGroup .jp-icon3[fill] {
fill: var(--jp-layout-color0);
}

.lm-CommandPalette-input {
background: transparent;
width: calc(100% - 18px);
float: left;
border: none;
outline: none;
font-size: var(--jp-ui-font-size1);
color: var(--jp-ui-font-color0);
line-height: var(--jp-private-commandpalette-search-height);
}

.lm-CommandPalette-input::-webkit-input-placeholder,
.lm-CommandPalette-input::-moz-placeholder,
.lm-CommandPalette-input:-ms-input-placeholder {
color: var(--jp-ui-font-color2);
font-size: var(--jp-ui-font-size1);
}

/_-----------------------------------------------------------------------------
| Results
|----------------------------------------------------------------------------_/

.lm-CommandPalette-header:first-child {
margin-top: 0;
}

.lm-CommandPalette-header {
border-bottom: solid var(--jp-border-width) var(--jp-border-color2);
color: var(--jp-ui-font-color1);
cursor: pointer;
display: flex;
font-size: var(--jp-ui-font-size0);
font-weight: 600;
letter-spacing: 1px;
margin-top: 8px;
padding: 8px 0 8px 12px;
text-transform: uppercase;
}

.lm-CommandPalette-header.lm-mod-active {
background: var(--jp-layout-color2);
}

.lm-CommandPalette-header > mark {
background-color: transparent;
font-weight: bold;
color: var(--jp-ui-font-color1);
}

.lm-CommandPalette-item {
padding: 4px 12px 4px 4px;
color: var(--jp-ui-font-color1);
font-size: var(--jp-ui-font-size1);
font-weight: 400;
display: flex;
}

.lm-CommandPalette-item.lm-mod-disabled {
color: var(--jp-ui-font-color2);
}

.lm-CommandPalette-item.lm-mod-active {
color: var(--jp-ui-inverse-font-color1);
background: var(--jp-brand-color1);
}

.lm-CommandPalette-item.lm-mod-active .lm-CommandPalette-itemLabel > mark {
color: var(--jp-ui-inverse-font-color0);
}

.lm-CommandPalette-item.lm-mod-active .jp-icon-selectable[fill] {
fill: var(--jp-layout-color0);
}

.lm-CommandPalette-item.lm-mod-active:hover:not(.lm-mod-disabled) {
color: var(--jp-ui-inverse-font-color1);
background: var(--jp-brand-color1);
}

.lm-CommandPalette-item:hover:not(.lm-mod-active):not(.lm-mod-disabled) {
background: var(--jp-layout-color2);
}

.lm-CommandPalette-itemContent {
overflow: hidden;
}

.lm-CommandPalette-itemLabel > mark {
color: var(--jp-ui-font-color0);
background-color: transparent;
font-weight: bold;
}

.lm-CommandPalette-item.lm-mod-disabled mark {
color: var(--jp-ui-font-color2);
}

.lm-CommandPalette-item .lm-CommandPalette-itemIcon {
margin: 0 4px 0 0;
position: relative;
width: 16px;
top: 2px;
flex: 0 0 auto;
}

.lm-CommandPalette-item.lm-mod-disabled .lm-CommandPalette-itemIcon {
opacity: 0.6;
}

.lm-CommandPalette-item .lm-CommandPalette-itemShortcut {
flex: 0 0 auto;
}

.lm-CommandPalette-itemCaption {
display: none;
}

.lm-CommandPalette-content {
background-color: var(--jp-layout-color1);
}

.lm-CommandPalette-content:empty::after {
content: 'No results';
margin: auto;
margin-top: 20px;
width: 100px;
display: block;
font-size: var(--jp-ui-font-size2);
font-family: var(--jp-ui-font-family);
font-weight: lighter;
}

.lm-CommandPalette-emptyMessage {
text-align: center;
margin-top: 24px;
line-height: 1.32;
padding: 0 8px;
color: var(--jp-content-font-color3);
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2017, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-Dialog {
position: absolute;
z-index: 10000;
display: flex;
flex-direction: column;
align-items: center;
justify-content: center;
top: 0;
left: 0;
margin: 0;
padding: 0;
width: 100%;
height: 100%;
background: var(--jp-dialog-background);
}

.jp-Dialog-content {
display: flex;
flex-direction: column;
margin-left: auto;
margin-right: auto;
background: var(--jp-layout-color1);
padding: 24px 24px 12px;
min-width: 300px;
min-height: 150px;
max-width: 1000px;
max-height: 500px;
box-sizing: border-box;
box-shadow: var(--jp-elevation-z20);
word-wrap: break-word;
border-radius: var(--jp-border-radius);

/\* This is needed so that all font sizing of children done in ems is

- relative to this base size \*/
  font-size: var(--jp-ui-font-size1);
  color: var(--jp-ui-font-color1);
  resize: both;
  }

.jp-Dialog-content.jp-Dialog-content-small {
max-width: 500px;
}

.jp-Dialog-button {
overflow: visible;
}

button.jp-Dialog-button:focus {
outline: 1px solid var(--jp-brand-color1);
outline-offset: 4px;
-moz-outline-radius: 0;
}

button.jp-Dialog-button:focus::-moz-focus-inner {
border: 0;
}

button.jp-Dialog-button.jp-mod-styled.jp-mod-accept:focus,
button.jp-Dialog-button.jp-mod-styled.jp-mod-warn:focus,
button.jp-Dialog-button.jp-mod-styled.jp-mod-reject:focus {
outline-offset: 4px;
-moz-outline-radius: 0;
}

button.jp-Dialog-button.jp-mod-styled.jp-mod-accept:focus {
outline: 1px solid var(--jp-accept-color-normal, var(--jp-brand-color1));
}

button.jp-Dialog-button.jp-mod-styled.jp-mod-warn:focus {
outline: 1px solid var(--jp-warn-color-normal, var(--jp-error-color1));
}

button.jp-Dialog-button.jp-mod-styled.jp-mod-reject:focus {
outline: 1px solid var(--jp-reject-color-normal, var(--md-grey-600));
}

button.jp-Dialog-close-button {
padding: 0;
height: 100%;
min-width: unset;
min-height: unset;
}

.jp-Dialog-header {
display: flex;
justify-content: space-between;
flex: 0 0 auto;
padding-bottom: 12px;
font-size: var(--jp-ui-font-size3);
font-weight: 400;
color: var(--jp-ui-font-color1);
}

.jp-Dialog-body {
display: flex;
flex-direction: column;
flex: 1 1 auto;
font-size: var(--jp-ui-font-size1);
background: var(--jp-layout-color1);
color: var(--jp-ui-font-color1);
overflow: auto;
}

.jp-Dialog-footer {
display: flex;
flex-direction: row;
justify-content: flex-end;
align-items: center;
flex: 0 0 auto;
margin-left: -12px;
margin-right: -12px;
padding: 12px;
}

.jp-Dialog-checkbox {
padding-right: 5px;
}

.jp-Dialog-checkbox > input:focus-visible {
outline: 1px solid var(--jp-input-active-border-color);
outline-offset: 1px;
}

.jp-Dialog-spacer {
flex: 1 1 auto;
}

.jp-Dialog-title {
overflow: hidden;
white-space: nowrap;
text-overflow: ellipsis;
}

.jp-Dialog-body > .jp-select-wrapper {
width: 100%;
}

.jp-Dialog-body > button {
padding: 0 16px;
}

.jp-Dialog-body > label {
line-height: 1.4;
color: var(--jp-ui-font-color0);
}

.jp-Dialog-button.jp-mod-styled:not(:last-child) {
margin-right: 12px;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

.jp-Input-Boolean-Dialog {
flex-direction: row-reverse;
align-items: end;
width: 100%;
}

.jp-Input-Boolean-Dialog > label {
flex: 1 1 auto;
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2016, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-MainAreaWidget > :focus {
outline: none;
}

.jp-MainAreaWidget .jp-MainAreaWidget-error {
padding: 6px;
}

.jp-MainAreaWidget .jp-MainAreaWidget-error > pre {
width: auto;
padding: 10px;
background: var(--jp-error-color3);
border: var(--jp-border-width) solid var(--jp-error-color1);
border-radius: var(--jp-border-radius);
color: var(--jp-ui-font-color1);
font-size: var(--jp-ui-font-size1);
white-space: pre-wrap;
word-wrap: break-word;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/\*\*

- google-material-color v1.2.6
- https://github.com/danlevan/google-material-color
  \*/
  :root {
  --md-red-50: #ffebee;
  --md-red-100: #ffcdd2;
  --md-red-200: #ef9a9a;
  --md-red-300: #e57373;
  --md-red-400: #ef5350;
  --md-red-500: #f44336;
  --md-red-600: #e53935;
  --md-red-700: #d32f2f;
  --md-red-800: #c62828;
  --md-red-900: #b71c1c;
  --md-red-A100: #ff8a80;
  --md-red-A200: #ff5252;
  --md-red-A400: #ff1744;
  --md-red-A700: #d50000;
  --md-pink-50: #fce4ec;
  --md-pink-100: #f8bbd0;
  --md-pink-200: #f48fb1;
  --md-pink-300: #f06292;
  --md-pink-400: #ec407a;
  --md-pink-500: #e91e63;
  --md-pink-600: #d81b60;
  --md-pink-700: #c2185b;
  --md-pink-800: #ad1457;
  --md-pink-900: #880e4f;
  --md-pink-A100: #ff80ab;
  --md-pink-A200: #ff4081;
  --md-pink-A400: #f50057;
  --md-pink-A700: #c51162;
  --md-purple-50: #f3e5f5;
  --md-purple-100: #e1bee7;
  --md-purple-200: #ce93d8;
  --md-purple-300: #ba68c8;
  --md-purple-400: #ab47bc;
  --md-purple-500: #9c27b0;
  --md-purple-600: #8e24aa;
  --md-purple-700: #7b1fa2;
  --md-purple-800: #6a1b9a;
  --md-purple-900: #4a148c;
  --md-purple-A100: #ea80fc;
  --md-purple-A200: #e040fb;
  --md-purple-A400: #d500f9;
  --md-purple-A700: #a0f;
  --md-deep-purple-50: #ede7f6;
  --md-deep-purple-100: #d1c4e9;
  --md-deep-purple-200: #b39ddb;
  --md-deep-purple-300: #9575cd;
  --md-deep-purple-400: #7e57c2;
  --md-deep-purple-500: #673ab7;
  --md-deep-purple-600: #5e35b1;
  --md-deep-purple-700: #512da8;
  --md-deep-purple-800: #4527a0;
  --md-deep-purple-900: #311b92;
  --md-deep-purple-A100: #b388ff;
  --md-deep-purple-A200: #7c4dff;
  --md-deep-purple-A400: #651fff;
  --md-deep-purple-A700: #6200ea;
  --md-indigo-50: #e8eaf6;
  --md-indigo-100: #c5cae9;
  --md-indigo-200: #9fa8da;
  --md-indigo-300: #7986cb;
  --md-indigo-400: #5c6bc0;
  --md-indigo-500: #3f51b5;
  --md-indigo-600: #3949ab;
  --md-indigo-700: #303f9f;
  --md-indigo-800: #283593;
  --md-indigo-900: #1a237e;
  --md-indigo-A100: #8c9eff;
  --md-indigo-A200: #536dfe;
  --md-indigo-A400: #3d5afe;
  --md-indigo-A700: #304ffe;
  --md-blue-50: #e3f2fd;
  --md-blue-100: #bbdefb;
  --md-blue-200: #90caf9;
  --md-blue-300: #64b5f6;
  --md-blue-400: #42a5f5;
  --md-blue-500: #2196f3;
  --md-blue-600: #1e88e5;
  --md-blue-700: #1976d2;
  --md-blue-800: #1565c0;
  --md-blue-900: #0d47a1;
  --md-blue-A100: #82b1ff;
  --md-blue-A200: #448aff;
  --md-blue-A400: #2979ff;
  --md-blue-A700: #2962ff;
  --md-light-blue-50: #e1f5fe;
  --md-light-blue-100: #b3e5fc;
  --md-light-blue-200: #81d4fa;
  --md-light-blue-300: #4fc3f7;
  --md-light-blue-400: #29b6f6;
  --md-light-blue-500: #03a9f4;
  --md-light-blue-600: #039be5;
  --md-light-blue-700: #0288d1;
  --md-light-blue-800: #0277bd;
  --md-light-blue-900: #01579b;
  --md-light-blue-A100: #80d8ff;
  --md-light-blue-A200: #40c4ff;
  --md-light-blue-A400: #00b0ff;
  --md-light-blue-A700: #0091ea;
  --md-cyan-50: #e0f7fa;
  --md-cyan-100: #b2ebf2;
  --md-cyan-200: #80deea;
  --md-cyan-300: #4dd0e1;
  --md-cyan-400: #26c6da;
  --md-cyan-500: #00bcd4;
  --md-cyan-600: #00acc1;
  --md-cyan-700: #0097a7;
  --md-cyan-800: #00838f;
  --md-cyan-900: #006064;
  --md-cyan-A100: #84ffff;
  --md-cyan-A200: #18ffff;
  --md-cyan-A400: #00e5ff;
  --md-cyan-A700: #00b8d4;
  --md-teal-50: #e0f2f1;
  --md-teal-100: #b2dfdb;
  --md-teal-200: #80cbc4;
  --md-teal-300: #4db6ac;
  --md-teal-400: #26a69a;
  --md-teal-500: #009688;
  --md-teal-600: #00897b;
  --md-teal-700: #00796b;
  --md-teal-800: #00695c;
  --md-teal-900: #004d40;
  --md-teal-A100: #a7ffeb;
  --md-teal-A200: #64ffda;
  --md-teal-A400: #1de9b6;
  --md-teal-A700: #00bfa5;
  --md-green-50: #e8f5e9;
  --md-green-100: #c8e6c9;
  --md-green-200: #a5d6a7;
  --md-green-300: #81c784;
  --md-green-400: #66bb6a;
  --md-green-500: #4caf50;
  --md-green-600: #43a047;
  --md-green-700: #388e3c;
  --md-green-800: #2e7d32;
  --md-green-900: #1b5e20;
  --md-green-A100: #b9f6ca;
  --md-green-A200: #69f0ae;
  --md-green-A400: #00e676;
  --md-green-A700: #00c853;
  --md-light-green-50: #f1f8e9;
  --md-light-green-100: #dcedc8;
  --md-light-green-200: #c5e1a5;
  --md-light-green-300: #aed581;
  --md-light-green-400: #9ccc65;
  --md-light-green-500: #8bc34a;
  --md-light-green-600: #7cb342;
  --md-light-green-700: #689f38;
  --md-light-green-800: #558b2f;
  --md-light-green-900: #33691e;
  --md-light-green-A100: #ccff90;
  --md-light-green-A200: #b2ff59;
  --md-light-green-A400: #76ff03;
  --md-light-green-A700: #64dd17;
  --md-lime-50: #f9fbe7;
  --md-lime-100: #f0f4c3;
  --md-lime-200: #e6ee9c;
  --md-lime-300: #dce775;
  --md-lime-400: #d4e157;
  --md-lime-500: #cddc39;
  --md-lime-600: #c0ca33;
  --md-lime-700: #afb42b;
  --md-lime-800: #9e9d24;
  --md-lime-900: #827717;
  --md-lime-A100: #f4ff81;
  --md-lime-A200: #eeff41;
  --md-lime-A400: #c6ff00;
  --md-lime-A700: #aeea00;
  --md-yellow-50: #fffde7;
  --md-yellow-100: #fff9c4;
  --md-yellow-200: #fff59d;
  --md-yellow-300: #fff176;
  --md-yellow-400: #ffee58;
  --md-yellow-500: #ffeb3b;
  --md-yellow-600: #fdd835;
  --md-yellow-700: #fbc02d;
  --md-yellow-800: #f9a825;
  --md-yellow-900: #f57f17;
  --md-yellow-A100: #ffff8d;
  --md-yellow-A200: #ff0;
  --md-yellow-A400: #ffea00;
  --md-yellow-A700: #ffd600;
  --md-amber-50: #fff8e1;
  --md-amber-100: #ffecb3;
  --md-amber-200: #ffe082;
  --md-amber-300: #ffd54f;
  --md-amber-400: #ffca28;
  --md-amber-500: #ffc107;
  --md-amber-600: #ffb300;
  --md-amber-700: #ffa000;
  --md-amber-800: #ff8f00;
  --md-amber-900: #ff6f00;
  --md-amber-A100: #ffe57f;
  --md-amber-A200: #ffd740;
  --md-amber-A400: #ffc400;
  --md-amber-A700: #ffab00;
  --md-orange-50: #fff3e0;
  --md-orange-100: #ffe0b2;
  --md-orange-200: #ffcc80;
  --md-orange-300: #ffb74d;
  --md-orange-400: #ffa726;
  --md-orange-500: #ff9800;
  --md-orange-600: #fb8c00;
  --md-orange-700: #f57c00;
  --md-orange-800: #ef6c00;
  --md-orange-900: #e65100;
  --md-orange-A100: #ffd180;
  --md-orange-A200: #ffab40;
  --md-orange-A400: #ff9100;
  --md-orange-A700: #ff6d00;
  --md-deep-orange-50: #fbe9e7;
  --md-deep-orange-100: #ffccbc;
  --md-deep-orange-200: #ffab91;
  --md-deep-orange-300: #ff8a65;
  --md-deep-orange-400: #ff7043;
  --md-deep-orange-500: #ff5722;
  --md-deep-orange-600: #f4511e;
  --md-deep-orange-700: #e64a19;
  --md-deep-orange-800: #d84315;
  --md-deep-orange-900: #bf360c;
  --md-deep-orange-A100: #ff9e80;
  --md-deep-orange-A200: #ff6e40;
  --md-deep-orange-A400: #ff3d00;
  --md-deep-orange-A700: #dd2c00;
  --md-brown-50: #efebe9;
  --md-brown-100: #d7ccc8;
  --md-brown-200: #bcaaa4;
  --md-brown-300: #a1887f;
  --md-brown-400: #8d6e63;
  --md-brown-500: #795548;
  --md-brown-600: #6d4c41;
  --md-brown-700: #5d4037;
  --md-brown-800: #4e342e;
  --md-brown-900: #3e2723;
  --md-grey-50: #fafafa;
  --md-grey-100: #f5f5f5;
  --md-grey-200: #eee;
  --md-grey-300: #e0e0e0;
  --md-grey-400: #bdbdbd;
  --md-grey-500: #9e9e9e;
  --md-grey-600: #757575;
  --md-grey-700: #616161;
  --md-grey-800: #424242;
  --md-grey-900: #212121;
  --md-blue-grey-50: #eceff1;
  --md-blue-grey-100: #cfd8dc;
  --md-blue-grey-200: #b0bec5;
  --md-blue-grey-300: #90a4ae;
  --md-blue-grey-400: #78909c;
  --md-blue-grey-500: #607d8b;
  --md-blue-grey-600: #546e7a;
  --md-blue-grey-700: #455a64;
  --md-blue-grey-800: #37474f;
  --md-blue-grey-900: #263238;
  }

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2017, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| RenderedText
|----------------------------------------------------------------------------_/

:root {
/_ This is the padding value to fill the gaps between lines containing spans with background color. _/
--jp-private-code-span-padding: calc(
(var(--jp-code-line-height) - 1) \* var(--jp-code-font-size) / 2
);
}

.jp-RenderedText {
text-align: left;
padding-left: var(--jp-code-padding);
line-height: var(--jp-code-line-height);
font-family: var(--jp-code-font-family);
}

.jp-RenderedText pre,
.jp-RenderedJavaScript pre,
.jp-RenderedHTMLCommon pre {
color: var(--jp-content-font-color1);
font-size: var(--jp-code-font-size);
border: none;
margin: 0;
padding: 0;
}

.jp-RenderedText pre a:link {
text-decoration: none;
color: var(--jp-content-link-color);
}

.jp-RenderedText pre a:hover {
text-decoration: underline;
color: var(--jp-content-link-color);
}

.jp-RenderedText pre a:visited {
text-decoration: none;
color: var(--jp-content-link-color);
}

/_ console foregrounds and backgrounds _/
.jp-RenderedText pre .ansi-black-fg {
color: #3e424d;
}

.jp-RenderedText pre .ansi-red-fg {
color: #e75c58;
}

.jp-RenderedText pre .ansi-green-fg {
color: #00a250;
}

.jp-RenderedText pre .ansi-yellow-fg {
color: #ddb62b;
}

.jp-RenderedText pre .ansi-blue-fg {
color: #208ffb;
}

.jp-RenderedText pre .ansi-magenta-fg {
color: #d160c4;
}

.jp-RenderedText pre .ansi-cyan-fg {
color: #60c6c8;
}

.jp-RenderedText pre .ansi-white-fg {
color: #c5c1b4;
}

.jp-RenderedText pre .ansi-black-bg {
background-color: #3e424d;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-red-bg {
background-color: #e75c58;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-green-bg {
background-color: #00a250;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-yellow-bg {
background-color: #ddb62b;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-blue-bg {
background-color: #208ffb;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-magenta-bg {
background-color: #d160c4;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-cyan-bg {
background-color: #60c6c8;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-white-bg {
background-color: #c5c1b4;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-black-intense-fg {
color: #282c36;
}

.jp-RenderedText pre .ansi-red-intense-fg {
color: #b22b31;
}

.jp-RenderedText pre .ansi-green-intense-fg {
color: #007427;
}

.jp-RenderedText pre .ansi-yellow-intense-fg {
color: #b27d12;
}

.jp-RenderedText pre .ansi-blue-intense-fg {
color: #0065ca;
}

.jp-RenderedText pre .ansi-magenta-intense-fg {
color: #a03196;
}

.jp-RenderedText pre .ansi-cyan-intense-fg {
color: #258f8f;
}

.jp-RenderedText pre .ansi-white-intense-fg {
color: #a1a6b2;
}

.jp-RenderedText pre .ansi-black-intense-bg {
background-color: #282c36;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-red-intense-bg {
background-color: #b22b31;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-green-intense-bg {
background-color: #007427;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-yellow-intense-bg {
background-color: #b27d12;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-blue-intense-bg {
background-color: #0065ca;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-magenta-intense-bg {
background-color: #a03196;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-cyan-intense-bg {
background-color: #258f8f;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-white-intense-bg {
background-color: #a1a6b2;
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-default-inverse-fg {
color: var(--jp-ui-inverse-font-color0);
}

.jp-RenderedText pre .ansi-default-inverse-bg {
background-color: var(--jp-inverse-layout-color0);
padding: var(--jp-private-code-span-padding) 0;
}

.jp-RenderedText pre .ansi-bold {
font-weight: bold;
}

.jp-RenderedText pre .ansi-underline {
text-decoration: underline;
}

.jp-RenderedText[data-mime-type='application/vnd.jupyter.stderr'] {
background: var(--jp-rendermime-error-background);
padding-top: var(--jp-code-padding);
}

/_-----------------------------------------------------------------------------
| RenderedLatex
|----------------------------------------------------------------------------_/

.jp-RenderedLatex {
color: var(--jp-content-font-color1);
font-size: var(--jp-content-font-size1);
line-height: var(--jp-content-line-height);
}

/_ Left-justify outputs._/
.jp-OutputArea-output.jp-RenderedLatex {
padding: var(--jp-code-padding);
text-align: left;
}

/_-----------------------------------------------------------------------------
| RenderedHTML
|----------------------------------------------------------------------------_/

.jp-RenderedHTMLCommon {
color: var(--jp-content-font-color1);
font-family: var(--jp-content-font-family);
font-size: var(--jp-content-font-size1);
line-height: var(--jp-content-line-height);

/_ Give a bit more R padding on Markdown text to keep line lengths reasonable _/
padding-right: 20px;
}

.jp-RenderedHTMLCommon em {
font-style: italic;
}

.jp-RenderedHTMLCommon strong {
font-weight: bold;
}

.jp-RenderedHTMLCommon u {
text-decoration: underline;
}

.jp-RenderedHTMLCommon a:link {
text-decoration: none;
color: var(--jp-content-link-color);
}

.jp-RenderedHTMLCommon a:hover {
text-decoration: underline;
color: var(--jp-content-link-color);
}

.jp-RenderedHTMLCommon a:visited {
text-decoration: none;
color: var(--jp-content-link-color);
}

/_ Headings _/

.jp-RenderedHTMLCommon h1,
.jp-RenderedHTMLCommon h2,
.jp-RenderedHTMLCommon h3,
.jp-RenderedHTMLCommon h4,
.jp-RenderedHTMLCommon h5,
.jp-RenderedHTMLCommon h6 {
line-height: var(--jp-content-heading-line-height);
font-weight: var(--jp-content-heading-font-weight);
font-style: normal;
margin: var(--jp-content-heading-margin-top) 0
var(--jp-content-heading-margin-bottom) 0;
}

.jp-RenderedHTMLCommon h1:first-child,
.jp-RenderedHTMLCommon h2:first-child,
.jp-RenderedHTMLCommon h3:first-child,
.jp-RenderedHTMLCommon h4:first-child,
.jp-RenderedHTMLCommon h5:first-child,
.jp-RenderedHTMLCommon h6:first-child {
margin-top: calc(0.5 \* var(--jp-content-heading-margin-top));
}

.jp-RenderedHTMLCommon h1:last-child,
.jp-RenderedHTMLCommon h2:last-child,
.jp-RenderedHTMLCommon h3:last-child,
.jp-RenderedHTMLCommon h4:last-child,
.jp-RenderedHTMLCommon h5:last-child,
.jp-RenderedHTMLCommon h6:last-child {
margin-bottom: calc(0.5 \* var(--jp-content-heading-margin-bottom));
}

.jp-RenderedHTMLCommon h1 {
font-size: var(--jp-content-font-size5);
}

.jp-RenderedHTMLCommon h2 {
font-size: var(--jp-content-font-size4);
}

.jp-RenderedHTMLCommon h3 {
font-size: var(--jp-content-font-size3);
}

.jp-RenderedHTMLCommon h4 {
font-size: var(--jp-content-font-size2);
}

.jp-RenderedHTMLCommon h5 {
font-size: var(--jp-content-font-size1);
}

.jp-RenderedHTMLCommon h6 {
font-size: var(--jp-content-font-size0);
}

/_ Lists _/

/_ stylelint-disable selector-max-type, selector-max-compound-selectors _/

.jp-RenderedHTMLCommon ul:not(.list-inline),
.jp-RenderedHTMLCommon ol:not(.list-inline) {
padding-left: 2em;
}

.jp-RenderedHTMLCommon ul {
list-style: disc;
}

.jp-RenderedHTMLCommon ul ul {
list-style: square;
}

.jp-RenderedHTMLCommon ul ul ul {
list-style: circle;
}

.jp-RenderedHTMLCommon ol {
list-style: decimal;
}

.jp-RenderedHTMLCommon ol ol {
list-style: upper-alpha;
}

.jp-RenderedHTMLCommon ol ol ol {
list-style: lower-alpha;
}

.jp-RenderedHTMLCommon ol ol ol ol {
list-style: lower-roman;
}

.jp-RenderedHTMLCommon ol ol ol ol ol {
list-style: decimal;
}

.jp-RenderedHTMLCommon ol,
.jp-RenderedHTMLCommon ul {
margin-bottom: 1em;
}

.jp-RenderedHTMLCommon ul ul,
.jp-RenderedHTMLCommon ul ol,
.jp-RenderedHTMLCommon ol ul,
.jp-RenderedHTMLCommon ol ol {
margin-bottom: 0;
}

/_ stylelint-enable selector-max-type, selector-max-compound-selectors _/

.jp-RenderedHTMLCommon hr {
color: var(--jp-border-color2);
background-color: var(--jp-border-color1);
margin-top: 1em;
margin-bottom: 1em;
}

.jp-RenderedHTMLCommon > pre {
margin: 1.5em 2em;
}

.jp-RenderedHTMLCommon pre,
.jp-RenderedHTMLCommon code {
border: 0;
background-color: var(--jp-layout-color0);
color: var(--jp-content-font-color1);
font-family: var(--jp-code-font-family);
font-size: inherit;
line-height: var(--jp-code-line-height);
padding: 0;
white-space: pre-wrap;
}

.jp-RenderedHTMLCommon :not(pre) > code {
background-color: var(--jp-layout-color2);
padding: 1px 5px;
}

/_ Tables _/

.jp-RenderedHTMLCommon table {
border-collapse: collapse;
border-spacing: 0;
border: none;
color: var(--jp-ui-font-color1);
font-size: var(--jp-ui-font-size1);
table-layout: fixed;
margin-left: auto;
margin-bottom: 1em;
margin-right: auto;
}

.jp-RenderedHTMLCommon thead {
border-bottom: var(--jp-border-width) solid var(--jp-border-color1);
vertical-align: bottom;
}

.jp-RenderedHTMLCommon td,
.jp-RenderedHTMLCommon th,
.jp-RenderedHTMLCommon tr {
vertical-align: middle;
padding: 0.5em;
line-height: normal;
white-space: normal;
max-width: none;
border: none;
}

.jp-RenderedMarkdown.jp-RenderedHTMLCommon td,
.jp-RenderedMarkdown.jp-RenderedHTMLCommon th {
max-width: none;
}

:not(.jp-RenderedMarkdown).jp-RenderedHTMLCommon td,
:not(.jp-RenderedMarkdown).jp-RenderedHTMLCommon th,
:not(.jp-RenderedMarkdown).jp-RenderedHTMLCommon tr {
text-align: right;
}

.jp-RenderedHTMLCommon th {
font-weight: bold;
}

.jp-RenderedHTMLCommon tbody tr:nth-child(odd) {
background: var(--jp-layout-color0);
}

.jp-RenderedHTMLCommon tbody tr:nth-child(even) {
background: var(--jp-rendermime-table-row-background);
}

.jp-RenderedHTMLCommon tbody tr:hover {
background: var(--jp-rendermime-table-row-hover-background);
}

.jp-RenderedHTMLCommon p {
text-align: left;
margin: 0;
margin-bottom: 1em;
}

.jp-RenderedHTMLCommon img {
-moz-force-broken-image-icon: 1;
}

/_ Restrict to direct children as other images could be nested in other content. _/
.jp-RenderedHTMLCommon > img {
display: block;
margin-left: 0;
margin-right: 0;
margin-bottom: 1em;
}

/_ Change color behind transparent images if they need it... _/
[data-jp-theme-light='false'] .jp-RenderedImage img.jp-needs-light-background {
background-color: var(--jp-inverse-layout-color1);
}

[data-jp-theme-light='true'] .jp-RenderedImage img.jp-needs-dark-background {
background-color: var(--jp-inverse-layout-color1);
}

.jp-RenderedHTMLCommon img,
.jp-RenderedImage img,
.jp-RenderedHTMLCommon svg,
.jp-RenderedSVG svg {
max-width: 100%;
height: auto;
}

.jp-RenderedHTMLCommon img.jp-mod-unconfined,
.jp-RenderedImage img.jp-mod-unconfined,
.jp-RenderedHTMLCommon svg.jp-mod-unconfined,
.jp-RenderedSVG svg.jp-mod-unconfined {
max-width: none;
}

.jp-RenderedHTMLCommon .alert {
padding: var(--jp-notebook-padding);
border: var(--jp-border-width) solid transparent;
border-radius: var(--jp-border-radius);
margin-bottom: 1em;
}

.jp-RenderedHTMLCommon .alert-info {
color: var(--jp-info-color0);
background-color: var(--jp-info-color3);
border-color: var(--jp-info-color2);
}

.jp-RenderedHTMLCommon .alert-info hr {
border-color: var(--jp-info-color3);
}

.jp-RenderedHTMLCommon .alert-info > p:last-child,
.jp-RenderedHTMLCommon .alert-info > ul:last-child {
margin-bottom: 0;
}

.jp-RenderedHTMLCommon .alert-warning {
color: var(--jp-warn-color0);
background-color: var(--jp-warn-color3);
border-color: var(--jp-warn-color2);
}

.jp-RenderedHTMLCommon .alert-warning hr {
border-color: var(--jp-warn-color3);
}

.jp-RenderedHTMLCommon .alert-warning > p:last-child,
.jp-RenderedHTMLCommon .alert-warning > ul:last-child {
margin-bottom: 0;
}

.jp-RenderedHTMLCommon .alert-success {
color: var(--jp-success-color0);
background-color: var(--jp-success-color3);
border-color: var(--jp-success-color2);
}

.jp-RenderedHTMLCommon .alert-success hr {
border-color: var(--jp-success-color3);
}

.jp-RenderedHTMLCommon .alert-success > p:last-child,
.jp-RenderedHTMLCommon .alert-success > ul:last-child {
margin-bottom: 0;
}

.jp-RenderedHTMLCommon .alert-danger {
color: var(--jp-error-color0);
background-color: var(--jp-error-color3);
border-color: var(--jp-error-color2);
}

.jp-RenderedHTMLCommon .alert-danger hr {
border-color: var(--jp-error-color3);
}

.jp-RenderedHTMLCommon .alert-danger > p:last-child,
.jp-RenderedHTMLCommon .alert-danger > ul:last-child {
margin-bottom: 0;
}

.jp-RenderedHTMLCommon blockquote {
margin: 1em 2em;
padding: 0 1em;
border-left: 5px solid var(--jp-border-color2);
}

a.jp-InternalAnchorLink {
visibility: hidden;
margin-left: 8px;
color: var(--md-blue-800);
}

h1:hover .jp-InternalAnchorLink,
h2:hover .jp-InternalAnchorLink,
h3:hover .jp-InternalAnchorLink,
h4:hover .jp-InternalAnchorLink,
h5:hover .jp-InternalAnchorLink,
h6:hover .jp-InternalAnchorLink {
visibility: visible;
}

.jp-RenderedHTMLCommon kbd {
background-color: var(--jp-rendermime-table-row-background);
border: 1px solid var(--jp-border-color0);
border-bottom-color: var(--jp-border-color2);
border-radius: 3px;
box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.25);
display: inline-block;
font-size: var(--jp-ui-font-size0);
line-height: 1em;
padding: 0.2em 0.5em;
}

/\* Most direct children of .jp-RenderedHTMLCommon have a margin-bottom of 1.0.

- At the bottom of cells this is a bit too much as there is also spacing
- between cells. Going all the way to 0 gets too tight between markdown and
- code cells.
  _/
  .jp-RenderedHTMLCommon > _:last-child {
  margin-bottom: 0.5em;
  }

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Copyright (c) 2014-2017, PhosphorJS Contributors
|
| Distributed under the terms of the BSD 3-Clause License.
|
| The full license is in the file LICENSE, distributed with this software.
|----------------------------------------------------------------------------_/

.lm-cursor-backdrop {
position: fixed;
width: 200px;
height: 200px;
margin-top: -100px;
margin-left: -100px;
will-change: transform;
z-index: 100;
}

.lm-mod-drag-image {
will-change: transform;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

.jp-lineFormSearch {
padding: 4px 12px;
background-color: var(--jp-layout-color2);
box-shadow: var(--jp-toolbar-box-shadow);
z-index: 2;
font-size: var(--jp-ui-font-size1);
}

.jp-lineFormCaption {
font-size: var(--jp-ui-font-size0);
line-height: var(--jp-ui-font-size1);
margin-top: 4px;
color: var(--jp-ui-font-color0);
}

.jp-baseLineForm {
border: none;
border-radius: 0;
position: absolute;
background-size: 16px;
background-repeat: no-repeat;
background-position: center;
outline: none;
}

.jp-lineFormButtonContainer {
top: 4px;
right: 8px;
height: 24px;
padding: 0 12px;
width: 12px;
}

.jp-lineFormButtonIcon {
top: 0;
right: 0;
background-color: var(--jp-brand-color1);
height: 100%;
width: 100%;
box-sizing: border-box;
padding: 4px 6px;
}

.jp-lineFormButton {
top: 0;
right: 0;
background-color: transparent;
height: 100%;
width: 100%;
box-sizing: border-box;
}

.jp-lineFormWrapper {
overflow: hidden;
padding: 0 8px;
border: 1px solid var(--jp-border-color0);
background-color: var(--jp-input-active-background);
height: 22px;
}

.jp-lineFormWrapperFocusWithin {
border: var(--jp-border-width) solid var(--md-blue-500);
box-shadow: inset 0 0 4px var(--md-blue-300);
}

.jp-lineFormInput {
background: transparent;
width: 200px;
height: 100%;
border: none;
outline: none;
color: var(--jp-ui-font-color0);
line-height: 28px;
}

/_-----------------------------------------------------------------------------
| Copyright (c) 2014-2016, Jupyter Development Team.
|
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-JSONEditor {
display: flex;
flex-direction: column;
width: 100%;
}

.jp-JSONEditor-host {
flex: 1 1 auto;
border: var(--jp-border-width) solid var(--jp-input-border-color);
border-radius: 0;
background: var(--jp-layout-color0);
min-height: 50px;
padding: 1px;
}

.jp-JSONEditor.jp-mod-error .jp-JSONEditor-host {
border-color: red;
outline-color: red;
}

.jp-JSONEditor-header {
display: flex;
flex: 1 0 auto;
padding: 0 0 0 12px;
}

.jp-JSONEditor-header label {
flex: 0 0 auto;
}

.jp-JSONEditor-commitButton {
height: 16px;
width: 16px;
background-size: 18px;
background-repeat: no-repeat;
background-position: center;
}

.jp-JSONEditor-host.jp-mod-focused {
background-color: var(--jp-input-active-background);
border: 1px solid var(--jp-input-active-border-color);
box-shadow: var(--jp-input-box-shadow);
}

.jp-Editor.jp-mod-dropTarget {
border: var(--jp-border-width) solid var(--jp-input-active-border-color);
box-shadow: var(--jp-input-box-shadow);
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/
.jp-DocumentSearch-input {
border: none;
outline: none;
color: var(--jp-ui-font-color0);
font-size: var(--jp-ui-font-size1);
background-color: var(--jp-layout-color0);
font-family: var(--jp-ui-font-family);
padding: 2px 1px;
resize: none;
}

.jp-DocumentSearch-overlay {
position: absolute;
background-color: var(--jp-toolbar-background);
border-bottom: var(--jp-border-width) solid var(--jp-toolbar-border-color);
border-left: var(--jp-border-width) solid var(--jp-toolbar-border-color);
top: 0;
right: 0;
z-index: 7;
min-width: 405px;
padding: 2px;
font-size: var(--jp-ui-font-size1);

--jp-private-document-search-button-height: 20px;
}

.jp-DocumentSearch-overlay button {
background-color: var(--jp-toolbar-background);
outline: 0;
}

.jp-DocumentSearch-overlay button:hover {
background-color: var(--jp-layout-color2);
}

.jp-DocumentSearch-overlay button:active {
background-color: var(--jp-layout-color3);
}

.jp-DocumentSearch-overlay-row {
display: flex;
align-items: center;
margin-bottom: 2px;
}

.jp-DocumentSearch-button-content {
display: inline-block;
cursor: pointer;
box-sizing: border-box;
width: 100%;
height: 100%;
}

.jp-DocumentSearch-button-content svg {
width: 100%;
height: 100%;
}

.jp-DocumentSearch-input-wrapper {
border: var(--jp-border-width) solid var(--jp-border-color0);
display: flex;
background-color: var(--jp-layout-color0);
margin: 2px;
}

.jp-DocumentSearch-input-wrapper:focus-within {
border-color: var(--jp-cell-editor-active-border-color);
}

.jp-DocumentSearch-toggle-wrapper,
.jp-DocumentSearch-button-wrapper {
all: initial;
overflow: hidden;
display: inline-block;
border: none;
box-sizing: border-box;
}

.jp-DocumentSearch-toggle-wrapper {
width: 14px;
height: 14px;
}

.jp-DocumentSearch-button-wrapper {
width: var(--jp-private-document-search-button-height);
height: var(--jp-private-document-search-button-height);
}

.jp-DocumentSearch-toggle-wrapper:focus,
.jp-DocumentSearch-button-wrapper:focus {
outline: var(--jp-border-width) solid
var(--jp-cell-editor-active-border-color);
outline-offset: -1px;
}

.jp-DocumentSearch-toggle-wrapper,
.jp-DocumentSearch-button-wrapper,
.jp-DocumentSearch-button-content:focus {
outline: none;
}

.jp-DocumentSearch-toggle-placeholder {
width: 5px;
}

.jp-DocumentSearch-input-button::before {
display: block;
padding-top: 100%;
}

.jp-DocumentSearch-input-button-off {
opacity: var(--jp-search-toggle-off-opacity);
}

.jp-DocumentSearch-input-button-off:hover {
opacity: var(--jp-search-toggle-hover-opacity);
}

.jp-DocumentSearch-input-button-on {
opacity: var(--jp-search-toggle-on-opacity);
}

.jp-DocumentSearch-index-counter {
padding-left: 10px;
padding-right: 10px;
user-select: none;
min-width: 35px;
display: inline-block;
}

.jp-DocumentSearch-up-down-wrapper {
display: inline-block;
padding-right: 2px;
margin-left: auto;
white-space: nowrap;
}

.jp-DocumentSearch-spacer {
margin-left: auto;
}

.jp-DocumentSearch-up-down-wrapper button {
outline: 0;
border: none;
width: var(--jp-private-document-search-button-height);
height: var(--jp-private-document-search-button-height);
vertical-align: middle;
margin: 1px 5px 2px;
}

.jp-DocumentSearch-up-down-button:hover {
background-color: var(--jp-layout-color2);
}

.jp-DocumentSearch-up-down-button:active {
background-color: var(--jp-layout-color3);
}

.jp-DocumentSearch-filter-button {
border-radius: var(--jp-border-radius);
}

.jp-DocumentSearch-filter-button:hover {
background-color: var(--jp-layout-color2);
}

.jp-DocumentSearch-filter-button-enabled {
background-color: var(--jp-layout-color2);
}

.jp-DocumentSearch-filter-button-enabled:hover {
background-color: var(--jp-layout-color3);
}

.jp-DocumentSearch-search-options {
padding: 0 8px;
margin-left: 3px;
width: 100%;
display: grid;
justify-content: start;
grid-template-columns: 1fr 1fr;
align-items: center;
justify-items: stretch;
}

.jp-DocumentSearch-search-filter-disabled {
color: var(--jp-ui-font-color2);
}

.jp-DocumentSearch-search-filter {
display: flex;
align-items: center;
user-select: none;
}

.jp-DocumentSearch-regex-error {
color: var(--jp-error-color0);
}

.jp-DocumentSearch-replace-button-wrapper {
overflow: hidden;
display: inline-block;
box-sizing: border-box;
border: var(--jp-border-width) solid var(--jp-border-color0);
margin: auto 2px;
padding: 1px 4px;
height: calc(var(--jp-private-document-search-button-height) + 2px);
}

.jp-DocumentSearch-replace-button-wrapper:focus {
border: var(--jp-border-width) solid var(--jp-cell-editor-active-border-color);
}

.jp-DocumentSearch-replace-button {
display: inline-block;
text-align: center;
cursor: pointer;
box-sizing: border-box;
color: var(--jp-ui-font-color1);

/_ height - 2 _ (padding of wrapper) \*/
line-height: calc(var(--jp-private-document-search-button-height) - 2px);
width: 100%;
height: 100%;
}

.jp-DocumentSearch-replace-button:focus {
outline: none;
}

.jp-DocumentSearch-replace-wrapper-class {
margin-left: 14px;
display: flex;
}

.jp-DocumentSearch-replace-toggle {
border: none;
background-color: var(--jp-toolbar-background);
border-radius: var(--jp-border-radius);
}

.jp-DocumentSearch-replace-toggle:hover {
background-color: var(--jp-layout-color2);
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.cm-editor {
line-height: var(--jp-code-line-height);
font-size: var(--jp-code-font-size);
font-family: var(--jp-code-font-family);
border: 0;
border-radius: 0;
height: auto;

/_ Changed to auto to autogrow _/
}

.cm-editor pre {
padding: 0 var(--jp-code-padding);
}

.jp-CodeMirrorEditor[data-type='inline'] .cm-dialog {
background-color: var(--jp-layout-color0);
color: var(--jp-content-font-color1);
}

.jp-CodeMirrorEditor {
cursor: text;
}

/_ When zoomed out 67% and 33% on a screen of 1440 width x 900 height _/
@media screen and (min-width: 2138px) and (max-width: 4319px) {
.jp-CodeMirrorEditor[data-type='inline'] .cm-cursor {
border-left: var(--jp-code-cursor-width1) solid
var(--jp-editor-cursor-color);
}
}

/_ When zoomed out less than 33% _/
@media screen and (min-width: 4320px) {
.jp-CodeMirrorEditor[data-type='inline'] .cm-cursor {
border-left: var(--jp-code-cursor-width2) solid
var(--jp-editor-cursor-color);
}
}

.cm-editor.jp-mod-readOnly .cm-cursor {
display: none;
}

.jp-CollaboratorCursor {
border-left: 5px solid transparent;
border-right: 5px solid transparent;
border-top: none;
border-bottom: 3px solid;
background-clip: content-box;
margin-left: -5px;
margin-right: -5px;
}

.cm-searching,
.cm-searching span {
/_ `.cm-searching span`: we need to override syntax highlighting _/
background-color: var(--jp-search-unselected-match-background-color);
color: var(--jp-search-unselected-match-color);
}

.cm-searching::selection,
.cm-searching span::selection {
background-color: var(--jp-search-unselected-match-background-color);
color: var(--jp-search-unselected-match-color);
}

.jp-current-match > .cm-searching,
.jp-current-match > .cm-searching span,
.cm-searching > .jp-current-match,
.cm-searching > .jp-current-match span {
background-color: var(--jp-search-selected-match-background-color);
color: var(--jp-search-selected-match-color);
}

.jp-current-match > .cm-searching::selection,
.cm-searching > .jp-current-match::selection,
.jp-current-match > .cm-searching span::selection {
background-color: var(--jp-search-selected-match-background-color);
color: var(--jp-search-selected-match-color);
}

.cm-trailingspace {
background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAFCAYAAAB4ka1VAAAAsElEQVQIHQGlAFr/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7+r3zKmT0/+pk9P/7+r3zAAAAAAAAAAABAAAAAAAAAAA6OPzM+/q9wAAAAAA6OPzMwAAAAAAAAAAAgAAAAAAAAAAGR8NiRQaCgAZIA0AGR8NiQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQyoYJ/SY80UAAAAASUVORK5CYII=);
background-position: center left;
background-repeat: repeat-x;
}

.jp-CollaboratorCursor-hover {
position: absolute;
z-index: 1;
transform: translateX(-50%);
color: white;
border-radius: 3px;
padding-left: 4px;
padding-right: 4px;
padding-top: 1px;
padding-bottom: 1px;
text-align: center;
font-size: var(--jp-ui-font-size1);
white-space: nowrap;
}

.jp-CodeMirror-ruler {
border-left: 1px dashed var(--jp-border-color2);
}

/_ Styles for shared cursors (remote cursor locations and selected ranges) _/
.jp-CodeMirrorEditor .cm-ySelectionCaret {
position: relative;
border-left: 1px solid black;
margin-left: -1px;
margin-right: -1px;
box-sizing: border-box;
}

.jp-CodeMirrorEditor .cm-ySelectionCaret > .cm-ySelectionInfo {
white-space: nowrap;
position: absolute;
top: -1.15em;
padding-bottom: 0.05em;
left: -1px;
font-size: 0.95em;
font-family: var(--jp-ui-font-family);
font-weight: bold;
line-height: normal;
user-select: none;
color: white;
padding-left: 2px;
padding-right: 2px;
z-index: 101;
transition: opacity 0.3s ease-in-out;
}

.jp-CodeMirrorEditor .cm-ySelectionInfo {
transition-delay: 0.7s;
opacity: 0;
}

.jp-CodeMirrorEditor .cm-ySelectionCaret:hover > .cm-ySelectionInfo {
opacity: 1;
transition-delay: 0s;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-MimeDocument {
outline: none;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Variables
|----------------------------------------------------------------------------_/

:root {
--jp-private-filebrowser-button-height: 28px;
--jp-private-filebrowser-button-width: 48px;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-FileBrowser .jp-SidePanel-content {
display: flex;
flex-direction: column;
}

.jp-FileBrowser-toolbar.jp-Toolbar {
flex-wrap: wrap;
row-gap: 12px;
border-bottom: none;
height: auto;
margin: 8px 12px 0;
box-shadow: none;
padding: 0;
justify-content: flex-start;
}

.jp-FileBrowser-Panel {
flex: 1 1 auto;
display: flex;
flex-direction: column;
}

.jp-BreadCrumbs {
flex: 0 0 auto;
margin: 8px 12px;
}

.jp-BreadCrumbs-item {
margin: 0 2px;
padding: 0 2px;
border-radius: var(--jp-border-radius);
cursor: pointer;
}

.jp-BreadCrumbs-item:hover {
background-color: var(--jp-layout-color2);
}

.jp-BreadCrumbs-item:first-child {
margin-left: 0;
}

.jp-BreadCrumbs-item.jp-mod-dropTarget {
background-color: var(--jp-brand-color2);
opacity: 0.7;
}

/_-----------------------------------------------------------------------------
| Buttons
|----------------------------------------------------------------------------_/

.jp-FileBrowser-toolbar > .jp-Toolbar-item {
flex: 0 0 auto;
padding-left: 0;
padding-right: 2px;
align-items: center;
height: unset;
}

.jp-FileBrowser-toolbar > .jp-Toolbar-item .jp-ToolbarButtonComponent {
width: 40px;
}

/_-----------------------------------------------------------------------------
| Other styles
|----------------------------------------------------------------------------_/

.jp-FileDialog.jp-mod-conflict input {
color: var(--jp-error-color1);
}

.jp-FileDialog .jp-new-name-title {
margin-top: 12px;
}

.jp-LastModified-hidden {
display: none;
}

.jp-FileSize-hidden {
display: none;
}

.jp-FileBrowser .lm-AccordionPanel > h3:first-child {
display: none;
}

/_-----------------------------------------------------------------------------
| DirListing
|----------------------------------------------------------------------------_/

.jp-DirListing {
flex: 1 1 auto;
display: flex;
flex-direction: column;
outline: 0;
}

.jp-DirListing-header {
flex: 0 0 auto;
display: flex;
flex-direction: row;
align-items: center;
overflow: hidden;
border-top: var(--jp-border-width) solid var(--jp-border-color2);
border-bottom: var(--jp-border-width) solid var(--jp-border-color1);
box-shadow: var(--jp-toolbar-box-shadow);
z-index: 2;
}

.jp-DirListing-headerItem {
padding: 4px 12px 2px;
font-weight: 500;
}

.jp-DirListing-headerItem:hover {
background: var(--jp-layout-color2);
}

.jp-DirListing-headerItem.jp-id-name {
flex: 1 0 84px;
}

.jp-DirListing-headerItem.jp-id-modified {
flex: 0 0 112px;
border-left: var(--jp-border-width) solid var(--jp-border-color2);
text-align: right;
}

.jp-DirListing-headerItem.jp-id-filesize {
flex: 0 0 75px;
border-left: var(--jp-border-width) solid var(--jp-border-color2);
text-align: right;
}

.jp-id-narrow {
display: none;
flex: 0 0 5px;
padding: 4px;
border-left: var(--jp-border-width) solid var(--jp-border-color2);
text-align: right;
color: var(--jp-border-color2);
}

.jp-DirListing-narrow .jp-id-narrow {
display: block;
}

.jp-DirListing-narrow .jp-id-modified,
.jp-DirListing-narrow .jp-DirListing-itemModified {
display: none;
}

.jp-DirListing-headerItem.jp-mod-selected {
font-weight: 600;
}

/_ increase specificity to override bundled default _/
.jp-DirListing-content {
flex: 1 1 auto;
margin: 0;
padding: 0;
list-style-type: none;
overflow: auto;
background-color: var(--jp-layout-color1);
}

.jp-DirListing-content mark {
color: var(--jp-ui-font-color0);
background-color: transparent;
font-weight: bold;
}

.jp-DirListing-content .jp-DirListing-item.jp-mod-selected mark {
color: var(--jp-ui-inverse-font-color0);
}

/_ Style the directory listing content when a user drops a file to upload _/
.jp-DirListing.jp-mod-native-drop .jp-DirListing-content {
outline: 5px dashed rgba(128, 128, 128, 0.5);
outline-offset: -10px;
cursor: copy;
}

.jp-DirListing-item {
display: flex;
flex-direction: row;
align-items: center;
padding: 4px 12px;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.jp-DirListing-checkboxWrapper {
/_ Increases hit area of checkbox. _/
padding: 4px;
}

.jp-DirListing-header
.jp-DirListing-checkboxWrapper

- .jp-DirListing-headerItem {
  padding-left: 4px;
  }

.jp-DirListing-content .jp-DirListing-checkboxWrapper {
position: relative;
left: -4px;
margin: -4px 0 -4px -8px;
}

.jp-DirListing-checkboxWrapper.jp-mod-visible {
visibility: visible;
}

/_ For devices that support hovering, hide checkboxes until hovered, selected...
_/
@media (hover: hover) {
.jp-DirListing-checkboxWrapper {
visibility: hidden;
}

.jp-DirListing-item:hover .jp-DirListing-checkboxWrapper,
.jp-DirListing-item.jp-mod-selected .jp-DirListing-checkboxWrapper {
visibility: visible;
}
}

.jp-DirListing-item[data-is-dot] {
opacity: 75%;
}

.jp-DirListing-item.jp-mod-selected {
color: var(--jp-ui-inverse-font-color1);
background: var(--jp-brand-color1);
}

.jp-DirListing-item.jp-mod-dropTarget {
background: var(--jp-brand-color3);
}

.jp-DirListing-item:hover:not(.jp-mod-selected) {
background: var(--jp-layout-color2);
}

.jp-DirListing-itemIcon {
flex: 0 0 20px;
margin-right: 4px;
}

.jp-DirListing-itemText {
flex: 1 0 64px;
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;
user-select: none;
}

.jp-DirListing-itemText:focus {
outline-width: 2px;
outline-color: var(--jp-inverse-layout-color1);
outline-style: solid;
outline-offset: 1px;
}

.jp-DirListing-item.jp-mod-selected .jp-DirListing-itemText:focus {
outline-color: var(--jp-layout-color1);
}

.jp-DirListing-itemModified {
flex: 0 0 125px;
text-align: right;
}

.jp-DirListing-itemFileSize {
flex: 0 0 90px;
text-align: right;
}

.jp-DirListing-editor {
flex: 1 0 64px;
outline: none;
border: none;
color: var(--jp-ui-font-color1);
background-color: var(--jp-layout-color1);
}

.jp-DirListing-item.jp-mod-running .jp-DirListing-itemIcon::before {
color: var(--jp-success-color1);
content: '\25CF';
font-size: 8px;
position: absolute;
left: -8px;
}

.jp-DirListing-item.jp-mod-running.jp-mod-selected
.jp-DirListing-itemIcon::before {
color: var(--jp-ui-inverse-font-color1);
}

.jp-DirListing-item.lm-mod-drag-image,
.jp-DirListing-item.jp-mod-selected.lm-mod-drag-image {
font-size: var(--jp-ui-font-size1);
padding-left: 4px;
margin-left: 4px;
width: 160px;
background-color: var(--jp-ui-inverse-font-color2);
box-shadow: var(--jp-elevation-z2);
border-radius: 0;
color: var(--jp-ui-font-color1);
transform: translateX(-40%) translateY(-58%);
}

.jp-Document {
min-width: 120px;
min-height: 120px;
outline: none;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Main OutputArea
| OutputArea has a list of Outputs
|----------------------------------------------------------------------------_/

.jp-OutputArea {
overflow-y: auto;
}

.jp-OutputArea-child {
display: table;
table-layout: fixed;
width: 100%;
overflow: hidden;
}

.jp-OutputPrompt {
width: var(--jp-cell-prompt-width);
color: var(--jp-cell-outprompt-font-color);
font-family: var(--jp-cell-prompt-font-family);
padding: var(--jp-code-padding);
letter-spacing: var(--jp-cell-prompt-letter-spacing);
line-height: var(--jp-code-line-height);
font-size: var(--jp-code-font-size);
border: var(--jp-border-width) solid transparent;
opacity: var(--jp-cell-prompt-opacity);

/_ Right align prompt text, don't wrap to handle large prompt numbers _/
text-align: right;
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;

/_ Disable text selection _/
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.jp-OutputArea-prompt {
display: table-cell;
vertical-align: top;
}

.jp-OutputArea-output {
display: table-cell;
width: 100%;
height: auto;
overflow: auto;
user-select: text;
-moz-user-select: text;
-webkit-user-select: text;
-ms-user-select: text;
}

.jp-OutputArea .jp-RenderedText {
padding-left: 1ch;
}

/\*\*

- Prompt overlay.
  \*/

.jp-OutputArea-promptOverlay {
position: absolute;
top: 0;
width: var(--jp-cell-prompt-width);
height: 100%;
opacity: 0.5;
}

.jp-OutputArea-promptOverlay:hover {
background: var(--jp-layout-color2);
box-shadow: inset 0 0 1px var(--jp-inverse-layout-color0);
cursor: zoom-out;
}

.jp-mod-outputsScrolled .jp-OutputArea-promptOverlay:hover {
cursor: zoom-in;
}

/\*\*

- Isolated output.
  \*/
  .jp-OutputArea-output.jp-mod-isolated {
  width: 100%;
  display: block;
  }

/_
When drag events occur, `lm-mod-override-cursor` is added to the body.
Because iframes steal all cursor events, the following two rules are necessary
to suppress pointer events while resize drags are occurring. There may be a
better solution to this problem.
_/
body.lm-mod-override-cursor .jp-OutputArea-output.jp-mod-isolated {
position: relative;
}

body.lm-mod-override-cursor .jp-OutputArea-output.jp-mod-isolated::before {
content: '';
position: absolute;
top: 0;
left: 0;
right: 0;
bottom: 0;
background: transparent;
}

/_ pre _/

.jp-OutputArea-output pre {
border: none;
margin: 0;
padding: 0;
overflow-x: auto;
overflow-y: auto;
word-break: break-all;
word-wrap: break-word;
white-space: pre-wrap;
}

/_ tables _/

.jp-OutputArea-output.jp-RenderedHTMLCommon table {
margin-left: 0;
margin-right: 0;
}

/_ description lists _/

.jp-OutputArea-output dl,
.jp-OutputArea-output dt,
.jp-OutputArea-output dd {
display: block;
}

.jp-OutputArea-output dl {
width: 100%;
overflow: hidden;
padding: 0;
margin: 0;
}

.jp-OutputArea-output dt {
font-weight: bold;
float: left;
width: 20%;
padding: 0;
margin: 0;
}

.jp-OutputArea-output dd {
float: left;
width: 80%;
padding: 0;
margin: 0;
}

.jp-TrimmedOutputs pre {
background: var(--jp-layout-color3);
font-size: calc(var(--jp-code-font-size) \* 1.4);
text-align: center;
text-transform: uppercase;
}

/\* Hide the gutter in case of

- - nested output areas (e.g. in the case of output widgets)
- - mirrored output areas
    \*/
    .jp-OutputArea .jp-OutputArea .jp-OutputArea-prompt {
    display: none;
    }

/_ Hide empty lines in the output area, for instance due to cleared widgets _/
.jp-OutputArea-prompt:empty {
padding: 0;
border: 0;
}

/_-----------------------------------------------------------------------------
| executeResult is added to any Output-result for the display of the object
| returned by a cell
|----------------------------------------------------------------------------_/

.jp-OutputArea-output.jp-OutputArea-executeResult {
margin-left: 0;
width: 100%;
}

/\* Text output with the Out[] prompt needs a top padding to match the

- alignment of the Out[] prompt itself.
  \*/
  .jp-OutputArea-executeResult .jp-RenderedText.jp-OutputArea-output {
  padding-top: var(--jp-code-padding);
  border-top: var(--jp-border-width) solid transparent;
  }

/_-----------------------------------------------------------------------------
| The Stdin output
|----------------------------------------------------------------------------_/

.jp-Stdin-prompt {
color: var(--jp-content-font-color0);
padding-right: var(--jp-code-padding);
vertical-align: baseline;
flex: 0 0 auto;
}

.jp-Stdin-input {
font-family: var(--jp-code-font-family);
font-size: inherit;
color: inherit;
background-color: inherit;
width: 42%;
min-width: 200px;

/_ make sure input baseline aligns with prompt _/
vertical-align: baseline;

/_ padding + margin = 0.5em between prompt and cursor _/
padding: 0 0.25em;
margin: 0 0.25em;
flex: 0 0 70%;
}

.jp-Stdin-input::placeholder {
opacity: 0;
}

.jp-Stdin-input:focus {
box-shadow: none;
}

.jp-Stdin-input:focus::placeholder {
opacity: 1;
}

/_-----------------------------------------------------------------------------
| Output Area View
|----------------------------------------------------------------------------_/

.jp-LinkedOutputView .jp-OutputArea {
height: 100%;
display: block;
}

.jp-LinkedOutputView .jp-OutputArea-output:only-child {
height: 100%;
}

/_-----------------------------------------------------------------------------
| Printing
|----------------------------------------------------------------------------_/

@media print {
.jp-OutputArea-child {
break-inside: avoid-page;
}
}

/_-----------------------------------------------------------------------------
| Mobile
|----------------------------------------------------------------------------_/
@media only screen and (max-width: 760px) {
.jp-OutputPrompt {
display: table-row;
text-align: left;
}

.jp-OutputArea-child .jp-OutputArea-output {
display: table-row;
margin-left: var(--jp-notebook-padding);
}
}

/_ Trimmed outputs warning _/
.jp-TrimmedOutputs > a {
margin: 10px;
text-decoration: none;
cursor: pointer;
}

.jp-TrimmedOutputs > a:hover {
text-decoration: none;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Table of Contents
|----------------------------------------------------------------------------_/

:root {
--jp-private-toc-active-width: 4px;
}

.jp-TableOfContents {
display: flex;
flex-direction: column;
background: var(--jp-layout-color1);
color: var(--jp-ui-font-color1);
font-size: var(--jp-ui-font-size1);
height: 100%;
}

.jp-TableOfContents-placeholder {
text-align: center;
}

.jp-TableOfContents-placeholderContent {
color: var(--jp-content-font-color2);
padding: 8px;
}

.jp-TableOfContents-placeholderContent > h3 {
margin-bottom: var(--jp-content-heading-margin-bottom);
}

.jp-TableOfContents .jp-SidePanel-content {
overflow-y: auto;
}

.jp-TableOfContents-tree {
margin: 4px;
}

.jp-TableOfContents ol {
list-style-type: none;
}

/_ stylelint-disable-next-line selector-max-type _/
.jp-TableOfContents li > ol {
/_ Align left border with triangle icon center _/
padding-left: 11px;
}

.jp-TableOfContents-content {
/_ left margin for the active heading indicator _/
margin: 0 0 0 var(--jp-private-toc-active-width);
padding: 0;
background-color: var(--jp-layout-color1);
}

.jp-tocItem {
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

.jp-tocItem-heading {
display: flex;
cursor: pointer;
}

.jp-tocItem-heading:hover {
background-color: var(--jp-layout-color2);
}

.jp-tocItem-content {
display: block;
padding: 4px 0;
white-space: nowrap;
text-overflow: ellipsis;
overflow-x: hidden;
}

.jp-tocItem-collapser {
height: 20px;
margin: 2px 2px 0;
padding: 0;
background: none;
border: none;
cursor: pointer;
}

.jp-tocItem-collapser:hover {
background-color: var(--jp-layout-color3);
}

/_ Active heading indicator _/

.jp-tocItem-heading::before {
content: ' ';
background: transparent;
width: var(--jp-private-toc-active-width);
height: 24px;
position: absolute;
left: 0;
border-radius: var(--jp-border-radius);
}

.jp-tocItem-heading.jp-tocItem-active::before {
background-color: var(--jp-brand-color1);
}

.jp-tocItem-heading:hover.jp-tocItem-active::before {
background: var(--jp-brand-color0);
opacity: 1;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

.jp-Collapser {
flex: 0 0 var(--jp-cell-collapser-width);
padding: 0;
margin: 0;
border: none;
outline: none;
background: transparent;
border-radius: var(--jp-border-radius);
opacity: 1;
}

.jp-Collapser-child {
display: block;
width: 100%;
box-sizing: border-box;

/_ height: 100% doesn't work because the height of its parent is computed from content _/
position: absolute;
top: 0;
bottom: 0;
}

/_-----------------------------------------------------------------------------
| Printing
|----------------------------------------------------------------------------_/

/\*
Hiding collapsers in print mode.

Note: input and output wrappers have "display: block" propery in print mode.
\*/

@media print {
.jp-Collapser {
display: none;
}
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Header/Footer
|----------------------------------------------------------------------------_/

/_ Hidden by zero height by default _/
.jp-CellHeader,
.jp-CellFooter {
height: 0;
width: 100%;
padding: 0;
margin: 0;
border: none;
outline: none;
background: transparent;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Input
|----------------------------------------------------------------------------_/

/_ All input areas _/
.jp-InputArea {
display: table;
table-layout: fixed;
width: 100%;
overflow: hidden;
}

.jp-InputArea-editor {
display: table-cell;
overflow: hidden;
vertical-align: top;

/_ This is the non-active, default styling _/
border: var(--jp-border-width) solid var(--jp-cell-editor-border-color);
border-radius: 0;
background: var(--jp-cell-editor-background);
}

.jp-InputPrompt {
display: table-cell;
vertical-align: top;
width: var(--jp-cell-prompt-width);
color: var(--jp-cell-inprompt-font-color);
font-family: var(--jp-cell-prompt-font-family);
padding: var(--jp-code-padding);
letter-spacing: var(--jp-cell-prompt-letter-spacing);
opacity: var(--jp-cell-prompt-opacity);
line-height: var(--jp-code-line-height);
font-size: var(--jp-code-font-size);
border: var(--jp-border-width) solid transparent;

/_ Right align prompt text, don't wrap to handle large prompt numbers _/
text-align: right;
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;

/_ Disable text selection _/
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
}

/_-----------------------------------------------------------------------------
| Mobile
|----------------------------------------------------------------------------_/
@media only screen and (max-width: 760px) {
.jp-InputArea-editor {
display: table-row;
margin-left: var(--jp-notebook-padding);
}

.jp-InputPrompt {
display: table-row;
text-align: left;
}
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Placeholder
|----------------------------------------------------------------------------_/

.jp-Placeholder {
display: table;
table-layout: fixed;
width: 100%;
}

.jp-Placeholder-prompt {
display: table-cell;
box-sizing: border-box;
}

.jp-Placeholder-content {
display: table-cell;
padding: 4px 6px;
border: 1px solid transparent;
border-radius: 0;
background: none;
box-sizing: border-box;
cursor: pointer;
}

.jp-Placeholder-contentContainer {
display: flex;
}

.jp-Placeholder-content:hover,
.jp-InputPlaceholder > .jp-Placeholder-content:hover {
border-color: var(--jp-layout-color3);
}

.jp-Placeholder-content .jp-MoreHorizIcon {
width: 32px;
height: 16px;
border: 1px solid transparent;
border-radius: var(--jp-border-radius);
}

.jp-Placeholder-content .jp-MoreHorizIcon:hover {
border: 1px solid var(--jp-border-color1);
box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.25);
background-color: var(--jp-layout-color0);
}

.jp-PlaceholderText {
white-space: nowrap;
overflow-x: hidden;
color: var(--jp-inverse-layout-color3);
font-family: var(--jp-code-font-family);
}

.jp-InputPlaceholder > .jp-Placeholder-content {
border-color: var(--jp-cell-editor-border-color);
background: var(--jp-cell-editor-background);
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Private CSS variables
|----------------------------------------------------------------------------_/

:root {
--jp-private-cell-scrolling-output-offset: 5px;
}

/_-----------------------------------------------------------------------------
| Cell
|----------------------------------------------------------------------------_/

.jp-Cell {
padding: var(--jp-cell-padding);
margin: 0;
border: none;
outline: none;
background: transparent;
}

/_-----------------------------------------------------------------------------
| Common input/output
|----------------------------------------------------------------------------_/

.jp-Cell-inputWrapper,
.jp-Cell-outputWrapper {
display: flex;
flex-direction: row;
padding: 0;
margin: 0;

/_ Added to reveal the box-shadow on the input and output collapsers. _/
overflow: visible;
}

/_ Only input/output areas inside cells _/
.jp-Cell-inputArea,
.jp-Cell-outputArea {
flex: 1 1 auto;
}

/_-----------------------------------------------------------------------------
| Collapser
|----------------------------------------------------------------------------_/

/\* Make the output collapser disappear when there is not output, but do so

- in a manner that leaves it in the layout and preserves its width.
  \*/
  .jp-Cell.jp-mod-noOutputs .jp-Cell-outputCollapser {
  border: none !important;
  background: transparent !important;
  }

.jp-Cell:not(.jp-mod-noOutputs) .jp-Cell-outputCollapser {
min-height: var(--jp-cell-collapser-min-height);
}

/_-----------------------------------------------------------------------------
| Output
|----------------------------------------------------------------------------_/

/_ Put a space between input and output when there IS output _/
.jp-Cell:not(.jp-mod-noOutputs) .jp-Cell-outputWrapper {
margin-top: 5px;
}

.jp-CodeCell.jp-mod-outputsScrolled .jp-Cell-outputArea {
overflow-y: auto;
max-height: 24em;
margin-left: var(--jp-private-cell-scrolling-output-offset);
resize: vertical;
}

.jp-CodeCell.jp-mod-outputsScrolled .jp-Cell-outputArea[style*='height'] {
max-height: unset;
}

.jp-CodeCell.jp-mod-outputsScrolled .jp-Cell-outputArea::after {
content: ' ';
box-shadow: inset 0 0 6px 2px rgb(0 0 0 / 30%);
width: 100%;
height: 100%;
position: sticky;
bottom: 0;
top: 0;
margin-top: -50%;
float: left;
display: block;
pointer-events: none;
}

.jp-CodeCell.jp-mod-outputsScrolled .jp-OutputArea-child {
padding-top: 6px;
}

.jp-CodeCell.jp-mod-outputsScrolled .jp-OutputArea-prompt {
width: calc(
var(--jp-cell-prompt-width) - var(--jp-private-cell-scrolling-output-offset)
);
}

.jp-CodeCell.jp-mod-outputsScrolled .jp-OutputArea-promptOverlay {
left: calc(-1 \* var(--jp-private-cell-scrolling-output-offset));
}

/_-----------------------------------------------------------------------------
| CodeCell
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| MarkdownCell
|----------------------------------------------------------------------------_/

.jp-MarkdownOutput {
display: table-cell;
width: 100%;
margin-top: 0;
margin-bottom: 0;
padding-left: var(--jp-code-padding);
}

.jp-MarkdownOutput.jp-RenderedHTMLCommon {
overflow: auto;
}

/_ collapseHeadingButton (show always if hiddenCellsButton is *not* shown) _/
.jp-collapseHeadingButton {
display: flex;
min-height: var(--jp-cell-collapser-min-height);
font-size: var(--jp-code-font-size);
position: absolute;
background-color: transparent;
background-size: 25px;
background-repeat: no-repeat;
background-position-x: center;
background-position-y: top;
background-image: var(--jp-icon-caret-down);
right: 0;
top: 0;
bottom: 0;
}

.jp-collapseHeadingButton.jp-mod-collapsed {
background-image: var(--jp-icon-caret-right);
}

/_
set the container font size to match that of content
so that the nested collapse buttons have the right size
_/
.jp-MarkdownCell .jp-InputPrompt {
font-size: var(--jp-content-font-size1);
}

/_
Align collapseHeadingButton with cell top header
The font sizes are identical to the ones in packages/rendermime/style/base.css
_/
.jp-mod-rendered .jp-collapseHeadingButton[data-heading-level='1'] {
font-size: var(--jp-content-font-size5);
background-position-y: calc(0.3 \* var(--jp-content-font-size5));
}

.jp-mod-rendered .jp-collapseHeadingButton[data-heading-level='2'] {
font-size: var(--jp-content-font-size4);
background-position-y: calc(0.3 \* var(--jp-content-font-size4));
}

.jp-mod-rendered .jp-collapseHeadingButton[data-heading-level='3'] {
font-size: var(--jp-content-font-size3);
background-position-y: calc(0.3 \* var(--jp-content-font-size3));
}

.jp-mod-rendered .jp-collapseHeadingButton[data-heading-level='4'] {
font-size: var(--jp-content-font-size2);
background-position-y: calc(0.3 \* var(--jp-content-font-size2));
}

.jp-mod-rendered .jp-collapseHeadingButton[data-heading-level='5'] {
font-size: var(--jp-content-font-size1);
background-position-y: top;
}

.jp-mod-rendered .jp-collapseHeadingButton[data-heading-level='6'] {
font-size: var(--jp-content-font-size0);
background-position-y: top;
}

/_ collapseHeadingButton (show only on (hover,active) if hiddenCellsButton is shown) _/
.jp-Notebook.jp-mod-showHiddenCellsButton .jp-collapseHeadingButton {
display: none;
}

.jp-Notebook.jp-mod-showHiddenCellsButton
:is(.jp-MarkdownCell:hover, .jp-mod-active)
.jp-collapseHeadingButton {
display: flex;
}

/_ showHiddenCellsButton (only show if jp-mod-showHiddenCellsButton is set, which
is a consequence of the showHiddenCellsButton option in Notebook Settings)_/
.jp-Notebook.jp-mod-showHiddenCellsButton .jp-showHiddenCellsButton {
margin-left: calc(var(--jp-cell-prompt-width) + 2 \* var(--jp-code-padding));
margin-top: var(--jp-code-padding);
border: 1px solid var(--jp-border-color2);
background-color: var(--jp-border-color3) !important;
color: var(--jp-content-font-color0) !important;
display: flex;
}

.jp-Notebook.jp-mod-showHiddenCellsButton .jp-showHiddenCellsButton:hover {
background-color: var(--jp-border-color2) !important;
}

.jp-showHiddenCellsButton {
display: none;
}

/_-----------------------------------------------------------------------------
| Printing
|----------------------------------------------------------------------------_/

/_
Using block instead of flex to allow the use of the break-inside CSS property for
cell outputs.
_/

@media print {
.jp-Cell-inputWrapper,
.jp-Cell-outputWrapper {
display: block;
}
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Variables
|----------------------------------------------------------------------------_/

:root {
--jp-notebook-toolbar-padding: 2px 5px 2px 2px;
}

/\*-----------------------------------------------------------------------------

/_-----------------------------------------------------------------------------
| Styles
|----------------------------------------------------------------------------_/

.jp-NotebookPanel-toolbar {
padding: var(--jp-notebook-toolbar-padding);

/_ disable paint containment from lumino 2.0 default strict CSS containment _/
contain: style size !important;
}

.jp-Toolbar-item.jp-Notebook-toolbarCellType .jp-select-wrapper.jp-mod-focused {
border: none;
box-shadow: none;
}

.jp-Notebook-toolbarCellTypeDropdown select {
height: 24px;
font-size: var(--jp-ui-font-size1);
line-height: 14px;
border-radius: 0;
display: block;
}

.jp-Notebook-toolbarCellTypeDropdown span {
top: 5px !important;
}

.jp-Toolbar-responsive-popup {
position: absolute;
height: fit-content;
display: flex;
flex-direction: row;
flex-wrap: wrap;
justify-content: flex-end;
border-bottom: var(--jp-border-width) solid var(--jp-toolbar-border-color);
box-shadow: var(--jp-toolbar-box-shadow);
background: var(--jp-toolbar-background);
min-height: var(--jp-toolbar-micro-height);
padding: var(--jp-notebook-toolbar-padding);
z-index: 1;
right: 0;
top: 0;
}

.jp-Toolbar > .jp-Toolbar-responsive-opener {
margin-left: auto;
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Variables
|----------------------------------------------------------------------------_/

/\*-----------------------------------------------------------------------------

/_-----------------------------------------------------------------------------
| Styles
|----------------------------------------------------------------------------_/

.jp-Notebook-ExecutionIndicator {
position: relative;
display: inline-block;
height: 100%;
z-index: 9997;
}

.jp-Notebook-ExecutionIndicator-tooltip {
visibility: hidden;
height: auto;
width: max-content;
width: -moz-max-content;
background-color: var(--jp-layout-color2);
color: var(--jp-ui-font-color1);
text-align: justify;
border-radius: 6px;
padding: 0 5px;
position: fixed;
display: table;
}

.jp-Notebook-ExecutionIndicator-tooltip.up {
transform: translateX(-50%) translateY(-100%) translateY(-32px);
}

.jp-Notebook-ExecutionIndicator-tooltip.down {
transform: translateX(calc(-100% + 16px)) translateY(5px);
}

.jp-Notebook-ExecutionIndicator-tooltip.hidden {
display: none;
}

.jp-Notebook-ExecutionIndicator:hover .jp-Notebook-ExecutionIndicator-tooltip {
visibility: visible;
}

.jp-Notebook-ExecutionIndicator span {
font-size: var(--jp-ui-font-size1);
font-family: var(--jp-ui-font-family);
color: var(--jp-ui-font-color1);
line-height: 24px;
display: block;
}

.jp-Notebook-ExecutionIndicator-progress-bar {
display: flex;
justify-content: center;
height: 100%;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

/\*

- Execution indicator
  \*/
  .jp-tocItem-content::after {
  content: '';

/_ Must be identical to form a circle _/
width: 12px;
height: 12px;
background: none;
border: none;
position: absolute;
right: 0;
}

.jp-tocItem-content[data-running='0']::after {
border-radius: 50%;
border: var(--jp-border-width) solid var(--jp-inverse-layout-color3);
background: none;
}

.jp-tocItem-content[data-running='1']::after {
border-radius: 50%;
border: var(--jp-border-width) solid var(--jp-inverse-layout-color3);
background-color: var(--jp-inverse-layout-color3);
}

.jp-tocItem-content[data-running='0'],
.jp-tocItem-content[data-running='1'] {
margin-right: 12px;
}

/\*

- Copyright (c) Jupyter Development Team.
- Distributed under the terms of the Modified BSD License.
  \*/

.jp-Notebook-footer {
height: 27px;
margin-left: calc(
var(--jp-cell-prompt-width) + var(--jp-cell-collapser-width) +
var(--jp-cell-padding)
);
width: calc(
100% -
(
var(--jp-cell-prompt-width) + var(--jp-cell-collapser-width) +
var(--jp-cell-padding) + var(--jp-cell-padding)
)
);
border: var(--jp-border-width) solid var(--jp-cell-editor-border-color);
color: var(--jp-ui-font-color3);
margin-top: 6px;
background: none;
cursor: pointer;
}

.jp-Notebook-footer:focus {
border-color: var(--jp-cell-editor-active-border-color);
}

/_ For devices that support hovering, hide footer until hover _/
@media (hover: hover) {
.jp-Notebook-footer {
opacity: 0;
}

.jp-Notebook-footer:focus,
.jp-Notebook-footer:hover {
opacity: 1;
}
}

/_-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| Imports
|----------------------------------------------------------------------------_/

/_-----------------------------------------------------------------------------
| CSS variables
|----------------------------------------------------------------------------_/

:root {
--jp-side-by-side-output-size: 1fr;
--jp-side-by-side-resized-cell: var(--jp-side-by-side-output-size);
--jp-private-notebook-dragImage-width: 304px;
--jp-private-notebook-dragImage-height: 36px;
--jp-private-notebook-selected-color: var(--md-blue-400);
--jp-private-notebook-active-color: var(--md-green-400);
}

/_-----------------------------------------------------------------------------
| Notebook
|----------------------------------------------------------------------------_/

/_ stylelint-disable selector-max-class _/

.jp-NotebookPanel {
display: block;
height: 100%;
}

.jp-NotebookPanel.jp-Document {
min-width: 240px;
min-height: 120px;
}

.jp-Notebook {
padding: var(--jp-notebook-padding);
outline: none;
overflow: auto;
background: var(--jp-layout-color0);
}

.jp-Notebook.jp-mod-scrollPastEnd::after {
display: block;
content: '';
min-height: var(--jp-notebook-scroll-padding);
}

.jp-MainAreaWidget-ContainStrict .jp-Notebook \* {
contain: strict;
}

.jp-Notebook .jp-Cell {
overflow: visible;
}

.jp-Notebook .jp-Cell .jp-InputPrompt {
cursor: move;
}

/_-----------------------------------------------------------------------------
| Notebook state related styling
|
| The notebook and cells each have states, here are the possibilities:
|
| - Notebook
| - Command
| - Edit
| - Cell
| - None
| - Active (only one can be active)
| - Selected (the cells actions are applied to)
| - Multiselected (when multiple selected, the cursor)
| - No outputs
|----------------------------------------------------------------------------_/

/_ Command or edit modes _/

.jp-Notebook .jp-Cell:not(.jp-mod-active) .jp-InputPrompt {
opacity: var(--jp-cell-prompt-not-active-opacity);
color: var(--jp-cell-prompt-not-active-font-color);
}

.jp-Notebook .jp-Cell:not(.jp-mod-active) .jp-OutputPrompt {
opacity: var(--jp-cell-prompt-not-active-opacity);
color: var(--jp-cell-prompt-not-active-font-color);
}

/_ cell is active _/
.jp-Notebook .jp-Cell.jp-mod-active .jp-Collapser {
background: var(--jp-brand-color1);
}

/_ cell is dirty _/
.jp-Notebook .jp-Cell.jp-mod-dirty .jp-InputPrompt {
color: var(--jp-warn-color1);
}

.jp-Notebook .jp-Cell.jp-mod-dirty .jp-InputPrompt::before {
color: var(--jp-warn-color1);
content: '•';
}

.jp-Notebook .jp-Cell.jp-mod-active.jp-mod-dirty .jp-Collapser {
background: var(--jp-warn-color1);
}

/_ collapser is hovered _/
.jp-Notebook .jp-Cell .jp-Collapser:hover {
box-shadow: var(--jp-elevation-z2);
background: var(--jp-brand-color1);
opacity: var(--jp-cell-collapser-not-active-hover-opacity);
}

/_ cell is active and collapser is hovered _/
.jp-Notebook .jp-Cell.jp-mod-active .jp-Collapser:hover {
background: var(--jp-brand-color0);
opacity: 1;
}

/_ Command mode _/

.jp-Notebook.jp-mod-commandMode .jp-Cell.jp-mod-selected {
background: var(--jp-notebook-multiselected-color);
}

.jp-Notebook.jp-mod-commandMode
.jp-Cell.jp-mod-active.jp-mod-selected:not(.jp-mod-multiSelected) {
background: transparent;
}

/_ Edit mode _/

.jp-Notebook.jp-mod-editMode .jp-Cell.jp-mod-active .jp-InputArea-editor {
border: var(--jp-border-width) solid var(--jp-cell-editor-active-border-color);
box-shadow: var(--jp-input-box-shadow);
background-color: var(--jp-cell-editor-active-background);
}

/_-----------------------------------------------------------------------------
| Notebook drag and drop
|----------------------------------------------------------------------------_/

.jp-Notebook-cell.jp-mod-dropSource {
opacity: 0.5;
}

.jp-Notebook-cell.jp-mod-dropTarget,
.jp-Notebook.jp-mod-commandMode
.jp-Notebook-cell.jp-mod-active.jp-mod-selected.jp-mod-dropTarget {
border-top-color: var(--jp-private-notebook-selected-color);
border-top-style: solid;
border-top-width: 2px;
}

.jp-dragImage {
display: block;
flex-direction: row;
width: var(--jp-private-notebook-dragImage-width);
height: var(--jp-private-notebook-dragImage-height);
border: var(--jp-border-width) solid var(--jp-cell-editor-border-color);
background: var(--jp-cell-editor-background);
overflow: visible;
}

.jp-dragImage-singlePrompt {
box-shadow: 2px 2px 4px 0 rgba(0, 0, 0, 0.12);
}

.jp-dragImage .jp-dragImage-content {
flex: 1 1 auto;
z-index: 2;
font-size: var(--jp-code-font-size);
font-family: var(--jp-code-font-family);
line-height: var(--jp-code-line-height);
padding: var(--jp-code-padding);
border: var(--jp-border-width) solid var(--jp-cell-editor-border-color);
background: var(--jp-cell-editor-background-color);
color: var(--jp-content-font-color3);
text-align: left;
margin: 4px 4px 4px 0;
}

.jp-dragImage .jp-dragImage-prompt {
flex: 0 0 auto;
min-width: 36px;
color: var(--jp-cell-inprompt-font-color);
padding: var(--jp-code-padding);
padding-left: 12px;
font-family: var(--jp-cell-prompt-font-family);
letter-spacing: var(--jp-cell-prompt-letter-spacing);
line-height: 1.9;
font-size: var(--jp-code-font-size);
border: var(--jp-border-width) solid transparent;
}

.jp-dragImage-multipleBack {
z-index: -1;
position: absolute;
height: 32px;
width: 300px;
top: 8px;
left: 8px;
background: var(--jp-layout-color2);
border: var(--jp-border-width) solid var(--jp-input-border-color);
box-shadow: 2px 2px 4px 0 rgba(0, 0, 0, 0.12);
}

/_-----------------------------------------------------------------------------
| Cell toolbar
|----------------------------------------------------------------------------_/

.jp-NotebookTools {
display: block;
min-width: var(--jp-sidebar-min-width);
color: var(--jp-ui-font-color1);
background: var(--jp-layout-color1);

/_ This is needed so that all font sizing of children done in ems is
_ relative to this base size \*/
font-size: var(--jp-ui-font-size1);
overflow: auto;
}

.jp-ActiveCellTool {
padding: 12px 0;
display: flex;
}

.jp-ActiveCellTool-Content {
flex: 1 1 auto;
}

.jp-ActiveCellTool .jp-ActiveCellTool-CellContent {
background: var(--jp-cell-editor-background);
border: var(--jp-border-width) solid var(--jp-cell-editor-border-color);
border-radius: 0;
min-height: 29px;
}

.jp-ActiveCellTool .jp-InputPrompt {
min-width: calc(var(--jp-cell-prompt-width) \* 0.75);
}

.jp-ActiveCellTool-CellContent > pre {
padding: 5px 4px;
margin: 0;
white-space: normal;
}

.jp-MetadataEditorTool {
flex-direction: column;
padding: 12px 0;
}

.jp-RankedPanel > :not(:first-child) {
margin-top: 12px;
}

.jp-KeySelector select.jp-mod-styled {
font-size: var(--jp-ui-font-size1);
color: var(--jp-ui-font-color0);
border: var(--jp-border-width) solid var(--jp-border-color1);
}

.jp-KeySelector label,
.jp-MetadataEditorTool label,
.jp-NumberSetter label {
line-height: 1.4;
}

.jp-NotebookTools .jp-select-wrapper {
margin-top: 4px;
margin-bottom: 0;
}

.jp-NumberSetter input {
width: 100%;
margin-top: 4px;
}

.jp-NotebookTools .jp-Collapse {
margin-top: 16px;
}

/_-----------------------------------------------------------------------------
| Presentation Mode (.jp-mod-presentationMode)
|----------------------------------------------------------------------------_/

.jp-mod-presentationMode .jp-Notebook {
--jp-content-font-size1: var(--jp-content-presentation-font-size1);
--jp-code-font-size: var(--jp-code-presentation-font-size);
}

.jp-mod-presentationMode .jp-Notebook .jp-Cell .jp-InputPrompt,
.jp-mod-presentationMode .jp-Notebook .jp-Cell .jp-OutputPrompt {
flex: 0 0 110px;
}

/_-----------------------------------------------------------------------------
| Side-by-side Mode (.jp-mod-sideBySide)
|----------------------------------------------------------------------------_/
.jp-mod-sideBySide.jp-Notebook .jp-Notebook-cell {
margin-top: 3em;
margin-bottom: 3em;
margin-left: 5%;
margin-right: 5%;
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell {
display: grid;
grid-template-columns: minmax(0, 1fr) min-content minmax(
0,
var(--jp-side-by-side-output-size)
);
grid-template-rows: auto minmax(0, 1fr) auto;
grid-template-areas:
'header header header'
'input handle output'
'footer footer footer';
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell.jp-mod-resizedCell {
grid-template-columns: minmax(0, 1fr) min-content minmax(
0,
var(--jp-side-by-side-resized-cell)
);
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell .jp-CellHeader {
grid-area: header;
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell .jp-Cell-inputWrapper {
grid-area: input;
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell .jp-Cell-outputWrapper {
/_ overwrite the default margin (no vertical separation needed in side by side move _/
margin-top: 0;
grid-area: output;
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell .jp-CellFooter {
grid-area: footer;
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell .jp-CellResizeHandle {
grid-area: handle;
user-select: none;
display: block;
height: 100%;
cursor: ew-resize;
padding: 0 var(--jp-cell-padding);
}

.jp-mod-sideBySide.jp-Notebook .jp-CodeCell .jp-CellResizeHandle::after {
content: '';
display: block;
background: var(--jp-border-color2);
height: 100%;
width: 5px;
}

.jp-mod-sideBySide.jp-Notebook
.jp-CodeCell.jp-mod-resizedCell
.jp-CellResizeHandle::after {
background: var(--jp-border-color0);
}

.jp-CellResizeHandle {
display: none;
}

/_-----------------------------------------------------------------------------
| Placeholder
|----------------------------------------------------------------------------_/

.jp-Cell-Placeholder {
padding-left: 55px;
}

.jp-Cell-Placeholder-wrapper {
background: #fff;
border: 1px solid;
border-color: #e5e6e9 #dfe0e4 #d0d1d5;
border-radius: 4px;
-webkit-border-radius: 4px;
margin: 10px 15px;
}

.jp-Cell-Placeholder-wrapper-inner {
padding: 15px;
position: relative;
}

.jp-Cell-Placeholder-wrapper-body {
background-repeat: repeat;
background-size: 50% auto;
}

.jp-Cell-Placeholder-wrapper-body div {
background: #f6f7f8;
background-image: -webkit-linear-gradient(
left,
#f6f7f8 0%,
#edeef1 20%,
#f6f7f8 40%,
#f6f7f8 100%
);
background-repeat: no-repeat;
background-size: 800px 104px;
height: 104px;
position: absolute;
right: 15px;
left: 15px;
top: 15px;
}

div.jp-Cell-Placeholder-h1 {
top: 20px;
height: 20px;
left: 15px;
width: 150px;
}

div.jp-Cell-Placeholder-h2 {
left: 15px;
top: 50px;
height: 10px;
width: 100px;
}

div.jp-Cell-Placeholder-content-1,
div.jp-Cell-Placeholder-content-2,
div.jp-Cell-Placeholder-content-3 {
left: 15px;
right: 15px;
height: 10px;
}

div.jp-Cell-Placeholder-content-1 {
top: 100px;
}

div.jp-Cell-Placeholder-content-2 {
top: 120px;
}

div.jp-Cell-Placeholder-content-3 {
top: 140px;
}

</style>
<style type="text/css">
/*-----------------------------------------------------------------------------
| Copyright (c) Jupyter Development Team.
| Distributed under the terms of the Modified BSD License.
|----------------------------------------------------------------------------*/

/\*
The following CSS variables define the main, public API for styling JupyterLab.
These variables should be used by all plugins wherever possible. In other
words, plugins should not define custom colors, sizes, etc unless absolutely
necessary. This enables users to change the visual theme of JupyterLab
by changing these variables.

Many variables appear in an ordered sequence (0,1,2,3). These sequences
are designed to work well together, so for example, `--jp-border-color1` should
be used with `--jp-layout-color1`. The numbers have the following meanings:

- 0: super-primary, reserved for special emphasis
- 1: primary, most important under normal situations
- 2: secondary, next most important under normal situations
- 3: tertiary, next most important under normal situations

Throughout JupyterLab, we are mostly following principles from Google's
Material Design when selecting colors. We are not, however, following
all of MD as it is not optimized for dense, information rich UIs.
\*/

:root {
/\* Elevation

-
- We style box-shadows using Material Design's idea of elevation. These particular numbers are taken from here:
-
- https://github.com/material-components/material-components-web
- https://material-components-web.appspot.com/elevation.html
  \*/

--jp-shadow-base-lightness: 0;
--jp-shadow-umbra-color: rgba(
var(--jp-shadow-base-lightness),
var(--jp-shadow-base-lightness),
var(--jp-shadow-base-lightness),
0.2
);
--jp-shadow-penumbra-color: rgba(
var(--jp-shadow-base-lightness),
var(--jp-shadow-base-lightness),
var(--jp-shadow-base-lightness),
0.14
);
--jp-shadow-ambient-color: rgba(
var(--jp-shadow-base-lightness),
var(--jp-shadow-base-lightness),
var(--jp-shadow-base-lightness),
0.12
);
--jp-elevation-z0: none;
--jp-elevation-z1: 0 2px 1px -1px var(--jp-shadow-umbra-color),
0 1px 1px 0 var(--jp-shadow-penumbra-color),
0 1px 3px 0 var(--jp-shadow-ambient-color);
--jp-elevation-z2: 0 3px 1px -2px var(--jp-shadow-umbra-color),
0 2px 2px 0 var(--jp-shadow-penumbra-color),
0 1px 5px 0 var(--jp-shadow-ambient-color);
--jp-elevation-z4: 0 2px 4px -1px var(--jp-shadow-umbra-color),
0 4px 5px 0 var(--jp-shadow-penumbra-color),
0 1px 10px 0 var(--jp-shadow-ambient-color);
--jp-elevation-z6: 0 3px 5px -1px var(--jp-shadow-umbra-color),
0 6px 10px 0 var(--jp-shadow-penumbra-color),
0 1px 18px 0 var(--jp-shadow-ambient-color);
--jp-elevation-z8: 0 5px 5px -3px var(--jp-shadow-umbra-color),
0 8px 10px 1px var(--jp-shadow-penumbra-color),
0 3px 14px 2px var(--jp-shadow-ambient-color);
--jp-elevation-z12: 0 7px 8px -4px var(--jp-shadow-umbra-color),
0 12px 17px 2px var(--jp-shadow-penumbra-color),
0 5px 22px 4px var(--jp-shadow-ambient-color);
--jp-elevation-z16: 0 8px 10px -5px var(--jp-shadow-umbra-color),
0 16px 24px 2px var(--jp-shadow-penumbra-color),
0 6px 30px 5px var(--jp-shadow-ambient-color);
--jp-elevation-z20: 0 10px 13px -6px var(--jp-shadow-umbra-color),
0 20px 31px 3px var(--jp-shadow-penumbra-color),
0 8px 38px 7px var(--jp-shadow-ambient-color);
--jp-elevation-z24: 0 11px 15px -7px var(--jp-shadow-umbra-color),
0 24px 38px 3px var(--jp-shadow-penumbra-color),
0 9px 46px 8px var(--jp-shadow-ambient-color);

/\* Borders

-
- The following variables, specify the visual styling of borders in JupyterLab.
  \*/

--jp-border-width: 1px;
--jp-border-color0: var(--md-grey-400);
--jp-border-color1: var(--md-grey-400);
--jp-border-color2: var(--md-grey-300);
--jp-border-color3: var(--md-grey-200);
--jp-inverse-border-color: var(--md-grey-600);
--jp-border-radius: 2px;

/\* UI Fonts

-
- The UI font CSS variables are used for the typography all of the JupyterLab
- user interface elements that are not directly user generated content.
-
- The font sizing here is done assuming that the body font size of --jp-ui-font-size1
- is applied to a parent element. When children elements, such as headings, are sized
- in em all things will be computed relative to that body size.
  \*/

--jp-ui-font-scale-factor: 1.2;
--jp-ui-font-size0: 0.83333em;
--jp-ui-font-size1: 13px; /_ Base font size _/
--jp-ui-font-size2: 1.2em;
--jp-ui-font-size3: 1.44em;
--jp-ui-font-family: system-ui, -apple-system, blinkmacsystemfont, 'Segoe UI',
helvetica, arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji',
'Segoe UI Symbol';

/\*

- Use these font colors against the corresponding main layout colors.
- In a light theme, these go from dark to light.
  \*/

/_ Defaults use Material Design specification _/
--jp-ui-font-color0: rgba(0, 0, 0, 1);
--jp-ui-font-color1: rgba(0, 0, 0, 0.87);
--jp-ui-font-color2: rgba(0, 0, 0, 0.54);
--jp-ui-font-color3: rgba(0, 0, 0, 0.38);

/\*

- Use these against the brand/accent/warn/error colors.
- These will typically go from light to darker, in both a dark and light theme.
  \*/

--jp-ui-inverse-font-color0: rgba(255, 255, 255, 1);
--jp-ui-inverse-font-color1: rgba(255, 255, 255, 1);
--jp-ui-inverse-font-color2: rgba(255, 255, 255, 0.7);
--jp-ui-inverse-font-color3: rgba(255, 255, 255, 0.5);

/\* Content Fonts

-
- Content font variables are used for typography of user generated content.
-
- The font sizing here is done assuming that the body font size of --jp-content-font-size1
- is applied to a parent element. When children elements, such as headings, are sized
- in em all things will be computed relative to that body size.
  \*/

--jp-content-line-height: 1.6;
--jp-content-font-scale-factor: 1.2;
--jp-content-font-size0: 0.83333em;
--jp-content-font-size1: 14px; /_ Base font size _/
--jp-content-font-size2: 1.2em;
--jp-content-font-size3: 1.44em;
--jp-content-font-size4: 1.728em;
--jp-content-font-size5: 2.0736em;

/_ This gives a magnification of about 125% in presentation mode over normal. _/
--jp-content-presentation-font-size1: 17px;
--jp-content-heading-line-height: 1;
--jp-content-heading-margin-top: 1.2em;
--jp-content-heading-margin-bottom: 0.8em;
--jp-content-heading-font-weight: 500;

/_ Defaults use Material Design specification _/
--jp-content-font-color0: rgba(0, 0, 0, 1);
--jp-content-font-color1: rgba(0, 0, 0, 0.87);
--jp-content-font-color2: rgba(0, 0, 0, 0.54);
--jp-content-font-color3: rgba(0, 0, 0, 0.38);
--jp-content-link-color: var(--md-blue-900);
--jp-content-font-family: system-ui, -apple-system, blinkmacsystemfont,
'Segoe UI', helvetica, arial, sans-serif, 'Apple Color Emoji',
'Segoe UI Emoji', 'Segoe UI Symbol';

/\*

- Code Fonts
-
- Code font variables are used for typography of code and other monospaces content.
  \*/

--jp-code-font-size: 13px;
--jp-code-line-height: 1.3077; /_ 17px for 13px base _/
--jp-code-padding: 5px; /_ 5px for 13px base, codemirror highlighting needs integer px value _/
--jp-code-font-family-default: menlo, consolas, 'DejaVu Sans Mono', monospace;
--jp-code-font-family: var(--jp-code-font-family-default);

/_ This gives a magnification of about 125% in presentation mode over normal. _/
--jp-code-presentation-font-size: 16px;

/_ may need to tweak cursor width if you change font size _/
--jp-code-cursor-width0: 1.4px;
--jp-code-cursor-width1: 2px;
--jp-code-cursor-width2: 4px;

/\* Layout

-
- The following are the main layout colors use in JupyterLab. In a light
- theme these would go from light to dark.
  \*/

--jp-layout-color0: white;
--jp-layout-color1: white;
--jp-layout-color2: var(--md-grey-200);
--jp-layout-color3: var(--md-grey-400);
--jp-layout-color4: var(--md-grey-600);

/\* Inverse Layout

-
- The following are the inverse layout colors use in JupyterLab. In a light
- theme these would go from dark to light.
  \*/

--jp-inverse-layout-color0: #111;
--jp-inverse-layout-color1: var(--md-grey-900);
--jp-inverse-layout-color2: var(--md-grey-800);
--jp-inverse-layout-color3: var(--md-grey-700);
--jp-inverse-layout-color4: var(--md-grey-600);

/_ Brand/accent _/

--jp-brand-color0: var(--md-blue-900);
--jp-brand-color1: var(--md-blue-700);
--jp-brand-color2: var(--md-blue-300);
--jp-brand-color3: var(--md-blue-100);
--jp-brand-color4: var(--md-blue-50);
--jp-accent-color0: var(--md-green-900);
--jp-accent-color1: var(--md-green-700);
--jp-accent-color2: var(--md-green-300);
--jp-accent-color3: var(--md-green-100);

/_ State colors (warn, error, success, info) _/

--jp-warn-color0: var(--md-orange-900);
--jp-warn-color1: var(--md-orange-700);
--jp-warn-color2: var(--md-orange-300);
--jp-warn-color3: var(--md-orange-100);
--jp-error-color0: var(--md-red-900);
--jp-error-color1: var(--md-red-700);
--jp-error-color2: var(--md-red-300);
--jp-error-color3: var(--md-red-100);
--jp-success-color0: var(--md-green-900);
--jp-success-color1: var(--md-green-700);
--jp-success-color2: var(--md-green-300);
--jp-success-color3: var(--md-green-100);
--jp-info-color0: var(--md-cyan-900);
--jp-info-color1: var(--md-cyan-700);
--jp-info-color2: var(--md-cyan-300);
--jp-info-color3: var(--md-cyan-100);

/_ Cell specific styles _/

--jp-cell-padding: 5px;
--jp-cell-collapser-width: 8px;
--jp-cell-collapser-min-height: 20px;
--jp-cell-collapser-not-active-hover-opacity: 0.6;
--jp-cell-editor-background: var(--md-grey-100);
--jp-cell-editor-border-color: var(--md-grey-300);
--jp-cell-editor-box-shadow: inset 0 0 2px var(--md-blue-300);
--jp-cell-editor-active-background: var(--jp-layout-color0);
--jp-cell-editor-active-border-color: var(--jp-brand-color1);
--jp-cell-prompt-width: 64px;
--jp-cell-prompt-font-family: var(--jp-code-font-family-default);
--jp-cell-prompt-letter-spacing: 0;
--jp-cell-prompt-opacity: 1;
--jp-cell-prompt-not-active-opacity: 0.5;
--jp-cell-prompt-not-active-font-color: var(--md-grey-700);

/\* A custom blend of MD grey and blue 600

- See https://meyerweb.com/eric/tools/color-blend/#546E7A:1E88E5:5:hex \*/
  --jp-cell-inprompt-font-color: #307fc1;

/\* A custom blend of MD grey and orange 600

- https://meyerweb.com/eric/tools/color-blend/#546E7A:F4511E:5:hex \*/
  --jp-cell-outprompt-font-color: #bf5b3d;

/_ Notebook specific styles _/

--jp-notebook-padding: 10px;
--jp-notebook-select-background: var(--jp-layout-color1);
--jp-notebook-multiselected-color: var(--md-blue-50);

/_ The scroll padding is calculated to fill enough space at the bottom of the
notebook to show one single-line cell (with appropriate padding) at the top
when the notebook is scrolled all the way to the bottom. We also subtract one
pixel so that no scrollbar appears if we have just one single-line cell in the
notebook. This padding is to enable a 'scroll past end' feature in a notebook.
_/
--jp-notebook-scroll-padding: calc(
100% - var(--jp-code-font-size) \* var(--jp-code-line-height) -
var(--jp-code-padding) - var(--jp-cell-padding) - 1px
);

/_ Rendermime styles _/

--jp-rendermime-error-background: #fdd;
--jp-rendermime-table-row-background: var(--md-grey-100);
--jp-rendermime-table-row-hover-background: var(--md-light-blue-50);

/_ Dialog specific styles _/

--jp-dialog-background: rgba(0, 0, 0, 0.25);

/_ Console specific styles _/

--jp-console-padding: 10px;

/_ Toolbar specific styles _/

--jp-toolbar-border-color: var(--jp-border-color1);
--jp-toolbar-micro-height: 8px;
--jp-toolbar-background: var(--jp-layout-color1);
--jp-toolbar-box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.24);
--jp-toolbar-header-margin: 4px 4px 0 4px;
--jp-toolbar-active-background: var(--md-grey-300);

/_ Statusbar specific styles _/

--jp-statusbar-height: 24px;

/_ Input field styles _/

--jp-input-box-shadow: inset 0 0 2px var(--md-blue-300);
--jp-input-active-background: var(--jp-layout-color1);
--jp-input-hover-background: var(--jp-layout-color1);
--jp-input-background: var(--md-grey-100);
--jp-input-border-color: var(--jp-inverse-border-color);
--jp-input-active-border-color: var(--jp-brand-color1);
--jp-input-active-box-shadow-color: rgba(19, 124, 189, 0.3);

/_ General editor styles _/

--jp-editor-selected-background: #d9d9d9;
--jp-editor-selected-focused-background: #d7d4f0;
--jp-editor-cursor-color: var(--jp-ui-font-color0);

/_ Code mirror specific styles _/

--jp-mirror-editor-keyword-color: #008000;
--jp-mirror-editor-atom-color: #88f;
--jp-mirror-editor-number-color: #080;
--jp-mirror-editor-def-color: #00f;
--jp-mirror-editor-variable-color: var(--md-grey-900);
--jp-mirror-editor-variable-2-color: rgb(0, 54, 109);
--jp-mirror-editor-variable-3-color: #085;
--jp-mirror-editor-punctuation-color: #05a;
--jp-mirror-editor-property-color: #05a;
--jp-mirror-editor-operator-color: #a2f;
--jp-mirror-editor-comment-color: #408080;
--jp-mirror-editor-string-color: #ba2121;
--jp-mirror-editor-string-2-color: #708;
--jp-mirror-editor-meta-color: #a2f;
--jp-mirror-editor-qualifier-color: #555;
--jp-mirror-editor-builtin-color: #008000;
--jp-mirror-editor-bracket-color: #997;
--jp-mirror-editor-tag-color: #170;
--jp-mirror-editor-attribute-color: #00c;
--jp-mirror-editor-header-color: blue;
--jp-mirror-editor-quote-color: #090;
--jp-mirror-editor-link-color: #00c;
--jp-mirror-editor-error-color: #f00;
--jp-mirror-editor-hr-color: #999;

/_
RTC user specific colors.
These colors are used for the cursor, username in the editor,
and the icon of the user.
_/

--jp-collaborator-color1: #ffad8e;
--jp-collaborator-color2: #dac83d;
--jp-collaborator-color3: #72dd76;
--jp-collaborator-color4: #00e4d0;
--jp-collaborator-color5: #45d4ff;
--jp-collaborator-color6: #e2b1ff;
--jp-collaborator-color7: #ff9de6;

/_ Vega extension styles _/

--jp-vega-background: white;

/_ Sidebar-related styles _/

--jp-sidebar-min-width: 250px;

/_ Search-related styles _/

--jp-search-toggle-off-opacity: 0.5;
--jp-search-toggle-hover-opacity: 0.8;
--jp-search-toggle-on-opacity: 1;
--jp-search-selected-match-background-color: rgb(245, 200, 0);
--jp-search-selected-match-color: black;
--jp-search-unselected-match-background-color: var(
--jp-inverse-layout-color0
);
--jp-search-unselected-match-color: var(--jp-ui-inverse-font-color0);

/_ Icon colors that work well with light or dark backgrounds _/
--jp-icon-contrast-color0: var(--md-purple-600);
--jp-icon-contrast-color1: var(--md-green-600);
--jp-icon-contrast-color2: var(--md-pink-600);
--jp-icon-contrast-color3: var(--md-blue-600);

/_ Button colors _/
--jp-accept-color-normal: var(--md-blue-700);
--jp-accept-color-hover: var(--md-blue-800);
--jp-accept-color-active: var(--md-blue-900);
--jp-warn-color-normal: var(--md-red-700);
--jp-warn-color-hover: var(--md-red-800);
--jp-warn-color-active: var(--md-red-900);
--jp-reject-color-normal: var(--md-grey-600);
--jp-reject-color-hover: var(--md-grey-700);
--jp-reject-color-active: var(--md-grey-800);

/_ File or activity icons and switch semantic variables _/
--jp-jupyter-icon-color: #f37626;
--jp-notebook-icon-color: #f37626;
--jp-json-icon-color: var(--md-orange-700);
--jp-console-icon-background-color: var(--md-blue-700);
--jp-console-icon-color: white;
--jp-terminal-icon-background-color: var(--md-grey-800);
--jp-terminal-icon-color: var(--md-grey-200);
--jp-text-editor-icon-color: var(--md-grey-700);
--jp-inspector-icon-color: var(--md-grey-700);
--jp-switch-color: var(--md-grey-400);
--jp-switch-true-position-color: var(--md-orange-900);
}
</style>

<style type="text/css">
/* Force rendering true colors when outputing to pdf */
* {
  -webkit-print-color-adjust: exact;
}

/* Misc */
a.anchor-link {
  display: none;
}

/* Input area styling */
.jp-InputArea {
  overflow: hidden;
}

.jp-InputArea-editor {
  overflow: hidden;
}

.cm-editor.cm-s-jupyter .highlight pre {
/* weird, but --jp-code-padding defined to be 5px but 4px horizontal padding is hardcoded for pre.cm-line */
  padding: var(--jp-code-padding) 4px;
  margin: 0;

  font-family: inherit;
  font-size: inherit;
  line-height: inherit;
  color: inherit;

}

.jp-OutputArea-output pre {
  line-height: inherit;
  font-family: inherit;
}

.jp-RenderedText pre {
  color: var(--jp-content-font-color1);
  font-size: var(--jp-code-font-size);
}

/* Hiding the collapser by default */
.jp-Collapser {
  display: none;
}

@page {
    margin: 0.5in; /* Margin for each printed piece of paper */
}

@media print {
  .jp-Cell-inputWrapper,
  .jp-Cell-outputWrapper {
    display: block;
  }
}
</style>
<!-- Load mathjax -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/latest.js?config=TeX-AMS_CHTML-full,Safe"> </script>
<!-- MathJax configuration -->
<script type="text/x-mathjax-config">
    init_mathjax = function() {
        if (window.MathJax) {
        // MathJax loaded
            MathJax.Hub.Config({
                TeX: {
                    equationNumbers: {
                    autoNumber: "AMS",
                    useLabelIds: true
                    }
                },
                tex2jax: {
                    inlineMath: [ ['$','$'], ["\\(","\\)"] ],
                    displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
                    processEscapes: true,
                    processEnvironments: true
                },
                displayAlign: 'center',
                CommonHTML: {
                    linebreaks: {
                    automatic: true
                    }
                }
            });

            MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
        }
    }
    init_mathjax();
    </script>
<!-- End of mathjax configuration --><script type="module">

document.addEventListener("DOMContentLoaded", async () => {
const diagrams = document.querySelectorAll(".jp-Mermaid > pre.mermaid");
// do not load mermaidjs if not needed
if (!diagrams.length) {
return;
}
const mermaid = (await import("https://cdnjs.cloudflare.com/ajax/libs/mermaid/10.7.0/mermaid.esm.min.mjs")).default;
const parser = new DOMParser();

    mermaid.initialize({
      maxTextSize: 100000,
      maxEdges: 100000,
      startOnLoad: false,
      fontFamily: window
        .getComputedStyle(document.body)
        .getPropertyValue("--jp-ui-font-family"),
      theme: document.querySelector("body[data-jp-theme-light='true']")
        ? "default"
        : "dark",
    });

    let _nextMermaidId = 0;

    function makeMermaidImage(svg) {
      const img = document.createElement("img");
      const doc = parser.parseFromString(svg, "image/svg+xml");
      const svgEl = doc.querySelector("svg");
      const { maxWidth } = svgEl?.style || {};
      const firstTitle = doc.querySelector("title");
      const firstDesc = doc.querySelector("desc");

      img.setAttribute("src", `data:image/svg+xml,${encodeURIComponent(svg)}`);
      if (maxWidth) {
        img.width = parseInt(maxWidth);
      }
      if (firstTitle) {
        img.setAttribute("alt", firstTitle.textContent);
      }
      if (firstDesc) {
        const caption = document.createElement("figcaption");
        caption.className = "sr-only";
        caption.textContent = firstDesc.textContent;
        return [img, caption];
      }
      return [img];
    }

    async function makeMermaidError(text) {
      let errorMessage = "";
      try {
        await mermaid.parse(text);
      } catch (err) {
        errorMessage = `${err}`;
      }

      const result = document.createElement("details");
      result.className = 'jp-RenderedMermaid-Details';
      const summary = document.createElement("summary");
      summary.className = 'jp-RenderedMermaid-Summary';
      const pre = document.createElement("pre");
      const code = document.createElement("code");
      code.innerText = text;
      pre.appendChild(code);
      summary.appendChild(pre);
      result.appendChild(summary);

      const warning = document.createElement("pre");
      warning.innerText = errorMessage;
      result.appendChild(warning);
      return [result];
    }

    async function renderOneMarmaid(src) {
      const id = `jp-mermaid-${_nextMermaidId++}`;
      const parent = src.parentNode;
      let raw = src.textContent.trim();
      const el = document.createElement("div");
      el.style.visibility = "hidden";
      document.body.appendChild(el);
      let results = null;
      let output = null;
      try {
        let { svg } = await mermaid.render(id, raw, el);
        svg = cleanMermaidSvg(svg);
        results = makeMermaidImage(svg);
        output = document.createElement("figure");
        results.map(output.appendChild, output);
      } catch (err) {
        parent.classList.add("jp-mod-warning");
        results = await makeMermaidError(raw);
        output = results[0];
      } finally {
        el.remove();
      }
      parent.classList.add("jp-RenderedMermaid");
      parent.appendChild(output);
    }


    /**
     * Post-process to ensure mermaid diagrams contain only valid SVG and XHTML.
     */
    function cleanMermaidSvg(svg) {
      return svg.replace(RE_VOID_ELEMENT, replaceVoidElement);
    }


    /**
     * A regular expression for all void elements, which may include attributes and
     * a slash.
     *
     * @see https://developer.mozilla.org/en-US/docs/Glossary/Void_element
     *
     * Of these, only `<br>` is generated by Mermaid in place of `\n`,
     * but _any_ "malformed" tag will break the SVG rendering entirely.
     */
    const RE_VOID_ELEMENT =
      /<\s*(area|base|br|col|embed|hr|img|input|link|meta|param|source|track|wbr)\s*([^>]*?)\s*>/gi;

    /**
     * Ensure a void element is closed with a slash, preserving any attributes.
     */
    function replaceVoidElement(match, tag, rest) {
      rest = rest.trim();
      if (!rest.endsWith('/')) {
        rest = `${rest} /`;
      }
      return `<${tag} ${rest}>`;
    }

    void Promise.all([...diagrams].map(renderOneMarmaid));

});
</script>

<style>
  .jp-Mermaid:not(.jp-RenderedMermaid) {
    display: none;
  }

  .jp-RenderedMermaid {
    overflow: auto;
    display: flex;
  }

  .jp-RenderedMermaid.jp-mod-warning {
    width: auto;
    padding: 0.5em;
    margin-top: 0.5em;
    border: var(--jp-border-width) solid var(--jp-warn-color2);
    border-radius: var(--jp-border-radius);
    color: var(--jp-ui-font-color1);
    font-size: var(--jp-ui-font-size1);
    white-space: pre-wrap;
    word-wrap: break-word;
  }

  .jp-RenderedMermaid figure {
    margin: 0;
    overflow: auto;
    max-width: 100%;
  }

  .jp-RenderedMermaid img {
    max-width: 100%;
  }

  .jp-RenderedMermaid-Details > pre {
    margin-top: 1em;
  }

  .jp-RenderedMermaid-Summary {
    color: var(--jp-warn-color2);
  }

  .jp-RenderedMermaid:not(.jp-mod-warning) pre {
    display: none;
  }

  .jp-RenderedMermaid-Summary > pre {
    display: inline-block;
    white-space: normal;
  }
</style>

<div class="jp-Notebook" data-jp-theme-light="true" data-jp-theme-name="JupyterLab Light">
<main><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [106]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="kn">import</span> <span class="n">Markdown</span><span class="p">,</span> <span class="n">display</span>

<span class="n">display</span><span class="p">(</span><span class="n">Markdown</span><span class="p">(</span><span class="s2">"README.md"</span><span class="p">))</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-OutputArea-output" data-mime-type="text/markdown" tabindex="0">
<h1 id="Exploring-Probabilities-in-War-Room-by-Larry-Harris">Exploring Probabilities in War Room by Larry Harris<a class="anchor-link" href="#Exploring-Probabilities-in-War-Room-by-Larry-Harris">¶</a></h1><p>War Room is a board game by Larry Harris, the designer of Axis and Allies. I see it as at least a spiritual successor to AA, if not a complete overhaul. Like AA, it's a grand strategy game set during World War II. Players control the major Axis and Allied powers and vie for the control of territories. The ultimate goals is to capture the opposing capitals and win the war.</p>
<p>See <a href="main.ipynb">main.ipynb</a> for the exploration.</p>
<p>I previously did an exploration of battle outcome probabilities in Axis and Allies using JavaScript and C (links below). Battles in War Room are similar in some ways and very different in others. The unit types are mostly identical, but the way dice are rolled and hits are allocated is different. War Room's dice have six different colors distributed across 12 faces. The first four colors: red, green, blue, and yellow correspond to different unit types. The last two colors: black and white, are wild, and may or may not be applied in specific circumstances.</p>
<p>The other big difference from AA is that only one "round" of combat and dice rolling happens per combat per turn. The impact of this rule is that most combats end up playing out over several turns, during which time the territory remains "contested," and players can make plans and moves that reinforce their forces in the territory. I personally like this. I think it reflects the reality of having different "fronts" open in a given region and potentially bogging down as both sides throw more and more resources into the fight.</p>
<h2 id="Links">Links<a class="anchor-link" href="#Links">¶</a></h2><ul>
<li><a href="https://codepen.io/whusterj/full/YzgJdEy/9439d70207e540169361fbbb0e6133e1">Codepen: War Room Air/Ground Battle Board Simulator</a> - JavaScript implementation of War Room air/ground battle board. Select attacking and defending units and see what might happen.</li>
<li><a href="https://williamhuster.com/explore-js-with-axis-and-allies/">(2020) Explore JavaScript with Axis &amp; Allies</a> - Blog post I wrote breaking down the JavaScript code I wrote to simulate Axis and Allies battles.</li>
<li><a href="https://codepen.io/whusterj/pen/VwvjzQv/b4397c0d26fc315dae283d682f7819d8">Codepen: Axis and Allies in JavaScript</a> - Complete JavaScript implementation of Monte Carlo simulation of Axis and Allies battles.</li>
<li><a href="https://github.com/whusterj/axis-and-allies">Github: Axis and Allies in C</a> - Naive implmeentation of Axis and Allies battle simulator in C. Tinkering with a focus on execution speed.</li>
<li><a href="https://boardgamegeek.com/boardgame/229713/war-room">Board Game Geek: War Room</a></li>
</ul>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [107]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="k">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">matplotlib.pyplot</span> <span class="k">as</span> <span class="nn">plt</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="Part-1---Modeling-the-Probabilities-Using-Simulation">Part 1 - Modeling the Probabilities Using Simulation<a class="anchor-link" href="#Part-1---Modeling-the-Probabilities-Using-Simulation">¶</a></h2><h3 id="Step-1---Set-Up-the-Simulation">Step 1 - Set Up the Simulation<a class="anchor-link" href="#Step-1---Set-Up-the-Simulation">¶</a></h3><p>Start by setting up the colors for the dice, the number of simulations we want to run, and the number of dice to roll per simulation.</p>
<h4 id="Why-Ten-Dice-per-Roll?">Why Ten Dice per Roll?<a class="anchor-link" href="#Why-Ten-Dice-per-Roll?">¶</a></h4><p>I've chosen to roll ten dice per simulation of a roll, because the game includes ten dice and the rules suggest that you roll in batches of ten. Because BLACK and WHITE results are wild, this fact can impact how many "hits" are actually allocatable vs ignored.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [108]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">NUM_SIMULATIONS</span> <span class="o">=</span> <span class="mi">10000</span>
<span class="n">COLORS</span> <span class="o">=</span> <span class="p">(</span><span class="s2">"YELLOW"</span><span class="p">,</span> <span class="s2">"BLUE"</span><span class="p">,</span> <span class="s2">"GREEN"</span><span class="p">,</span> <span class="s2">"RED"</span><span class="p">,</span> <span class="s2">"BLACK"</span><span class="p">,</span> <span class="s2">"WHITE"</span><span class="p">)</span>
<span class="n">COLOR_LOOKUP</span> <span class="o">=</span> <span class="p">{</span>
    <span class="s2">"YELLOW"</span><span class="p">:</span> <span class="s2">"#BBBB77"</span><span class="p">,</span>
    <span class="s2">"BLUE"</span><span class="p">:</span> <span class="s2">"#77AABB"</span><span class="p">,</span>
    <span class="s2">"GREEN"</span><span class="p">:</span> <span class="s2">"#77BB77"</span><span class="p">,</span>
    <span class="s2">"RED"</span><span class="p">:</span> <span class="s2">"#BB7777"</span><span class="p">,</span>
    <span class="s2">"BLACK"</span><span class="p">:</span> <span class="s2">"#222222"</span><span class="p">,</span>
    <span class="s2">"WHITE"</span><span class="p">:</span> <span class="s2">"#B0B0B0"</span>
<span class="p">}</span>
<span class="n">DIE_FACES</span> <span class="o">=</span> <span class="p">[</span>
    <span class="s2">"YELLOW"</span><span class="p">,</span>
    <span class="s2">"YELLOW"</span><span class="p">,</span>
    <span class="s2">"YELLOW"</span><span class="p">,</span>
    <span class="s2">"YELLOW"</span><span class="p">,</span>
    <span class="s2">"BLUE"</span><span class="p">,</span>
    <span class="s2">"BLUE"</span><span class="p">,</span>
    <span class="s2">"BLUE"</span><span class="p">,</span>
    <span class="s2">"GREEN"</span><span class="p">,</span>
    <span class="s2">"GREEN"</span><span class="p">,</span>
    <span class="s2">"RED"</span><span class="p">,</span>
    <span class="s2">"BLACK"</span><span class="p">,</span>
    <span class="s2">"WHITE"</span>
<span class="p">]</span>
<span class="n">NUM_DICE</span> <span class="o">=</span> <span class="mi">10</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="Step-2---Generate-Rolls-for-Each-Simulation">Step 2 - Generate Rolls for Each Simulation<a class="anchor-link" href="#Step-2---Generate-Rolls-for-Each-Simulation">¶</a></h3><p>This is very straightforward in Python. We'll use numpy's <code>random.choice</code> function to simulate rolling all ten die at once. We'll do this for each simulation. All results are collected into a list of lists and then turned into a pandas DataFrame so we can more easily view, manipulate, and analyze the data.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [109]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">random_choices</span> <span class="o">=</span> <span class="p">[]</span>
<span class="k">for</span> <span class="n">_</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">NUM_SIMULATIONS</span><span class="p">):</span>
    <span class="n">choices</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">choice</span><span class="p">(</span><span class="n">DIE_FACES</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="n">NUM_DICE</span><span class="p">)</span>
    <span class="n">random_choices</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">choices</span><span class="p">)</span>

<span class="n">df_random_choices</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">(</span><span class="n">random_choices</span><span class="p">)</span>
<span class="n">df_random_choices</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[109]:</div>
<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html" tabindex="0">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }

</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>0</th>
<th>1</th>
<th>2</th>
<th>3</th>
<th>4</th>
<th>5</th>
<th>6</th>
<th>7</th>
<th>8</th>
<th>9</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>BLACK</td>
<td>BLUE</td>
<td>BLACK</td>
<td>YELLOW</td>
<td>YELLOW</td>
<td>GREEN</td>
<td>WHITE</td>
<td>YELLOW</td>
<td>BLACK</td>
<td>BLUE</td>
</tr>
<tr>
<th>1</th>
<td>GREEN</td>
<td>GREEN</td>
<td>BLACK</td>
<td>YELLOW</td>
<td>GREEN</td>
<td>BLUE</td>
<td>BLUE</td>
<td>GREEN</td>
<td>YELLOW</td>
<td>YELLOW</td>
</tr>
<tr>
<th>2</th>
<td>RED</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>YELLOW</td>
<td>GREEN</td>
<td>BLACK</td>
</tr>
<tr>
<th>3</th>
<td>GREEN</td>
<td>BLACK</td>
<td>BLACK</td>
<td>RED</td>
<td>YELLOW</td>
<td>RED</td>
<td>RED</td>
<td>RED</td>
<td>YELLOW</td>
<td>GREEN</td>
</tr>
<tr>
<th>4</th>
<td>YELLOW</td>
<td>YELLOW</td>
<td>RED</td>
<td>BLUE</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>YELLOW</td>
<td>RED</td>
<td>BLUE</td>
<td>YELLOW</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>9995</th>
<td>BLUE</td>
<td>BLUE</td>
<td>GREEN</td>
<td>BLUE</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>YELLOW</td>
<td>BLUE</td>
</tr>
<tr>
<th>9996</th>
<td>RED</td>
<td>YELLOW</td>
<td>WHITE</td>
<td>BLACK</td>
<td>WHITE</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>BLACK</td>
<td>YELLOW</td>
<td>YELLOW</td>
</tr>
<tr>
<th>9997</th>
<td>BLUE</td>
<td>YELLOW</td>
<td>GREEN</td>
<td>GREEN</td>
<td>GREEN</td>
<td>YELLOW</td>
<td>WHITE</td>
<td>GREEN</td>
<td>YELLOW</td>
<td>YELLOW</td>
</tr>
<tr>
<th>9998</th>
<td>YELLOW</td>
<td>YELLOW</td>
<td>YELLOW</td>
<td>GREEN</td>
<td>RED</td>
<td>YELLOW</td>
<td>BLACK</td>
<td>BLACK</td>
<td>GREEN</td>
<td>BLACK</td>
</tr>
<tr>
<th>9999</th>
<td>BLACK</td>
<td>YELLOW</td>
<td>YELLOW</td>
<td>BLUE</td>
<td>GREEN</td>
<td>BLUE</td>
<td>YELLOW</td>
<td>BLUE</td>
<td>BLUE</td>
<td>GREEN</td>
</tr>
</tbody>
</table>
<p>10000 rows × 10 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="Step-3---Analyze-the-Results">Step 3 - Analyze the Results<a class="anchor-link" href="#Step-3---Analyze-the-Results">¶</a></h3><p>The proportions of colors on the dice are known, so the expected value for a given roll or set of rules is easy to compute and doesn't require a simulation.</p>
<p>But what is less clear is the <em>variability</em> you might expect from each color, and also the aggregate impact of the wild BLACK and WHITE results. So here we look at the distribution by each color.</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h4 id="Get-and-Graph-a-Distribution-for-a-Color">Get and Graph a Distribution for a Color<a class="anchor-link" href="#Get-and-Graph-a-Distribution-for-a-Color">¶</a></h4><p>Here I'm just testing the steps required to aggregate the results of the simulations and plot the distribution of a single color.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [110]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">yellow_distribution</span> <span class="o">=</span> <span class="n">df_random_choices</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">row</span><span class="p">:</span> <span class="n">row</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s1">'YELLOW'</span><span class="p">,</span> <span class="mi">0</span><span class="p">),</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
<span class="n">yellow_distribution</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[110]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>0       3
1       3
2       4
3       2
4       5
       ..
9995    3
9996    4
9997    4
9998    4
9999    3
Length: 10000, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [111]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s2">"Distribution of YELLOW dice"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">yellow_distribution</span><span class="p">,</span> <span class="n">bins</span><span class="o">=</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">],</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"YELLOW"</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[111]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>(array([ 191.,  858., 1919., 2591., 2288., 1362.,  585.,  174.,   28.,
           4.]),
 array([0. , 0.9, 1.8, 2.7, 3.6, 4.5, 5.4, 6.3, 7.2, 8.1, 9. ]),
 &lt;BarContainer object of 10 artists&gt;)</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,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134uRcFzebFb9o8dO+byvAcEBKh58+YuIaVt27b2ZPOoqCiXPm9vb11//fUl7qPgeb3w/VWnTh3VqFGjxMfu3r1bkkqcY7Nr1y5ZlqXHH39cjz/+eJFjcnJydM0115S4L6AoBBjgPD/++KNyc3PVqFGjYsf4+voqJSVFH330kdasWaO1a9dq+fLluummm7Ru3Tp5enpedD8FHzplqbgv28vPz7+kmspCcfuxLpjwW5E1atRIlSpV0tdff13smLy8PO3cubNQ4OrSpYsWLVqko0eP2vNfCkRFRenVV1/VmTNntGnTJrVr187tdw0VnKF8+OGHFRMTU+SYkv7WgJJwCQk4z5IlSySp2P/YFvDw8FCPHj00Z84cffPNN3rqqae0fv16ffTRR5KKDxOX67vvvnNZtyxLu3btcrljqEaNGvYkzvNdePaiNLWFh4frwIEDhc4W7Nixw+4vC+Hh4fruu+8KXZIr6/2UB1WrVlX37t2VkpJS7JmlFStWKC8vT3379nVp79KliyzLUlJSkr788kt17tzZ7ouKitLJkye1Zs0aff/995d0+3TB83rh++vQoUMXPWtWcKlw27ZtxY5p0KCBpN8uB0ZHRxe5XOxSGlAcAgzwX+vXr9e0adMUERGhwYMHFzvuyJEjhdoKvhAuLy9P0m8fUpKKDBSX44033nAJEW+//bYOHjyo3r17220NGzbU5s2bdfr0abtt9erVhW63Lk1tffr0UX5+vp5//nmX9rlz58rhcLjs//fo06ePsrKytHz5crvt7NmzWrBggapVq6Ybb7yxTPZTXjz22GOyLEvDhg0rdCfZnj179MgjjygkJKTQ3VIFoWTOnDk6c+aMyxmY+vXrKyQkRDNnznQZW5Lo6Gh5eXlpwYIFLmfJ5s2bd9HHXnfddYqIiNC8efMKvZcKthUYGKhu3brppZde0sGDBwtt49ChQxfdD1AcLiGhQvrggw+0Y8cOnT17VtnZ2Vq/fr0SExMVHh6uVatWlXjqferUqUpJSVFsbKzCw8OVk5OjF198UXXr1rU/NBo2bKiAgAAtWrRI1atXV9WqVdWxY8dib5u9mJo1a6pLly4aPny4srOzNW/ePDVq1EgjR460x9xzzz16++231atXL912223avXu33nzzTZdJtaWtrV+/furevbv+9re/ae/evWrdurXWrVunlStXKj4+vtC2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QpowYYJSU1P18ccfu7sUSOrbt6+CgoL0j3/8w24bMGCAfH199eabb7qxMnNxBuYSnT59Wunp6YqOjrbbPDw8FB0drbS0NDdWBknKzc2VJNWsWdPNlVRscXFxio2Ndfk7gXusWrVK7du311/+8hcFBgaqbdu2+vvf/+7usiqsqKgoJScn69tvv5UkffXVV9q0aZN69+7t5srMVW5/SqC8+fnnn5Wfn1/opwyCgoK0Y8cON1UF6bczYfHx8ercubNatGjh7nIqrH/961/64osvtGXLFneXAknff/+9Fi5cqISEBD366KPasmWLHnjgAXl7e2vo0KHuLq/CmTBhgpxOp5o0aSJPT0/l5+frqaee0uDBg91dmrEIMDBeXFyctm3bpk2bNrm7lApr//79Gjt2rBITE1W5cmV3lwP9Fuzbt2+vp59+WpLUtm1bbdu2TYsWLSLAuMGKFSu0dOlSLVu2TM2bN1dGRobi4+MVGhrK63GZCDCXqHbt2vL09FR2drZLe3Z2toKDg91UFUaPHq3Vq1crJSVFdevWdXc5FVZ6erpycnJ03XXX2W35+flKSUnR888/r7y8PHl6erqxwoonJCREzZo1c2lr2rSp/v3vf7upoopt3LhxmjBhggYNGiRJatmypX744QdNnz6dAHOZmANziby9vdWuXTslJyfbbefOnVNycrIiIyPdWFnFZFmWRo8erXfeeUfr169XRESEu0uq0Hr06KGtW7cqIyPDXtq3b6/BgwcrIyOD8OIGnTt3LvTVAt9++63Cw8PdVFHF9uuvv8rDw/Uj19PTU+fOnXNTRebjDEwpJCQkaOjQoWrfvr2uv/56zZs3TydOnNDw4cPdXVqFExcXp2XLlmnlypWqXr26srKyJEn+/v7y9fV1c3UVT/Xq1QvNP6patapq1arFvCQ3efDBBxUVFaWnn35at912mz777DO9/PLLevnll91dWoXUr18/PfXUU6pXr56aN2+uL7/8UnPmzNFf//pXd5dmLgulsmDBAqtevXqWt7e3df3111ubN292d0kVkqQil9dee83dpeG/brzxRmvs2LHuLqNCe++996wWLVpYPj4+VpMmTayXX37Z3SVVWE6n0xo7dqxVr149q3LlylaDBg2sv/3tb1ZeXp67SzMW3wMDAACMwxwYAABgHAIMAAAwDgEGAAAYhwADAACMQ4ABAADGIcAAAADjEGAAAIBxCDAAAMA4BBgAAGAcAgwAADAOAQYAABjn/wBM1BPzFOfmHQAAAABJRU5ErkJggg=="/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h4 id="Aggregate-and-Plot-All-Colors">Aggregate and Plot All Colors<a class="anchor-link" href="#Aggregate-and-Plot-All-Colors">¶</a></h4><p>With that figured out for yellow, we can put all colors on the same plot to see how they compare.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [112]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>

<span class="n">fig</span><span class="p">,</span> <span class="n">axes</span> <span class="o">=</span> <span class="n">plt</span><span class="o">.</span><span class="n">subplots</span><span class="p">(</span><span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span>
<span class="n">axes</span> <span class="o">=</span> <span class="n">axes</span><span class="o">.</span><span class="n">flatten</span><span class="p">()</span>

<span class="k">for</span> <span class="n">i</span><span class="p">,</span> <span class="n">color</span> <span class="ow">in</span> <span class="nb">enumerate</span><span class="p">(</span><span class="n">COLORS</span><span class="p">):</span>
<span class="n">distribution</span> <span class="o">=</span> <span class="n">df_random_choices</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">row</span><span class="p">:</span> <span class="n">row</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="n">color</span><span class="p">,</span> <span class="mi">0</span><span class="p">),</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">distribution</span><span class="p">,</span> <span class="n">bins</span><span class="o">=</span><span class="nb">range</span><span class="p">(</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">+</span> <span class="mi">1</span><span class="p">),</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="n">color</span><span class="p">])</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="sa">f</span><span class="s2">"Distribution of </span><span class="si">{</span><span class="n">color</span><span class="si">}</span><span class="s2"> dice"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">set_xlim</span><span class="p">(</span><span class="n">right</span><span class="o">=</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span> <span class="c1"># Set max value on x-axis</span>

<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>&lt;Figure size 640x480 with 0 Axes&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA+sAAAKqCAYAAABCc880AAAAOXRFWHRTb2Z0d2FyZQBNYXRwbG90bGliIHZlcnNpb24zLjguMiwgaHR0cHM6Ly9tYXRwbG90bGliLm9yZy8g+/7EAAAACXBIWXMAAA9hAAAPYQGoP6dpAACy3klEQVR4nOzdeXxOZ/7/8XcWWSwJQXInRKSoPSgtQQlSEaEMpqPUVkvbCS1aW6dVSzWqtVWV7mktU/Rb1aIIsRSxNCO11qBaWpK0VIKSRHJ+f/SXM25ZJGS5E6/n43Ee4z7nc5/runLf/cz53Oec69gZhmEIAAAAAADYDPvi7gAAAAAAALBGsQ4AAAAAgI2hWAcAAAAAwMZQrAMAAAAAYGMo1gEAAAAAsDEU6wAAAAAA2BiKdQAAAAAAbAzFOgAAAAAANoZiHQAAAAAAG0OxXkSmTJkiOzu7ImkrKChIQUFB5utt27bJzs5On3/+eZG0P3jwYNWsWbNI2rpTV65c0bBhw2SxWGRnZ6fRo0cXd5dKpZo1a2rw4MHm68zv4rZt24qtTygdyKm25V7PqZGRkbKzs9NPP/1krrv1ewMUJHKgbbnXc+DdsrOz05QpU8zX2eXUexXF+h3I/AJlLi4uLvLx8VFISIjeeustXb58uUDaOXfunKZMmaK4uLgC2V9BsuW+5cVrr72myMhIPfPMM1qyZIkGDBiQJSYmJkb29vaaNGlStvt4/fXXZWdnp3Xr1kn66//Mbv5e3LzUq1fPfF/m9+e7777LsX8//fST7Ozs9Oabb952LLt27dLf/vY3eXl5ydnZWTVr1tRTTz2lM2fOWMXNmjVLdnZ2OnDggNV6wzBUqVIl2dnZ6fTp01bbrl+/LmdnZ/Xr1++2/QDuFDnVtvuWF3nJqZlq1qyZ5fOuU6eOxo0bp4sXL1rFZhYkv//+e7b7ul3RMHLkyCwFza3t37x06dIlnyMH7h450Lb7lhf5yYGSlJGRoU8//VSPPPKIqlSpojJlysjT01OdO3fWe++9p5SUFKv4W3OVm5ub2rdvbx6D3uzW79Oty549e3Lc783L008/bcYNHjxYdnZ2CggIkGEYWdq0s7PTyJEj8/tnQx44FncHSrJp06bJ399faWlpio+P17Zt2zR69GjNmTNHX331lQICAszYl156SRMnTszX/s+dO6epU6eqZs2aatq0aZ7ft2nTpny1cydy69v777+vjIyMQu/D3YiOjlarVq30yiuv5BgTGBiop556SrNnz9YTTzyhhg0bmtt+/vlnTZs2TX//+98VFhZmrq9evboiIiKy7Mvd3b1gB/D/LViwQM8995zuu+8+jRo1St7e3jp27Jg++OADrVixQuvXr1fr1q0lSW3btpUk7dy5U82aNTP3ceTIEV26dEmOjo7atWuX/P39zW379+9Xamqq+d671a5dO127dk1OTk4Fsj+ULuTU0p1Tb9a0aVM9//zzkv76UTA2Nlbz5s3T9u3btW/fvsLsapb2b+bj41NgbRTF9walCznw3siB165d09/+9jdt3LhRrVu31gsvvCAvLy9dvHhR27dv1z//+U/t3btXH374odX7HnnkEQ0cOFCGYejnn3/WokWL1L17d33zzTcKCQnJ0k7m9+lWtWvXzna/t7r//vuzrDt06JC++OIL9e7d+7bjvBsDBgxQ37595ezsXKjtlAQU63chNDRULVq0MF9PmjRJ0dHR6tatmx599FEdO3ZMrq6ukiRHR0c5Ohbun/vPP/9U2bJli70QKlOmTLG2nxeJiYlq0KDBbeNmzpypNWvW6KmnntK3335rnqEZNWqUypQpo/nz51vFu7u764knniiUPt9q165dGj16tNq2basNGzaobNmy5rZnnnlGbdq0UZ8+fXTkyBFVqlRJLVq0kIuLi3bu3KlRo0ZZ7ady5cpq0aKFdu7cadX/nTt3SlKBFev29vZycXEpkH2h9CGnZq805dRM1apVs8o1w4YNU/ny5fXmm2/qxIkTqlOnTmF0M8f2C0Nxf29Q8pADs1facuCYMWO0ceNGzZs3T88995zVtueff14nTpxQVFRUlvfdf//9Vnmrd+/eatCggebPn59tsX7r9yknt+43J66urvL19dW0adPUq1evQr0Nw8HBQQ4ODoW2/5KEy+ALWMeOHfXyyy/r559/1tKlS8312d1bFBUVpbZt26pixYoqX7686tatqxdffFHSX5f2Pfjgg5KkIUOGmJekREZGSvrrkutGjRopNjZW7dq1U9myZc335nSfXHp6ul588UVZLBaVK1dOjz76qM6ePWsVc+s9xplu3uft+pbdvUVXr17V888/L19fXzk7O6tu3bp68803s1xKk3kZzZdffqlGjRrJ2dlZDRs21IYNG7L/g98iMTFRQ4cOlZeXl1xcXNSkSRN98skn5vbMSyZPnz6tdevWmX3P6Z4Yd3d3zZ8/X7t27dIHH3wgSVq9erW+/vprzZw5U97e3nnqV2GYPn267Ozs9Mknn1gV6pJUq1YtzZo1S+fPn9e7774r6a8DxwcffFC7du2yit21a5cCAwPVpk2bbLdVrFhRjRo1yrUvhmHo1VdfVfXq1VW2bFl16NBBR44cyRKX0z3re/fuVdeuXVWpUiWVK1dOAQEBWX4I+eGHH9SnTx95eHjIxcVFLVq00FdffZVrv1DykVNLV07NjcVikaRCL0Du1pEjR9SxY0e5urqqevXqevXVV7M965fd9+b69euaMmWK7r//frm4uMjb21u9evXSqVOnzJiMjAzNmzdPDRs2lIuLi7y8vPTUU0/pjz/+KOyhwQaRA0tXDjx79qw++OADdenSJUuhnqlOnTr65z//edu+1a9fX1WqVLHKH4XJ3t5eL730kg4ePKjVq1ff0T5SUlI0ZswYVa1aVRUqVNCjjz6qX375JUtcTvesf/PNN2rfvr0qVKggNzc3Pfjgg1q+fLlVzN69e9WlSxe5u7urbNmyat++fZbj25KEYr0QZN6nkttlQ0eOHFG3bt2UkpKiadOmafbs2Xr00UfNL1P9+vU1bdo0SdKIESO0ZMkSLVmyRO3atTP3ceHCBYWGhqpp06aaN2+eOnTokGu/ZsyYoXXr1mnChAl69tlnFRUVpeDgYF27di1f48tL325mGIYeffRRzZ07V126dNGcOXNUt25djRs3TmPHjs0Sv3PnTv3zn/9U3759NWvWLF2/fl29e/fWhQsXcu3XtWvXFBQUpCVLlqh///5644035O7ursGDB5uFX/369bVkyRJVqVJFTZs2NftetWrVHPebean7hAkT9OOPP+q5555T69at9dRTT2WJTU9P1++//55luXr1aq59z68///xTW7Zs0cMPP5ztJU6S9I9//EPOzs5au3atua5t27b69ddfrZLfrl271Lp1a7Vu3dq8JF7663PbvXu3AgMDZW+fe6qYPHmyXn75ZTVp0kRvvPGG7rvvPnXu3DlP446KilK7du109OhRPffcc5o9e7Y6dOhg1e8jR46oVatWOnbsmCZOnKjZs2erXLly6tmz5x3/HwZKDnKqtZKeUyUpLS3NzI+//PKLvv76a82ZM0ft2rXLMacVpJvbv3m53WcXHx+vDh06KC4uThMnTtTo0aP16aefZvlxMTvp6enq1q2bpk6dqubNm2v27Nl67rnnlJSUpMOHD5txTz31lMaNG6c2bdpo/vz5GjJkiJYtW6aQkBClpaXd9dhR8pADrZXkHPjNN98oPT29QK7sSUpK0h9//KFKlSrluP3WHJfdmK9fv55tPkxNTc0S269fP9WpU0fTpk3L9t712xk2bJjmzZunzp07a+bMmSpTpozV7aS5iYyMVFhYmC5evKhJkyZp5syZatq0qdUPL9HR0WrXrp2Sk5P1yiuv6LXXXtOlS5fUsWPHIrnFqlAYyLePP/7YkGTs378/xxh3d3ejWbNm5utXXnnFuPnPPXfuXEOS8dtvv+W4j/379xuSjI8//jjLtvbt2xuSjMWLF2e7rX379ubrrVu3GpKMatWqGcnJyeb6lStXGpKM+fPnm+v8/PyMQYMG3XafufVt0KBBhp+fn/n6yy+/NCQZr776qlVcnz59DDs7O+PkyZPmOkmGk5OT1brvv//ekGQsWLAgS1s3mzdvniHJWLp0qbkuNTXVCAwMNMqXL281dj8/PyMsLCzX/d3sp59+MsqVK2d4eHgYZcqUMQ4dOpQlJvMzyW556qmnzLi8fH9Onz5tSDLeeOONbLfHxcUZkoznnnsu134HBAQYHh4e5ut169YZkowlS5YYhmEY58+fNyQZ27dvNy5fvmw4ODgY69atMwzDMA4fPmxIMmbMmJFrG4mJiYaTk5MRFhZmZGRkmOtffPFFQ5LV9ynzu7h161bDMAzjxo0bhr+/v+Hn52f88ccfVvu9eV+dOnUyGjdubFy/ft1qe+vWrY06derk2j/YPnLqvZVT/fz8ss2Tbdq0MX7//Xer2MzPOafPNfOzWLVqVbbbw8PDrb4nubUvyYiIiMi176NHjzYkGXv37jXXJSYmGu7u7oYk4/Tp0+b6Wz/jjz76yJBkzJkzJ8t+M/Pdt99+a0gyli1bZrV9w4YN2a5H6UAOvHdy4JgxYwxJRlxcnNX6lJQU47fffjOXW3OhJGPo0KHGb7/9ZiQmJhrfffed0aVLl2yPFTO/T9ktzs7OWfab0/Lvf//bjBs0aJBRrlw5wzAM45NPPjEkGV988YXVfsLDw3Mde+ax6z//+U+r9f369TMkGa+88kqWMWTm1EuXLhkVKlQwWrZsaVy7ds3q/Zn5MyMjw6hTp44REhJidQz5559/Gv7+/sYjjzySa/9sFWfWC0n58uVznb2zYsWKkqQ1a9bc8aQZzs7OGjJkSJ7jBw4cqAoVKpiv+/TpI29vb61fv/6O2s+r9evXy8HBQc8++6zV+ueff16GYeibb76xWh8cHKxatWqZrwMCAuTm5qYff/zxtu1YLBY9/vjj5royZcro2Wef1ZUrV7R9+/Y7HoOfn59eeeUVXbx4UWPHjs3xsvCaNWsqKioqy1LQj/DI/G7d/Hlmp0KFCkpOTjZft27dWvb29ua96Lt27VKZMmX04IMPqnz58goICDB/hc/839vdr75582alpqZq1KhRVpfk5WXMBw4c0OnTpzV69Gjzv4lMmfu6ePGioqOj9dhjj+ny5ctWvw6HhIToxIkT+vXXX2/bFko2cur/lIac2rJlSzM/rl27VjNmzNCRI0f06KOP5vus3N22f/Ny81izs379erVq1UoPPfSQua5q1arq37//bdv8v//7P1WpUsVqzpBMmflu1apVcnd31yOPPGJ1hqt58+YqX768tm7dms+RorQgB/5PSc6Bmcdk5cuXz9JW1apVzcXPzy/Lez/88ENVrVpVnp6eatGihbZs2aLx48dnezWBJC1cuDBLjrv1byNJPXr0yDYf5nRlRf/+/e/o7Hrm9+LWzy0vx4tRUVG6fPmyJk6cmGXuo8z8GRcXpxMnTqhfv366cOGC1dWtnTp10o4dO2x+osLs2PaNYSXYlStX5OnpmeP2f/zjH/rggw80bNgwTZw4UZ06dVKvXr3Up0+f215ynKlatWr5mvTj1gl77OzsVLt27UJ/huHPP/8sHx+fLIVl/fr1ze03q1GjRpZ9VKpU6bb36/3888+qU6dOlr9fTu3kV+b9VLlN1lGuXDkFBwffVTt5kfm3vN3jXC5fvmz1d69YsaIaNmxoVZA3a9bMnLCmdevWVtucnJysDkqzk/l3vfX7VbVq1RwvzcqUeZ9VbvfEnzx5UoZh6OWXX9bLL7+cbUxiYqKqVauWa1so2cip/1MacmqVKlWscmVYWJjq1q2rPn366IMPPsi2oC1It7afVz///LNatmyZZX3dunVv+95Tp06pbt26ud6Tf+LECSUlJeX4XU9MTMx7Z1GqkAP/pyTnwMw+X7lyxWp9mzZtzEnl3njjjWzvse7Ro4dGjhyp1NRU7d+/X6+99pr+/PPPHD/fhx56KE8TzFWvXj1f+dDBwUEvvfSSBg0apC+//FJ/+9vf8vS+n3/+Wfb29lY/nEh5z59S7seLJ06ckCQNGjQox5ikpKTbHpvaGor1QvDLL78oKSkpy6MRbubq6qodO3Zo69atWrdunTZs2KAVK1aoY8eO2rRpU55mQMwssApSTjM7pqenF9msjDm1k59f70q72rVry9HRUQcPHswxJiUlRcePH8+SqNu2bavFixfr0qVL5v3qmVq3bq2PPvpIaWlp2rlzp5o3b17ss7dn/gr6wgsvZDvbqZT1MSQoXcipd6ek5NROnTpJknbs2JHnYj0zP+V0Nv7PP/8s9hyWHxkZGfL09NSyZcuy3X67uQBQOpED744t5cB69epJkg4fPqwmTZqY66tWrWoWzDdPJHizm4vqrl27qkqVKho5cqQ6dOigXr16FXLPrfXv31/Tp0/XtGnT1LNnzyJtOyeZx4tvvPFGjo8mvPWKhpKAy+ALwZIlSyQpx8Iik729vTp16qQ5c+bo6NGjmjFjhqKjo83L3Ar6kQiZvzhlMgxDJ0+etJphs1KlSuYEYze79dfD/PTNz89P586dy3IW+IcffjC3FwQ/Pz+dOHEiyyUuBd2OLShXrpw6dOigHTt25PjL7sqVK5WSkqJu3bpZrW/btq0Mw9DmzZt14MABtWnTxtzWunVrXbt2TevWrdOPP/6Yp0e2Zf5db/1+/fbbb7f91Trz19WbJ1e61X333Sfpr0vPgoODs11udzsASjZyqrXSmlNv3LghKesZp9xk9uH48ePZbj9+/HiB9jPzb5JdO7dTq1YtHT9+PNdJ4mrVqqULFy6oTZs22ea6mw/uce8gB1oryTkwNDRUDg4OOf4glx9PPfWUatWqpZdeeqnIf3jIPLseFxenNWvW5Ok9fn5+ysjIyDJ7fV7zp5T78WJmjJubW47HiyXhMYC3olgvYNHR0Zo+fbr8/f1zvYft4sWLWdZl/gqUkpIi6a+CTFK2Se5OfPrpp1aJ7fPPP9f58+cVGhpqrqtVq5b27NljNQPk2rVrszyKIz9969q1q9LT0/X2229brZ87d67s7Oys2r8bXbt2VXx8vFasWGGuu3HjhhYsWKDy5curffv2BdKOrchMzoMHD85yVun06dMaP368vL29s8xan1mAz5kzR2lpaVZn1mvWrClvb2/NmjXLKjY3mclvwYIFVv9nMW/evNu+94EHHpC/v7/mzZuX5buUuS9PT08FBQXp3Xff1fnz57Ps47fffrttOyi5yKlZldac+vXXX0tSvgpSb29vNW3aVEuXLs3yt4uNjdWePXsK7O8h/fU32bNnj9Wswr/99lueDrx79+6t33//PcvnJv0v3z322GNKT0/X9OnTs8TcuHGjwL67KDnIgVmV5BxYo0YNPfnkk/rmm2+yzQVS3s/4Ozo66vnnn9exY8fyXDAXpCeeeEK1a9fW1KlT8xSf+bm89dZbVuvzcrzYuXNnVahQQREREbp+/brVtsy/V/PmzVWrVi29+eab2f7oW1KPF7kM/i588803+uGHH3Tjxg0lJCQoOjpaUVFR8vPz01dffZXrpXfTpk3Tjh07FBYWJj8/PyUmJuqdd95R9erVzQKpVq1aqlixohYvXqwKFSqoXLlyatmy5R0/1sbDw0Nt27bVkCFDlJCQoHnz5ql27doaPny4GTNs2DB9/vnn6tKlix577DGdOnVKS5cuzXJ/SX761r17d3Xo0EH/+te/9NNPP6lJkybatGmT1qxZo9GjR2fZ950aMWKE3n33XQ0ePFixsbGqWbOmPv/8c+3atUvz5s0rkrOvSUlJOV6+dOtjOj766KNsn/N583M3t2zZkiUpSVLPnj3Vrl07vfnmmxo7dqwCAgI0ePBgeXt764cfftD777+vjIwMrV+/Psu9OTVq1JCvr69iYmJUs2ZN+fj4WG1v3bq1/u///k92dnZWZ91zUrVqVb3wwguKiIhQt27d1LVrVx04cEDffPONqlSpkut77e3ttWjRInXv3l1NmzbVkCFDzDEcOXJEGzdulPTXJClt27ZV48aNNXz4cN13331KSEhQTEyMfvnlF33//fe37SdsHzn13smpv/76q5krU1NT9f333+vdd9/NcQK2OXPmqGzZslbr7O3t9eKLL2rOnDkKCQlR06ZNNXjwYPn4+OjYsWN677335O3trUmTJuXa/s3Kly+f6yWd48eP15IlS8xnJJcrV07vvfee/Pz8cr0tSfprMq5PP/1UY8eO1b59+/Twww/r6tWr2rx5s/75z3+qR48eat++vZ566ilFREQoLi5OnTt3VpkyZXTixAmtWrVK8+fPV58+fXJtByUXOfDeyIHz5s3T6dOnNWrUKH322Wfq3r27PD099fvvv2vX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BysuLs78pTcv8tK3mxmGoUcffVRbt27V0KFD1bRpU23cuFHjxo3Tr7/+qrlz51rF79y5U1988YX++c9/qkKFCnrrrbfUu3dvnTlzRpUrV86xX9euXVNQUJBOnjypkSNHyt/fX6tWrdLgwYN16dIlPffcc6pfv76WLFmiMWPGqHr16uYlnlWrVs3z+KW/Dgh/+eUXVapUKdvtly9fzvb+zcqVK+dpQpny5cvrb3/7mz788EMdPXpUDRs2zDF28uTJevXVV9W1a1d17dpV//nPf9S5c2elpqbetp2oqCh169ZN3t7eeu6552SxWHTs2DGtXbtWzz33nKS/vqtt2rRRtWrVNHHiRJUrV04rV65Uz5499X//93/629/+dtt2UPqR96yVhryXlpZm5rHr16/rwIEDmjNnjtq1ayd/f/88/+1u9tVXX+nKlSvq27evLBaLgoKCtGzZMvXr18/qb3Hx4kWNHj1aDg4Oed73jRs39Pjjj2v16tVauHChnnrqqTy979q1a+rUqZPOnDmjZ599Vj4+PlqyZInVffG5GTp0qCIjIxUaGqphw4bpxo0b+vbbb7Vnzx7zLOuMGTP08ssv67HHHtOwYcP022+/acGCBWrXrp0OHDigihUr5nmcKHnIj9ZKcn6877775OPjo507d5rr9u/fr9TUVLVu3VqtW7fWrl27zP3s3r1bkrIt1pOSkrI9VkxLS8txTHcqPT0927ZcXV2zXNl0M/LjXTJQLD7++GNDkrF///4cY9zd3Y1mzZqZr1955RXj5o9s7ty5hiTjt99+y3Ef+/fvNyQZH3/8cZZt7du3NyQZixcvznZb+/btzddbt241JBnVqlUzkpOTzfUrV640JBnz58831/n5+RmDBg267T5z69ugQYMMPz8/8/WXX35pSDJeffVVq7g+ffoYdnZ2xsmTJ811kgwnJyerdd9//70hyViwYEGWtm42b948Q5KxdOlSc11qaqoRGBholC9f3mrsfn5+RlhYWK77uzm2c+fOxm+//Wb89ttvxqFDh4wBAwYYkozw8HCr2My/dU7L+fPn89yHzO/ImjVrcoxJTEw0nJycjLCwMCMjI8Nc/+KLLxqSrD7LzL5t3brVMAzDuHHjhuHv72/4+fkZf/zxh9V+b95Xp06djMaNGxvXr1+32t66dWujTp06OfYNpQt5797Le9nlsDZt2hi/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TJigCxcu6P333y/Q/V67dk0DBgzQxYsX9a9//SvX/wMMDg5WmTJltGDBAqtEOm/evNu288ADD8jf31/z5s3L8jlm7svT01NBQUF69913df78+Sz7+O233/I2KJRq5L2sSmve+/rrryUp32esM8+qjx8/Xn369LFaHnvsMbVv396MKVu2rCZMmKBjx45pwoQJ2Z49W7p0qfbt25dtW40bN9a6det05coVPfLII7edV6Nr1646d+6cPv/8c3Pdn3/+qffee++24+rdu7cMw9DUqVOzbMvsd69eveTg4KCpU6dmGYthGLpw4cJt20HJRX7MqjTkx7Zt2+q3337Txx9/rJYtW1pdat+6dWsdP35ca9asUeXKlXM96WLryI93h8vgi9k333yjH374QTdu3FBCQoKio6MVFRUlPz8/ffXVV3JxccnxvdOmTdOOHTsUFhYmPz8/JSYm6p133lH16tXNX+Bq1aqlihUravHixapQoYLKlSunli1b3vEjczw8PNS2bVsNGTJECQkJmjdvnmrXrm31GJFhw4bp888/V5cuXfTYY4/p1KlTWrp0qdXEHvntW/fu3dWhQwf961//0k8//aQmTZpo06ZNWrNmjUaPHp1l33dqxIgRevfddzV48GDFxsaqZs2a+vzzz7Vr1y7NmzevwM8Ah4aGqlGjRpozZ47Cw8Ot7qv59ttvdf369SzvCQgIsJo45NdffzWfu3rlyhUdPXpUq1atUnx8vJ5//vnbPnqoatWqeuGFFxQREaFu3bqpa9euOnDggL755htVqVIl1/fa29tr0aJF6t69u5o2baohQ4bI29tbP/zwg44cOaKNGzdK+msClLZt26px48YaPny47rvvPiUkJCgmJka//PKLvv/++zz/zVDykffunbx3c35KTU3V999/r3fffVdVqlTJ9hL4OXPmqGzZslbr7O3t9eKLL2rZsmVq2rSpfH19s23r0Ucf1ahRo/Sf//xHDzzwgMaNG6cjR45o9uzZ2rp1q/r06SOLxaL4+Hh9+eWX2rdvn/lIpOwEBgbqiy++UPfu3fXII4/o22+/zfERT8OHD9fbb7+tgQMHKjY2Vt7e3lqyZEmWsWSnQ4cOGjBggN566y2dOHFCXbp0UUZGhr799lt16NBBI0eOVK1atfTqq69q0qRJ+umnn9SzZ09VqFBBp0+f1urVqzVixAi98MIL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BQWSZIbtqlWr1LNnT8XHx2v27NnKyspSZWVlXZQLAPXms88+U2RkpO644w6NGjVKJSUlkqTCwkJdunRJsbGx5tiOHTuqbdu2ys/PlyTl5+erW7duioiIMMfExcXJ5XLp2LFj9TsRAPAy8hEA3NVJs+6LsK2oqJDL5XLbAMBK+vTpo+zsbG3dulVLly7VyZMn9cADD+ibb76R0+lUcHCwwsLC3J4TEREhp9MpSXI6nW7ZWH28+ti1kI8ArI58BICref1t8NVh26FDB505c0azZs3SAw88oI8//rhOwzYzM1OzZs3y7mQAwIvi4+PNP3fv3l19+vRRu3bttH79ejVp0qTOrks+ArA68hEArub1V9bj4+P1m9/8Rt27d1dcXJy2bNmic+fOaf369d6+lJuMjAyVl5eb26lTp+r0egBws8LCwnTXXXfp888/l91uV2Vlpc6dO+c2prS01PwMp91uv+oLOasf1/Q5z2rkI4CGhnwEgHr46bb6ClubzaaQkBC3DQCs7Pz58youLlbr1q0VExOjW265RTt37jSPnzhxQiUlJXI4HJIkh8Oho0ePqqyszByTm5urkJAQde7c+ZrXIR8BNDTkIwDUQ7NeX2ELAFb3+9//Xnv27NGXX36p/fv366GHHlJQUJB+97vfKTQ0VOPHj1d6erp2796twsJCPfbYY3I4HLrvvvskSYMGDVLnzp01evRoffTRR9q2bZumT5+ulJQU2Ww2H88OAGqPfASAq3n9M+u///3vNXToULVr106nT5/Wc889V2PYtmjRQiEhIZo4ceI1w3bu3LlyOp2ELQC/8Pe//12/+93v9NVXX+n2229X3759VVBQoNtvv12StGDBAgUGBioxMVEVFRWKi4vTkiVLzOcHBQUpJydHycnJcjgcatasmZKSkvT888/7akoA4BXkIwBczevNOmELADVbu3btdY83btxYWVlZysrKuuaYdu3aacuWLd4uDQB8inwEgKt5vVknbAEAAAAAuDleb9bx87Rj2rR6uU7snDn1ch0A8Jb27dvXy3WKi4vr5ToA4C0bN26st2sNGzas3q4FeEudf8EcAAAAAADwDM06AAAAAAAWQ7MOAAAAAIDF0KwDAAAAAGAxNOsAAAAAAFgMzToAAAAAABZDsw4AAAAAgMXQrAMAAAAAYDE06wAAAAAAWAzNOgAAAAAAFkOzDgAA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"/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h4 id="What-We-See">What We See<a class="anchor-link" href="#What-We-See">¶</a></h4><p>Distributions appear normally distributed around the expected value for their color. There's a slight skew, because the distributions are discrete and values can't go negative, but the shape is generally normal.</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="Step-4---Adding-in-White-and-Black-Results">Step 4 - Adding in White and Black Results<a class="anchor-link" href="#Step-4---Adding-in-White-and-Black-Results">¶</a></h3><p>This step is a bit tricky, and the results may not be entirely correct, depending on what you're looking to get out of the problem. My approach here is to add the wild results to all colors. Then we look at the 'before wilds' and 'after wilds' distributions for each color to see how BLACK and WHITE rolls impact the distribution of hits.</p>
<p>In practice you can only apply a wild to one color, not all of them. So doing it this way overstates the total number of hits across all colors. So you should look at the 'after wilds' distributions as a sort of upper bound on the number of hits you might expect.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [113]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_by_color</span> <span class="o">=</span> <span class="n">df_random_choices</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">row</span><span class="p">:</span> <span class="n">pd</span><span class="o">.</span><span class="n">Series</span><span class="p">(</span><span class="n">row</span><span class="o">.</span><span class="n">value_counts</span><span class="p">())</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="mi">0</span><span class="p">),</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
<span class="n">df_by_color</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="n">inplace</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="n">df_by_color</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[113]:</div>
<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html" tabindex="0">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }

</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>BLACK</th>
<th>BLUE</th>
<th>GREEN</th>
<th>RED</th>
<th>WHITE</th>
<th>YELLOW</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>3.0</td>
<td>2.0</td>
<td>1.0</td>
<td>0.0</td>
<td>1.0</td>
<td>3.0</td>
</tr>
<tr>
<th>1</th>
<td>1.0</td>
<td>2.0</td>
<td>4.0</td>
<td>0.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>2</th>
<td>1.0</td>
<td>3.0</td>
<td>1.0</td>
<td>1.0</td>
<td>0.0</td>
<td>4.0</td>
</tr>
<tr>
<th>3</th>
<td>2.0</td>
<td>0.0</td>
<td>2.0</td>
<td>4.0</td>
<td>0.0</td>
<td>2.0</td>
</tr>
<tr>
<th>4</th>
<td>0.0</td>
<td>3.0</td>
<td>0.0</td>
<td>2.0</td>
<td>0.0</td>
<td>5.0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>9995</th>
<td>0.0</td>
<td>6.0</td>
<td>1.0</td>
<td>0.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>9996</th>
<td>2.0</td>
<td>1.0</td>
<td>0.0</td>
<td>1.0</td>
<td>2.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9997</th>
<td>0.0</td>
<td>1.0</td>
<td>4.0</td>
<td>0.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9998</th>
<td>3.0</td>
<td>0.0</td>
<td>2.0</td>
<td>1.0</td>
<td>0.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9999</th>
<td>1.0</td>
<td>4.0</td>
<td>2.0</td>
<td>0.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
</tbody>
</table>
<p>10000 rows × 6 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [114]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_black</span> <span class="o">=</span> <span class="n">df_by_color</span><span class="o">.</span><span class="n">pop</span><span class="p">(</span><span class="s2">"BLACK"</span><span class="p">)</span>
<span class="n">df_white</span> <span class="o">=</span> <span class="n">df_by_color</span><span class="o">.</span><span class="n">pop</span><span class="p">(</span><span class="s2">"WHITE"</span><span class="p">)</span>
<span class="n">df_by_color</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[114]:</div>
<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html" tabindex="0">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }

</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>BLUE</th>
<th>GREEN</th>
<th>RED</th>
<th>YELLOW</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>2.0</td>
<td>1.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>1</th>
<td>2.0</td>
<td>4.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>2</th>
<td>3.0</td>
<td>1.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
<tr>
<th>3</th>
<td>0.0</td>
<td>2.0</td>
<td>4.0</td>
<td>2.0</td>
</tr>
<tr>
<th>4</th>
<td>3.0</td>
<td>0.0</td>
<td>2.0</td>
<td>5.0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>9995</th>
<td>6.0</td>
<td>1.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>9996</th>
<td>1.0</td>
<td>0.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9997</th>
<td>1.0</td>
<td>4.0</td>
<td>0.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9998</th>
<td>0.0</td>
<td>2.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9999</th>
<td>4.0</td>
<td>2.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
</tbody>
</table>
<p>10000 rows × 4 columns</p>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [115]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_black</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[115]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>0       3.0
1       1.0
2       1.0
3       2.0
4       0.0
       ... 
9995    0.0
9996    2.0
9997    0.0
9998    3.0
9999    1.0
Name: BLACK, Length: 10000, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [116]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_white</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[116]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>0       1.0
1       0.0
2       0.0
3       0.0
4       0.0
       ... 
9995    0.0
9996    2.0
9997    1.0
9998    0.0
9999    0.0
Name: WHITE, Length: 10000, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Next, add the BLACK results to each color. This can be done with simple matrix addition.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [117]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_by_color</span> <span class="o">=</span> <span class="n">df_by_color</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="n">df_black</span><span class="p">,</span> <span class="n">axis</span><span class="o">=</span><span class="mi">0</span><span class="p">)</span>
<span class="n">df_by_color</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[117]:</div>
<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html" tabindex="0">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }

</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>BLUE</th>
<th>GREEN</th>
<th>RED</th>
<th>YELLOW</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>5.0</td>
<td>4.0</td>
<td>3.0</td>
<td>6.0</td>
</tr>
<tr>
<th>1</th>
<td>3.0</td>
<td>5.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
<tr>
<th>2</th>
<td>4.0</td>
<td>2.0</td>
<td>2.0</td>
<td>5.0</td>
</tr>
<tr>
<th>3</th>
<td>2.0</td>
<td>4.0</td>
<td>6.0</td>
<td>4.0</td>
</tr>
<tr>
<th>4</th>
<td>3.0</td>
<td>0.0</td>
<td>2.0</td>
<td>5.0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>9995</th>
<td>6.0</td>
<td>1.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>9996</th>
<td>3.0</td>
<td>2.0</td>
<td>3.0</td>
<td>6.0</td>
</tr>
<tr>
<th>9997</th>
<td>1.0</td>
<td>4.0</td>
<td>0.0</td>
<td>4.0</td>
</tr>
<tr>
<th>9998</th>
<td>3.0</td>
<td>5.0</td>
<td>4.0</td>
<td>7.0</td>
</tr>
<tr>
<th>9999</th>
<td>5.0</td>
<td>3.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
</tbody>
</table>
<p>10000 rows × 4 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Now add WHITE results. WHITE can only be applied to a unit that has already received a hit. A unit can potentially receive a hit from a same-colored result or a BLACK result. So before adding WHITE to each column, we clip the value based on the number of hits after adding black. This effectively ignores excess WHITE results that couldn't be paired with a colored or BLACK result.</p>
<p>NOTE: It would be interesting to have a look at how many white results end up being ignored.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [118]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">color</span> <span class="ow">in</span> <span class="n">df_by_color</span><span class="o">.</span><span class="n">columns</span><span class="p">:</span>
    <span class="n">df_white_color</span> <span class="o">=</span> <span class="n">df_white</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span><span class="o">.</span><span class="n">clip</span><span class="p">(</span><span class="n">upper</span><span class="o">=</span><span class="n">df_by_color</span><span class="p">[</span><span class="n">color</span><span class="p">])</span>
    <span class="n">df_by_color</span><span class="p">[</span><span class="n">color</span><span class="p">]</span> <span class="o">+=</span> <span class="n">df_white_color</span>

<span class="n">df_by_color</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[118]:</div>
<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html" tabindex="0">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }

</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>BLUE</th>
<th>GREEN</th>
<th>RED</th>
<th>YELLOW</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>6.0</td>
<td>5.0</td>
<td>4.0</td>
<td>7.0</td>
</tr>
<tr>
<th>1</th>
<td>3.0</td>
<td>5.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
<tr>
<th>2</th>
<td>4.0</td>
<td>2.0</td>
<td>2.0</td>
<td>5.0</td>
</tr>
<tr>
<th>3</th>
<td>2.0</td>
<td>4.0</td>
<td>6.0</td>
<td>4.0</td>
</tr>
<tr>
<th>4</th>
<td>3.0</td>
<td>0.0</td>
<td>2.0</td>
<td>5.0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>9995</th>
<td>6.0</td>
<td>1.0</td>
<td>0.0</td>
<td>3.0</td>
</tr>
<tr>
<th>9996</th>
<td>5.0</td>
<td>4.0</td>
<td>5.0</td>
<td>8.0</td>
</tr>
<tr>
<th>9997</th>
<td>2.0</td>
<td>5.0</td>
<td>0.0</td>
<td>5.0</td>
</tr>
<tr>
<th>9998</th>
<td>3.0</td>
<td>5.0</td>
<td>4.0</td>
<td>7.0</td>
</tr>
<tr>
<th>9999</th>
<td>5.0</td>
<td>3.0</td>
<td>1.0</td>
<td>4.0</td>
</tr>
</tbody>
</table>
<p>10000 rows × 4 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h4 id="Before-and-After-Wilds-Comparison">Before and After Wilds Comparison<a class="anchor-link" href="#Before-and-After-Wilds-Comparison">¶</a></h4><p>Now we'll re-chart our color distributions from before and compare them to the adjusted distributions after adding BLACK and WHITE results...</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [119]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>

<span class="n">fig</span><span class="p">,</span> <span class="n">axes</span> <span class="o">=</span> <span class="n">plt</span><span class="o">.</span><span class="n">subplots</span><span class="p">(</span><span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span>
<span class="n">axes</span> <span class="o">=</span> <span class="n">axes</span><span class="o">.</span><span class="n">flatten</span><span class="p">()</span>

<span class="k">for</span> <span class="n">i</span><span class="p">,</span> <span class="n">color</span> <span class="ow">in</span> <span class="nb">enumerate</span><span class="p">([</span><span class="s2">"YELLOW"</span><span class="p">,</span> <span class="s2">"BLUE"</span><span class="p">,</span> <span class="s2">"GREEN"</span><span class="p">,</span> <span class="s2">"RED"</span><span class="p">]):</span>
<span class="n">distribution</span> <span class="o">=</span> <span class="n">df_random_choices</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">row</span><span class="p">:</span> <span class="n">row</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="n">color</span><span class="p">,</span> <span class="mi">0</span><span class="p">),</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">distribution</span><span class="p">,</span> <span class="n">bins</span><span class="o">=</span><span class="nb">range</span><span class="p">(</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">+</span> <span class="mi">1</span><span class="p">),</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="n">color</span><span class="p">])</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="sa">f</span><span class="s2">"Distribution of </span><span class="si">{</span><span class="n">color</span><span class="si">}</span><span class="s2"> dice"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">set_xlim</span><span class="p">(</span><span class="n">right</span><span class="o">=</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span> <span class="c1"># Set max value on x-axis</span>

<span class="n">plt</span><span class="o">.</span><span class="n">suptitle</span><span class="p">(</span><span class="s2">"Before adding black and white dice"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>&lt;Figure size 640x480 with 0 Axes&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,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s3Hjxvrqq6/M12fPntXevXtlb2+vjRs3qkaNGpL++7GjZMmSqly5ss37n3rqKQUEBCg8PFy//fabZs+eLU9PT73//vvprq9JkyZ65ZVX9OGHH+r11183l5f633nz5ql79+4KDg7W+++/r0uXLmnGjBlq1KiRdu7cmemPOrGxsWrevLmuX7+u4cOHy9XVVbNmzcrSlSzJyclq3769Vq9erS5dumjgwIE6f/68IiMjtWfPHpUrV05S1v7tAADkAQMAYElz5swxJKWZnJycjIiICJvYjRs3GpKM+fPn27QvX748TXv37t0NV1dXm7jo6GhDktG7d2+b9ldffdWQZKxZs8Zs8/f3NyQZy5cvt4kdO3as4erqavzxxx827cOHDzccHByM48ePZ7q9ly5dStPWr18/o1ChQsaVK1cMwzCMq1evGp6enkatWrWMpKQkM27WrFmGJKNp06Zm25QpUwxJxjfffGO2Xbx40ShfvrwhyVi7dq3NPvH39zdfx8TEGJKM4sWLG2fPnjXbf/zxR0OS8dNPP5lt1atXN0qXLm2cP3/ebFu3bp0hyWaZGUndn//73//MtoSEBMPHx8eoXbu22bZ27do0eae3z8LDww07Ozvj2LFjZluTJk0MNzc3mzbDMIyUlBTz/9966y1DkvHPP/8Y+/fvN3x9fY169erZbH9G0stjy5YthiTjiy++MNtSv9NBQUE26x40aJDh4OBgnDt3zjAMw4iPjzccHR2NkJAQm7jXX3/dkGR0794903wWLVpkSDL27dtnGIZhLF682HBycjIeffRR4+mnnzbjatSoYTz++ONp9sELL7xgs7zHH3/cKF68uE2bv7+/TR6p67zx8zEMwzh//rxRpEgRo0+fPjbtsbGxhoeHR5r2m4WFhRmSjG3btplt8fHxhoeHhyHJiImJMdubNm1q8zfw+eefG5KMSZMmpVlu6n7Nzr8dAIC7i8vgAcDipk+frsjISEVGRurLL79U8+bN1bt3b5vLpBctWiQPDw+1atVKp0+fNqc6deqocOHCWrt2babr+PnnnyVJgwcPtmkfMmSIpP/OHt8oICBAwcHBNm2LFi1S48aNVbRoUZscgoKClJycrA0bNmSaw41nCs+fP6/Tp0+rcePGunTpkg4cOCBJ+vXXXxUfH68XX3zR5v7cHj16yMPDI802+fj4qHPnzmZboUKF1Ldv30zzuNHTTz+tokWLmq8bN24sSfrzzz8lSSdPntTu3bvVrVs3FS5c2Ixr2rSpqlevnuX1+Pr66vHHHzdfu7u7q1u3btq5c6diY2MzfN+N++zixYs6ffq0GjRoIMMwtHPnTknSP//8ow0bNuiFF15QmTJlbN5vZ2eXZpl79uxR06ZNVbZsWa1atcpm+7OSx7Vr13TmzBmVL19eRYoU0W+//ZYmvm/fvjbrbty4sZKTk3Xs2DFJ0qpVq3T16lUNGDDAJi4sLOyWuaQuT5L5ndu4caPq1aunVq1ambdMnDt3Tnv27DFjb/Tiiy+mWd6ZM2eUmJiYpfXfKDIyUufOndMzzzxj83fh4OCg+vXrZ+lv85FHHtHDDz9stpUsWVJdu3a95br/97//qUSJEhowYECaean7Naf/dgAA7hwugwcAi3v44YdtHjD3zDPPqHbt2urfv7/at28vR0dHHTp0SAkJCfL09Ex3GfHx8Zmu49ixY7K3t1f58uVt2r29vVWkSBGziEoVEBCQZhmHDh3Srl27VLJkydvKYe/evRo5cqTWrFmTpihKSEgw85SkChUq2MwvWLCgHnjggTTbVL58+TQFacWKFTPN40Y3F7ephWvqvbyp+dy831Lb0itU05Neng8++KCk/+6f9/b2Tvd9x48f16hRo7R48eI09xen7rPUHxaqVauWpVw6dOggLy8vrVixwuYHiMxcvnxZ4eHhmjNnjv7++28ZhpEmjxtldb/e/DmXLFkySz8eeHl5qUKFCtq4caP69eunjRs3qnnz5mrSpIkGDBigP//8U/v371dKSkq6xXpm+bm7u99y/Tc6dOiQJKlFixbpzr/V8o4dO6b69eunac/K9/jIkSOqWLFimudb3JxfTv7tAADcORTrAJDP2Nvbq3nz5po6daoOHTqkqlWrKiUlRZ6enpo/f36678mogL5Zemda05Pe/bIpKSlq1aqVhg4dmu57UovP9Jw7d05NmzaVu7u7xowZo3LlysnZ2Vm//fabhg0blmfDqjk4OKTbfmMxmleSk5PVqlUrnT17VsOGDVOlSpXk6uqqv//+Wz169LjtfdapUyfNnTtX8+fPV79+/bL0ngEDBmjOnDkKCwtTYGCgPDw8ZGdnpy5duqSbx93Yr40aNdLq1at1+fJlRUVFadSoUapWrZqKFCmijRs3av/+/SpcuLBq1659R/NL3f558+al+6NLZoX03ZBb/3YAAHIfxToA5EPXr1+XJF24cEGSVK5cOa1atUoNGza8rSHU/P39lZKSokOHDtk8bCsuLk7nzp2Tv7//LZdRrlw5XbhwQUFBQdle/7p163TmzBl99913atKkidkeExOTJk/pv7OBN56pvHbtmmJiYlSzZk2b2D179sgwDJsfIQ4ePJjt/DKSms/hw4fTzEuvLSOHDx9Ok+cff/whSRk+fGz37t36448/NHfuXHXr1s1sj4yMtIlLveJgz549WcplwoQJKlCggF5++WW5ubnp2WefveV7vv32W3Xv3l0TJ040265cuaJz585laZ03u/FzvvGKiX/++SfLTyhv3Lix5syZo6+//lrJyclq0KCB7O3t1ahRI7NYb9CgQYaFeXZl9ENX6kPcPD09b+tvw9/f3zw7f6OsfI/LlSunbdu26dq1axk+JC6n/3YAAO4c7lkHgHzm2rVrWrlypRwdHc3C+qmnnlJycrLGjh2bJv769eu3LJratWsnSWme2D5p0iRJUkhIyC3zeuqpp7RlyxatWLEizbxz586ZPzCkJ7VguvHM5dWrV/Xxxx/bxNWtW1clS5bUzJkzbZ4KHhERkWYb27Vrp5MnT+rbb7812y5duqRZs2bdcluyytfXV9WqVdMXX3xh/nAiSevXr9fu3buzvJyTJ0/aPHE/MTFRX3zxhWrVqpXhJfDp7TPDMDR16lSbuJIlS6pJkyb6/PPPdfz4cZt56Z0ptrOz06xZs9S5c2d1795dixcvvmX+Dg4OaZY1bdq0dIfdy4qgoCAVLFhQ06ZNs1nurUYUuFHq5e3vv/++atSoYT7ToHHjxlq9erV+/fXXdC+Bv12urq6SlOZ7GBwcLHd3d7333nu6du1amvfdPGTdzdq1a6etW7dq+/btNu/J6Ez4jTp16qTTp0/ro48+SjMvdb/m9N8OAMCdw5l1ALC4ZcuWmQ9Yi4+P14IFC3To0CENHz7cvN+1adOm6tevn8LDwxUdHa3WrVurYMGCOnTokBYtWqSpU6faPGjtZjVr1lT37t01a9Ys85L07du3a+7cuerYsaOaN29+yzxfe+01LV68WO3bt1ePHj1Up04dXbx4Ubt379a3336ro0ePZjj8V4MGDVS0aFF1795dr7zyiuzs7DRv3rw0BWDBggX1zjvvqF+/fmrRooWefvppxcTEaM6cOWnuWe/Tp48++ugjdevWTVFRUfLx8dG8efPSDCOWU++9954ee+wxNWzYUD179tS///6rjz76SNWqVbMp4DPz4IMPqlevXtqxY4e8vLz0+eefKy4uTnPmzMnwPZUqVVK5cuX06quv6u+//5a7u7v+97//pXvm+cMPP1SjRo300EMPqW/fvgoICNDRo0e1dOlSRUdHp4m3t7fXl19+qY4dO+qpp57Szz//nOE915LUvn17zZs3Tx4eHqpSpYq2bNmiVatWqXjx4lna/puVLFlSr776qsLDw9W+fXu1a9dOO3fu1LJlyzIdQu5G5cuXl7e3tw4ePGjzgLUmTZpo2LBhkpSrxXqtWrXk4OCg999/XwkJCXJyclKLFi3k6empGTNm6Pnnn9dDDz2kLl26qGTJkjp+/LiWLl2qhg0bpltMpxo6dKjmzZunNm3aaODAgebQbf7+/jZjxqenW7du+uKLLzR48GBt375djRs31sWLF7Vq1Sq9/PLLeuyxx3L8bwcA4A7KgyfQAwCyIL2h25ydnY1atWoZM2bMsBnSKtWsWbOMOnXqGC4uLoabm5tRvXp1Y+jQocbJkyfNmPSGbjMMw7h27Zrx9ttvGwEBAUbBggUNPz8/Y8SIEeawaan8/f2NkJCQdHM+f/68MWLECKN8+fKGo6OjUaJECaNBgwbGBx98YFy9ejXT7d28ebPxyCOPGC4uLoavr68xdOhQY8WKFekOh/Xxxx8bAQEBhpOTk1G3bl1jw4YNaYatMgzDOHbsmPHoo48ahQoVMkqUKGEMHDjQHJIqK0O3TZgwIU2ekoy33nrLpu3rr782KlWqZDg5ORnVqlUzFi9ebHTq1MmoVKlSpttsGP+3P1esWGHUqFHDcHJyMipVqmQsWrTIJi69odv27dtnBAUFGYULFzZKlChh9OnTx/j9998NScacOXNs3r9nzx7j8ccfN4oUKWI4OzsbFStWNN58801z/o1Dt6W6dOmS0bRpU6Nw4cLG1q1bM9yGf//91+jZs6dRokQJo3DhwkZwcLBx4MCBNMObpX6nd+zYccttS05ONt5++23Dx8fHcHFxMZo1a2bs2bMnzTIz8+STTxqSjIULF5ptV69eNQoVKmQ4Ojoaly9ftolPbx/cmPeNw6Sll8enn35qPPDAA4aDg0Oa7Vm7dq0RHBxseHh4GM7Ozka5cuWMHj16GL/++ustt2PXrl1G06ZNDWdnZ6NUqVLG2LFjjc8+++yWQ7cZxn+f4RtvvGH+XXt7exudO3c2jhw5YhOXlX87AAB3l51hWOApOQAA3GNq1aqlkiVLprmHHAAAICu4Zx0AgBy4du1amvvx161bp99//13NmjXLm6QAAEC+x5l1AABy4OjRowoKCtJzzz0nX19fHThwQDNnzpSHh4f27Nlz2/dtAwCA+xsPmAMAIAeKFi2qOnXqaPbs2frnn3/k6uqqkJAQjRs3jkIdAADcNs6sAwAAAABgMdyzDgAAAACAxVCsAwAAAABgMRTrAAAAAABYDMU6AAAAAAAWQ7EOAAAAAIDFUKwDAAAAAGAxFOsAAAAAAFgMxToAAAAAABZDsQ4AAAAAgMVQrAMAAAAAYDEU6wAAAAAAWAzFOgAAAAAAFkOxDgAAAACAxVCsAwAAAABgMRTrAAAAAABYDMU6AAAAAAAWQ7EOAAAAAIDFUKwDAAAAAGAxFOsAAAAAAFgMxToAAAAAABZDsQ4AAAAAgMVQrAMAAAAAYDEU6wAAAAAAWAzFOgAAAAAAFkOxDgAAAACAxVCsAwAAAABgMRTrAAAAAABYDMU6AAAAAAAWQ7EOAAAAAIDFUKwDAAAAAGAxFOsAAAAAAFgMxToAAAAAABZDsQ4AAAAAgMVQrAMAAAAAYDEU6wAAAAAAWAzFOgAAAAAAFkOxDgAAAACAxVCsAwAAAABgMRTrAAAAAABYDMU6LGf06NGys7O7K+tq1qyZmjVrZr5et26d7Ozs9O23396V9ffo0UNly5a9K+u6XRcuXFDv3r3l7e0tOzs7hYWF5XVK96SyZcuqR48e5uvU7+K6devyLCcAsBKOD6zlfj8+iIiIkJ2dnY4ePWq23fy9AXKKYh13VOo/ZKmTs7OzfH19FRwcrA8//FDnz5/PlfWcPHlSo0ePVnR0dK4sLzdZObeseO+99xQREaGXXnpJ8+bN0/PPP58mZsuWLbK3t9eIESPSXcb7778vOzs7LV26VNJ/ndmN34sbp0qVKpnvS/3+/Prrrxnmd/ToUdnZ2emDDz645bZs3rxZjz/+uLy8vOTk5KSyZcuqX79+On78uE3c+PHjZWdnp507d9q0G4ahokWLys7OTjExMTbzrly5IicnJz377LO3zAMA7nccH1g7t6zIyvFBqrJly6b5vCtUqKDXXntNZ8+etYlN/VHm9OnT6S7rVj+c9O/fP82POjev/8apTZs22dxy4O4pkNcJ4P4wZswYBQQE6Nq1a4qNjdW6desUFhamSZMmafHixapRo4YZO3LkSA0fPjxbyz958qTefvttlS1bVrVq1cry+1auXJmt9dyOzHL79NNPlZKScsdzyIk1a9bokUce0VtvvZVhTGBgoPr166eJEyfqueeeU9WqVc15x44d05gxY/Tkk08qJCTEbC9durTCw8PTLMvDwyN3N+D/mzZtmgYOHKgHHnhAAwYMkI+Pj/bv36/Zs2dr4cKF+vnnn9WgQQNJUqNGjSRJmzZtUu3atc1l7N27V+fOnVOBAgW0efNmBQQEmPN27Nihq1evmu/NqSZNmujy5ctydHTMleUBgBVxfHBvHx/cqFatWhoyZIik/37gjoqK0pQpU7R+/Xpt3779TqaaZv038vX1zbV13I3vDe4vFOu4K9q2bau6deuar0eMGKE1a9aoffv2evTRR7V//365uLhIkgoUKKACBe7sV/PSpUsqVKhQnhdCBQsWzNP1Z0V8fLyqVKlyy7hx48bpxx9/VL9+/bRx40bzV+0BAwaoYMGCmjp1qk28h4eHnnvuuTuS8802b96ssLAwNWrUSMuXL1ehQoXMeS+99JIaNmyozp07a+/evSpatKjq1q0rZ2dnbdq0SQMGDLBZTvHixVW3bl1t2rTJJv9NmzZJUq4V6/b29nJ2ds6VZQGAVXF8kL576fggValSpWz6zd69e6tw4cL64IMPdOjQIVWoUOFOpJnh+u+EvP7e4N7DZfDIMy1atNCbb76pY8eO6csvvzTb07snLTIyUo0aNVKRIkVUuHBhVaxYUa+//rqk/y6HqlevniSpZ8+e5mVNERERkv675LpatWqKiopSkyZNVKhQIfO9Gd1blJycrNdff13e3t5ydXXVo48+qhMnTtjE3HyPcaobl3mr3NK7J+3ixYsaMmSI/Pz85OTkpIoVK+qDDz6QYRg2cXZ2durfv79++OEHVatWTU5OTqpataqWL1+e/g6/SXx8vHr16iUvLy85OzurZs2amjt3rjk/9TKzmJgYLV261Mz9xnuzbuTh4aGpU6dq8+bNmj17tiTp+++/108//aRx48bJx8cnS3ndCWPHjpWdnZ3mzp1rU6hLUrly5TR+/HidOnVKn3zyiaT/Ott69epp8+bNNrGbN29WYGCgGjZsmO68IkWKqFq1apnmYhiG3nnnHZUuXVqFChVS8+bNtXfv3jRxGd2zvm3bNrVr105FixaVq6uratSokeaHkAMHDqhz584qVqyYnJ2dVbduXS1evDjTvADAKjg+uLeODzLj7e0tSXf8R5ic2rt3r1q0aCEXFxeVLl1a77zzTrpXPqT3vbly5YpGjx6tBx98UM7OzvLx8dETTzyhI0eOmDEpKSmaMmWKqlatKmdnZ3l5ealfv376999/7/SmweKs/ZeBe97zzz+v119/XStXrlSfPn3Sjdm7d6/at2+vGjVqaMyYMXJyctLhw4fNYqly5coaM2aMRo0apb59+6px48aSZF7SLElnzpxR27Zt1aVLFz333HPy8vLKNK93331XdnZ2GjZsmOLj4zVlyhQFBQUpOjra/IU/K7KS240Mw9Cjjz6qtWvXqlevXqpVq5ZWrFih1157TX///bcmT55sE79p0yZ99913evnll+Xm5qYPP/xQnTp10vHjx1W8ePEM87p8+bKaNWumw4cPq3///goICNCiRYvUo0cPnTt3TgMHDlTlypU1b948DRo0SKVLlzYvHStZsmSGy0291H3YsGFq2bKlBg4cqAYNGqhfv35pYpOTk9O9H83FxUWurq4ZriO7Ll26pNWrV6tx48Y2l63f6Omnn1bfvn21ZMkS8xLLRo0aaePGjTp69Kh5wLR582b17t1bDz/8sN566y2dO3dORYoUkWEY+uWXXxQYGCh7+8x/Ax01apTeeecdtWvXTu3atdNvv/2m1q1b6+rVq7fclsjISLVv314+Pj4aOHCgvL29tX//fi1ZskQDBw6U9N/fS8OGDVWqVCkNHz5crq6u+uabb9SxY0f973//0+OPP56NvQcAeYPjA1v5/fhAkq5du2b2+1euXNHOnTs1adIkNWnSJMP+OTfduP4bubq6ZvrZxcbGqnnz5rp+/brZr86aNStLn3dycrLat2+v1atXq0uXLho4cKDOnz+vyMhI7dmzR+XKlZMk9evXTxEREerZs6deeeUVxcTE6KOPPtLOnTu1efPmfHGlBe4QA7iD5syZY0gyduzYkWGMh4eHUbt2bfP1W2+9Zdz41Zw8ebIhyfjnn38yXMaOHTsMScacOXPSzGvatKkhyZg5c2a685o2bWq+Xrt2rSHJKFWqlJGYmGi2f/PNN4YkY+rUqWabv7+/0b1791suM7Pcunfvbvj7+5uvf/jhB0OS8c4779jEde7c2bCzszMOHz5stkkyHB0dbdp+//13Q5Ixbdq0NOu60ZQpUwxJxpdffmm2Xb161QgMDDQKFy5ss+3+/v5GSEhIpsu70dGjRw1XV1ejWLFiRsGCBY3du3eniUn9TNKb+vXrZ8Zl5fsTExNjSDImTJiQ7vzo6GhDkjFw4MBM865Ro4ZRrFgx8/XSpUsNSca8efMMwzCMU6dOGZKM9evXG+fPnzccHByMpUuXGoZhGHv27DEkGe+++26m64iPjzccHR2NkJAQIyUlxWx//fXXDUk236fU7+LatWsNwzCM69evGwEBAYa/v7/x77//2iz3xmW1bNnSqF69unHlyhWb+Q0aNDAqVKiQaX4AcLdwfHB/HR/4+/un2+c3bNjQOH36tE1s6uec0eea+lksWrQo3fmhoaE235PM1i/JCA8PzzT3sLAwQ5Kxbds2sy0+Pt7w8PAwJBkxMTFm+82f8eeff25IMiZNmpRmual998aNGw1Jxvz5823mL1++PN123F+4DB55rnDhwpk+9bVIkSKSpB9//PG2H7bi5OSknj17Zjm+W7ducnNzM1937txZPj4++vnnn29r/Vn1888/y8HBQa+88opN+5AhQ2QYhpYtW2bTHhQUZP4qK0k1atSQu7u7/vzzz1uux9vbW88884zZVrBgQb3yyiu6cOGC1q9ff9vb4O/vr7feektnz57V4MGDM7wsvGzZsoqMjEwz5fbQL6nfrRs/z/S4ubkpMTHRfN2gQQPZ29ub96Kn/rJdr149FS5cWDVq1DDP3qT+91b3q69atUpXr17VgAEDbC7lzMo279y5UzExMQoLCzP/JlKlLuvs2bNas2aNnnrqKZ0/f16nT5/W6dOndebMGQUHB+vQoUP6+++/b7kuALACjg/+z71wfFC/fn2zr1+yZIneffdd7d27V48++qguX75828u9nfXfON24ren5+eef9cgjj+jhhx8220qWLKmuXbvecp3/+9//VKJECZvn36RK7bsXLVokDw8PtWrVyuy3T58+rTp16qhw4cJau3ZtNrcU9xIug0eeu3Dhgjw9PTOc//TTT2v27Nnq3bu3hg8frpYtW+qJJ55Q586db3nJcapSpUpl66EfNz/kxM7OTuXLl7+t+7Gy49ixY/L19U1TWFauXNmcf6MyZcqkWUbRokVveY/TsWPHVKFChTT7L6P1ZFfqfXg3PjToZq6urgoKCsrRerIidV/eahig8+fP2+z3IkWKqGrVqjYFee3atc3L3ho0aGAzz9HR0aYjT0/qfr35+1WyZEkVLVo00/em3tuW2T3xhw8flmEYevPNN/Xmm2+mGxMfH69SpUplui4AsAKOD/7PvXB8UKJECZt+PyQkRBUrVlTnzp01e/bsdAva3HTz+rPq2LFjql+/fpr2ihUr3vK9R44cUcWKFTO9J//QoUNKSEjI8LseHx+f9WRxz6FYR57666+/lJCQoPLly2cY4+Liog0bNmjt2rVaunSpli9froULF6pFixZauXKlHBwcbrme7NxHllU3P+QmVXJycpZyyg0Zrce46WEz97Py5curQIEC2rVrV4YxSUlJOnjwYJofFxo1aqSZM2fq3Llz2rx5s829hA0aNNDnn3+ua9euadOmTapTp06eP7099czSq6++quDg4HRjMvtbAwCr4PggZ/LL8UHLli0lSRs2bMhysZ7a12Z0Nv7SpUt53h9nR0pKijw9PTV//vx059/qWQC4t3EZPPLUvHnzJCnDwiKVvb29WrZsqUmTJmnfvn169913tWbNGvPSoIw6xtt16NAhm9eGYejw4cM2T2YtWrSozp07l+a9N//qnJ3c/P39dfLkyTRngQ8cOGDOzw3+/v46dOhQmssGc3s9VuDq6qrmzZtrw4YNGZ4R+Oabb5SUlKT27dvbtDdq1EiGYWjVqlXauXOnGjZsaM5r0KCBLl++rKVLl+rPP//M0pBtqfv15u/XP//8c8uzHamXM+7ZsyfDmAceeEDSf5csBgUFpTvd6nYAALACjg9s3avHB9evX5f031UUWZWaw8GDB9Odf/DgwVzNM3WfpLeeWylXrpwOHjyoa9euZRpz5swZNWzYMN1+u2bNmjnKH/kbxTryzJo1azR27FgFBARket/P2bNn07TVqlVL0n9nRCWZTw9Pr3O8HV988YVNh/jtt9/q1KlTatu2rdlWrlw5bd261eYp3kuWLEkzhEt2cmvXrp2Sk5P10Ucf2bRPnjxZdnZ2NuvPiXbt2ik2NlYLFy40265fv65p06apcOHCatq0aa6sxypGjhwpwzDUo0ePNL/Ex8TEaOjQofLx8Unz1PrUAnzSpEm6du2azZn1smXLysfH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AAAAIE9l6zL4G4WGhmrPnj3atGlTbuZz25ycnOTk5JTXaQAAAAAAkGO3dWa9f//+WrJkidauXavSpUub7d7e3rp69arOnTtnEx8XFydvb28z5uanw6e+vlWMu7u7XFxcbidlAAAAAADyjWwV64ZhqH///vr++++1Zs0aBQQE2MyvU6eOChYsqNWrV5ttBw8e1PHjxxUYGChJCgwM1O7duxUfH2/GREZGyt3dXVWqVDFjblxGakzqMgAAAAAAuJdl6zL40NBQLViwQD/++KPc3NzMe8w9PDzk4uIiDw8P9erVS4MHD1axYsXk7u6uAQMGKDAwUI888ogkqXXr1qpSpYqef/55jR8/XrGxsRo5cqRCQ0PNy9hffPFFffTRRxo6dKheeOEFrVmzRt98842WLl2ay5sPAAAAAID1ZOvM+owZM5SQkKBmzZrJx8fHnBYuXGjGTJ48We3bt1enTp3UpEkTeXt767vvvjPnOzg4aMmSJXJwcFBgYKCee+45devWTWPGjDFjAgICtHTpUkVGRqpmzZqaOHGiZs+eneGwbQAAAAAA3EuydWbdMIxbxjg7O2v69OmaPn16hjH+/v76+eefM11Os2bNtHPnzuykBwAAAADAPSFH46wDAAAAAIDcd9tDtwHZtWrV8LxOAQAAAADyBc6sAwAAAABgMRTrAAAAAABYDMU6AAAAAAAWQ7EOAABM4eHhqlevntzc3OTp6amOHTvq4MGDNjFXrlxRaGioihcvrsKFC6tTp06Ki4uziTl+/LhCQkJUqFAheXp66rXXXtP169dtYtatW6eHHnpITk5OKl++vCIiIu705gEAkG9QrAMAANP69esVGhqqrVu3KjIyUteuXVPr1q118eJFM2bQoEH66aeftGjRIq1fv14nT57UE088Yc5PTk5WSEiIrl69ql9++UVz585VRESERo0aZcbExMQoJCREzZs3V3R0tMLCwtS7d2+tWLHirm4vAABWxdPgAQCAafny5TavIyIi5OnpqaioKDVp0kQJCQn67LPPtGDBArVo0UKSNGfOHFWuXFlbt27VI488opUrV2rfvn1atWqVvLy8VKtWLY0dO1bDhg3T6NGj5ejoqJkzZyogIEATJ06UJFWuXFmbNm3S5MmTFRwcfNe3GwAAq+HMOgAAyFBCQoIkqVixYpKkqKgoXbt2TUFBQWZMpUqVVKZM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AAAAAACLoVgHAAAAAMBislWsz5gxQzVq1JC7u7vc3d0VGBioZcuWmfOvXLmi0NBQFS9eXIULF1anTp0UFxdns4zjx48rJCREhQoVkqenp1577TVdv37dJmbdunV66KGH5OTkpPLlyysiIuL2txAAAAAAgHwmW8V66dKlNW7cOEVFRenXX39VixYt9Nhjj2nv3r2SpEGDBumnn37SokWLtH79ep08eVJPPPGE+f7k5GSFhITo6tWr+uWXXzR37lxFRERo1KhRZkxMTIxCQkLUvHlzRUdHKywsTL1799aKFStyaZMBAAAAALC2AtkJ7tChg83rd999VzNmzNDWrVtVunRpffbZZ1qwYIFatGghSZozZ44qV66srVu36pFHHtHKlSu1b98+rVq1Sl5eXqpVq5bGjh2rYcOGafTo0XJ0dNTMmTMVEBCgiRMnSpIqV66sTZs2afLkyQoODs6lzQYAAAAAwLpu+5715ORkff3117p48aICAwMVFRWla9euKSgoyIypVKmSypQpoy1btkiStmzZourVq8vLy8uMCQ4OVmJionl2fsuWLTbLSI1JXUZGkpKSlJiYaDMBAAAAAJAfZbtY3717twoXLiwnJye9+OKL+v7771WlShXFxsbK0dFRRYoUsYn38vJSbGysJCk2NtamUE+dnzovs5jExERdvnw5w7zCw8Pl4eFhTn5+ftndNAAAcJNx48bJzs5OYWFhZhvPqAEA4M7LdrFesWJFRUdHa9u2bXrppZfUvXt37du3707kli0jRoxQQkKCOZ04cSKvUwIAIF/bsWOHPvnkE9WoUcOmnWfUAABw52W7WHd0dFT58uVVp04dhYeHq2bNmpo6daq8vb119epVnTt3ziY+Li5O3t7ekiRvb+80v7ynvr5VjLu7u1xcXDLMy8nJyXxKfeoEAABuz4ULF9S1a1d9+umnKlq0qNmekJCgzz77TJMmTVKLFi1Up04dzZkzR7/88ou2bt0qSeYzar788kvVqlVLbdu21dixYzV9+nRdvXpVkmyeUVO5cmX1799fnTt31uTJk/NkewEAsJocj7OekpKipKQk1alTRwULFtTq1avNeQcPHtTx48cVGBgoSQoMDNTu3bsVHx9vxkRGRsrd3V1VqlQxY25cRmpM6jIAAMCdFxoaqpCQkDTPkcnLZ9TwfBoAwP0kW0+DHzFihNq2basyZcro/PnzWrBggdatW6cVK1bIw8NDvXr10uDBg1WsWDG5u7trwIABCgwM1COPPCJJat26tapUqaLnn39e48ePV2xsrEaOHKnQ0FA5OTlJkl588UV99NFHGjp0qF544QWtWbNG33zzjZYuXZr7Ww8AANL4+uuv9dtvv2nHjh1p5t2tZ9SkdzVdeHi43n777dveLgAA8pNsFevx8fHq1q2bTp06JQ8PD9WoUUMrVqxQq1atJEmTJ0+Wvb29OnXqpKSkJAUHB+vjjz823+/g4KAlS5bopZdeUmBgoFxdXdW9e3eNGTPGjAkICNDSpUs1aNAgTZ06VaVLl9bs2bMZtg0AgLvgxIkTGjhwoCIjI+Xs7JzX6dgYMWKEBg8ebL5OTEzkgbIAgHtWtor1zz77LNP5zs7Omj59uqZPn55hjL+/v37++edMl9OsWTPt3LkzO6kBAIBcEBUVpfj4eD300ENmW3JysjZs2KCPPvpIK1asMJ9Rc+PZ9ZufUbN9+3ab5ebGM2qcnJzMK/EAALjXZatYB3Ji+KrheZ3CLY0LGpfXKQBAnmrZsqV2795t09azZ09VqlRJw4YNk5+fn/mMmk6dOklK/xk17777ruLj4+Xp6Skp/WfU3PzjPc+oAQDg/1CsAwAAk5ubm6pVq2bT5urqquLFi5vtPKMGAIA7j2IdAABkC8+oAQDgzqNYBwAAmVq3bp3Na55RAwDAnZfjcdYBAAAAAEDuolgHAAAAAMBiKNYBAAAAALAYinUAAAAAACyGYh0AAAAAAIuhWAcAAAAAwGIYug0AACAfWTV8eF6nkKmgcePyOgUAuCdwZh0AAAAAAIuhWAcAAAAAwGIo1gEAAAAAsBiKdQAAAAAALIZiHQAAAAAAi6FYBwAAAADAYijWAQAAAACwGIp1AAAAAAAshmIdAAAAAACLoVgHAAAAAMBiKNYBAAAAALAYinUAAAAAACyGYh0AAAAAAIuhWAcAAKYZM2aoRo0acnd3l7u7uwIDA7Vs2TJzfrNmzWRnZ2czvfjiizbLOH78uEJCQlSoUCF5enrqtdde0/Xr121i1q1bp4ceekhOTk4qX768IiIi7sbmAQCQbxTI6wQAAIB1lC5dWuPGjVOFChVkGIbmzp2rxx57TDt37lTVqlUlSX369NGYMWPM9xQqVMj8/+TkZIWEhMjb21u//PKLTp06pW7duqlgwYJ67733JEkxMTEKCQnRiy++qPnz52v16tXq3bu3fHx8FBwcfHc3GAAAi6JYBwAApg4dOti8fvfddzVjxgxt3brVLNYLFSokb2/vdN+/cuVK7du3T6tWrZKXl5dq1aqlsWPHatiwYRo9erQcHR01c+ZMBQQEaOLEiZKkypUra9OmTZo8eTLFOgAA/x+XwQMAgHQlJyfr66+/1sWLFxUYGGi2z58/XyVKlFC1atU0YsQIXbp0yZy3ZcsWVa9eXV5eXmZbcHCwEhMTtXfvXjMmKCjIZl3BwcHasmVLpvkkJSUpMTHRZgIA4F7FmXUAAGBj9+7dCgwM1JUrV1S4cGF9//33qlKliiTp2Weflb+/v3x9fbVr1y4NGzZMBw8e1HfffSdJio2NtSnUJZmvY2NjM41JTEzU5cuX5eLikm5e4eHhevvtt3N1WwEAsCqKdQAAYKNixYqKjo5WQkKCvv32W3Xv3l3r169XlSpV1LdvXzOuevXq8vHxUcuWLXXkyBGVK1fujuY1YsQIDR482HydmJgoPz+/O7pOAADyCpfBAwAAG46Ojipfvrzq1Kmj8PBw1axZU1OnTk03tn79+pKkw4cPS5K8vb0VFxdnE5P6OvU+94xi3N3dMzyrLklOTk7mU+pTJwAA7lXZKtbDw8NVr149ubm5ydPTUx07dtTBgwdtYhjSBQCAe0tKSoqSkpLSnRcdHS1J8vHxkSQFBgZq9+7dio+PN2MiIyPl7u5uXkofGBio1atX2ywnMjLS5r54AADud9kq1tevX6/Q0FBt3bpVkZGRunbtmlq3bq2LFy/axPXp00enTp0yp/Hjx5vzUod0uXr1qn755RfNnTtXERERGjVqlBmTOqRL8+bNFR0drbCwMPXu3VsrVqzI4eYCAIDMjBgxQhs2bNDRo0e1e/dujRgxQuvWrVPXrl115MgRjR07VlFRUTp69KgWL16sbt26qUmTJqpRo4YkqXXr1qpSpYqef/55/f7771qxYoVGjhyp0NBQOTk5SZJefPFF/fnnnxo6dKgOHDigjz/+WN98840GDRqUl5sOAIClZOue9eXLl9u8joiIkKenp6KiotSkSROznSFdAADIn+Lj49WtWzedOnVKHh4eqlGjhlasWKFWrVrpxIkTWrVqlaZMmaKLFy/Kz89PnTp10siRI833Ozg4aMmSJXrppZcUGBgoV1dXde/e3WZc9oCAAC1dulSDBg3S1KlTVbp0ac2ePZs+HgCAG+ToAXMJCQmSpGLFitm0z58/X19++aW8vb3VoUMHvfnmmypUqJCkjId0eemll7R3717Vrl07wyFdwsLCMswlKSnJ5hI9hnPB/2vv/sOirPP9j78QnQHTGUJjBi6RQ+sm4O+wcFbzS8kBibU8cp1zLFN3pbzqGtxFWjX3mLla0eKaqZGeThbttbJq51rbRFdFTMgCNTZWw5atlr2wkwPXZjLJJiDM94893KfZ1ELQudHn47o+1+V9f95zz/tzt9u7t/d9zw0A6LrNmzdfdC46OlplZWXfeIyYmBjt3r37kjHJycl67733upwfAADXi8tu1js6OpSTk6OJEydq5MiRxv5AvdKF17kAAAAAAK4Vl92su91uvf/++zp06JDf/kC90oXXuQAAAAAArhWX9eq27OxsFRcX680339SQIUMuGXu1XunC61wAAAAAANeKLjXrPp9P2dnZ2rFjhw4cOKDY2Nhv/AyvdAEAAAAAoGu61Ky73W796le/UlFRkQYOHCiPxyOPx6Mvv/xSknilCwAAAAAAPaBLzfrGjRvV1NSk5ORkRUZGGmPbtm2SJIvFov379ys1NVVxcXF69NFHlZmZqZ07dxrH6HylS3BwsFwulx544AHNmTPngq90KSkp0ZgxY7RmzRpe6QIAAAAAuG506QfmfD7fJed5pQsAAAAAAN13WT8wBwAAAAAArhyadQAAAAAATIZmHQAAAAAAk6FZBwAAAADAZGjWAQAAAAAwGZp1AAAAAABMhmYdAAAAAACToVkHAAAAAMBkaNYBAAAAADAZmnUAAAAAAEyGZh0AAAAAAJOhWQcAAAAAwGRo1gEAAAAAMBmadQAAAAAATIZmHQAAGDZu3KjRo0fLZrPJZrPJ5XLpd7/7nTF/7tw5ud1uDRo0SAMGDFBmZqYaGhr8jlFfX6+MjAz1799fERERWrRokc6fP+8Xc/DgQd16662yWq0aNmyYCgsLr8byAADoNWjWAQCAYciQIXrmmWdUVVWld999V3fddZfuvfde1dTUSJIWLlyonTt36rXXXlNZWZk+/fRTzZgxw/h8e3u7MjIy1NraqnfeeUevvvqqCgsLtXz5ciOmrq5OGRkZuvPOO1VdXa2cnBw9+OCD2rt371VfLwAAZtU30AkAAADzmDZtmt/2U089pY0bN6qyslJDhgzR5s2bVVRUpLvuukuS9Morryg+Pl6VlZWaMGGC9u3bpxMnTmj//v1yOBwaO3asVq1apSVLlmjFihWyWCzatGmTYmNjtWbNGklSfHy8Dh06pLVr1yotLe2iubW0tKilpcXY9nq9V+AMAABgDlxZBwAAF9Te3q6tW7equblZLpdLVVVVamtrU0pKihETFxenoUOHqqKiQpJUUVGhUaNGyeFwGDFpaWnyer3G1fmKigq/Y3TGdB7jYvLy8mS3240RHR3dU0sFAMB0aNYBAICf48ePa8CAAbJarXr44Ye1Y8cOJSQkyOPxyGKxKCwszC/e4XDI4/FIkjwej1+j3jnfOXepGK/Xqy+//PKieS1dulRNTU3GOHnyZHeXCgCAaXEbPAAA8DN8+HBVV1erqalJ//3f/625c+eqrKws0GnJarXKarUGOg0AAK4KmnUAAODHYrFo2LBhkqTExEQdPXpU69at07//+7+rtbVVZ86c8bu63tDQIKfTKUlyOp06cuSI3/E6fy3+qzH/+AvyDQ0NstlsCg0NvVLLAgCgV+E2eAAAcEkdHR1qaWlRYmKi+vXrp9LSUmOutrZW9fX1crlckiSXy6Xjx4+rsbHRiCkpKZHNZlNCQoIR89VjdMZ0HgMAAHBlHQAAfMXSpUuVnp6uoUOH6osvvlBRUZEOHjyovXv3ym63KysrS7m5uQoPD5fNZtOCBQvkcrk0YcIESVJqaqoSEhI0e/Zs5efny+PxaNmyZXK73cYt7A8//LCef/55LV68WPPmzdOBAwe0fft27dq1K5BLBwDAVGjWAQCAobGxUXPmzNGpU6dkt9s1evRo7d27V//8z/8sSVq7dq369OmjzMxMtbS0KC0tTS+88ILx+eDgYBUXF+uRRx6Ry+XSDTfcoLlz52rlypVGTGxsrHbt2qWFCxdq3bp1GjJkiF566aVLvrYNAIDrDc06AAAwbN68+ZLzISEhKigoUEFBwUVjYmJitHv37kseJzk5We+9995l5QgAwPWAZ9YBAAAAADAZmnUAAAAAAEyGZh0AAAAAAJOhWQcAAAAAwGRo1gEAAAAAMBmadQAAAAAATIZmHQAAAAAAk+lSs56Xl6fbbrtNAwcOVEREhKZPn67a2lq/mHPnzsntdmvQoEEaMGCAMjMz1dDQ4BdTX1+vjIwM9e/fXxEREVq0aJHOnz/vF3Pw4EHdeuutslqtGjZsmAoLCy9vhQAAAAAA9DJdatbLysrkdrtVWVmpkpIStbW1KTU1Vc3NzUbMwoULtXPnTr322msqKyvTp59+qhkzZhjz7e3tysjIUGtrq9555x29+uqrKiws1PLly42Yuro6ZWRk6M4771R1dbVycnL04IMPau/evT2wZAAAAAAAzK1vV4L37Nnjt11YWKiIiAhVVVVp8uTJampq0ubNm1VUVKS77rpLkvTKK68oPj5elZWVmjBhgvbt26cTJ05o//79cjgcGjt2rFatWqUlS5ZoxYoVslgs2rRpk2JjY7VmzRpJUnx8vA4dOqS1a9cqLS2th5YOAAAAAIA5deuZ9aamJklSeHi4JKmqqkptbW1KSUkxYuLi4jR06FBVVFRIkioqKjRq1Cg5HA4jJi0tTV6vVzU1NUbMV4/RGdN5jAtpaWmR1+v1GwAAAAAA9EaX3ax3dHQoJydHEydO1MiRIyVJHo9HFotFYWFhfrEOh0Mej8eI+Wqj3jnfOXepGK/Xqy+//PKC+eTl5clutxsjOjr6cpcGAAAAAEBAXXaz7na79f7772vr1q09mc9lW7p0qZqamoxx8uTJQKcEAAAAAMBl6dIz652ys7NVXFys8vJyDRkyxNjvdDrV2tqqM2fO+F1db2hokNPpNGKOHDnid7zOX4v/asw//oJ8Q0ODbDabQkNDL5iT1WqV1Wq9nOUAAAAAAGAqXbqy7vP5lJ2drR07dujAgQOKjY31m09MTFS/fv1UWlpq7KutrVV9fb1cLpckyeVy6fjx42psbDRiSkpKZLPZlJCQYMR89RidMZ3HAAAAAADgWtalK+tut1tFRUX67W9/q4EDBxrPmNvtdoWGhsputysrK0u5ubkKDw+XzWbTggUL5HK5NGHCBElSamqqEhISNHv2bOXn58vj8WjZsmVyu93GlfGHH35Yzz//vBYvXqx58+bpwIED2r59u3bt2tXDywcAAAAAwHy6dGV948aNampqUnJysiIjI42xbds2I2bt2rX6/ve/r8zMTE2ePFlOp1O/+c1vjPng4GAVFxcrODhYLpdLDzzwgObMmaOVK1caMbGxsdq1a5dKSko0ZswYrVmzRi+99BKvbQMAAAAAXBe6dGXd5/N9Y0xISIgKCgpUUFBw0ZiYmBjt3r37ksdJTk7We++915X0AAAAAAC4JnTrPesAAAAAAKDn0awDAAAAAGAyNOsAAMCQl5en2267TQMHDlRERISmT5+u2tpav5jk5GQFBQX5jYcfftgvpr6+XhkZGerfv78iIiK0aNEinT9/3i/m4MGDuvXWW2W1WjVs2DAVFhZe6eUBANBr0KwDAABDWVmZ3G63KisrVVJSora2NqWmpqq5udkv7qGHHtKpU6eMkZ+fb8y1t7crIyNDra2teuedd/Tqq6+qsLBQy5cvN2Lq6uqUkZGhO++8U9XV1crJydGDDz6ovXv3XrW1AgBgZl36gTkAAHBt27Nnj992YWGhIiIiVFVVpcmTJxv7+/fvL6fTecFj7Nu3TydOnND+/fvlcDg0duxYrVq1SkuWLNGKFStksVi0adMmxcbGas2aNZKk+Ph4HTp0SGvXruXtLwAAiCvrAADgEpqamiRJ4eHhfvu3bNmiwYMHa+TIkVq6dKn+9re/GXMVFRUaNWqUHA6HsS8tLU1er1c1NTVGTEpKit8x09LSVFFRcdFcWlpa5PV6/QYAANcqrqwDAIAL6ujoUE5OjiZOnKiRI0ca+++//37FxMQoKipKx44d05IlS1RbW6vf/OY3kiSPx+PXqEsytj0ezyVjvF6vvvzyS4WGhn4tn7y8PP3sZz/r0TUCAGBWNOsAAOCC3G633n//fR06dMhv//z5840/jxo1SpGRkZoyZYo+/vhjfec737li+SxdulS5ubnGttfrVXR09BX7PgAAAonb4AEAwNdkZ2eruLhYb775poYMGXLJ2KSkJEnSRx99JElyOp1qaGjwi+nc7nzO/WIxNpvtglfVJclqtcpms/kNAACuVTTrAADA4PP5lJ2drR07dujAgQOKjY39xs9UV1dLkiIjIyVJLpdLx48fV2NjoxFTUlIim82mhIQEI6a0tNTvOCUlJXK5XD20EgAAejeadQAAYHC73frVr36loqIiDRw4UB6PRx6PR19++aUk6eOPP9aqVatUVVWlv/zlL3rjjTc0Z84cTZ48WaNHj5YkpaamKiEhQbNnz9Yf/vAH7d27V8uWLZPb7ZbVapUkPfzww/rzn/+sxYsX649//KNeeOEFbd++XQsXLgzY2gEAMBOadQAAYNi4caOampqUnJysyMhIY2zbtk2SZLFYtH//fqWmpiouLk6PPvqoMjMztXPnTuMYwcHBKi4uVnBwsFwulx544AHNmTNHK1euNGJiY2O1a9culZSUaMyYMVqzZo1eeuklXtsGAMD/4gfmAACAwefzXXI+OjpaZWVl33icmJgY7d69+5IxycnJeu+997qUHwAA1wuurAMAAAAAYDI06wAAAAAAmAzNOgAAAAAAJkOzDgAAAACAydCsAwAAAABgMjTrAAAAAACYDM06AAAAAAAmQ7MOAAAAAIDJ9A10Ar3JY/sfC3QKAAAAAIDrAFfWAQAAAAAwGZp1AAAAAABMhmYdAAAAAACToVkHAAAAAMBkaNYBAAAAADAZmnUAAAAAAEyGZh0AAAAAAJOhWQcAAAAAwGRo1gEAAAAAMJm+Xf1AeXm5Vq9eraqqKp06dUo7duzQ9OnTjfkf/OAHevXVV/0+k5aWpj179hjbp0+f1oIFC7Rz50716dNHmZmZWrdunQYMGGDEHDt2TG63W0ePHtVNN92kBQsWaPHixZexRODbe2z/Y4FO4ZKeSXkm0CkAAAAAuAq6fGW9ublZY8aMUUFBwUVjpk6dqlOnThnj17/+td/8rFmzVFNTo5KSEhUXF6u8vFzz58835r1er1JTUxUTE6OqqiqtXr1aK1as0IsvvtjVdAEAAAAA6HW63Kynp6frySef1L/8y79cNMZqtcrpdBrjxhtvNOY++OAD7dmzRy+99JKSkpI0adIkbdiwQVu3btWnn34qSdqyZYtaW1v18ssva8SIEZo5c6Z+9KMf6dlnn72MJQIAgG8rLy9Pt912mwYOHKiIiAhNnz5dtbW1fjHnzp2T2+3WoEGDNGDAAGVmZqqhocEvpr6+XhkZGerfv78iIiK0aNEinT9/3i/m4MGDuvXWW2W1WjVs2DAVFhZe6eUBANBrXJFn1g8ePKiIiAgNHz5cjzzyiD777DNjrqKiQmFhYRo/fryxLyUlRX369NHhw4eNmMmTJ8tisRgxaWlpqq2t1eeff37B72xpaZHX6/UbAACga8rKyuR2u1VZWamSkhK1tbUpNTVVzc3NRszChQu1c+dOvfbaayorK9Onn36qGTNmGPPt7e3KyMhQa2ur3nnnHb366qsqLCzU8uXLjZi6ujplZGTozjvvVHV1tXJycvTggw9q7969V3W9AACYVZefWf8mU6dO1YwZMxQbG6uPP/5YP/3pT5Wenq6KigoFBwfL4/EoIiLCP4m+fRUeHi6PxyNJ8ng8io2N9YtxOBzG3Fev1HfKy8vTz372s55eDgAA15Wv/saMJBUWFioiIkJVVVWaPHmympqatHnzZhUVFemuu+6SJL3yyiuKj49XZWWlJkyYoH379unEiRPav3+/HA6Hxo4dq1WrVmnJkiVasWKFLBaLNm3apNjYWK1Zs0aSFB8fr0OHDmnt2rVKS0u76usGAMBsevzK+syZM3XPPfdo1KhRmj59uoqLi3X06FEdPHiwp7/Kz9KlS9XU1GSMkydPXtHvAwDgetDU1CRJCg8PlyRVVVWpra1NKSkpRkxcXJyGDh2qiooKSX+/Q27UqFHGX7RLf79Dzuv1qqamxoj56jE6YzqPcSHcRQcAuJ5c8Ve33XzzzRo8eLA++ugjSZLT6VRjY6NfzPnz53X69Gk5nU4j5h+ffevc7oz5R1arVTabzW8AAIDL19HRoZycHE2cOFEjR46U9Pc73CwWi8LCwvxiHQ6H3x1yX23UO+c75y4V4/V69eWXX14wn7y8PNntdmNER0d3e40AAJjVFW/WP/nkE3322WeKjIyUJLlcLp05c0ZVVVVGzIEDB9TR0aGkpCQjpry8XG1tbUZMSUmJhg8ffsFb4AEAQM9zu916//33tXXr1kCnIom76AAA15cuN+tnz55VdXW1qqurJf39B2Kqq6tVX1+vs2fPatGiRaqsrNRf/vIXlZaW6t5779WwYcOM58/i4+M1depUPfTQQzpy5IjefvttZWdna+bMmYqKipIk3X///bJYLMrKylJNTY22bdumdevWKTc3t+dWDgAALio7O1vFxcV68803NWTIEGO/0+lUa2urzpw54xff0NDQpTvkLhZjs9kUGhp6wZy4iw4AcD3pcrP+7rvvaty4cRo3bpwkKTc3V+PGjdPy5csVHBysY8eO6Z577tEtt9yirKwsJSYm6q233pLVajWOsWXLFsXFxWnKlCm6++67NWnSJL93qNvtdu3bt091dXVKTEzUo48+quXLl/u9ix0AAPQ8n8+n7Oxs7dixQwcOHPjaD74mJiaqX79+Ki0tNfbV1taqvr5eLpdL0t/vkDt+/LjfY28lJSWy2WxKSEgwYr56jM6YzmMAAHC96/KvwScnJ8vn8110/tu8ciU8PFxFRUWXjBk9erTeeuutrqYHAAC6we12q6ioSL/97W81cOBA4xlzu92u0NBQ2e12ZWVlKTc3V+Hh4bLZbFqwYIFcLpcmTJggSUpNTVVCQoJmz56t/Px8eTweLVu2TG632/jL+4cffljPP/+8Fi9erHnz5unAgQPavn27du3aFbC1AwBgJlf8mXUAANB7bNy4UU1NTUpOTlZkZKQxtm3bZsSsXbtW3//+95WZmanJkyfL6XTqN7/5jTEfHBys4uJiBQcHy+Vy6YEHHtCcOXO0cuVKIyY2Nla7du1SSUmJxowZozVr1uill17itW0AAPyvHn/POgAA6L0udfdcp5CQEBUUFKigoOCiMTExMdq9e/clj5OcnKz33nuvyzkCAHA94Mo6AAAAAAAmQ7MOAAAAAIDJ0KwDAAAAAGAyNOsAAAAAAJgMzToAAAAAACZDsw4AAAAAgMnQrAMAAAAAYDI06wAAAAAAmAzNOgAAAAAAJkOzDgAAAACAydCsAwAAAABgMjTrAAAAAACYDM06AAAAAAAmQ7MOAAAAAIDJ0KwDAAAAAGAyNOsAAAAAAJgMzToAAAAAACZDsw4AAAAAgMnQrAMAAAAAYDI06wAAAAAAmAzNOgAAAAAAJkOzDgAA/JSXl2vatGmKiopSUFCQXn/9db/5H/zgBwoKCvIbU6dO9Ys5ffq0Zs2aJZvNprCwMGVlZens2bN+MceOHdMdd9yhkJAQRUdHKz8//0ovDQCAXoNmHQAA+GlubtaYMWNUUFBw0ZipU6fq1KlTxvj1r3/tNz9r1izV1NSopKRExcXFKi8v1/z58415r9er1NRUxcTEqKqqSqtXr9aKFSv04osvXrF1AQDQm/QNdAIAAMBc0tPTlZ6efskYq9Uqp9N5wbkPPvhAe/bs0dGjRzV+/HhJ0oYNG3T33XfrF7/4haKiorRlyxa1trbq5ZdflsVi0YgRI1RdXa1nn33Wr6n/qpaWFrW0tBjbXq/3MleIK2n/Y48FOoVLSnnmmUCnAADfClfWAQBAlx08eFAREREaPny4HnnkEX322WfGXEVFhcLCwoxGXZJSUlLUp08fHT582IiZPHmyLBaLEZOWlqba2lp9/vnnF/zOvLw82e12Y0RHR1+h1QEAEHg06wAAoEumTp2qX/7ylyotLdXPf/5zlZWVKT09Xe3t7ZIkj8ejiIgIv8/07dtX4eHh8ng8RozD4fCL6dzujPlHS5cuVVNTkzFOnjzZ00sDAMA0uA0eAAB0ycyZM40/jxo1SqNHj9Z3vvMdHTx4UFOmTLli32u1WmW1Wq/Y8QEAMBOurAMAgG65+eabNXjwYH300UeSJKfTqcbGRr+Y8+fP6/Tp08Zz7k6nUw0NDX4xndsXexYeAIDrCc06AADolk8++USfffaZIiMjJUkul0tnzpxRVVWVEXPgwAF1dHQoKSnJiCkvL1dbW5sRU1JSouHDh+vGG2+8ugsAAMCEaNYBAICfs2fPqrq6WtXV1ZKkuro6VVdXq76+XmfPntWiRYtUWVmpv/zlLyotLdW9996rYcOGKS0tTZIUHx+vqVOn6qGHHtKRI0f09ttvKzs7WzNnzlRUVJQk6f7775fFYlFWVpZqamq0bds2rVu3Trm5uYFaNgAAptLlZr28vFzTpk1TVFSUgoKC9Prrr/vN+3w+LV++XJGRkQoNDVVKSoo+/PBDv5jTp09r1qxZstlsCgsLU1ZWls6ePesXc+zYMd1xxx0KCQlRdHS08vPzu746AADQZe+++67GjRuncePGSZJyc3M1btw4LV++XMHBwTp27Jjuuece3XLLLcrKylJiYqLeeustv+fJt2zZori4OE2ZMkV33323Jk2a5PcOdbvdrn379qmurk6JiYl69NFHtXz58ou+tg0AgOtNl39grrm5WWPGjNG8efM0Y8aMr83n5+dr/fr1evXVVxUbG6vHH39caWlpOnHihEJCQiRJs2bN0qlTp1RSUqK2tjb98Ic/1Pz581VUVCTp7+9NTU1NVUpKijZt2qTjx49r3rx5CgsLo4gDAHCFJScny+fzXXR+796933iM8PBwo65fzOjRo/XWW291OT8AAK4HXW7W09PTlZ6efsE5n8+n5557TsuWLdO9994rSfrlL38ph8Oh119/XTNnztQHH3ygPXv26OjRo8b7Vzds2KC7775bv/jFLxQVFaUtW7aotbVVL7/8siwWi0aMGKHq6mo9++yzF23WW1pa1NLSYmx7vd6uLg0AAAAAAFPo0WfW6+rq5PF4lJKSYuyz2+1KSkpSRUWFJKmiokJhYWFGoy5JKSkp6tOnjw4fPmzETJ48WRaLxYhJS0tTbW2tPv/88wt+d15enux2uzGio6N7cmkAAAAAAFw1PdqsezweSZLD4fDb73A4jDmPx6OIiAi/+b59+yo8PNwv5kLH+Op3/KOlS5eqqanJGCdPnuz+ggAAAAAACIAu3wZvVlar1e+HbQAAAAAA6K169Mq60+mUJDU0NPjtb2hoMOacTqcaGxv95s+fP6/Tp0/7xVzoGF/9DgAAAAAArlU92qzHxsbK6XSqtLTU2Of1enX48GG5XC5Jksvl0pkzZ1RVVWXEHDhwQB0dHUpKSjJiysvL1dbWZsSUlJRo+PDhuvHGG3syZQAAAAAATKfLzfrZs2dVXV2t6upqSX//Ubnq6mrV19crKChIOTk5evLJJ/XGG2/o+PHjmjNnjqKiojR9+nRJUnx8vKZOnaqHHnpIR44c0dtvv63s7GzNnDlTUVFRkqT7779fFotFWVlZqqmp0bZt27Ru3Trl5ub22MIBAAAAADCrLj+z/u677+rOO+80tjsb6Llz56qwsFCLFy9Wc3Oz5s+frzNnzmjSpEnas2eP8Y51SdqyZYuys7M1ZcoU9enTR5mZmVq/fr0xb7fbtW/fPrndbiUmJmrw4MFavnw571gHAAAAAFwXutysJycny+fzXXQ+KChIK1eu1MqVKy8aEx4erqKiokt+z+jRo/XWW291NT0AAAAAAHq9Hn1mHQAAAAAAdB/NOgAAAAAAJkOzDgAAAACAydCsAwAAAABgMjTrAAAAAACYDM06AAAAAAAmQ7MOAAAAAIDJ0KwDAAAAAGAyNOsAAAAAAJgMzToAAAAAACZDsw4AAAAAgMnQrAMAAD/l5eWaNm2aoqKiFBQUpNdff91v3ufzafny5YqMjFRoaKhSUlL04Ycf+sWcPn1as2bNks1mU1hYmLKysnT27Fm/mGPHjumOO+5QSEiIoqOjlZ+ff6WXBgBAr0GzDgAA/DQ3N2vMmDEqKCi44Hx+fr7Wr1+vTZs26fDhw7rhhhuUlpamc+fOGTGzZs1STU2NSkpKVFxcrPLycs2fP9+Y93q9Sk1NVUxMjKqqqrR69WqtWLFCL7744hVfHwAAvUHfQCcAAADMJT09Xenp6Rec8/l8eu6557Rs2TLde++9kqRf/vKXcjgcev311zVz5kx98MEH2rNnj44eParx48dLkjZs2KC7775bv/jFLxQVFaUtW7aotbVVL7/8siwWi0aMGKHq6mo9++yzfk09AADXK66sAwCAb62urk4ej0cpKSnGPrvdrqSkJFVUVEiSKioqFBYWZjTqkpSSkqI+ffro8OHDRszkyZNlsViMmLS0NNXW1urzzz+/4He3tLTI6/X6DQAArlU06wAA4FvzeDySJIfD4bff4XAYcx6PRxEREX7zffv2VXh4uF/MhY7x1e/4R3l5ebLb7caIjo7u/oIAADApmnUAANArLF26VE1NTcY4efJkoFMCAOCKoVkHAADfmtPplCQ1NDT47W9oaDDmnE6nGhsb/ebPnz+v06dP+8Vc6Bhf/Y5/ZLVaZbPZ/AYAANcqmnUAAPCtxcbGyul0qrS01Njn9Xp1+PBhuVwuSZLL5dKZM2dUVVVlxBw4cEAdHR1KSkoyYsrLy9XW1mbElJSUaPjw4brxxhuv0moAADAvmnUAAODn7Nmzqq6uVnV1taS//6hcdXW16uvrFRQUpJycHD355JN64403dPz4cc2ZM0dRUVGaPn26JCk+Pl5Tp07VQw89pCNHjujtt99Wdna2Zs6cqaioKEnS/fffL4vFoqysLNXU1Gjbtm1at26dcnNzA7RqAADMhVe3AQAAP++++67uvPNOY7uzgZ47d64KCwu1ePFiNTc3a/78+Tpz5owmTZqkPXv2KCQkxPjMli1blJ2drSlTpqhPnz7KzMzU+vXrjXm73a59+/bJ7XYrMTFRgwcP1vLly3ltGwAA/4tmHQAA+ElOTpbP57vofFBQkFauXKmVK1deNCY8PFxFRUWX/J7Ro0frrbfeuuw8AQC4lnEbPAAAAAAAJkOzDgAAAACAydCsAwAAAABgMjTrAAAAAACYDM06AAAAAAAmQ7MOAAAAAIDJ0KwDAAAAAGAyvGcd6EUe2/9YoFO4pGdSngl0CgAAAMA1gSvrAAAAAACYTI836ytWrFBQUJDfiIuLM+bPnTsnt9utQYMGacCAAcrMzFRDQ4PfMerr65WRkaH+/fsrIiJCixYt0vnz53s6VQAAAAAATOmK3AY/YsQI7d+///++pO//fc3ChQu1a9cuvfbaa7Lb7crOztaMGTP09ttvS5La29uVkZEhp9Opd955R6dOndKcOXPUr18/Pf3001ciXQAAAAAATOWKNOt9+/aV0+n82v6mpiZt3rxZRUVFuuuuuyRJr7zyiuLj41VZWakJEyZo3759OnHihPbv3y+Hw6GxY8dq1apVWrJkiVasWCGLxXIlUgYAAAAAwDSuyDPrH374oaKionTzzTdr1qxZqq+vlyRVVVWpra1NKSkpRmxcXJyGDh2qiooKSVJFRYVGjRolh8NhxKSlpcnr9aqmpuai39nS0iKv1+s3AAAAAADojXq8WU9KSlJhYaH27NmjjRs3qq6uTnfccYe++OILeTweWSwWhYWF+X3G4XDI4/FIkjwej1+j3jnfOXcxeXl5stvtxoiOju7ZhQEAAAAAcJX0+G3w6enpxp9Hjx6tpKQkxcTEaPv27QoNDe3przMsXbpUubm5xrbX66VhBwAAAAD0Slf81W1hYWG65ZZb9NFHH8npdKq1tVVnzpzxi2loaDCecXc6nV/7dfjO7Qs9B9/JarXKZrP5DQAAAAAAeqMr3qyfPXtWH3/8sSIjI5WYmKh+/fqptLTUmK+trVV9fb1cLpckyeVy6fjx42psbDRiSkpKZLPZlJCQcKXTBQAAAAAg4Hr8Nvif/OQnmjZtmmJiYvTpp5/qiSeeUHBwsO677z7Z7XZlZWUpNzdX4eHhstlsWrBggVwulyZMmCBJSk1NVUJCgmbPnq38/Hx5PB4tW7ZMbrdbVqu1p9MFAAAAAMB0erxZ/+STT3Tffffps88+00033aRJkyapsrJSN910kyRp7dq16tOnjzIzM9XS0qK0tDS98MILxueDg4NVXFysRx55RC6XSzfccIPmzp2rlStX9nSqAAAAAACYUo8361u3br3kfEhIiAoKClRQUHDRmJiYGO3evbunUwMAAAAAoFe44s+sAwCAa8uKFSsUFBTkN+Li4oz5c+fOye12a9CgQRowYIAyMzO/9uOx9fX1ysjIUP/+/RUREaFFixbp/PnzV3spAACYVo9fWQcAANe+ESNGaP/+/cZ2377/958UCxcu1K5du/Taa6/JbrcrOztbM2bM0Ntvvy1Jam9vV0ZGhpxOp9555x2dOnVKc+bMUb9+/fT0009f9bUAAGBGNOsAAKDL+vbte8FXqjY1NWnz5s0qKirSXXfdJUl65ZVXFB8fr8rKSk2YMEH79u3TiRMntH//fjkcDo0dO1arVq3SkiVLtGLFClkslqu9HAAATIfb4AEAQJd9+OGHioqK0s0336xZs2apvr5eklRVVaW2tjalpKQYsXFxcRo6dKgqKiokSRUVFRo1apQcDocRk5aWJq/Xq5qamot+Z0tLi7xer98AAOBaRbMOAAC6JCkpSYWFhdqzZ482btyouro63XHHHfriiy/k8XhksVgUFhbm9xmHwyGPxyNJ8ng8fo1653zn3MXk5eXJbrcbIzo6umcXBgCAiXAbPAAA6JL09HTjz6NHj1ZSUpJiYmK0fft2hYaGXrHvXbp0qXJzc41tr9dLww4AuGZxZR0AAHRLWFiYbrnlFn300UdyOp1qbW3VmTNn/GIaGhqMZ9ydTufXfh2+c/tCz8F3slqtstlsfgMAgGsVzToAAOiWs2fP6uOPP1ZkZKQSExPVr18/lZaWGvO1tbWqr6+Xy+WSJLlcLh0/flyNjY1GTElJiWw2mxISEq56/gAAmBG3wQMAgC75yU9+omnTpikmJkaffvqpnnjiCQUHB+u+++6T3W5XVlaWcnNzFR4eLpvNpgULFsjlcmnChAmSpNTUVCUkJGj27NnKz8+Xx+PRsmXL5Ha7ZbVaA7w6AADMgWYdAAB0ySeffKL77rtPn332mW666SZNmjRJlZWVuummmyRJa9euVZ8+fZSZmamWlhalpaXphRdeMD4fHBys4uJiPfLII3K5XLrhhhs0d+5crVy5MlBLAgDAdGjWAQBAl2zduvWS8yEhISooKFBBQcFFY2JiYrR79+6eTg0AgGsGzToAAACuG/sfeyzQKVxSyjPPBDoFACbBD8wBAAAAAGAyNOsAAAAAAJgMzToAAAAAACZDsw4AAAAAgMnQrAMAAAAAYDI06wAAAAAAmAzNOgAAAAAAJkOzDgAAAACAydCsAwAAAABgMjTrAAAAAACYDM06AAAAAAAmQ7MOAAAAAIDJ9A10AgCuHY/tfyzQKXyjZ1KeCXQKAAAAwDfiyjoAAAAAACZDsw4AAAAAgMnQrAMAAAAAYDI06wAAAAAAmAzNOgAAAAAAJkOzDgAAAACAydCsAwAAAABgMqZ+z3pBQYFWr14tj8ejMWPGaMOGDbr99tsDnRaAXszs74LnPfC4HlHvgf+z/zFz1ylJSnmGWgVcDaa9sr5t2zbl5ubqiSee0O9//3uNGTNGaWlpamxsDHRqAACgh1DvAQC4MNNeWX/22Wf10EMP6Yc//KEkadOmTdq1a5defvllPXaBv3FsaWlRS0uLsd3U1CRJ8nq9PZZTS3PLNwcBQDf05L+zYD6d/3x9Pl+AMzGPrtT7q1Hrm1uo9cA3oVYBF9ejtd5nQi0tLb7g4GDfjh07/PbPmTPHd88991zwM0888YRPEoPBYDAYph8ff/zxVaim5tfVek+tZzAYDEZvGT1R6015Zf2vf/2r2tvb5XA4/PY7HA798Y9/vOBnli5dqtzcXGO7o6NDp0+f1qBBgxQUFNTtnLxer6Kjo3Xy5EnZbLZuH+96w/nrPs5h93EOu4fz131NTU0aOnSowsPDA52KKXS13lPrzY9z2D2cv+7jHHYP56/7erLWm7JZvxxWq1VWq9VvX1hYWI9/j81m43+43cD56z7OYfdxDruH89d9ffqY9idjTI1a33twDruH89d9nMPu4fx1X0/UelP+18LgwYMVHByshoYGv/0NDQ1yOp0BygoAAPQk6j0AABdnymbdYrEoMTFRpaWlxr6Ojg6VlpbK5XIFMDMAANBTqPcAAFycaW+Dz83N1dy5czV+/Hjdfvvteu6559Tc3Gz8WuzVZrVa9cQTT3zt9jt8O5y/7uMcdh/nsHs4f93HOfw6M9V7/vl0H+ewezh/3cc57B7OX/f15DkM8vnM+/6Y559/XqtXr5bH49HYsWO1fv16JSUlBTotAADQg6j3AAB8nambdQAAAAAArkemfGYdAAAAAIDrGc06AAAAAAAmQ7MOAAAAAIDJ0KwDAAAAAGAyNOvfQkFBgf7pn/5JISEhSkpK0pEjRwKdUq+Rl5en2267TQMHDlRERISmT5+u2traQKfVaz3zzDMKCgpSTk5OoFPpVf7nf/5HDzzwgAYNGqTQ0FCNGjVK7777bqDT6jXa29v1+OOPKzY2VqGhofrOd76jVatWid8nvbDy8nJNmzZNUVFRCgoK0uuvv+437/P5tHz5ckVGRio0NFQpKSn68MMPA5Ms/FDvLw+1vudR77uOWt891Pquuxr1nmb9G2zbtk25ubl64okn9Pvf/15jxoxRWlqaGhsbA51ar1BWVia3263KykqVlJSora1Nqampam5uDnRqvc7Ro0f1n//5nxo9enSgU+lVPv/8c02cOFH9+vXT7373O504cUJr1qzRjTfeGOjUeo2f//zn2rhxo55//nl98MEH+vnPf678/Hxt2LAh0KmZUnNzs8aMGaOCgoILzufn52v9+vXatGmTDh8+rBtuuEFpaWk6d+7cVc4UX0W9v3zU+p5Fve86an33Ueu77qrUex8u6fbbb/e53W5ju7293RcVFeXLy8sLYFa9V2Njo0+Sr6ysLNCp9CpffPGF77vf/a6vpKTE9//+3//z/fjHPw50Sr3GkiVLfJMmTQp0Gr1aRkaGb968eX77ZsyY4Zs1a1aAMuo9JPl27NhhbHd0dPicTqdv9erVxr4zZ874rFar79e//nUAMkQn6n3PodZfPur95aHWdx+1vnuuVL3nyvoltLa2qqqqSikpKca+Pn36KCUlRRUVFQHMrPdqamqSJIWHhwc4k97F7XYrIyPD73+L+HbeeOMNjR8/Xv/6r/+qiIgIjRs3Tv/1X/8V6LR6le9973sqLS3Vn/70J0nSH/7wBx06dEjp6ekBzqz3qaurk8fj8fv/st1uV1JSEnUlgKj3PYtaf/mo95eHWt991Pqe1VP1vu+VSO5a8de//lXt7e1yOBx++x0Oh/74xz8GKKveq6OjQzk5OZo4caJGjhwZ6HR6ja1bt+r3v/+9jh49GuhUeqU///nP2rhxo3Jzc/XTn/5UR48e1Y9+9CNZLBbNnTs30On1Co899pi8Xq/i4uIUHBys9vZ2PfXUU5o1a1agU+t1PB6PJF2wrnTO4eqj3vccav3lo95fPmp991Hre1ZP1XuadVw1brdb77//vg4dOhToVHqNkydP6sc//rFKSkoUEhIS6HR6pY6ODo0fP15PP/20JGncuHF6//33tWnTJgr4t7R9+3Zt2bJFRUVFGjFihKqrq5WTk6OoqCjOIQA/1PrLQ73vHmp991HrzYnb4C9h8ODBCg4OVkNDg9/+hoYGOZ3OAGXVO2VnZ6u4uFhvvvmmhgwZEuh0eo2qqio1Njbq1ltvVd++fdW3b1+VlZVp/fr16tu3r9rb2wOdoulFRkYqISHBb198fLzq6+sDlFHvs2jRIj322GOaOXOmRo0apdmzZ2vhwoXKy8sLdGq9TmftoK6YC/W+Z1DrLx/1vnuo9d1Hre9ZPVXvadYvwWKxKDExUaWlpca+jo4OlZaWyuVyBTCz3sPn8yk7O1s7duzQgQMHFBsbG+iUepUpU6bo+PHjqq6uNsb48eM1a9YsVVdXKzg4ONApmt7EiRO/9gqhP/3pT4qJiQlQRr3P3/72N/Xp418ugoOD1dHREaCMeq/Y2Fg5nU6/uuL1enX48GHqSgBR77uHWt991PvuodZ3H7W+Z/VUvec2+G+Qm5uruXPnavz48br99tv13HPPqbm5WT/84Q8DnVqv4Ha7VVRUpN/+9rcaOHCg8YyG3W5XaGhogLMzv4EDB37tmb8bbrhBgwYN4lnAb2nhwoX63ve+p6efflr/9m//piNHjujFF1/Uiy++GOjUeo1p06bpqaee0tChQzVixAi99957evbZZzVv3rxAp2ZKZ8+e1UcffWRs19XVqbq6WuHh4Ro6dKhycnL05JNP6rvf/a5iY2P1+OOPKyoqStOnTw9c0qDedwO1vvuo991Dre8+an3XXZV633M/WH/t2rBhg2/o0KE+i8Xiu/32232VlZWBTqnXkHTB8corrwQ6tV6LV7l03c6dO30jR470Wa1WX1xcnO/FF18MdEq9itfr9f34xz/2DR061BcSEuK7+eabff/xH//ha2lpCXRqpvTmm29e8N97c+fO9fl8f3+dy+OPP+5zOBw+q9XqmzJliq+2tjawScPn81HvLxe1/sqg3ncNtb57qPVddzXqfZDP5/N1528UAAAAAABAz+KZdQAAAAAATIZmHQAAAAAAk6FZBwAAAADAZGjWAQAAAAAwGZp1AAAAAABMhmYdAAAAAACToVkHAAAAAMBkaNYBAAAAADAZmnUAAAAAAEyGZh0AAAAAAJOhWQcAAAAAwGT+P7Q+kymZlTb7AAAAAElFTkSuQmCC"/>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [120]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>

<span class="n">fig</span><span class="p">,</span> <span class="n">axes</span> <span class="o">=</span> <span class="n">plt</span><span class="o">.</span><span class="n">subplots</span><span class="p">(</span><span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span>
<span class="n">axes</span> <span class="o">=</span> <span class="n">axes</span><span class="o">.</span><span class="n">flatten</span><span class="p">()</span>

<span class="k">for</span> <span class="n">i</span><span class="p">,</span> <span class="n">color</span> <span class="ow">in</span> <span class="nb">enumerate</span><span class="p">([</span><span class="s2">"YELLOW"</span><span class="p">,</span> <span class="s2">"BLUE"</span><span class="p">,</span> <span class="s2">"GREEN"</span><span class="p">,</span> <span class="s2">"RED"</span><span class="p">]):</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">df_by_color</span><span class="p">[</span><span class="n">color</span><span class="p">],</span> <span class="n">bins</span><span class="o">=</span><span class="nb">range</span><span class="p">(</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">+</span> <span class="mi">1</span><span class="p">),</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="n">color</span><span class="p">])</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="sa">f</span><span class="s2">"Distribution of </span><span class="si">{</span><span class="n">color</span><span class="si">}</span><span class="s2"> dice"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">.</span><span class="n">set_xlim</span><span class="p">(</span><span class="n">right</span><span class="o">=</span><span class="n">df_random_choices</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span> <span class="c1"># Set max value on x-axis</span>

<span class="n">plt</span><span class="o">.</span><span class="n">suptitle</span><span class="p">(</span><span class="s2">"After adding black and white dice"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>&lt;Figure size 640x480 with 0 Axes&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA+sAAALjCAYAAABqJJSQAAAAOXRFWHRTb2Z0d2FyZQBNYXRwbG90bGliIHZlcnNpb24zLjguMiwgaHR0cHM6Ly9tYXRwbG90bGliLm9yZy8g+/7EAAAACXBIWXMAAA9hAAAPYQGoP6dpAACj7klEQVR4nOzdeVwW9fr/8TcgmwooKZsikpr7lpriikqiombqaTO3XLKD5dIptcy1oiy3yjSzxExPmmmLO4p7akZSqelRw6UUcElwBYX5/dGP+XrLIgjKYK/n4zGPnJlrZq6Z+6bPXPcsHzvDMAwBAAAAAADLsC/sBAAAAAAAgC2KdQAAAAAALIZiHQAAAAAAi6FYBwAAAADAYijWAQAAAACwGIp1AAAAAAAshmIdAAAAAACLoVgHAAAAAMBiKNYBAAAAALAYinUA+AdYsGCBqlWrJkdHR5UqVaqw07ktR48elZ2dnSIjI28Z27dvX1WsWNFmmp2dncaPH39HcsvJpk2bZGdnp6VLl94yNqu8C1LFihXVqVOnO7b+gpBxvDZt2nRH1p/bY3Cn88iN4OBgBQcHm+N5+RsAABR9FOsAUMR9+OGHsrOzU+PGjbOcf+DAAfXt21eVKlXSxx9/rDlz5ujy5csaP358oRYiQFGzaNEiTZ8+vbDTAAD8QxQr7AQAAPmzcOFCVaxYUT/88IMOHz6sypUr28zftGmT0tPTNWPGDHPemTNnNGHCBEmyuXJ3L7ty5YqKFaPZQ+60bNlSV65ckZOTkzlt0aJF2rt3r4YNG1YoOQUEBOjKlStydHQslO0DAO4urqwDQBEWFxen77//XlOnTlXZsmW1cOHCTDGJiYmSdFduf7906dId38btcnFxoVhHrtnb28vFxUX29tY5VbKzs5OLi4scHBwKOxUAwF1gnRYIAJBnCxcuVOnSpRUWFqYePXpkKtYrVqyocePGSZLKli0rOzs79e3bV2XLlpUkTZgwQXZ2dpme5z5w4IB69OghT09Pubi4qGHDhvr2229t1h0ZGSk7Oztt3rxZ//73v+Xl5aXy5ctnm2tqaqrGjh2rBg0ayMPDQyVKlFCLFi20cePGTLHnz59X37595eHhoVKlSqlPnz46f/58luv9+uuvVatWLbm4uKhWrVpavnx5lnE37+P48eNlZ2enw4cPq2/fvipVqpQ8PDzUr18/Xb582WbZK1eu6IUXXlCZMmXk5uamLl266M8//8zTc/BpaWl65ZVX5OPjoxIlSqhLly46ceLELZd799131bRpU913331ydXVVgwYNsn3+/fPPP9dDDz2k4sWLq3Tp0mrZsqXWrVuX4/rnz5+vYsWK6aWXXsox7ptvvlFYWJj8/Pzk7OysSpUqadKkSUpLS7OJCw4OVq1atbR//361bt1axYsXV7ly5TR58uRM6/zjjz/UtWtXlShRQl5eXho+fLhSUlJucUSkX375RXZ2djbfyZiYGNnZ2enBBx+0ie3QoUOWj4hs27ZNDz30kFxcXHT//ffrs88+s5l/8zPrwcHBWrlypY4dO2b+zdz4foGUlBSNGzdOlStXlrOzs/z9/fXyyy/nan8kac6cOapUqZJcXV310EMPaevWrZlisntm/cCBA3rsscdUtmxZubq6qmrVqnr11VdtYv78808988wz8vb2lrOzs2rWrKlPP/00V7kBAAoHlxgAoAhbuHChunXrJicnJz355JOaNWuWdu/erUaNGkmSpk+frs8++0zLly/XrFmzVLJkSdWuXVtNmjTRc889p0cffVTdunWTJNWpU0eStG/fPjVr1kzlypXTqFGjVKJECS1ZskRdu3bVV199pUcffdQmh3//+98qW7asxo4dm+OV9eTkZM2dO1dPPvmkBg4cqAsXLuiTTz5RaGiofvjhB9WrV0+SZBiGHnnkEW3btk2DBw9W9erVtXz5cvXp0yfTOtetW6fu3burRo0aioiI0NmzZ9WvX78cfzS42WOPPabAwEBFRETop59+0ty5c+Xl5aW3337bjOnbt6+WLFmiXr16qUmTJtq8ebPCwsJyvQ1JeuONN2RnZ6eRI0cqMTFR06dPV0hIiGJjY+Xq6prtcjNmzFCXLl3Us2dPpaam6osvvtC//vUvrVixwiaHCRMmaPz48WratKkmTpwoJycn7dq1S9HR0WrXrl2W654zZ44GDx6sV155Ra+//nqO+UdGRqpkyZIaMWKESpYsqejoaI0dO1bJycl65513bGL/+usvtW/fXt26ddNjjz2mpUuXauTIkapdu7Y6dOgg6e8fQNq2bavjx4/rhRdekJ+fnxYsWKDo6OhbHstatWqpVKlS2rJli7p06SJJ2rp1q+zt7fXzzz8rOTlZ7u7uSk9P1/fff69BgwbZLH/48GH16NFD/fv3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Po97Dtw9xQo7AfwzTJw4UYGBgbp27Zri4+O1adMmDRs2TFOnTtW3336rOnXqmLFjxozRqFGj8rT+kydPasKECapYsaLq1auX6+XWrVuXp+3cjpxy+/jjj5Wenn7Hc8iP6OhoNWnSROPGjcs2JigoSM8++6ymTJmip59+WjVr1jTnHTt2TBMnTtS//vUvhYWFmdPLly+viIiITOvy8PAo2B34/95//30NHTpU999/v55//nn5+vrqt99+09y5c7V48WKtWrVKTZs2lSQ1b95ckrRt2zbVr1/fXMe+fft0/vx5FStWTNu3b1dgYKA5b/fu3UpNTTWXza+WLVvqypUrcnJyKpD1AYAVcX5wb58f3KhevXp68cUXJf39A3dMTIymT5+uzZs364cffriTqWba/o38/PwKbBt343uDfxaKddwVHTp0UMOGDc3x0aNHKzo6Wp06dVKXLl3022+/ydXVVZJUrFgxFSt2Z7+aly9fVvHixQu9EHJ0dCzU7edGYmKiatSoccu4t956S998842effZZbd261fxV+/nnn5ejo6NmzJhhE+/h4aGnn376juR8s+3bt2vYsGFq3ry51qxZo+LFi5vznnvuOTVr1kw9evTQvn37VLp0aTVs2FAuLi7atm2bnn/+eZv13HfffWrYsKG2bdtmk/+2bdskqcCKdXt7e7m4uBTIugDAqjg/yNq9dH6QoVy5cjbt5oABA1SyZEm9++67OnTokKpUqXIn0sx2+3dCYX9vcO/hNngUmjZt2ui1117TsWPH9Pnnn5vTs3omLSoqSs2bN1epUqVUsmRJVa1aVa+88oqkv2+HatSokSSpX79+5m1NkZGRkv6+5bpWrVqKiYlRy5YtVbx4cXPZ7J4tSktL0yuvvCIfHx+VKFFCXbp00YkTJ2xibn7GOMON67xVblk9k3bp0iW9+OKL8vf3l7Ozs6pWrap3331XhmHYxNnZ2WnIkCH6+uuvVatWLTk7O6tmzZpas2ZN1gf8JomJierfv7+8vb3l4uKiunXrav78+eb8jNvM4uLitHLlSjP3G5/NupGHh4dmzJih7du3a+7cuZKk5cuX67vvvtNbb70lX1/fXOV1J0yaNEl2dnaaP3++TaEuSZUqVdLkyZN16tQpffTRR5L+bmwbNWqk7du328Ru375dQUFBatasWZbzSpUqpVq1auWYi2EYev31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Dz6owMBATZ8+PdN3KWNdXl5eCg4O1kcffaRTp05lWsfp06dvuR0AKGycH2R2r54ffPfdd5KUp4LU19dX9erV0+eff57p2MXExGjnzp0Fdjykv4/Jzp079cMPP5jTTp8+ne2V8Bt1795dZ86cyfS5Sf/Xdj/22GNKS0vTpEmTMsVcv369wL67KJq4DR53xerVq3XgwAFdv35dCQkJio6OVlRUlAICAvTtt9/meLvSxIkTtWXLFoWFhSkgIECJiYn68MMPVb58ebNAqlSpkkqVKqXZs2fLzc1NJUqUUOPGjW+7KxBPT081b95c/fr1U0JCgqZPn67KlSvbdB8zYMAALV26VO3bt9djjz2mI0eO6PPPP7d5oUtec+vcubNat26tV199VUePHlXdunW1bt06ffPNNxo2bFimdd+uQYMG6aOPPlLfvn0VExOjihUraunSpdq+fbumT59+V66+JiUl2fSfe6Onn37aZvzTTz/Nsn/YjO7KJGnDhg26evVqppiuXbuqZcuWevfddzVixAjVqVNHffv2la+vrw4cOKCPP/5Y6enpWrVqVabnxitUqCB/f3/t2LFDFStWlJ+fn838pk2b6quvvpKdnZ3NVffslC1bVv/5z38UERGhTp06qWPHjtqzZ49Wr16tMmXK5Lisvb29Zs2apc6dO6tevXrq16+fuQ/79u3T2rVrJUkzZ85U8+bNVbt2bQ0cOFD333+/EhIStGPHDv3xxx/6+eefb5knANwtnB/8c84P/vzzT7PdT01N1c8//6yPPvoo2xewTZ06VcWLF7eZZm9vr1deeUVTp05VaGio6tWrp759+8rPz0+//fab5syZI19fX40ePTrH7d+oZMmS6tq1a7Z5v/zyy1qwYIHat2+voUOHml23BQQE5PiInfT3Cwk/++wzjRgxQj/88INatGihS5cuaf369fr3v/+tRx55RK1atdKzzz6riIgIxcbGql27dnJ0dNShQ4f05ZdfasaMGerRo0eO28E9rHBeQo9/ioyuWTIGJycnw8fHx3j44YeNGTNm2HQBkuHmrlk2bNhgPPLII4afn5/h5ORk+Pn5GU8++aTxv//9z2a5b775xqhRo4ZRrFgxm65QWrVqZdSsWTPL/LLrmuW///2vMXr0aMPLy8twdXU1wsLCjGPHjmVafsqUKUa5cuUMZ2dno1mzZsaPP/6YaZ05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dXWVJBUrVkzFit3Zr+vly5dVvHjxQv+frqOjY6FuPzcSExNVo0aNXMUOHz5ca9eu1fTp0zV06FCbeS+++KIOHTqkqKioTMs98MADevrpp83x7t27q0aNGpoxY0aWxfrN36fs3Lze7Li6usrf318TJ05Ut27d7ujtlg4ODnJwcLhj6weAooDzgqzda+cFklSuXDmbtrhv3766//77NW3atCyL9RYtWqhHjx55Xq8kvf3223rqqac0bdo0ValSRc8991yu88yJvb29XFxcCmRdQHa4DR6W0qZNG7322ms6duyYPv/8c3N6Vs+mRUVFqXnz5ipVqpRKliypqlWr6pVXXpH0921TGb/A9uvXz7wtKjIyUtLfz5/VqlVLMTExatmypYoXL24ue/OzaRnS0tL0yiuvyMfHRyVKlFCXLl104sQJm5ibn2fKcOM6b5VbVs+mXbp0SS+++KL8/f3l7OysqlWr6t133810i3bG7dlff/21atWqJWdnZ9WsWVNr1qzJ+oDfJDExUf3795e3t7dcXFxUt25dzZ8/35yfcTtaXFycVq5caeae3bPWJ06c0Ny5c9W+fftMhXqGKlWq6N///vctc6tevbrKlCmjI0eO5Gpf8sve3l5jxozRL7/8ouXLl9/WOlJSUjR8+HCVLVtWbm5u6tKli/74449Mcdk9s7569Wq1atVKbm5ucnd3V6NGjbRo0SKbmF27dql9+/by8PBQ8eLF1apVK23fvv228gUAq+G84N46L8hO2bJlVa1atTvSxru6umrBggXy9PTUG2+8keXjbTcyDEOvv/66ypcvr+LFi6t169bat29fprjsnlnftWuXOnbsqNKlS6tEiRKqU6eOZsyYYRNz4MAB9ejRQ56ennJxcVHDhg317bff5ntfce+hWIflZDznlNNtZ/v27VOnTp2UkpKiiRMnasqUKerSpYtZpFSvXl0TJ06UJA0aNEgLFizQggUL1LJlS3MdZ8+eVYcOHVSvXj1Nnz5drVu3zjGvN954QytXrtTIkSP1wgsvKCoqSiEhIbpy5Uqe9i83ud3IMAx16dJF06ZNU/v27TV16lRVrVpVL730kkaMGJEpftu2bfr3v/+tJ554QpMnT9bVq1fVvXt3nT17Nse8rly5ouDgYC1YsEA9e/bUO++8Iw8PD/Xt29dsZKpXr64FCxaoTJkyqlevnpl72bJls1zn6tWrlZaWlqsr2beSlJSkv/76S6VLl852/pkzZ2yGrPb56tWrmeLOnDmj1NTUTLFPPfWUqlSpookTJ96ycc/KgAEDNH36dLVr105vvfWWHB0dFRYWlqtlIyMjFRYWpnPnzmn06NF66623VK9ePZsTrOjoaLVs2VLJyckaN26c3nzzTZ0/f15t2rTRDz/8kOd8AcCKOC+wVZTPC7Jz/fp1/fHHH9m28RcuXMiy7c5t21yyZEk9+uij+vPPP7V///4cY8eOHavXXntNdevW1TvvvKP7779f7dq106VLl265naioKLVs2VL79+/X0KFDNWXKFLVu3VorVqwwY/bt26cmTZrot99+06hRozRlyhSVKFFCXbt2ve2LA7iHGcBdNm/ePEOSsXv37mxjPDw8jPr165vj48aNM278uk6bNs2QZJw+fTrbdezevduQZMybNy/TvFatWhmSjNmzZ2c5r1WrVub4xo0bDUlGuXLljOTkZHP6kiVLDEnGjBkzzGkBAQFGnz59brnOnHLr06ePERAQYI5//fXXhiTj9ddft4nr0aOHYWdnZxw+fNicJslwcnKymfbzzz8bkoz3338/07ZuNH36dEOS8fnnn5vTUlNTjaCgIKNkyZI2+x4QEGCEhYXluD7DMIzhw4cbkozY2Fib6SkpKcbp06fN4cyZMzbzJRn9+/c3Tp8+bSQmJho//vij0b59e0OS8c4779jEZnyfshqcnZ0zrTe74b///a8Z16dPH6NEiRKGYRjG/PnzDUnGsmXLbNYTHh6e477HxsYakox///vfNtOfeuopQ5Ixbty4TPsQFxdnGIZhnD9/3nBzczMaN25sXLlyxWb59PR0879VqlQxQkNDzWmGYRiXL182AgMDjYcffjjH/ADAKjgv+OecF2TEtmvXzjwH+PXXX41evXpl2bZmHOvshlOnTuU6h4zvyDfffJNtTGJiouHk5GSEhYXZtK2vvPKKIcnms8zIbePGjYZhGMb169eNwMBAIyAgwPjrr79s1nvjutq2bWvUrl3buHr1qs38pk2bGlWqVMk2N/wzcWUdllSyZMkc3/5aqlQpSdI333xz2y9dcXZ2Vr9+/XId37t3b7m5uZnjPXr0kK+vr1atWnVb28+tVatWycHBQS+88ILN9BdffFGGYWj16tU200NCQlSpUiVzvE6dOnJ3d9fvv/9+y+34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"/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="Conclusions---Wild-Results-Have-a-Decent-Impact!">Conclusions - Wild Results Have a Decent Impact!<a class="anchor-link" href="#Conclusions---Wild-Results-Have-a-Decent-Impact!">¶</a></h3><p>So it looks like adding in wild results has shifted each distribution up by a little less than two hits. This is to be expected, because both BLACK and WHITE have a 1:12 chance of being rolled, and white is slightly discounted, because it may not always be allocatable.</p>
<p>The impact is most pronounced on green and red. This is because their odds have been improved by a lot: 2X in the case of green (from 2:12 -&gt; ~4:12) and 3X in the case of red (from 1:12 -&gt; ~3:12).</p>
<p>Again, this effectively shows the maximum number of hits you <em>might</em> be able to allocate to each indvidual color. In a real game BLACK and WHITE results won't shift all of the colors up by the same amount, because you can only apply a wild to one color at a time. But presumably you would allocate the wild to the color that would benefit the most from it, so this is a reasonable upper bound on the number of hits you might expect to allocate to each color.</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="Part-2---Modeling-the-Probabilities-in-%22Pure-Math%22">Part 2 - Modeling the Probabilities in "Pure Math"<a class="anchor-link" href="#Part-2---Modeling-the-Probabilities-in-%22Pure-Math%22">¶</a></h2><p>I'm very familiar with simulation approaches at this point. Practical and imperative math like this also makes a lot of sense to me as a programmer.</p>
<p>So next, I would like to take a more mathematical appraoch to the problem, which is not as natural to me.</p>
<p>I was trying to derive the formula myself while in the shower this morning. It's clear that it's not as simple as looking at the probability of rolling a single color. We need to look at combined probabilities across any number of rolls.</p>
<p>I started by thinking about a specific case: how would you compute the probability that you could roll ten times and end up with zero yellow results? I <em>know</em> I studied this back in high school math, but twenty years later it's not exactly top of mind.</p>
<p>I realized that the probability of having no yellow results is the same as rolling non-yellow ten times in a row. That would be something like $(8/12)^{10}$. Not math I can do in my head, but definitely a small number. Using a calculator, there's about a 1.7% chance of this happening. Makes sense.</p>
<p>Then I moved on to the probability of having one out of ten results be yellow, and here I realized that I needed to somehow combine the probability of success with the probability of failure. That's where I got stuck mentally.</p>
<h3 id="Computing-the-Binomial-Distribution">Computing the Binomial Distribution<a class="anchor-link" href="#Computing-the-Binomial-Distribution">¶</a></h3><p>So I turned to Google and ChatGPT who pointed me at the Binomial Probability formula, which I can use to compute a Binomial Distribution for a given number of dice rolls and a given probability of success.</p>
<p>The formula for Binomial Probability is:</p>
<p>$$P(X = k) = \binom{n}{k} \times p^k \times (1-p)^{n-k}$$</p>
<p>where:</p>
<ul>
<li>$n$ is the number of trials (number of die rolls)</li>
<li>$k$ is the number of successful outcomes (rolling a particular color)</li>
<li>$p$ is the probability of success on a single trial</li>
<li>$\binom{n}{k}$ represents the binomial coefficient, which is the number of ways to choose $k$ successes out of $n$ trials</li>
</ul>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>My recollection of this formula from math class is very vague. Looking at it closely, I see that my intuitions were on the right track. The formula is basically using multiplication to combine the probability of getting $k$ successes with the probability of getting $n-k$ failures.</p>
<p>The big piece I was missing and failed to derive for myself was the <strong>binomial coefficient</strong>.</p>
<h3 id="The-Binomial-Coefficient">The Binomial Coefficient<a class="anchor-link" href="#The-Binomial-Coefficient">¶</a></h3><p>The binomial coefficient is the piece I was missing working through this problem in my head. This is how we can combine the probability $p^k$ of getting $k$ successes with the probability $(1-p)^{n-k}$ of getting $n-k$ failures.</p>
<p>The formula for the binomial coefficient is given by:</p>
<p>$$\binom{n}{k} = \frac{n!}{k! \cdot (n-k)!}$$</p>
<p>where:</p>
<ul>
<li>$n!$ denotes the factorial of $n$</li>
<li>$k!$ denotes the factorial of $k$</li>
<li>$(n-k)!$ denotes the factorial of $n-k$</li>
</ul>
<p>Lots of factorials. What do they mean? The question was asked and answered on the <a href="https://math.stackexchange.com/questions/3566964/what-is-the-exact-connection-between-binomial-coefficients-and-factorials#:~:text=What%20is%20the%20exact%20connection%20between%20Binomial%20coefficients%20and%20Factorials,-Ask%20Question&amp;text=The%20factorial%20n!%20is%20the,n%20exactly%20k%20of%20them.">Math Stack Exchange here</a>.</p>
<p>I think I get it, but I don't love these kinds of explanations that are very much grounded in the abstract language of math, rather than a concrete representation of what actually happens in the real world when I toss the dice. To gain a better understanding, let's look at the binomial coefficient in Python.</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h4 id="Binomial-Coefficient-in-Python">Binomial Coefficient in Python<a class="anchor-link" href="#Binomial-Coefficient-in-Python">¶</a></h4><p>In Python we could implement a function that computes the binomial coefficient exactly as represented above using <code>math.factorial</code>. Python makes it even easier by providing this function in the standard library as <code>math.comb</code>.</p>
<p>Remembering that in our case $n$ is the number of dice rolls and $k$ is the number of rolls of a particular color. We can hold $n$ steady at 10 and see how the coefficient varies with $k$. So let's use <code>NUM_DICE</code> as $n$ from our simulations above. Then we'll step through every possible value of $k$ successful roles. In math lingo, that is the set of $\{0, 1, 2 ... 10\}$.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [121]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">math</span>

<span class="n">n</span> <span class="o">=</span> <span class="n">NUM_DICE</span>
<span class="k">for</span> <span class="n">k</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">n</span> <span class="o">+</span> <span class="mi">1</span><span class="p">):</span>
<span class="nb">print</span><span class="p">(</span><span class="n">k</span><span class="p">,</span> <span class="n">math</span><span class="o">.</span><span class="n">comb</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">))</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>0 1
1 10
2 45
3 120
4 210
5 252
6 210
7 120
8 45
9 10
10 1
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>So here we can see the rise and fall of the distribution in number form. It is centered around 5, because at this point we have not introduced any probabilities. So perhaps we could say that this is the "standard" binomial distribution for 10 dice.</p>
<p>And looking back at the binomial probability formula, we see that this binomial coefficient functions as a way to increase the "weight" of the positive case against the negative case of rolling a particular color. At the center of the distribution it is a heavy weight, indeed. It multiplies the probability of the success case by up to 252 times!</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h4 id="A-Real-Understanding-of-the-Binomial-Coefficient">A Real Understanding of the Binomial Coefficient<a class="anchor-link" href="#A-Real-Understanding-of-the-Binomial-Coefficient">¶</a></h4><p>So back to how we can make sense of these numbers... Let's imagine it as cases of throwing ten real dice. For each number of successful yellow rolls $k$, how many different ways can the dice rolls be combined to results in that number?</p>
<p>In the case of zero successful dice rolls of a given color ($k=0$), the binomial coefficient says there's only one way this can happen. This is a little counterintuitive, because I can easily think of many ways that we could roll zero yellow dice: we could roll all blues or all reds or all greens or any combination of those. So this is our first revelation: for the purposes of the binomial coefficient, all those negative cases are treated as the same case, regardless of order or combination of non-yellow results.</p>
<p>Now moving up to $k=1$, there are ten different ways to roll just one yellow die in ten. This is easy to make sense of. We're still ignoring the order, but because there are ten dice, there are ten different combinations of one yellow dice and 9 others: die #1 could be yellow, or die #2, and so on.</p>
<p>At $k=2$, we find there are 45 different ways to roll two yellow dice in ten. We're still ignoring the order, but the possible combinations are quickly adding up. For instance, there are ten combinations of die #1 and the other 9 dice. And then there are nine cases of die #2 and the other 8 dice - note that we already counted the combo of die #1 and die #2. And then there are eight cases of die #3 and the remaining 7 dice, and so on.</p>
<p>Now <em>that</em> is starting to look like a factorial. So the formula is helping us compute the sum of these possible combinations for a given number of dice rolls ($n$) and a target number of successful rolls ($k$).</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="Computing-and-Graphing-the-Probability-Distributions">Computing and Graphing the Probability Distributions<a class="anchor-link" href="#Computing-and-Graphing-the-Probability-Distributions">¶</a></h3><p>Now let's put it all together in Python and make some more plots...</p>
<p>First, we'll define a function for binomial probability, based on the formula above and using <code>math.comb</code> again for the binomial coefficient.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [122]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">binomial_probability</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">,</span> <span class="n">p</span><span class="p">):</span>
    <span class="k">return</span> <span class="n">math</span><span class="o">.</span><span class="n">comb</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">)</span> <span class="o">*</span> <span class="nb">pow</span><span class="p">(</span><span class="n">p</span><span class="p">,</span> <span class="n">k</span><span class="p">)</span> <span class="o">*</span> <span class="nb">pow</span><span class="p">(</span><span class="mi">1</span> <span class="o">-</span> <span class="n">p</span><span class="p">,</span> <span class="n">n</span> <span class="o">-</span> <span class="n">k</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Now, let's set up $n$ and $p_yellow$ then compute the binomial distribution for yellow.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [123]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">n</span> <span class="o">=</span> <span class="n">NUM_DICE</span>
<span class="n">p_yellow</span> <span class="o">=</span> <span class="mi">4</span> <span class="o">/</span> <span class="mi">12</span>

<span class="n">yellow_binom_dist</span> <span class="o">=</span> <span class="nb">list</span><span class="p">((</span><span class="n">k</span><span class="p">,</span> <span class="n">binomial_probability</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">,</span> <span class="n">p_yellow</span><span class="p">))</span> <span class="k">for</span> <span class="n">k</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">n</span> <span class="o">+</span> <span class="mi">1</span><span class="p">))</span>
<span class="n">yellow_binom_dist</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[123]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>[(0, 0.017341529915832633),
 (1, 0.08670764957916315),
 (2, 0.19509221155311707),
 (3, 0.26012294873748937),
 (4, 0.22760758014530316),
 (5, 0.13656454808718185),
 (6, 0.05690189503632578),
 (7, 0.016257684296093075),
 (8, 0.0030483158055174507),
 (9, 0.0003387017561686056),
 (10, 1.693508780843028e-05)]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Again, we see the rise and fall of the distribution in number form and that the peak is slightly shifted towards zero and centered on 3-4 successes, as we saw in the earlier simulation and would expect from the underlying probabilities.</p>
<p>We also see that the probabilities sum to 1.0 (allowing for some floating point error):</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [124]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">sum</span><span class="p">(</span><span class="n">prob</span> <span class="k">for</span> <span class="n">k</span><span class="p">,</span> <span class="n">prob</span> <span class="ow">in</span> <span class="n">yellow_binom_dist</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[124]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>1.0000000000000007</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Now let's plot this distribution side-by-side with the simulation results from earlier:</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [125]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>

<span class="n">fig</span><span class="p">,</span> <span class="n">axes</span> <span class="o">=</span> <span class="n">plt</span><span class="o">.</span><span class="n">subplots</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">axes</span> <span class="o">=</span> <span class="n">axes</span><span class="o">.</span><span class="n">flatten</span><span class="p">()</span>

<span class="n">x_values</span><span class="p">,</span> <span class="n">y_values</span> <span class="o">=</span> <span class="nb">zip</span><span class="p">(</span><span class="o">\*</span><span class="n">yellow_binom_dist</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="s2">"Probability Distribution of YELLOW results"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">bar</span><span class="p">(</span><span class="n">x_values</span><span class="p">,</span> <span class="n">y_values</span><span class="p">,</span> <span class="n">align</span><span class="o">=</span><span class="s1">'center'</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"YELLOW"</span><span class="p">],</span> <span class="n">width</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>

<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="sa">f</span><span class="s2">"Sim Distribution of YELLOW dice"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">yellow_distribution</span><span class="p">,</span> <span class="n">bins</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"YELLOW"</span><span class="p">])</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">set_xlim</span><span class="p">(</span><span class="n">right</span><span class="o">=</span><span class="mi">10</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">suptitle</span><span class="p">(</span><span class="s2">"Side-by-side comparison of binomial and simulated distributions"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>&lt;Figure size 640x480 with 0 Axes&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,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H31U8+fP1/jx4+Xm5mZ/76effipjjDp27Jhh/cnJyYqJidGVK1fUp08fBQcH688//9TixYuVmJgof39/S5fD+fPn1aBBA/3888965plndO+99+rUqVP6+uuv9ccffyggIECXLl1S48aNtX//fvXu3VsRERH6/PPP1blzZyUmJqbbcTFnzhwlJyerT58+OnPmjMaOHavHH39c999/v1avXq3//ve/2r9/v95991298MIL6Tawf/vtNz3xxBN67rnnFBsbq+nTp6tdu3aKi4vTAw88IOnaRunChQvVrl07RURE6Pjx43r//ffVqFEj7d27VyEhIQ51jho1Su7u7nrhhRd05coVp0dcs/tddevWTTNnzlTbtm01cOBAbdq0SWPGjNHPP/+cLmTt379fbdu2VdeuXRUbG6uPP/5YnTt3VmRkpCpXrpzh92KM0cMPP6xVq1apa9euqlGjhpYuXaoXX3xRf/75pyZMmKDAwEDNmjVLo0eP1vnz5+07ie6+++4M683u8s3I33//rebNm+uxxx7T448/ri+++EL//e9/VbVqVbVo0UKSbvv6cr2kpCR9+OGH6tChg7p3765z587po48+UkxMjDZv3qwaNWpkOn+5rW/u3Lk6d+6cnn32Wbm4uGjs2LF67LHH9Pvvv9tPS162bJnatGmjSpUqacyYMTp9+rS6dOmiUqVKZdmeEydOqFmzZgoMDNTgwYNVuHBhHTp0KN3OlYw88cQTuvvuu/X666/r22+/1auvvqqiRYvq/fff1/3336833nhDc+bM0QsvvKBatWqpYcOGOVpeGXn77bf18MMPq2PHjkpOTta8efPUrl07LV68WK1atZJ07XesW7duql27tnr06CFJKlu2rCTp+PHjqlOnjlxcXNS7d28FBgbqu+++U9euXZWUlKR+/fpJurbuNW3aVEeOHFHfvn0VEhKiWbNmaeXKldlq565du+zLd/jw4UpJSdGwYcMUFBSU5XuHDx+uMWPG2OchKSlJW7du1fbt2/XAAw/o2Wef1bFjxxQfH69Zs2Y5rWP69Om6fPmyevToIQ8PDxUtWjTDHbKpqalq3ry56tSpo7FjxyouLk7Dhg1TSkqKRo4cma35tclO2663Z88eNWjQQH5+fho0aJAKFiyo999/X40bN9aaNWsUFRXlUL5Pnz4qUqSIhg0bpkOHDmnixInq3bu35s+fLyn36zUACxkA+d6yZcuMm5ubcXNzM3Xr1jWDBg0yS5cuNcnJyenKhoWFmdjYWPvrfv36GUlm06ZN9nEnTpww/v7+RpI5ePCgMcaYc+fOmcKFC5vu3bs71JeQkGD8/f3TjXemUaNGRpJ566237OOuXLliatSoYYoXL25v79KlS40k89133zm8v1q1aqZRo0aZfsaPP/5oJJnPP/8803JWLYehQ4caSearr75KNy0tLc0YY8zEiRONJDN79mz7tOTkZFO3bl3j6+trkpKSjDHGHDx40EgygYGBJjEx0V52yJAhRpKpXr26uXr1qn18hw4djLu7u7l8+bLDcpBkvvzyS/u4s2fPmhIlSph77rnHPu7y5csmNTXVob0HDx40Hh4eZuTIkfZxq1atMpJMmTJlzMWLFx3K26atWrXKGJO972rHjh1GkunWrZvD+BdeeMFIMitXrkw3L99//7193IkTJ4yHh4cZOHBghp9hjDELFy40ksyrr77qML5t27bGxcXF7N+/3z6uUaNGpnLlypnWd2Obslq+Ny4b2+dIMp988ol93JUrV0xwcLBp06aNfdztXF8aNWrk8DeYkpJirly54jDPf//9twkKCjLPPPOMw3hJZtiwYZkur+zWZ5uXYsWKmTNnztjHL1q0yEgy33zzjX1cjRo1TIkSJRzmedmyZUaSCQsLy7Q9CxYsMJLMli1bMi1347wNGzbMSDI9evRwmLdSpUoZFxcX8/rrrzvMn5eXl8Pv0fTp0x1+d2ycrSexsbHp5uPGv73k5GRTpUoVc//99zuM9/Hxcfhcm65du5oSJUqYU6dOOYxv37698ff3t9dvW/c+++wze5kLFy6YcuXKpWunM61btzaenp7m8OHD9nF79+41bm5u5sZN0Bt/s6tXr25atWqVaf29evVKV48x/1t//Pz8zIkTJ5xOmz59un1cbGyskWT69OljH5eWlmZatWpl3N3dzcmTJ40xzr+fjOrMqG3GpF+fWrdubdzd3c2BAwfs444dO2YKFSpkGjZsaB9nW2+io6Pt/YkxxvTv39+4ubnZ/wayu14DyH84rR24AzzwwAPasGGDHn74Yf30008aO3asYmJiVLJkSX399deZvnfJkiWqU6eOateubR8XGBiY7uh0fHy8EhMT1aFDB506dco+uLm5KSoqKtunsRYoUEDPPvus/bW7u7ueffZZnThxQtu2bZMkRUdHKyQkRHPmzLGX2717t3bu3Kmnnnoq0/ptR1uXLl2qixcvZqtN0u1bDl9++aWqV6+uRx99NN0022mNS5YsUXBwsDp06GCfVrBgQfXt21fnz5/XmjVrHN7Xrl07hzMCbEdRnnrqKYebCkVFRSk5OVl//vmnw/tDQkIc2uPn56dOnTrpxx9/VEJCgqRr13vabsaUmpqq06dPy9fXVxUqVND27dvTzUtsbKzTsw6ul53vasmSJZKkAQMGOIwfOHCgJOnbb791GF+pUiU1aNDA/jowMFAVKlTQ77//nmlblixZIjc3N/Xt2zfd5xhj9N1332X6/sxkZ/lmxNfX12Gdd3d3V+3atR3m53avL9dzc3OznxWRlpamM2fOKCUlRTVr1nS6XmQlp/U98cQTKlKkiP217bu3LZ+//vpLO3bsUGxsrMM8P/DAA6pUqVKW7bFdKrR48WJdvXo1x/PTrVs3h3mrWbOmjDHq2rWrw2dkZx3Niev/9v7++2+dPXtWDRo0yNZ3YozRl19+qYceekjGGIffuZiYGJ09e9Zez5IlS1SiRAm1bdvW/n5vb2/7kfjMpKamaunSpWrdurVKly5tH3/33XcrJiYmy/cXLlxYe/bs0W+//ZZl2Yy0adNGgYGB2S7fu3dv+/9tZxUkJydr+fLlN92GrKSmpmrZsmVq3bq1ypQpYx9fokQJPfnkk1q7dq2SkpIc3tOjRw+H0+QbNGig1NRUHT58WFLu12sA1iGcA3eIWrVq6auvvtLff/+tzZs3a8iQITp37pzatm2rvXv3Zvi+w4cPq3z58unGV6hQweG1bQPo/vvvV2BgoMOwbNky+43nLl26pISEBIfheiEhIfLx8XEYd9ddd0mS/fpKV1dXdezYUQsXLrSHtjlz5sjT01Pt2rXL9HMiIiI0YMAAffjhhwoICFBMTIwmTZrkcA3z7VgOGTlw4ECWlx7Y2nLjnYltp0/bNrBsrt+wlf4XekNDQ52O//vvvx3GlytXLt0zhW/8TtLS0jRhwgSVL19eHh4eCggIUGBgoHbu3Ol02UZERGQ6j7YyWX1Xhw8flqurq8qVK+fw3uDgYBUuXDjLZSFJRYoUSTfPNzp8+LBCQkJUqFAhh/EZLfOcyM7yzUipUqXSvffG+bnd68uNZs6cqWrVqtmv+w0MDNS3336b5d9cXtR347zYgrqtzbZ5z87ftjONGjVSmzZtNGLECAUEBOiRRx7R9OnTs31NtbNl7enpqYCAgHTjs1rOObF48WLVqVNHnp6eKlq0qAIDAzVlypRsfScnT55UYmKipk2blu43rkuXLpL+d6PRw4cPO12/s7NsT548qUuXLt30dzNy5EglJibqrrvuUtWqVfXiiy9q586dWb7vetn5nbJxdXV1CMdS9v+Oc+PkyZO6ePGi02Vy9913Ky0tTUePHnUYn9XfRW7XawDWIZwDdxh3d3fVqlVLr732mqZMmaKrV6/q888/z3W9tuvwZs2apfj4+HTDokWLJEnz589XiRIlHIab0alTJ50/f14LFy6UMUZz587Vgw8+aA8MmX3OW2+9pZ07d+qll17SpUuX1LdvX1WuXFl//PFHLpdC9pfD7XT9dfnZGW+uu4FRdr322msaMGCAGjZsqNmzZ2vp0qWKj49X5cqVnV6jmdVRc5vsflc3bvxnJC/nOT+4FfOTl+vL7Nmz1blzZ5UtW1YfffSR4uLiFB8fr/vvvz/Da3czk9P6bvX37eLioi+++EIbNmxQ79697TdJi4yM1Pnz57N8v7P2ZafNGa3vqampWX7mDz/8oIcfflienp6aPHmylixZovj4eD355JPZWi625fzUU085/Y2Lj49XvXr1sqznVmvYsKEOHDigjz/+WFWqVNGHH36oe++9Vx9++GG268ju71R25eZ7y0tZrWO5Xa8BWIcbwgF3sJo1a0q6dmpnRsLCwpyeFrhv3z6H17YbBRUvXlzR0dEZ1hcTE2O/W64zx44d04ULFxyOnv/666+S5HAjtSpVquiee+7RnDlzVKpUKR05ckTvvvtutj+natWqqlq1ql5++WWtX79e9erV09SpU/Xqq686LZ/XyyEjZcuW1e7duzMtExYWpp07dyotLc3haOgvv/xin56X9u/fL2OMw4bljd/JF198oSZNmuijjz5yeG9iYmK6o4A5ldl3FRYWprS0NP32228ON147fvy4EhMT82xZhIWFafny5Tp37pzD0fO8WObZWb65cbvXl+t98cUXKlOmjL766iuH+Rs2bFi+qM8279n5285MnTp1VKdOHY0ePVpz585Vx44dNW/ePIfT1vOS7UhnYmKiw/jsnMHx5ZdfytPTU0uXLnV4/Nj06dPTlXUWJgMDA1WoUCGlpqZm+RsXFham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rTBu3DhdvHhR06ZNcwjmkhQQEKD3339fFy5c0NixY+3j69evrx9//FGXLl2yj1u3bp0qV66sFi1aaOPGjQ57zNetWycXFxfVq1cv07bYTgHctm2bGjZsKG9vb7300kuSpCtXrmjYsGEqV66cPDw8FBoaqkGDBqX77uPj41W/fn0VLlxYvr6+qlChgr0OKeP7Nji7Zu56Wa2vCQkJ6tKli0qVKiUPDw+VKFFCjzzyyG25PwTwT3DgwAFVrlzZaZAqXry4w+sbr+u2/V2vXbtWffv2VWBgoAoXLqxnn31WycnJSkxMVKdOnVSkSBEVKVJEgwYNynDbJDvc3Nz0zjvvqFKlSnrvvfd09uzZDNt29epVjRgxQuXLl5enp6eKFSum+vXr20+L79y5s/2yputPj5Yc7/UyceJEe9+3d+9ep9ec2/z++++KiYmRj4+PQkJCNHLkSIf5zej37sY6M2ubbdyNR9R//PFHtWjRQn5+fvL19VXTpk21ceNGhzK272vdunUaMGCAAgMD5ePjo0cffTTbl/StXLlSDRo0kI+PjwoXLqxHHnlEP//8s316586d7advt2vXTi4uLplu/9kC+ODBg+2hvk+fPipYsKDefvvtbLXpVvjjjz/00Ucf6f7773d6iVqvXr3UpEkTffjhh/rjjz8k/W9H+Lp16+zlLl++rO3bt+uxxx5TmTJlHKadPHlSv/76a7Z2oP/xxx9q3bq1fHx8VLx4cfXv3z9dPyw534ZMS0vT22+/rapVq8rT01OBgYFq3rx5untGzZ49W5GRkfLy8lLRokXVvn17HT16NMu24fbI34fN/gUOHDggSSpWrJh9XEpKimJiYlS/fn29+eab8vb2ljFGDz/8sFatWqWuXbuqRo0aWrp0qV588UX9+eef6U77XbNmjebPn6++ffvKw8NDkydPVvPmzbV582b79TlbtmzR+vXr1b59e5UqVUqHDh3SlClT1LhxY+3duzfd0bTevXurcOHCGj58uPbt26cpU6bo8OHD9k7oZs2aNUvdunVT7dq17XtTy5Ytqzp16ig0NFRz5sxxOL1XurbjoWzZsrk6Paht27bq2rWrli1bptGjRzstc+LECTVr1kyBgYEaPHiwChcurEOHDumrr76SJAUGBmrKlCnq2bOnHn30UT322GOS5BAGnX2fmfnkk0907tw59erVS5cvX9bb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61S8eHH7d3N9OLf9m91wXrJkyXQ3bvztt9+0Z88eBQYGOgx33XWXpP/d9OeJJ55QvXr11K1bNwUFBal9+/b67LPPbnlQ9/Dw0BtvvKHvvvtOQUFBatiwocaOHauEhIRb+rnAP02tWrX01Vdf6e+//9bmzZs1ZMgQnTt3Tm3bttXevXuzfP+Nv/u2O1WHhoamG58XO9LOnz8vKfPgNHLkSCUmJuquu+5S1apV9eKLL2rnzp05+pyIiIhsl3V1dXUIx5Lsv5W3sp8+efKkLl68qAoVKqSbdvfddystLS3ddcM3fl9FihSRpEy/G1sfnNHnnDp1ShcuXMhx+23c3Nx0zz33yMvLK9NL4MqXL++0n87rS8+y0087C/DXX3dujNH69evt932pUqWK/Pz8tG7dOl2+fFnbtm3LVh99+PBhlStXLt0OC2ffxY0OHDigkJAQhx0qN/rtt99kjFH58uXT9fc///xzuhtDwhpcc36b1a5dO9PQIF3bEL0djzDp06ePpk+frn79+qlu3bry9/eXi4uL2rdvn68ez9CpUyc9//zz+uOPP3TlyhVt3LjR4SZuN+vq1av69ddfM732zvac640bN+qbb77R0qVL9cwzz+itt97Sxo0b7Xv1M3Mrvk8XFxenN9uxnRWR27qzI6O72jtr17+Vv7+/SpQokeWG4s6dO1WyZEmHjY769evrm2++0a5duxz2yEvXwrntGv21a9cqJCQk3cZiRq4/Y8YmLS1NVatW1fjx452+x7bh7eXlpe+//16rVq3St99+q7i4OM2fP1/333+/li1bJjc3twzXn9yum/369dNDDz2khQsXaunSpXrllVc0ZswYrVy58pY8Wgf4J3N3d1etWrVUq1Yt3XXXXerSpYs+//zzDO/RYZPR776z8XnRF9huhprZzviGDRvqwIEDWrRokZYtW6YPP/xQEyZM0NSpUzN9vNf1nP0u5sat+h3MKfrprNkODOzcuTPDHfS2Pvz6o/bVq1dXoUKFtHbtWrVs2VJnzpyx99Ourq6KiorS2rVrVbZsWSUnJ9/U01TyWlpamlxcXPTdd985XTeys02LW48j53eIsLAwHTt2LN2evV9++cU+/XrOTu/69ddf5e3tbT9164svvlBsbKzeeusttW3bVg888IDq16+vxMREp224sc7z58/rr7/+ypObMWUWCNu3by83Nzd9+umnmjNnjgoWLKgnnngi15/5xRdf6NKlSxme+ny9OnXqaPTo0dq6davmzJmjPXv2aN68eVm2/WZk9N1dv5yLFCni9Hu68ahzTtoWFhamtLS0dJ9//PhxJSYmplvHblZO1+U73YMPPqiDBw+me/yZzQ8//KBDhw7pwQcfdBh//fPO161b53An9sjISHl4eGj16tXatGlTlndpz0rZsmV15swZNW3a1OmRiuv32ru6uqpp06YaP3689u7dq9GjR2vlypX20+FsR2ZuXD+zc0ZEVutr2bJlNXDgQC1btky7d+9WcnKy3nrrrRzOLYDr2Q4Y/PXXXxa3xFFqaqrmzp0rb2/vLINN0aJF1aVLF3366ac6evSoqlWr5nCX87zsp9PS0tKdsv/rr79Kkr2fzsnvYHbbFhgYKG9vb+3bty/dtF9++UWurq7pzmC4GbY+OKPPCQgIuGMe75sdLVq0kJubW6Y35Pvkk09UoEABNW/e3D7Ozc1NderU0bp167R27Vr5+fmpatWq9um2M9xycnZbWFiYDhw4kG7nibPv4kZly5bVsWPHdObMmUzLGGMUERHhtK+//tFvsA7h/A7RsmVLpaampjtiPGHCBLm4uDg8Z1G6dh3q9deNHz16VIsWLVKzZs3se8vc3NzS/QC8++67Ge7ZnTZtmsN111OmTFFKSkq6z74ZPj4+Ge4UCAgIUIsWLTR79mzNmTNHzZs3V0BAQK4+76efflK/fv1UpEgR9erVK8Nyf//9d7plZNuzaju13Xb39Yzan1MLFy7Un3/+aX+9efNmbdq0yWE5ly1bVr/88ovDI1F++umndHfNzknbbM8YnThxosN429HUjO6Um1M5XZfvdC+++KK8vLz07LPP6vTp0w7Tzpw5o+eee07e3t568cUXHabVrFlTnp6emjNnjv7880+HI+ceHh669957NWnSJF24cCHXe+Qff/xx/fnnn/rggw/STbt06ZL9FEZnnf6Nfw9ly5aVJIdHN6ampmratGlZtiOj9fXixYu6fPmyw7iyZcuqUKFCObrEBPg3W7VqldMjprZriLNz6uztkpqaqr59++rnn39W3759Mz2V+cbfVV9fX5UrV87ht8EWJvOqn76+/zLG6L333lPBggXVtGlTSddClpubW7pH2E6ePDldXdltm5ubm5o1a6ZFixY5nD5//PhxzZ07V/Xr18+T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"/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>As expected, the distributions look identical!</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="Including-Wild-Results">Including Wild Results<a class="anchor-link" href="#Including-Wild-Results">¶</a></h3><p>We can follow the same approach to compute our probability distribution for the number of BLACK results.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [126]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b_prob</span> <span class="o">=</span> <span class="mi">1</span> <span class="o">/</span> <span class="mi">12</span>
<span class="n">black_binom_dist</span> <span class="o">=</span> <span class="nb">list</span><span class="p">((</span><span class="n">k</span><span class="p">,</span> <span class="n">binomial_probability</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">,</span> <span class="n">b_prob</span><span class="p">))</span> <span class="k">for</span> <span class="n">k</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">n</span> <span class="o">+</span> <span class="mi">1</span><span class="p">))</span>

<span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>

<span class="n">fig</span><span class="p">,</span> <span class="n">axes</span> <span class="o">=</span> <span class="n">plt</span><span class="o">.</span><span class="n">subplots</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">axes</span> <span class="o">=</span> <span class="n">axes</span><span class="o">.</span><span class="n">flatten</span><span class="p">()</span>

<span class="n">x_values</span><span class="p">,</span> <span class="n">y_values</span> <span class="o">=</span> <span class="nb">zip</span><span class="p">(</span><span class="o">\*</span><span class="n">black_binom_dist</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="s2">"Probability Distribution of BLACK results"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">bar</span><span class="p">(</span><span class="n">x_values</span><span class="p">,</span> <span class="n">y_values</span><span class="p">,</span> <span class="n">align</span><span class="o">=</span><span class="s1">'center'</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"BLACK"</span><span class="p">],</span> <span class="n">width</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>

<span class="n">black_distribution</span> <span class="o">=</span> <span class="n">df_random_choices</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">row</span><span class="p">:</span> <span class="n">row</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s2">"BLACK"</span><span class="p">,</span> <span class="mi">0</span><span class="p">),</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="sa">f</span><span class="s2">"Sim Distribution of BLACK dice"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">black_distribution</span><span class="p">,</span> <span class="n">bins</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"BLACK"</span><span class="p">],</span> <span class="n">width</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">set_xlim</span><span class="p">(</span><span class="n">right</span><span class="o">=</span><span class="mi">10</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">suptitle</span><span class="p">(</span><span class="s2">"Side-by-side comparison of binomial and simulated distributions"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>&lt;Figure size 640x480 with 0 Axes&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,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atu2rRYtWqQpU6bIwcHBMu+XX34pwzDUpUuXHMtPS0tTeHi4UlNTNXDgQPn5+emvv/7SihUrlJycLE9PT1O3w6VLl9SwYUP99ttv6tGjhx555BGdOXNG3333nf788095eXnp6tWratKkiQ4fPqwBAwYoMDBQ33zzjbp166bk5ORsNy4WLFigtLQ0DRw4UOfOndPEiRP1zDPPqFmzZtq0aZOGDRumw4cP64MPPtCrr76a7Qf2oUOH1LFjR73wwguKiorS7Nmz1aFDB61evVqPP/64pL9/lC5btkwdOnRQYGCgEhMT9fHHH6tx48Y6cOCA/P39rcocO3asHB0d9eqrryo1NdXmE9e87qtevXpp7ty5at++vV555RVt375dMTEx+u2337IFWYcPH1b79u3Vs2dPRUVFadasWerWrZtq1aqlqlWr5rhfDMPQU089pY0bN6pnz54KCQnRmjVrNGTIEP3111+aOnWqvL29NW/ePI0fP16XLl2y3CSqUqVKjuXmdfvm5Pz582rZsqXatWunZ555RosXL9awYcNUvXp1tWrVSpLu+fFyo5SUFH322Wfq3LmzevfurYsXL+rzzz9XeHi4duzYoZCQkFzX707LW7hwoS5evKi+ffvKzs5OEydOVLt27fTHH39YmiWvXbtWkZGRCg4OVkxMjM6ePavu3burVKlSt6xPUlKSWrRoIW9vb7322msqUqSIjh49mu3mSk46duyoKlWq6O2339bKlSs1btw4FStWTB9//LGaNWumd955RwsWLNCrr76qOnXqqFGjRvnaXjl577339NRTT6lLly5KS0vTV199pQ4dOmjFihWKiIiQ9Pd5rFevXqpbt6769OkjSQoKCpIkJSYmqn79+rKzs9OAAQPk7e2tH374QT179lRKSooGDRok6e9jr3nz5jp+/Lheeukl+fv7a968edqwYUOe6vnrr79atu+oUaOUnp6ukSNHytfX95bzjho1SjExMZZ1SElJ0U8//aTdu3fr8ccfV9++fXXy5EnFxsZq3rx5NsuYPXu2rl27pj59+sjJyUnFihXL8YZsRkaGWrZsqfr162vixIlavXq1Ro4cqfT0dI0ZMyZP65slL3W70f79+9WwYUN5eHho6NChKly4sD7++GM1adJEmzdvVr169azyDxw4UEWLFtXIkSN19OhRTZs2TQMGDNCiRYsk3flx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c9a65+V/25bGjRsrMjJSo0ePlpeXl55++mnNnj07z32qbW1rZ2dneXl5ZUu/1XbOjxUrVqh+/fpydnZWsWLF5O3trRkzZuRpn5w+fVrJycn65JNPsp3junfvLul/Lxo9duyYzeM7L9v29OnTunr16m3vmzFjxig5OVkVK1ZU9erVNWTIEO3du/eW890oL+epLPb29lbBsZT3/+M7cfr0aV25csXmNqlSpYoyMzN14sQJq/Rb/V/c6XENwDwE58ADxtHRUXXq1NGECRM0Y8YMXb9+Xd98880dl5vVD2/evHmKjY3N9lm+fLkkadGiRSpRooTV53Z07dpVly5d0rJly2QYhhYuXKgnn3zSEjDktpzJkydr7969ev3113X16lW99NJLqlq1qv7888873Ap53w730o398vOSbtzwAqO8mjBhgqKjo9WoUSPNnz9fa9asUWxsrKpWrWqzj+atnppnyeu+uvnHf04Kcp3vB3djfQryeJk/f766deumoKAgff7551q9erViY2PVrFmzHPvu5ia/5d3t/W1nZ6fFixcrLi5OAwYMsLwkrVatWrp06dIt57dVv7zUOafjPSMj45bL/L//+z899dRTcnZ21kcffaRVq1YpNjZWzz77bJ62S9Z2fu6552ye42JjY/XYY4/dspy7rVGjRoqPj9esWbNUrVo1ffbZZ3rkkUf02Wef5bmMvJ6n8upO9ltButUxdqfHNQDz8EI44AFWu3ZtSX837cxJQECAzWaBBw8etPqe9aIgHx8fhYWF5VheeHi45W25tpw8eVKXL1+2enr+3//+V5KsXqRWrVo1Pfzww1qwYIFKlSql48eP64MPPsjzcqpXr67q1avrzTff1NatW/XYY49p5syZGjdunM38Bb0dchIUFKR9+/blmicgIEB79+5VZmam1dPQ33//3TK9IB0+fFiGYVj9sLx5nyxevFhNmzbV559/bjVvcnJytqeA+ZXbvgoICFBmZqYOHTpk9eK1xMREJScnF9i2CAgI0Lp163Tx4kWrp+cFsc3zsn3vxL0+Xm60ePFilStXTkuWLLFav5EjR94X5WWte17+t3NTv3591a9fX+PHj9fChQvVpUsXffXVV1bN1gtS1pPO5ORkq/S8tOD49ttv5ezsrDVr1lgNPzZ79uxseW0Fk97e3nrooYeUkZFxy3NcQECA9u3bl+34zsu2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rS+//FLz58/X8OHD87Wcfv366dy5c3rzzTf13HPPWZrS5yRrG9r6PWdru97I29tbHh4e2UbpuVlQUJAuXbrENfMBRbP2f4AnnnhCGRkZ2Z4YT506VXZ2dmrVqpVVelxcnFW/8RMnTmj58uVq0aKF5QTm4OCQ7e7pBx98kOOd3U8++cSq3/WMGTOUnp6ebdm3w83NLcebAl5eXmrVqpXmz5+vBQsWqGXLlvnq+2PLL7/8okGDBqlo0aK5jqt5/vz5bNsoJCREkixN27Pevp5T/fNr2bJlln7BkrRjxw5t377dajsHBQXp999/t2oC9ssvv2R743V+6pZ1k+XmN3xOmTJFkvJ1N/tWy8nPsXynNm7cqEuXLqlmzZr5mm/p0qW6fPmy+vfvr/bt22f7PPnkk/r2228tx8Ho0aN19uxZ9erVy/JD40Zr167VihUrbC6rZMmSio2NlZubmyIiIvL9BD6Lj4+PmjRpoo8//tjmD+0bj5ezZ89aTXN3d1f58uWtumzk9TizJevH283H3rlz57Llvfl/CkDB27hxo80npll9iG/V3PZeysjI0EsvvaTffvtNL730kqXrkC15OZfldD66XTdevwzD0IcffqjChQurefPmkv4OzhwcHLK12Proo4+ylZXXujk4OKhFixZavny5VfP5xMRELVy4UA0aNMh1O+VViRIlFBISorlz51rVad++fVq7dm2BPJC5Wda1Mb/X6QULFqhhw4aWm+g3frKG8/zyyy8l/T1CT/Xq1TV+/Hibw/BevHhRb7zxRo7LeuONNzR48GB988036tu3b671unEb3thNNDY29pbdR+zt7dWmTRt9//33+umnn7JNz/offuaZZxQXF6c1a9Zky5OcnGzzdwjuHzw5/wdo3bq1mjZtqjfeeENHjx5VzZo1tXbtWi1fvlyDBg3KNrRDtWrVFB4ebjWUmvR3AJHlySef1Lx58+Tp6ang4GDFxcVp3bp1VsO63SgtLU3NmzfXM888o4MHD+qjjz5SgwYN9NRTT93x+tWqVUvr1q3TlClT5O/vr8DAQKshQbp27Wp5ejl27Nh8lf1///d/unbtmjIyMnT27Fn95z//0XfffSdPT08tXbrUMg62LXPnztVHH32ktm3bKigoSBcvXtSnn34qDw8PywXKxcVFwcHBWrRokSpWrKhixYqpWrVqtz1UTfny5dWg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"/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Now at first I thought that we should somehow combine this distribution with the yellow distribution through addition or multiplication, but I realize that wouldn't be correct. The BLACK results really modify the probability of a success ($p$) in the binomial probability function.</p>
<p>So this is actually fairly simple, I think, we must recompute the binomial distribution with a higher value for $p$.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [127]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">y_and_b_prob</span> <span class="o">=</span> <span class="mi">5</span> <span class="o">/</span> <span class="mi">12</span>

<span class="n">yellow_and_black_binom_dist</span> <span class="o">=</span> <span class="nb">list</span><span class="p">((</span><span class="n">k</span><span class="p">,</span> <span class="n">binomial_probability</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">,</span> <span class="n">y_and_b_prob</span><span class="p">))</span> <span class="k">for</span> <span class="n">k</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">n</span> <span class="o">+</span> <span class="mi">1</span><span class="p">))</span>

<span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>
<span class="n">x_values</span><span class="p">,</span> <span class="n">y_values</span> <span class="o">=</span> <span class="nb">zip</span><span class="p">(</span><span class="o">\*</span><span class="n">yellow_and_black_binom_dist</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s2">"Combined Probability Distribution of YELLOW and BLACK results"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">bar</span><span class="p">(</span><span class="n">x_values</span><span class="p">,</span> <span class="n">y_values</span><span class="p">,</span> <span class="n">align</span><span class="o">=</span><span class="s1">'center'</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"YELLOW"</span><span class="p">],</span> <span class="n">width</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[127]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>&lt;BarContainer object of 11 artists&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,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fv36FdjMKkkLFy5UnTp15O3trVatWul///tfodO1JAIDA9WgQQMdPnxYku2m1NmzZ1un8e7duyVJX3zxhdq3by8fHx9VqVJFd911l/bs2WN37JMnT6pv377y9fVV9erVNXLkSP355582fZYsWaLbb79d/v7+8vT0VMOGDYvcJLxmzRpFRkbKy8tLDRs2tNkMLNk/xseeS+fXxIkTNXr0aEl/rewsm7yPHDmiDh062N3kL0k33XSTYmJiinydwri5uWnOnDlq2LCh5s2bp6ysLOtjlx/jc+HCBT377LOqV6+evLy8VL16dbVr1866q2zQoEGaP3++9X1ZblLR89PeMT4WxS3zhU3ny8csqjZL2+V/oX799dfq2rWrfH19ValSJXXq1Elbt2616WPZ5bB582bFx8erZs2a8vHx0d13323dolKc4pblQYMGWXfp9OnTRy4uLkUeS2cJN2PGjLEGphEjRqhChQp66aWXSlTT1fDzzz/rtdde0+23324TeiyGDRum2267Ta+++qp+/vlnSX8FH+mvoGPx559/Ki0tTb169VJ4eLjNY5mZmdq/f7/1eYXJzc3VhAkT1Lx5c/n5+cnHx0ft27fX+vXrbfpdutxa1nmenp5q2bKlduzYUWDcDz/8UI0bN5aXl5caN25cJrvvAwMDJemKtkguX75cvXv3Vvfu3eXn56fly5cX6DN+/HhVq1ZNixcvtrv1NSYmptDjG0eOHKn58+dr7Nixmjx5crH1FLd+37t3r3r37q1q1arJy8tLLVq00EcffWQzRnHrI6nw406LO+6qqHWxJK1du1bt2rVTlSpVVKlSJd10000aN25cse/7UtfNFp+PP/5Y4eHhatOmTYn6DxkyREuXLlXv3r315JNPatu2bUpMTNSePXsKLPAHDx7Uvffeq6FDh+r+++/XjBkz1KNHDyUlJWncuHF67LHHJEmJiYnq27dvgd0MeXl56tKli2655RZNnz5dycnJSkhI0MWLF0uUrvv27auwsDAlJiYqLS1Nr776qvz9/W3+wp8yZYrGjx+vvn37asiQIcrMzNTcuXN166236uuvv7b+tfnaa69p6NChatOmjUaNGqUff/xRd955p6pVq6aQkJASTbvLXbhwQceOHVP16tVt2pcsWaI///xTDz/8sDw9PVWtWjWtW7dOXbt2VXh4uCZOnKg//vhDc+fOVdu2bZWWllZgge7bt69CQ0OVmJiorVu3as6cOfr999/1xhtvWPssWLBAjRo10p133il3d3d9/PHHeuyxx5Sfn69hw4bZjHfgwAHFxsbqkUce0cCBA7VkyRL16dNHycnJpf6LTJJ69eql/fv366233tKsWbNUo0YNSVLNmjU1YMAAPfTQQ/r+++9tjrXYsWOH9u/fr//+97+lfl03Nzf1799f48eP16ZNm9StWze7/SZOnKjExEQNGTJErVq1UnZ2tr766iulpaXpjjvu0NChQ3X8+HGtXbtW//d//2d3DHvzMz8/327fK13mL1WS2i71ww8/qH379vL19dXTTz+tChUq6JVXXlHHjh21ceNGRUVF2fQfMWKEqlatqoSEBB05ckSzZ8/W8OHDtWLFiiJfpyTL8tChQ1WrVi09//zzevzxx9WyZUsFBAQUOe7LL7+sRo0a6YknnlDfvn310UcfKSkpyfoleqlz587ZPS6nSpUqZbr777PPPlNeXp7i4uIK7RMXF6f169crOTlZQ4YMUXh4uIKDg7Vp0yZrnx07dig3N1dt2rRRmzZttHnzZutu8y1btkhSscEnOztbr776qvr376+HHnpIZ86c0WuvvaaYmBht375dkZGRNv2XL1+uM2fOWI9fmT59unr16qUff/zRGhLWrFmje+65Rw0bNlRiYqJOnTqlwYMH61//+leJp1FeXp51Xly4cEF79uxRQkKC6tatq7Zt25Z4nEtt27ZNBw8e1JIlS+Th4aFevXrpzTfftPmiPnDggPbu3asHHnjA4S1lTzzxhObMmaNnnnlGzz//vEPPtbc++OGHH9S2bVvVqlVLY8aMkY+Pj9555x317NlT77//vu6++25Jxa+PrkRR6+IffvhB3bt3V0REhJ577jl5enrq4MGDNgG8RIzrQFZWliHJuOuuu0rUf9euXYYkY8iQITbtTz31lCHJ+OKLL6xttWvXNiQZW7ZssbZ9/vnnhiTD29vb+Omnn6ztr7zyiiHJWL9+vbVt4MCBhiRjxIgR1rb8/HyjW7duhoeHh5GZmWltl2QkJCRY7yckJBiSjAceeMCmzrvvvtuoXr269f6RI0cMNzc3Y8qUKTb9vvvuO8Pd3d3anpuba/j7+xuRkZHG+fPnrf0WLlxoSDI6dOhQ1GSzTo/OnTsbmZmZRmZmpvHNN98Y/fr1s3mPhw8fNiQZvr6+xokTJ2yeHxkZafj7+xunTp2ytn3zzTeGq6urERcXV+C933nnnTbPf+yxxwxJxjfffGNtO3fuXIE6Y2JijPDw8AK1SzLef/99a1tWVpYRFBRkNGvWzNq2fv16u/Oxdu3aNuNdPr9eeOEFQ5Jx+PBhm36nT582vLy8jGeeecam/fHHHzd8fHyMs2fPFqj/Uh06dDAaNWpU6OMffPCBIcl46aWXbN7rwIEDrfebNm1qdOvWrcjXGTZsmGHvI13U/LQ8tmTJEmtbSZd5e9O5sDELq80wCs6Hnj17Gh4eHsahQ4esbcePHzcqV65s3Hrrrda2JUuWGJKM6OhoIz8/39r+xBNPGG5ubsbp06ftvp5FSZdly/t89913ixzvUjNmzDAkGdWqVTPatm1rU59h/D2NCrulpqZa+xa3/BjG35+3S9dHlxo1apQhyfj6668LHSMtLc2QZMTHx1vb+vTpY3h7exu5ubmGYRhGYmKiERYWZhiGYbz88suGv7+/ta9l/fvLL78UWevFixdt1l+GYRi///67ERAQYLOutEyj6tWrG7/99pu1fdWqVYYk4+OPP7a2RUZGGkFBQTbzfM2aNYakAp97ezp06GB3PjRo0MD48ccfbfpalrsdO3YUO+7w4cONkJAQ6/y31HTpfLC8n1mzZhU7nmH8PV0s68PRo0eX6HmXP9/e+qBTp05GkyZNjD///NPalp+fb7Rp08aoV6+eta0k66MOHTrY/U66knXxrFmzilzOS+q62NWVnZ0tSSVOu6tXr5b01z7rS1n+8rj8WKCGDRvaHGxn+Yvx9ttv1w033FCg/ccffyzwmpduHnZxcdHw4cOVm5urdevWFVvv5cfNtG/fXqdOnbK+75UrVyo/P199+/bVyZMnrbfAwEDVq1fPugn4q6++0okTJ6xnj1gMGjTI5uDD4qxZs0Y1a9ZUzZo11bRpU7377rsaMGCAzRYoSbrnnntUs2ZN6/1ff/1Vu3bt0qBBg1StWjVre0REhO644w7rfLnU5VtsRowYIUk2fb29va3/z8rK0smTJ9WhQwf9+OOPNrt/JCk4ONj6V4ck+fr6Ki4uTl9//bXS09NLPA0c4efnp7vuuktvvfWWdVdPXl6eVqxYoZ49e1oPBi0ty6njZ86cKbRPlSpV9MMPP+jAgQOlfp3L52dxrmSZL628vDytWbNGPXv2VHh4uLU9KChI9957rzZt2mT93Fg8/PDDNrvO2rdvr7y8PP3000+Fvk5plmVHjBo1ShERETp9+rReeeUVm/our33t2rUFbg0bNryi17+cZdkqah1reezS6duuXTv98ccf2rlzp6S/dntZtsq3bdtWJ06csC6TmzdvVlhYmIKDg4usxc3Nzbr+ys/P12+//aaLFy+qRYsWSktLK9A/NjZWVatWtd5v3769pL/X05Z5OXDgQJv14B133OHQdAwNDbVO/88++0yzZ89WVlaWunbtWuJdp5e6ePGiVqxYodjYWOv8t+zSf/PNN639HP3+s8jIyJAk3XjjjQ7XJhVcH/z222/64osv1LdvX505c8b6PXTq1CnFxMTowIED+uWXXySVzfqoNCx7PlatWlXo1uqSuC6Cj6+vr6SiV/yX+umnn+Tq6qq6devatAcGBqpKlSoFVniXhhtJ1g/H5buGLO2///67Tburq6vNSlj6e2Gz7HcsyuWvb/kQW17nwIEDMgxD9erVswYSy23Pnj3WYwUs76tevXo241WoUKFAfUWJiorS2rVrtW7dOm3ZskUnT57UG2+8YRNApL/2r17K8vo33XRTgTEbNGigkydPKicnx6b98lrr1KkjV1dXm+m2efNmRUdHW4+zqFmzpnVT8OXBp27dugW+RByZF6UVFxeno0ePWo+nWrdunTIyMjRgwIArHvvs2bOSil7xPffcczp9+rRuvPFGNWnSRKNHj9a3337r0OtcPj+LcqXLfGllZmbq3LlzhS5j+fn5BY57K+7zZU9plmVHuLm5qVmzZvL29lajRo0K7VevXj1FR0cXuFnWiWXFsmwVtY61F44uPc7HMAxt2bLFutuncePG8vX11ebNm/Xnn39q586dxe7msli6dKkiIiKsx4fUrFlTn376aYHPu1T8/C1svSjZn7+F8fHxsU7/Ll26aOTIkfroo4+0b98+m8sLlNSaNWuUmZmpVq1a6eDBgzp48KAOHz6s2267TW+99Zb1i9vR7z+LZ555Ri1bttTQoUP13nvvOVzf5euDgwcPyjAMjR8/vsD3UEJCgqS/D/Qvi/VRacTGxqpt27YaMmSIAgIC1K9fP73zzjsOh6Dr4hgfX19fBQcH273+RVEK+yvqcm5ubg61W/6qLyvFvU5+fr5cXFz02Wef2e1b1heTq1GjhqKjo4vtd3kQKguXz7NDhw6pU6dOql+/vmbOnKmQkBB5eHho9erVmjVr1hWl+rIUExOjgIAALVu2TLfeequWLVumwMDAEk3H4liW+8uD/KVuvfVWHTp0SKtWrdKaNWv06quvatasWUpKSiryFOtLlfX8LOzzl5eXV6avU5xr9Tkuzxo0aCBJ+vbbbwscQ2Nh+eK6dCtJ06ZNVblyZW3atEn//ve/9dtvv1m3+Li6uioqKkqbNm1SnTp1lJubW6Lgs2zZMg0aNEg9e/bU6NGj5e/vLzc3NyUmJurQoUMF+jtz/loOwP7yyy8dfq5lq07fvn3tPr5x40bddtttql+/viTpu+++c2j8SpUq6bPPPtOtt96q++67T76+vurcuXOJn3/5+sCyrn3qqacKPWHDso4qyfrIxcXF7jy6kvWDt7e3vvzyS61fv16ffvqpkpOTtWLFCt1+++1as2ZNocvK5a6LLT6S1L17dx06dEipqanF9q1du7by8/MLbGbLyMjQ6dOn7V5c7Erk5+cX2P21f/9+SSqTq4LWqVNHhmEoLCzM7l9/ltNFLe/r8vd94cIF6xlZV5Pl9fft21fgsb1796pGjRoFdvtcXuvBgweVn59vnW4ff/yxzp8/r48++khDhw7Vv//9b0VHRxf6JW35q+RSZTUvigrSbm5uuvfee/Xee+/p999/14cffqj+/fuX+INWmLy8PC1fvlwVK1Ys9kujWrVqGjx4sN566y0dO3ZMERERNmdDlfQPgZIoyTJv+cv78ouM2dvFVNLaatasqYoVKxa6jLm6upb6IP5LlWZZLs+6du0qNze3Ig8uf+ONN+Tu7q4uXbpY29zc3HTLLbdo8+bN2rRpk3x9fdWkSRPr45YDnC0Hl5Yk+Lz33nsKDw/XypUrNWDAAMXExCg6OrrA2Z4lVdh6UbI/fx2Vl5dn3SpbUjk5OVq1apViY2P17rvvFrgFBQVZg9GNN96om266SatWrXL4dapXr641a9YoKChIvXr1KtH3Z2EsW3grVKhg93soOjraZmtgceujqlWr2r0AYVG7oC2KWl+4urqqU6dOmjlzpnbv3q0pU6boiy++KHBWYFGum+Dz9NNPy8fHR0OGDLHuu7zUoUOHrKeDWq6FMXv2bJs+M2fOlKRCz4y5EvPmzbP+3zAMzZs3TxUqVFCnTp2ueOxevXrJzc1Nzz77bIEvdcMwdOrUKUlSixYtVLNmTSUlJSk3N9fa5/XXX79qV7i8VFBQkCIjI7V06VKb1/v++++1Zs0auxdis5zGbDF37lxJsl4XxBIcLn3fWVlZWrJkid0ajh8/bnPWXnZ2tt544w1FRkbaPWvGEZYvusKm5YABA/T7779r6NChOnv27BVffyUvL0+PP/649uzZo8cff7zI3RuWZcCiUqVKqlu3rs3lG4qr31HFLfO1a9eWm5tbgb+GX3755QJjlbQ2Nzc3de7cWatWrbLZpZaRkaHly5erXbt2ZbIbqDTLcnkWEhKiwYMHa926dXYvFZGUlKQvvvhCDz74YIEzodq1a6fMzEwtWbJEUVFRNme8tmnTRvv27dOqVatUvXp165alotj7zG/btq3UX9qXzstLd5WtXbvWeop2aa1fv15nz54t9HIWhfnggw+Uk5OjYcOGqXfv3gVu3bt31/vvv2/9/D777LM6deqUhgwZoosXLxYYb82aNfrkk0/svlatWrW0du1a+fj4qFu3bg5vObLw9/dXx44d9corr+jXX38t8PilxzmVZH1Up04d7d271+Z533zzTYnOwCpsffHbb78V6GvZgnn5pWyKcl3s6pL+mkjLly9XbGysGjRoYHPl5i1btujdd9+1XtekadOmGjhwoBYuXKjTp0+rQ4cO2r59u5YuXaqePXvqtttuK9PavLy8lJycrIEDByoqKkqfffaZPv30U40bN86hg0ULU6dOHU2ePFljx47VkSNH1LNnT1WuXFmHDx/WBx98oIcfflhPPfWUKlSooMmTJ2vo0KG6/fbbFRsbq8OHD2vJkiUOHeNzJV544QV17dpVrVu31oMPPmg9BdjPz8/u1UIPHz6sO++8U126dFFqaqqWLVume++917oi6dy5szw8PNSjRw9roFi0aJH8/f3tfvhuvPFGPfjgg9qxY4cCAgK0ePFiZWRkFBqUHNG8eXNJ0n/+8x/169dPFSpUUI8ePawfwmbNmqlx48Z699131aBBA918880lHjsrK0vLli2T9NcpzJYrNx86dEj9+vXTpEmTinx+w4YN1bFjRzVv3lzVqlXTV199pffee8/mAGRL/Y8//rhiYmLk5uamfv36OTQNLEqyzPv5+alPnz6aO3euXFxcVKdOHX3yySfW4wAu5UhtkydPtl6r47HHHpO7u7teeeUVnT9/XtOnTy/V+7HH0WX5akhLS7MuF5eqU6eOzQkZmZmZdq/REhYWpvvuu896f+bMmQWuMOzq6qpx48Zp1qxZ2rt3rx577DElJydbt+x8/vnnWrVqlTp06KAXX3yxwGtYtuKkpqYWmC633HKLXFxctHXrVvXo0aNEW/a6d++ulStX6u6771a3bt10+PBhJSUlqWHDhg5v8bBITExUt27d1K5dOz3wwAP67bffNHfuXDVq1KjEY176Gb148aL27dunBQsWyNvbW2PGjCnQf/HixUpOTi7QPnLkSL355puqXr16oZdnufPOO7Vo0SJ9+umn6tWrl2JjY/Xdd99pypQp+vrrr9W/f3/rlZuTk5OVkpJi9/o/FvXq1dPnn3+ujh07KiYmRps2bSrVd8L8+fPVrl07NWnSRA899JDCw8OVkZGh1NRU/fzzz/rmm28klWx99MADD2jmzJmKiYnRgw8+qBMnTigpKUmNGjUqcILC5QpbFz/33HP68ssv1a1bN9WuXVsnTpzQyy+/rH/9618lPr5M0vVxOvul9u/fbzz00ENGaGio4eHhYVSuXNlo27atMXfuXJtT7C5cuGA8++yzRlhYmFGhQgUjJCTEGDt2rE0fw/jrtGB7p91JMoYNG2bTZjnN74UXXrC2DRw40PDx8TEOHTpkdO7c2ahYsaIREBBgJCQkGHl5eQXGtHc6++Wn3llOh7z8VL3333/faNeuneHj42P4+PgY9evXN4YNG2bs27fPpt/LL79shIWFGZ6enkaLFi2ML7/8stBTBy9X2PQobjpcat26dUbbtm0Nb29vw9fX1+jRo4exe/dumz6W9757926jd+/eRuXKlY2qVasaw4cPN/744w+bvh999JERERFheHl5GaGhoca0adOMxYsXF5hGlto///xzIyIiwvD09DTq169f4DTj0p7ObhiGMWnSJKNWrVqGq6ur3Xk0ffp0Q5Lx/PPPFz4BL3P5qbKVKlUy6tWrZ9x///3GmjVr7D7n8tPZJ0+ebLRq1cqoUqWK4e3tbdSvX9+YMmWK9TRjw/jrNOERI0YYNWvWNFxcXKynjxc1Pws7nb2ky3xmZqZxzz33GBUrVjSqVq1qDB061Pj+++8LjFlYbYZhfz6kpaUZMTExRqVKlYyKFSsat912m80lKQyj8NOKCzvN3p6SLMulOZ3dMP6ejvYUdzr7pfO+sFOtJRmdOnUyDOPvz5u9m5ubm3Ws8+fPG7NmzTKaN29u+Pj4GBUrVjRuvvlmY/bs2TbL0qVycnIMd3d3Q5Ld5TUiIsKQZEybNq1E0yU/P994/vnnjdq1axuenp5Gs2bNjE8++aTAZ7So5dbeMvP+++8bDRo0MDw9PY2GDRsaK1eutPu5t+fyaezi4mJUq1bNuPPOO42dO3fa9LUsd4XdfvrpJ8Pd3d0YMGBAoa937tw5o2LFisbdd99t056SkmLcddddhr+/v+Hu7m7UrFnT6NGjh7Fq1aoSTZf//e9/hre3txEWFlboZQWKW78fOnTIiIuLMwIDA40KFSoYtWrVMrp3726899571j4lWR8ZhmEsW7bMCA8PNzw8PIzIyEjj888/v6J1sWX6BAcHGx4eHkZwcLDRv39/Y//+/XbfS2Fc/v+LAiiBl156SU888YSOHDlS4GwTAMD1j+ADlJBhGGratKmqV6/u0IF0AIDrx3VzjA9wvcrJydFHH32k9evX67vvvtOqVaucXRIAoJTY4gMU48iRIwoLC1OVKlX02GOPacqUKc4uCQBQSgQfAABgGtfNdXwAAACuNoIPAAAwjX/Ewc35+fk6fvy4KleuXKaX7QcAAFePYRg6c+aMgoODba4KfjX9I4LP8ePHy+T3ewAAwLV37NixAj+XcrX8I4KP5YfTjh07Via/4wMAAK6+7OxshYSE2PwA6tX2jwg+lt1bvr6+BB8AAMqZa3mYCgc3AwAA0yD4AAAA0yD4AAAA0yD4AAAA0yD4AAAA0yD4AAAA0yD4AAAA0yD4AAAA0yD4AAAA0yD4AAAA0yhV8Jk/f75CQ0Pl5eWlqKgobd++vdC+ixYtUvv27VW1alVVrVpV0dHRBfoPGjRILi4uNrcuXbqUpjQAAIBCORx8VqxYofj4eCUkJCgtLU1NmzZVTEyMTpw4Ybf/hg0b1L9/f61fv16pqakKCQlR586d9csvv9j069Kli3799Vfr7a233irdOwIAACiEi2EYhiNPiIqKUsuWLTVv3jxJUn5+vkJCQjRixAiNGTOm2Ofn5eWpatWqmjdvnuLi4iT9tcXn9OnT+vDDD0tUw/nz53X+/Hnrfcuvu2ZlZfEjpQAAlBPZ2dny8/O7pt/fDm3xyc3N1c6dOxUdHf33AK6uio6OVmpqaonGOHfunC5cuKBq1arZtG/YsEH+/v666aab9Oijj+rUqVOFjpGYmCg/Pz/rLSQkxJG3AQAATMrdkc4nT55UXl6eAgICbNoDAgK0d+/eEo3xzDPPKDg42CY8denSRb169VJYWJgOHTqkcePGqWvXrkpNTZWbm1uBMcaOHav4+HjrfcsWH8AM1q0rfsuqs0VHT3V2CQBgl0PB50pNnTpVb7/9tjZs2CAvLy9re79+/az/b9KkiSIiIlSnTh1t2LBBnTp1KjCOp6enPD09r0nNAADgn8OhXV01atSQm5ubMjIybNozMjIUGBhY5HNnzJihqVOnas2aNYqIiCiyb3h4uGrUqKGDBw86Uh4AAECRHAo+Hh4eat68uVJSUqxt+fn5SklJUevWrQt93vTp0zVp0iQlJyerRYsWxb7Ozz//rFOnTikoKMiR8gAAAIrk8Ons8fHxWrRokZYuXao9e/bo0UcfVU5OjgYPHixJiouL09ixY639p02bpvHjx2vx4sUKDQ1Venq60tPTdfbsWUnS2bNnNXr0aG3dulVHjhxRSkqK7rrrLtWtW1cxMTFl9DYBAABKcYxPbGysMjMzNWHCBKWnpysyMlLJycnWA56PHj0qV9e/89SCBQuUm5ur3r1724yTkJCgiRMnys3NTd9++62WLl2q06dPKzg4WJ07d9akSZM4jgcAAJQph6/jcz1yxnUAAGfhrC4A/xTX/XV8AAAAyjOCDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA2CDwAAMA13ZxcA4J9n3boxzi6hWNHRU51dAgAnYIsPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwDYIPAAAwjVIFn/nz5ys0NFReXl6KiorS9u3bC+27aNEitW/fXlWrVlXVqlUVHR1doL9hGJowYYKCgoLk7e2t6OhoHThwoDSlAQAAFMrh4LNixQrFx8crISFBaWlpatq0qWJiYnTixAm7/Tds2KD+/ftr/fr1Sk1NVUhIiDp37qxffvnF2mf69OmaM2eOkpKStG3bNvn4+CgmJkZ//vln6d8ZAADAZVwMwzAceUJUVJRatmypefPmSZLy8/MVEhKiESNGaMyYMcU+Py8vT1WrVtW8efMUFxcnwzAUHBysJ598Uk899ZQkKSsrSwEBAXr99dfVr1+/YsfMzs6Wn5+fsrKy5Ovr68jbAcqddeuK/5yheNHRU51dAmB6zvj+dmiLT25urnbu3Kno6Oi/B3B1VXR0tFJTU0s0xrlz53ThwgVVq1ZNknT48GGlp6fbjOnn56eoqKhCxzx//ryys7NtbgAAAMVxKPicPHlSeXl5CggIsGkPCAhQenp6icZ45plnFBwcbA06luc5MmZiYqL8/Pyst5CQEEfeBgAAMCn3a/liU6dO1dtvv60NGzbIy8ur1OOMHTtW8fHx1vvZ2dmEH5QJdiMBwD+bQ8GnRo0acnNzU0ZGhk17RkaGAgMDi3zujBkzNHXqVK1bt04RERHWdsvzMjIyFBQUZDNmZGSk3bE8PT3l6enpSOkAAACO7ery8PBQ8+bNlZKSYm3Lz89XSkqKWrduXejzpk+frkmTJik5OVktWrSweSwsLEyBgYE2Y2ZnZ2vbtm1FjgkAAOAoh3d1xcfHa+DAgWrRooVatWql2bNnKycnR4MHD5YkxcXFqVatWkpMTJQkTZs2TRMmTNDy5csVGhpqPW6nUqVKqlSpklxcXDRq1ChNnjxZ9erVU1hYmMaPH6/g4GD17Nmz7N4pAAAwPYeDT2xsrDIzMzVhwgSlp6crMjJSycnJ1oOTjx49KlfXvzckLViwQLm5uerdu7fNOAkJCZo4caIk6emnn1ZOTo4efvhhnT59Wu3atVNycvIVHQcEAABwOYev43M94jo+KCsc3GweXMcHcL7r/jo+AAAA5RnBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmAbBBwAAmEapgs/8+fMVGhoqLy8vRUVFafv27YX2/eGHH3TPPfcoNDRULi4umj17doE+EydOlIuLi82tfv36pSkNAACgUA4HnxUrVig+Pl4JCQlKS0tT06ZNFRMToxMnTtjtf+7cOYWHh2vq1KkKDAwsdNxGjRrp119/td42bdrkaGkAAABFcjj4zJw5Uw899JAGDx6shg0bKikpSRUrVtTixYvt9m/ZsqVeeOEF9evXT56enoWO6+7ursDAQOutRo0ajpYGAABQJIeCT25urnbu3Kno6Oi/B3B1VXR0tFJTU6+okAMHDig4OFjh4eG67777dPTo0UL7nj9/XtnZ2TY3AACA4jgUfE6ePKm8vDwFBATYtAcEBCg9Pb3URURFRen1119XcnKyFixYoMOHD6t9+/Y6c+aM3f6JiYny8/Oz3kJCQkr92gAAwDyui7O6unbtqj59+igiIkIxMTFavXq1Tp8+rXfeecdu/7FjxyorK8t6O3bs2DWuGAAAlEfujnSuUaOG3NzclJGRYdOekZFR5IHLjqpSpYpuvPFGHTx40O7jnp6eRR4vBAAAYI9DW3w8PDzUvHlzpaSkWNvy8/OVkpKi1q1bl1lRZ8+e1aFDhxQUFFRmYwIAADi0xUeS4uPjNXDgQLVo0UKtWrXS7NmzlZOTo8GDB0uS4uLiVKtWLSUmJkr664Do3bt3W///yy+/aNeuXapUqZLq1q0rSXrqqafUo0cP1a5dW8ePH1dCQoLc3NzUv3//snqfAAAAjgef2NhYZWZmasKECUpPT1dkZKSSk5OtBzwfPXpUrq5/b0g6fvy4mjVrZr0/Y8YMzZgxQx06dNCGDRskST///LP69++vU6dOqWbNmmrXrp22bt2qmjVrXuHbAwAA+JuLYRiGs4u4UtnZ2fLz81NWVpZ8fX2dXQ7KsXXrxji7BFwj0dFTnV0CYHrO+P6+Ls7qAgAAuBYIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDQIPgAAwDTcnV0AADjDunVjnF1CsaKjpzq7BOAfhy0+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANAg+AADANNydXQDMY926Mc4uAQBgcmzxAQAApkHwAQAAplGq4DN//nyFhobKy8tLUVFR2r59e6F9f/jhB91zzz0KDQ2Vi4uLZs+efcVjAgAAlIbDwWfFihWKj49XQkKC0tLS1LRpU8XExOjEiRN2+587d07h4eGaOnWqAgMDy2RMAACA0nA4+MycOVMPPfSQBg8erIYNGyopKUkVK1bU4sWL7fZv2bKlXnjhBfXr10+enp5lMiYAAEBpOBR8cnNztXPnTkVHR/89gKuroqOjlZqaWqoCSjPm+fPnlZ2dbXMDAAAojkPB5+TJk8rLy1NAQIBNe0BAgNLT00tVQGnGTExMlJ+fn/UWEhJSqtcGAADmUi7P6ho7dqyysrKst2PHjjm7JAAAUA44dAHDGjVqyM3NTRkZGTbtGRkZhR64fDXG9PT0LPR4IQAAgMI4tMXHw8NDzZs3V0pKirUtPz9fKSkpat26dakKuBpjAgAA2OPwT1bEx8dr4MCBatGihVq1aqXZs2crJydHgwcPliTFxcWpVq1aSkxMlPTXwcu7d++2/v+XX37Rrl27VKlSJdWtW7dEYwIAAJQFh4NPbGysMjMzNWHCBKWnpysyMlLJycnWg5OPHj0qV9e/NyQdP35czZo1s96fMWOGZsyYoQ4dOmjDhg0lGhMAAKAsuBiGYTi7iCuVnZ0tPz8/ZWVlydfX19nloBD8SCngmOjoqc4uAbiqnPH9XS7P6gIAACgNgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADANgg8AADCNUgWf+fPnKzQ0VF5eXoqKitL27duL7P/uu++qfv368vLyUpMmTbR69WqbxwcNGiQXFxebW5cuXUpTGgAAQKHcHX3CihUrFB8fr6SkJEVFRWn27NmKiYnRvn375O/vX6D/li1b1L9/fyUmJqp79+5avny5evbsqbS0NDVu3Njar0uXLlqyZIn1vqenZynfEgD8M6xbN8bZJRQrOnqqs0sAHOLwFp+ZM2fqoYce0uDBg9WwYUMlJSWpYsWKWrx4sd3+L730krp06aLRo0erQYMGmjRpkm6++WbNmzfPpp+np6cCAwOtt6pVq5buHQEAABTCoeCTm5urnTt3Kjo6+u8BXF0VHR2t1NRUu89JTU216S9JMTExBfpv2LBB/v7+uummm/Too4/q1KlThdZx/vx5ZWdn29wAAACK41DwOXnypPLy8hQQEGDTHhAQoPT0dLvPSU9PL7Z/ly5d9MYbbyglJUXTpk3Txo0b1bVrV+Xl5dkdMzExUX5+ftZbSEiII28DAACYlMPH+FwN/fr1s/6/SZMmioiIUJ06dbRhwwZ16tSpQP+xY8cqPj7eej87O5vwAwAAiuXQFp8aNWrIzc1NGRkZNu0ZGRkKDAy0+5zAwECH+ktSeHi4atSooYMHD9p93NPTU76+vjY3AACA4jgUfDw8PNS8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"/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>So we see that this has shifted the distribution to the right a bit by approximately 1 hit.</p>
<h4 id="How-to-Add-WHITE-Results?">How to Add WHITE Results?<a class="anchor-link" href="#How-to-Add-WHITE-Results?">¶</a></h4><p>This seems tricky, and I have not had time to figure out the mathematical formulation for this.</p>
<p>It's tricky because WHITE results are <em>not</em> independent of YELLOW and BLACK results. They can only be counted in cases where one of the others is already present. In the simulation I accounted for this by clipping the number of WHITE results based on the number of hits after adding BLACK results.</p>
<p>If I have time I'll revisit this.</p>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h5 id="The-Impact-of-Adding-WHITE-Results">The Impact of Adding WHITE Results<a class="anchor-link" href="#The-Impact-of-Adding-WHITE-Results">¶</a></h5><p>Looking at the simulation results, it seems like adding white results shifts the distribution to the right and also "crushes" the center of the distribution, resulting in a flatter peak and less overall variability around the center.</p>
<p>So adding WHITE results does not simply increase the probability of a hit. It changes the whole character of the distribution.</p>
<p>We can see this by running the numbers with a slightly higher probability to represent adding WHITE dice.</p>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [155]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">n</span> <span class="o">=</span> <span class="n">NUM_DICE</span>
<span class="n">y_or_b_prob</span> <span class="o">=</span> <span class="mf">5.5</span> <span class="o">/</span> <span class="mi">12</span>

<span class="n">yellow_and_wilds_binom_dist</span> <span class="o">=</span> <span class="p">[]</span>
<span class="k">for</span> <span class="n">k</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">n</span> <span class="o">+</span> <span class="mi">1</span><span class="p">):</span>
<span class="n">yellow_and_wilds_binom_dist</span><span class="o">.</span><span class="n">append</span><span class="p">((</span><span class="n">k</span><span class="p">,</span> <span class="n">binomial_probability</span><span class="p">(</span><span class="n">n</span><span class="p">,</span> <span class="n">k</span><span class="p">,</span> <span class="n">y_or_b_prob</span><span class="p">)))</span>

<span class="n">yellow_and_wilds_binom_dist</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[155]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>[(0, 0.0021743082111706858),
 (1, 0.018397992556059645),
 (2, 0.07005389473268862),
 (3, 0.15807032657632303),
 (4, 0.23406567589186295),
 (5, 0.23766668629019927),
 (6, 0.16758548392257636),
 (7, 0.0810303438746523),
 (8, 0.02571155142176466),
 (9, 0.004834650694690791),
 (10, 0.0004090858280122976)]</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [156]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">sum</span><span class="p">(</span><span class="n">prob</span> <span class="k">for</span> <span class="n">k</span><span class="p">,</span> <span class="n">prob</span> <span class="ow">in</span> <span class="n">yellow_and_wilds_binom_dist</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child jp-OutputArea-executeResult">
<div class="jp-OutputPrompt jp-OutputArea-prompt">Out[156]:</div>
<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain" tabindex="0">
<pre>1.0000000000000004</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea">
<div class="jp-InputPrompt jp-InputArea-prompt">In [157]:</div>
<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="cm-editor cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">clf</span><span class="p">()</span>

<span class="n">fig</span><span class="p">,</span> <span class="n">axes</span> <span class="o">=</span> <span class="n">plt</span><span class="o">.</span><span class="n">subplots</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">axes</span> <span class="o">=</span> <span class="n">axes</span><span class="o">.</span><span class="n">flatten</span><span class="p">()</span>

<span class="n">x1_values</span><span class="p">,</span> <span class="n">y1_values</span> <span class="o">=</span> <span class="nb">zip</span><span class="p">(</span><span class="o">\*</span><span class="n">yellow_and_black_binom_dist</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="s2">"Probability Distribution of YELLOW and black results"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">bar</span><span class="p">(</span><span class="n">x1_values</span><span class="p">,</span> <span class="n">y1_values</span><span class="p">,</span> <span class="n">align</span><span class="o">=</span><span class="s1">'center'</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"YELLOW"</span><span class="p">],</span> <span class="n">width</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>

<span class="n">x2_values</span><span class="p">,</span> <span class="n">y2_values</span> <span class="o">=</span> <span class="nb">zip</span><span class="p">(</span><span class="o">\*</span><span class="n">yellow_and_wilds_binom_dist</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="s2">"Probability Distribution of YELLOW and wild results"</span><span class="p">)</span>
<span class="n">axes</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">.</span><span class="n">bar</span><span class="p">(</span><span class="n">x2_values</span><span class="p">,</span> <span class="n">y2_values</span><span class="p">,</span> <span class="n">align</span><span class="o">=</span><span class="s1">'center'</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="n">COLOR_LOOKUP</span><span class="p">[</span><span class="s2">"YELLOW"</span><span class="p">],</span> <span class="n">width</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">suptitle</span><span class="p">(</span><span class="s2">"Side-by-side comparison of binomial and simulated distributions"</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>

</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-Collapser jp-OutputCollapser jp-Cell-outputCollapser">
</div>
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain" tabindex="0">
<pre>&lt;Figure size 640x480 with 0 Axes&gt;</pre>
</div>
</div>
<div class="jp-OutputArea-child">
<div class="jp-OutputPrompt jp-OutputArea-prompt"></div>
<div class="jp-RenderedImage jp-OutputArea-output" tabindex="0">
<img alt="No description has been provided for this image" class="" src="data:image/png;base64,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qaFDh8rHx0e9evXSsmXLNGPGDHl4eNjf+9///lfGGA0cODDf9jMzMxUdHa1z587pgQceUGBgoA4fPqwPP/xQaWlp8vX1del0OH36tCIjI/XDDz9o6NCh+sc//qFjx47pf//7n3777Tf5+fnpzz//VMeOHbVnzx7FxcWpdu3aevvttzVkyBClpaXl+VFi8eLFyszM1AMPPKATJ05o6tSpuuuuu3TLLbdow4YNevzxx7Vnzx7NmjVLjzzySJ6d519++UX9+vXTv//9b8XExGjBggXq27evkpKSdOutt0q6sMO5YsUK9e3bV7Vr11ZKSopeeeUVdejQQbt371ZwcLBDmxMnTpSnp6ceeeQRnTt3zumR0qLOq3vuuUcLFy5Unz59NHr0aG3ZskWJiYn64Ycf8gSoPXv2qE+fPho2bJhiYmI0f/58DRkyROHh4WrUqFG+88UYozvvvFPr16/XsGHD1Lx5c61atUqPPvqoDh8+rOeff17+/v5atGiRJk2apNOnT9t/AGrQoEG+7RZ1+ubnjz/+UNeuXfXPf/5Td911l9555x09/vjjatKkibp16yZJV315uVh6erpee+01DRgwQMOHD9epU6f0+uuvKzo6Wlu3blXz5s0LHL8rbW/JkiU6deqU7rvvPrm5uWnq1Kn65z//qV9//dV+qvDq1avVu3dvNWzYUImJiTp+/LhiY2NVo0aNQvuTmpqqLl26yN/fX2PGjFGlSpW0f//+PD+c5Kdfv35q0KCBpkyZoo8++kjPPPOMqlSpoldeeUW33HKLnn32WS1evFiPPPKIWrZsqfbt2xdreuXnhRde0J133qmBAwcqMzNTS5cuVd++ffXhhx+qe/fuki6sx+655x61atVK9957ryQpLCxMkpSSkqLWrVvLzc1NcXFx8vf318cff6xhw4YpPT1dDz30kKQLy17nzp118OBBjRo1SsHBwVq0aJE++eSTIvXz+++/t0/f8ePHKysrSwkJCQoICCj0vePHj1diYqJ9HNLT0/X1119r+/btuvXWW3XffffpyJEjWrNmjRYtWuS0jQULFujs2bO69957ZbPZVKVKlXx/bM3OzlbXrl3VunVrTZ06VUlJSUpISFBWVpaefvrpIo1vrqL07WK7du1SZGSkKlasqMcee0xly5bVK6+8oo4dO+rTTz9VRESEQ/0HHnhAlStXVkJCgvbv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Pvroo0K/cyXR3qXjkhvCc/ucO+5F+W4706FDB/Xu3VsTJkyQn5+fevTooQULFhT5GmZn09rLy0t+fn55ygubzsXx4YcfqnXr1vLy8lKVKlXk7++vOXPmFGmeHD16VGlpaZo3b16edVxsbKykv27aeeDAAafLd1Gm7dGjR/Xnn39e9rx5+umnlZaWphtuuEFNmjTRo48+qh07dhT6vosVZT2Vy93d3SH4SkX/Hl+Jo0eP6syZM06nSYMGDZSTk6NDhw45lBf2vbjS5RqANQjewDXG09NTLVu21OTJkzVnzhydP39eb7/99hW3m3vd26JFi7RmzZo8wwcffCBJWrZsmYKCghyGyzF48GCdPn1aK1askDFGS5Ys0e23324PAwV9znPPPacdO3boiSee0J9//qlRo0apUaNG+u23365wKhR9OlxNF18HX5Ryc9HNgIpq8uTJio+PV/v27fXWW29p1apVWrNmjRo1auT0msjCjnbnKuq8unTHPj8lOc6lgRXjU5LLy1tvvaUhQ4YoLCxMr7/+upKSkrRmzRrdcsst+V4rW5Ditmf1/HZzc9M777yjzZs3Ky4uzn7DsfDwcJ0+fbrQ9zvrX1H6nN/ynp2dXehnbty4UXfeeae8vLz08ssva+XKlVqzZo3+9a9/FWm65E7nu+++2+k6bs2aNbr55psLbcdq7du31969ezV//nw1btxYr732mv7xj3/otddeK3IbRV1PFdWVzLeSVNgydqXLNQBrcHM14BrWokULSRdOt8xPrVq1nJ6q99NPPzn8nXvTnWrVqikqKirf9qKjo+13lXXmyJEjysjIcDjq/fPPP0uSw03JGjdurJtuukmLFy9WjRo1dPDgQc2aNavIn9OkSRM1adJETz75pL744gvdfPPNmjt3rp555hmn9Ut6OuQnLCxMO3fuLLBOrVq1tGPHDuXk5Dgcxfzxxx/tr5ekPXv2yBjjsNN46Tx555131KlTJ73++usO701LS8tz9K64CppXtWrVUk5Ojn755ReHm5ilpKQoLS2txKZFrVq1tHbtWp06dcrhqHdJTPOiTN8rcbWXl4u98847qlOnjt577z2H8UtISCgV7eWOe1G+2wVp3bq1WrdurUmTJmnJkiUaOHCgli5d6nAqeUnKPUKZlpbmUF6UMy/effddeXl5adWqVQ6P4FqwYEGeus6Cor+/vypUqKDs7OxC13G1atXSzp078yzfRZm2/v7+8vb2vqJ5U6VKFcXGxio2NlanT59W+/btNX78ePt8KeoPdkWRk5OjX3/91X6UW8r7PS7OfCtq3/z9/VWuXDmn0+THH3+Uu7t7nrNViupqL9cACsYRb+AasH79eqdHMnKvjy3otL3bbrtNX375pbZu3WovO3r0qMP11dKFoFuxYkVNnjzZ6TVhuY8qCQoKUlRUlMNwsaysLIfHxWRmZuqVV16Rv7+/wsPDHeoOGjRIq1ev1syZM1W1alX7XZwL+pz09HRlZWU5tNOkSRO5u7sXeBpdSU+H/PTu3Vvfffed08cZ5c7D2267TcnJyfY70EoXptusWbPk4+OjDh06FPgZxXXkyBGH/qSnp+vNN99U8+bNFRgYKOnCEZRLl7G33367wOt/C1OUeXXbbbdJkmbOnOlQb8aMGZJkv0PzlbrtttuUnZ2tl156yaH8+eefl5ubm8OyV1xFmb5X4movLxfLPbJ28bKxZcsWbd68uVS0FxQUpObNm2vhwoUOp1mvWbOmwEtwcv3xxx95lvvcO6tbeVpu7g98n332mb0sOztb8+bNK/S9Hh4ecnNzczjKun//fq1YsSJP3fLly+cJiR4eHurdu7feffddpz8SXryOu+2223TkyBGHR5WdOXOmyP2Mjo7WihUrdPDgQXv5Dz/8oFWrVhX6/uPHjzv87ePjo7p16zrMl9wfeC8dx8t18frBGKOXXnpJZcuWVefOnSVd+CHCw8PDYb5J0ssvv5ynraL2zcPDQ126dNEHH3zgcEp7SkqKlixZonbt2qlixYrFGg9XLdcACsYRb+Aa8MADD+jMmTPq1auX6tevr8zMTH3xxRdatmyZQkND7dflOfPYY49p0aJF6tq1qx588EH7Y7Ryj6LlqlixoubMmaNBgwbpH//4h/r37y9/f38dPHhQH330kW6++eY8ocWZ4OBgPfvss9q/f79uuOEGLVu2TN9++63mzZtnf/xPrn/961967LHH9P7772vEiBF5Xnfmk08+UVxcnPr27asbbrhBWVlZWrRokX1n0tXT4dFHH9U777yjvn372k/tO3HihP73v/9p7ty5atasme6991698sorGjJkiLZt26bQ0FC98847+vzzzzVz5sw81yFfqRtuuEHDhg3TV199pYCAAM2fP18pKSkOR8huv/12Pf3004qNjVXbtm31/fffa/HixXmueSyOosyrZs2aKSYmRvPmzVNaWpo6dOigrVu3auHCherZs6c6dep0xeMvSXfccYc6deqk//znP9q/f7+aNWum1atX64MPPtBDDz1kD0KXoyjT90pc7eXlYrfffrvee+899erVS927d9e+ffs0d+5cNWzY8LJOWS3p9iQpMTFR3bt3V7t27TR06FCdOHFCs2bNUqNGjQptc+HChXr55ZfVq1cvhYWF6dSpU3r11VdVsWJF+49CVmjUqJFat26tsWPH6sSJE6pSpYqWLl2a54cqZ7p3764ZM2aoa9eu+te//qXU1FTNnj1bdevWzXMNdHh4uNauXasZM2YoODhYtWvXVkREhKZMmaL169crIiJCw4cPV8OGDXXixAlt375da9eutT/fffjw4XrppZc0ePBgbdu2TUFBQVq0aJHKlStXpPGcMGGCkpKSFBkZqfvvv9/+g1GjRo0KvV67YcOG6tixo8LDw1WlShV9/fXXeueddxxugJb7Y+6oUaMUHR0tDw8P9e/fv0h9u5SXl5eSkpIUExOjiIgIffzxx/roo4/0xBNP2G/Q5uvrq759+2rWrFlyc3NTWFiYPvzwQ6f3/ihO35555hmtWbNG7dq10/33368yZcrolVde0blz5zR16tRij4urlmsAhbh6N1AHcLk+/vhjM3ToUFO/fn3j4+NjPD09Td26dc0DDzxgUlJSHOpe+kgWY4zZsWOH6dChg/Hy8jLVq1c3EydONK+//nq+j7OJjo42vr6+xsvLy4SFhZkhQ4aYr7/+utB+5j6G6euvvzZt2rQxXl5eplatWuall17K9z233XabkWS++OKLIk2LX3/91QwdOtSEhYUZLy8vU6VKFdOpUyezdu3aUjMdjh8/buLi4kz16tWNp6enqVGjhomJiXF4dE9KSoqJjY01fn5+xtPT0zRp0sThUTTG/PWImmnTpuXpm5w8piv3UTMXP0KmVq1apnv37mbVqlWmadOmxmazmfr16+d579mzZ83o0aNNUFCQ8fb2NjfffLPZvHlznsdL5ffZF7+W+6idos6r8+fPmwkTJpjatWubsmXLmpCQEDN27FiHx1xdPC6XurSP+Tl16pR5+OGHTXBwsClbtqypV6+emTZtmsNjeXLbK87jxIoyffN7nJizz3H2+KirtbxcOi1zcnLM5MmTTa1a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xpKkr776Sl988YX69++vGjVqaP/+/ZozZ446duyo3bt35/lVJy4uTpUqVdL48eP1008/ac6cOTpw4IB9AblcixYt0j333KNWrVrp3nvvlSSFhYWpdevWCgkJ0eLFix1Ot5Eu7FCEhYWpTZs2l/25ffr00bBhw7R69WpNmjTJaZ3U1FR16dJF/v7+GjNmjCpVqqT9+/frvffekyT5+/trzpw5GjFihHr16qV//vOfkuSwknc2Pwvy5ptv6tSpUxo5cqTOnj2rF154Qbfccou+//57BQQEFHn8itK3S91zzz1auHCh+vTpo9GjR2vLli1KTEzUDz/8kGfnZ8+ePfZpGBMTo/nz52vIkCEKDw9Xo0aN8v2MoizL/v7+WrRokSZNmqTTp08rMTFRktSgQYN8223durVGjBihadOmqX///rrvvvsUGhqqhIQEp/WPHTuWp8zT01MVK1bM9zMux//93/8pNDRUkZGRTl9v3769QkND9dFHH9nL2rVrp0WLFmnLli32navPP/9cbdu2Vdu2bXXy5Ent3LnTPi8///xz1a9f32E94szbb7+tM2fOaMSIEapataq2bt2qWbNm6bffftPbb7/tUDc7O1vR0dGKiIjQ9OnTtXbtWj333HMKCwuzn7JnjFGPHj20adMm/fvf/1aDBg30/vvvKyYmpljT6HLWLenp6Xrttdc0YMAADR8+XKdOndLrr7+u6Ohobd26Vc2bN7fXHTZsmN544w1169ZN99xzj7KysrRx40Z9+eWX9qOPl3ryySc1efJkvfLKKxo+fHih4/DJJ59o+fLliouLk5+fn0JDQ5WSkqLWrVvbg7m/v78+/vhjDRs2TOnp6XrooYckXThtbtSoUerTp48efPBBnT17Vjt27NCWLVv0r3/9q1jT8lLt27fXqFGj9OKLL+qJJ56wf4caNGhQ6PoN1mMfgH2AS7EPwD7A32EfoFKlSmrcuLE+++wzjRo1StKFoOzm5qYTJ05o9+7d9uVo48aN+U6//Hz//ff27+748eOVlZWlhISEYn2Hjh8/rm7duql///66++67FRAQoJycHN15553atGmT7r33XjVo0EDff/+9nn/+ef3888/2e1Xs2rVLt99+u5o2baqnn35aNptNe/bs0eeff16s8XCmsO927969tWvXLj3wwAMKDQ1Vamqq1qxZo4MHDxbvcjNzDVuw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s2fP1qxZs/K90VV+ateu7fD30aNHlZaWZr+u7+Ihd0OempoqSXr88cfl4+OjVq1aqV69eho5cmSJnI5WmJJYv6F42AcoHvYBLmAfoOjYB8hfadsHyA3TGzduVEZGhr755htFRkaqffv29uC9ceNGVaxYUc2aNStSm9KF7e+ff/7p9LtUnP2T6tWr57lh5C+//KJdu3bl2a7fcMMNkv7arvfr108333yz7rnnHgUEBKh///5avny55SHcZrPp2Wef1ccff6yAgAC1b99eU6dOVXJycrHbui6Cd6tWrRQVFaWOHTuqQYMGDndZzGWz2ZyWl7QHHnhAkyZN0l133aXly5dr9erVWrNmjapWrVqqbtM/ePBgffrpp/rtt9+0d+9effnllyXyS/f58+f1888/F7jxzn2G4+bNmxUXF2e/UVJ4eLhOnz5dpM+xYn7mdz3dpTe9KMm2L5XfnV9NPjf6+Tvy9fVVUFCQduzYUWC9HTt2qHr16g7XlrVr104nT57U999/b7+2K1fbtm114MABHT58WJs2bVJwcLDq1KlT4GdkZ2fr1ltv1UcffaTHH39cK1as0Jo1a/TGG29IUp7vvNV39r1Sb731loYMGaKwsDC9/vrrSkpK0po1a3TLLbdc9vrr5ptvVkBAgF566SWdOHGiWO+9+EiC9Nf0vPvuu50eWVmzZo39RjgNGjTQTz/9pKVLl6pdu3Z699131a5dO4ej9FZ850ti/YbiYR+g+NgHcN4vZ9gHKF3YByhY7h3cP/vsM/td29u0aaPIyEgdOnRIBw4c0MaNG9W2bdursk681KXbdenCdGrSpEm+2/X777/f/t7PPvtMa9eutd+1vl+/frr11lvt31OrvscPPfSQfv75ZyUmJsrLy0tPPfWUGjRo4PSshoJcF8H7ctWqVUtHjhzJ86vZjz/+aH/9Yr/88kueNn7++WeVK1fO/gvWO++8o5iYGD333HPq06ePbr31VrVr1y7fuxFe2ubp06f1+++/l8hzYQta0ffv318eHh7673//q8WLF6ts2bLq16/fFX/mO++8oz///LNIp520bt1akyZN0tdff63Fixdr165dWrp0aaF9vxz5zbuLp3PlypWdzqdLfykuTt9q1aqlnJycPJ+fkpKitLS0PMvY5Srusnytu/3227Vv3748j//ItXHjRu3fv1+33367Q/nFz/L8/PPPHe5WGh4eLpvNpg0bNmjLli2F3slUunCjkZ9//lnPPfecHn/8cfXo0UNRUVEKDg6+7HGrVauWfv/99zw7oLmnjRXV5axb3nnnHdWpU0fvvfeeBg0apOjoaEVFRens2bMO9cLCwnTkyJEiBem6detq9erVOnLkiLp27VroUYqC+Pv7q0KFCsrOznZ6ZCUqKkrVqlWz1y9fvrz69eunBQsW6ODBg+revbsmTZpkH5+ifuedKWw9UND6DaUD+wDsA7APcG1iH6BguaeVb9y4Uc2bN1eFChXUrFkz+fr6KikpSdu3b1f79u2L1S9/f395e3s7/S4Vd//kUmFhYTpx4oQ6d+7sdLt+8RF1d3d3de7cWTNmzNDu3bs1adIkffLJJ/bT0StXrixJeb7LJbFdDwsL0+jRo7V69Wrt3LlTmZmZeu6554o1rn/r4H3bbbcpOzvb4bEX0oVHTri5ualbt24O5Zs3b3a4RuvQoUP64IMP1KVLF/uvWB4eHnl+mZw1a1a+v7TMmzfP4RqnOXPmKCsrK89nX47y5cvnu7H38/NTt27d9NZbb2nx4sXq2rWr/Pz8rujzvvvuOz300EOqXLmyRo4cmW+9P/74I880yj0VKfdUs9w7lBb3EUr5WbFihQ4fPmz/e+vWrdqyZYvDdA4LC9OPP/5oP2VQujBOl56eWpy+3XbbbZKkmTNnOpTPmDFDktS9e/dijUdBn1OcZfla9+ijj8rb21v33Xefjh8/7vDaiRMn9O9//1vlypXTo48+6vBaixYt5OXlpcWLF+vw4cMOv3bbbDb94x//0OzZs5WRkVGkU8xyv/cXL8/GGL3wwguXPW633XabsrKyNGfOHHtZdnZ2oY/futTlrFucjc+WLVvyPF6od+/eMsZowoQJedpwdmSmadOmWrlypX744QfdcccdeR6zUlQeHh7q3bu33n333TyPApLk8N29dLnw9PRUw4YNZYyxT5ewsDCdPHnS4cjJ77//7vRRS5fKfQb0peuBoqzfUDqwD8A+APsA1yb2AQoWGRmp/fv3a9myZfZTz93d3dW2bVvNmDFD58+fL/YdzT08PBQdHa0VK1bo4MGD9vIffvhBq1atKlZbl7rrrrt0+PBhvfrqq3le+/PPP5WRkSFJTn/sv3TdERYWJkkOj3rMzs7WvHnzCu1Hft/tM2fOOD0AUaFChWJv16/Lx4kV1R133KFOnTrpP//5j/bv369mzZpp9erV+uCDD/TQQw/ZZ16uxo0bKzo62uFRIpIcdj5vv/12LVq0SL6+vmrYsKE2b96stWvX5vs4gszMTHXu3Fl33XWXfvrpJ7388stq166d7rzzzisev/DwcK1du1YzZsywn3oSERFhf33w4MHq06ePJGnixInFanvjxo06e/assrOzdfz4cX3++ef63//+J19fX73//vsOzwa81MKFC/Xyyy+rV69eCgsL06lTp/Tqq6+qYsWK9o2Ut7e3GjZsqGXLlumGG25QlSpV1LhxY/sjW4qrbt26ateunUaMGKFz585p5syZqlq1qh577DF7naFDh2rGjBmKjo7WsGHDlJqaqrlz56pRo0b2m3MUt2/NmjVTTEyM5s2bp7S0NHXo0EFbt27VwoUL1bNnT3Xq1OmyxudSxV2WrZCVlaW33nrL6Wu9evWyBxXpws25cn+Jv1hMTIxCQkIkXXjOa+6zQy/WsWNHtWvXTgsXLtTAgQPVpEkTDRs2TLVr19b+/fv1+uuv69ixY/rvf/+bZ7w9PT3VsmVLbdy4UTabzeFGSdKFU81yf70syka3fv36CgsL0yOPPKLDhw+rYsWKevfdd6/o5ht33HGHbr75Zo0ZM0b79+9Xw4YN9d577zm9PrQgl7Nuuf322/Xee++pV69e6t69u/bt26e5c+eqYcOGDr++d+rUSYMGDdKLL76oX375RV27dlVOTo42btyoTp06KS4uLk/brVu31gcffKDbbrtNffr00YoVKxxuKlVUU6ZM0fr16xUREaHhw4erYcOGOnHihLZv3661a9faN8xdunRRYGCg/VT3H374QS+99JK6d+9uv+avf//+evzxx9WrVy+NGjVKZ86c0Zw5c3TDDTc4vRHWxZo3by4PDw89++yzOnnypGw2m2655RYtWbKk0PUbSgf2AdgHYB+g5LAPUHr2AXJD9U8//aTJkyfby9u3b6+PP/5YNpvNft1+cUyYMEFJSUmKjIzU/fffr6ysLM2aNUuNGjUq9NT/ggwaNEjLly/Xv//9b61fv14333yzsrOz9eOPP2r58uVatWqVWrRooaefflqfffaZunfvrlq1aik1NVUvv/yyatSoYZ9fjRo1UuvWrTV27FidOHFCVapU0dKlS5WVlVVoP/L7bmdlZdnX0w0bNlSZMmX0/vvv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"/>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell jp-MarkdownCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper" tabindex="0">
<div class="jp-Collapser jp-InputCollapser jp-Cell-inputCollapser">
</div>
<div class="jp-InputArea jp-Cell-inputArea"><div class="jp-InputPrompt jp-InputArea-prompt">
</div><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>Looking back at the YELLOW graph from our simulation results above, we can clearly see the shape of this distribution is more "sharp" at the peak than it should be, while the simulation resulted in a flatter peak. This shows that there must be a better way to mathematically model the impact of WHITE results. I'll have to come back to this.</p>
</div>
</div>
</div>
</div>
</main>
</div>

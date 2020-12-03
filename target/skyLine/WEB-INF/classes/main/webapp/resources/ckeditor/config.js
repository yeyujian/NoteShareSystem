/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
        {name: 'tools'},
        {name: 'document', groups: ['mode', 'document', 'doctools']},
        {name: 'clipboard', groups: ['clipboard']},
        '/',
        {name: 'insert'},
        {name: 'links'},
        '/',
        {name: 'forms'},
        {name: 'others'},
        {name: 'basicstyles', groups: ['basicstyles', 'cleanup']},
        {name: 'colors'},
        '/',
        {name: 'styles'},
        {name: 'paragraph', groups: ['list', 'blocks', 'align', 'bidi']}
    ];

    config.language = 'zh-cn';
    config.toolbarCanCollapse = true;
    config.toolbarStartupExpanded = false;
    config.format_tags = 'p;h1;h2;h3;pre';
    config.removeButtons = 'SpecialChar';
    config.removeDialogTabs = 'image:advanced;link:advanced';
};

const {
    aceVimMap,
    mapkey,
    imap,
    imapkey,
    getClickableElements,
    vmapkey,
    map,
    unmap,
    cmap,
    addSearchAlias,
    removeSearchAlias,
    tabOpenLink,
    readText,
    Clipboard,
    Front,
    Hints,
    Visual,
    RUNTIME,
} = api;

// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
    Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

mapkey('<', '#3Move current tab to left', function() {
    RUNTIME('moveTab', {
        step: -1
    });
});

mapkey('>', '#3Move current tab to right', function() {
    RUNTIME('moveTab', {
        step: 1
    });
});

// an example to replace `u` with `?`, click `Default mappings` to see how `u` works.
// map('?', 'u');

// an example to remove mapkey `Ctrl-i`
unmap('<Ctrl-i>');

settings.blocklistPattern = /app.tana.inc*|mail.google.com*|.*inbox.google.com.*|workona.com*|coda.io*|logseq.com*|workflowy.com*|mail.superhuman.com*|app.hey.com*|docs.google.com|app.clickup.com*|app.slack.com*|teams.microsoft.com*|roamresearch.com*|remnote.io*|my.supernotes.app*|notion.so*|woven.com*|access.mymind.com*/i;

addSearchAlias('s', 'startpage', 'https://www.startpage.com/sp/search?q=', 's', 'https://www.startpage.com/cgi-bin/csuggest?query=%s&limit=10&lang=english&format=json', function(response) {
    var res = JSON.parse(response.text);
    return res[1];
});

addSearchAlias('b', 'brave', 'https://search.brave.com/search?q=', 's', 'https://search.brave.com/api/suggest?q=', function(response) {
    var res = JSON.parse(response.text);
    return res[1].map(function(r){
        return r;
    });
}, '', {favicon_url: 'https://cdn.search.brave.com/serp/favicon.ico'});

addSearchAlias('a', 'amazon', 'https://www.amazon.com/s?k=', 's', '', function(response) {});

// My settings
settings.scrollStepSize = 150;
settings.defaultSearchEngine = "g";
map('p', 'd');
map('<Ctrl-a>', 'k');
map('<Ctrl-s>', 'j');
// imap('fd', "<Esc>");
aceVimMap('jk', '<Esc>', 'insert');
settings.newTabPosition = "right";
settings.focusAfterClosed = "left";
settings.hintAlign = "left";
settings.tabsThreshold = 3;
settings.modeAfterYank = "Normal";
cmap('<Ctrl-j>', '<Tab>');
cmap('<Ctrl-k>', '<Shift-Tab>');
mapkey('cw', '#2Switch frames', 'Normal.rotateFrame()');
map('q', 'E');
map('w', 'R');
mapkey('ga', '#4Go to last used tab', function() {
    RUNTIME("goToLastTab");
});
map('<Ctrl-;>', 'og');
map('<Ctrl-l>', 'od');

// set theme

// click `Save` button to make above settings to take effect.

Catppuccin = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 11pt;
    backdrop-filter: blur(4px);
    background: rgba(36, 39, 58, 0.95);
    color: #CAD3F5;
    border: 0.5px solid rgba(255, 255, 255, 0.3);
    caret-color: #C6A0F6;
}
#sk_omnibar {
    overflow: hidden;
    position: fixed;
    width: min(90%, 800px);
    max-height: 70%;
    left: max(calc((100% - 800px)/2), 5%);
    text-align: left;
    box-shadow: 0px 20px 40px 10px rgba(0, 0, 0, 0.5);
    z-index: 2147483000;
}
.sk_theme tbody {
    color: #C6A0F6;
}
.sk_theme input {
    color: #d9dce0;
}
.sk_theme .url {
    color: #8087A2;
}
.sk_theme .annotation {
    color: #8BD5CA;
}
.sk_theme .omnibar_highlight {
    color: #C6A0F6;
}
.sk_theme .omnibar_timestamp {
    color: #8AADF4;
}
.sk_theme .omnibar_visitcount {
    color: #C6A0F6;
}
.sk_theme .separator {
    color: #C6A0F6;
}
.sk_theme .omnibar_folder {
    color: #91D7E3;
}
.sk_theme .prompt, .sk_theme .resultPage {
    color: #C6A0F6;
}
#sk_omnibarSearchArea {
    display: flex;
    align-items: center;
    padding-bottom: 5px;
    border-bottom: 1px solid #6D598B;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: rgba(36, 39, 58, 0.0);
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: rgba(198, 160, 246, 0.25);
    border-radius: 5px;
}
#sk_status, #sk_find {
    font-size: 20pt;
}
#sk_omnibarSearchArea .prompt, #sk_omnibarSearchArea .resultPage {
    font-size: 17pt;
}
#sk_omnibarSearchArea>input {
    font-size: 17pt;
    padding: 6px 0px 6px 0.5rem;
}
.sk_omnibar_middle {
    top: 10%;
    border-radius: 10px;
}
#sk_usage, #sk_popup, #sk_editor {
    overflow: auto;
    position: fixed;
    top: 10%;
    width: min(90%, 800px);
    max-height: 70%;
    left: max(calc((100% - 800px)/2), 5%);
    text-align: left;
    box-shadow: 0px 20px 40px 10px rgba(0, 0, 0, 0.5);
    z-index: 2147483298;
    padding: 1rem;
}
.ace_editor {
    z-index: 2147483300 !important;
    width: min(90%, 800px);
    border: 0.5px solid rgba(255, 255, 255, 0.3) !important;
    border-radius: 7px;
}
.ace_editor,
.ace_gutter,
.ace_gutter-cell {
    color: #CAD3F5 !important;
    backdrop-filter: blur(4px);
    -webkit-backdrop-filter: blur(4px);
    background: rgba(36, 39, 58, 0.7) !important;
}
.ace_print-margin {
    background: #C6A0F6 !important;
    opacity: 0.2 !important;
}
.ace_cursor {
    color: #C6A0F6 !important;
    opacity: 0.9 !important;
}
.normal-mode .ace_cursor {
    opacity: 0.9 !important;
    border: 1px solid #C6A0F6;
    background: #C6A0F6 !important;
}
.normal-mode .ace_hidden-cursors .ace_cursor {
    background: transparent !important;
    border: 1px solid #C6A0F6;
    opacity: 0.9 !important;
}
`;


Catppuccin_latte = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 11pt;
    backdrop-filter: blur(4px);
    background: rgba(239, 241, 245, 0.85);
    color: #4C4F69;
    border: 0.5px solid rgba(0, 0, 0, 0.2);
}
#sk_omnibar {
    overflow: hidden;
    position: fixed;
    width: min(90%, 800px);
    max-height: 70%;
    left: max(calc((100% - 800px)/2), 5%);
    text-align: left;
    box-shadow: 0px 20px 40px 10px rgba(0, 0, 0, 0.2);
    z-index: 2147483000;
}
.sk_theme tbody {
    color: #8839EF;
}
.sk_theme input {
    color: #4C4F69;
}
.sk_theme .url {
    color: #7C7F93;
}
.sk_theme .annotation {
    color: #179299;
}
.sk_theme .omnibar_highlight {
    color: #8839EF;
}
.sk_theme .omnibar_timestamp {
    color: #ea76cb;
}
.sk_theme .omnibar_visitcount {
    color: #8839EF;
}
.sk_theme .separator {
    color: #8839EF;
}
.sk_theme .omnibar_folder {
    color: #04A5E5;
}
.sk_theme .prompt, .sk_theme .resultPage {
    color: #8839EF;
}
#sk_omnibarSearchArea {
    display: flex;
    align-items: center;
    padding-bottom: 5px;
    border-bottom: 1px solid #CEC0F2;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: rgba(239, 241, 245, 0.0);
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: RGBA(206, 192, 242, 0.50);
    border-radius: 5px;
}
#sk_status, #sk_find {
    font-size: 20pt;
}
#sk_omnibarSearchArea .prompt, #sk_omnibarSearchArea .resultPage {
    font-size: 17pt;
}
#sk_omnibarSearchArea>input {
    font-size: 17pt;
    padding: 6px 0px 6px 0.5rem;
}
.sk_omnibar_middle {
    top: 10%;
    border-radius: 10px;
}
#sk_usage, #sk_popup, #sk_editor {
    overflow: auto;
    position: fixed;
    top: 10%;
    width: min(90%, 800px);
    max-height: 70%;
    left: max(calc((100% - 800px)/2), 5%);
    text-align: left;
    box-shadow: 0px 20px 40px 10px rgba(0, 0, 0, 0.2);
    z-index: 2147483298;
    padding: 1rem;
}
.ace_editor {
    z-index: 2147483300 !important;
    width: min(90%, 800px);
    border: 0.5px solid rgba(0, 0, 0, 0.2) !important;
    border-radius: 7px;
}
.ace_editor,
.ace_gutter,
.ace_gutter-cell {
    color: #4C4F69 !important;
    backdrop-filter: blur(4px);
    -webkit-backdrop-filter: blur(4px);
    background: rgba(239, 241, 245, 0.6) !important;
}
`;


settings.theme = `
    @media (prefers-color-scheme: dark) {
    ${Catppuccin}
}
    @media (prefers-color-scheme: light) {
    ${Catppuccin_latte}
}
}
`
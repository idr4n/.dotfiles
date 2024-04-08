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

// search in Google
mapkey('<Ctrl-g>', 'Search Query in Google', function () {
  const urlParams = new URLSearchParams(window.location.search);
  const queryValue = urlParams.get('q') || urlParams.get('query') || '';
  window.open('https://www.google.com/search?q=' + encodeURIComponent(queryValue));
})

// search in DuckDuckGo
mapkey('<Ctrl-d>', 'Search Query in DuckDuckGo', function () {
  const urlParams = new URLSearchParams(window.location.search);
  const queryValue = urlParams.get('q') || urlParams.get('query') || '';
  window.open('https://duckduckgo.com/?q=' + encodeURIComponent(queryValue));
})

// search in Brave
mapkey('<Ctrl-b>', 'Search Query in Brave', function () {
  const urlParams = new URLSearchParams(window.location.search);
  const queryValue = urlParams.get('q') || urlParams.get('query') || '';
  window.open('https://search.brave.com/search?q=' + encodeURIComponent(queryValue) + '&source=desktop');
})

// search in Perplexity
mapkey('<Ctrl-p>', 'Search Query in Perplexity', function () {
  const urlParams = new URLSearchParams(window.location.search);
  const queryValue = urlParams.get('q') || urlParams.get('query') || '';
  window.open('https://www.perplexity.ai/?q=' + encodeURIComponent(queryValue) + '&source=desktop');
})
mapkey('<Ctrl-P>', 'Search in Perplexity', async function () {
  const selectedText = document.getSelection().toString();
  const queryValue = selectedText || await navigator.clipboard.readText();
  window.open('https://www.perplexity.ai/?q=' + encodeURIComponent(queryValue) + '&source=desktop');
})

// search in ALL (Google, DuckDuckGo, Breave and Perplexity)
mapkey('<Ctrl-A>', 'Search Query in ALL engines', function () {
  const urlParams = new URLSearchParams(window.location.search);
  const queryValue = urlParams.get('q') || urlParams.get('query') || '';
  window.open('https://www.google.com/search?q=' + encodeURIComponent(queryValue));
  window.open('https://duckduckgo.com/?q=' + encodeURIComponent(queryValue));
  window.open('https://search.brave.com/search?q=' + encodeURIComponent(queryValue) + '&source=desktop');
  window.open('https://www.perplexity.ai/?q=' + encodeURIComponent(queryValue) + '&source=desktop');
})

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

settings.blocklistPattern = /calendar.cron.com*|colab.research.google.com|app.tana.inc*|mail.google.com*|.*inbox.google.com.*|workona.com*|coda.io*|logseq.com*|workflowy.com*|mail.superhuman.com*|app.hey.com*|docs.google.com|app.clickup.com*|app.slack.com*|teams.microsoft.com*|roamresearch.com*|remnote.io*|my.supernotes.app*|notion.so*|app.shortwave.com|access.mymind.com*|remnote.com*|omnivore.app*/i;

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

addSearchAlias('u', 'you.com', 'https://you.com/search?q=', 's', '', function(response) {});

addSearchAlias('n', 'neeva', 'https://neeva.com/search?q=', 's', '', function(response) {});

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

Dark_theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 14px;
    backdrop-filter: blur(25px);
    background: rgba(39, 39, 39, 0.85);
    color: #F2F2F2;
    border: 0.5px solid rgba(255, 255, 255, 0.3);
    caret-color: #A0A0A1;
}
#sk_omnibar {
    overflow: hidden;
    position: fixed;
    width: min(90%, 750px);
    max-height: 70%;
    left: max(calc((100% - 750px)/2), 5%);
    text-align: left;
    box-shadow: 0px 20px 40px 10px rgba(0, 0, 0, 0.5);
    z-index: 2147483000;
}
.sk_theme tbody {
    color: #C6A0F6;
}
.sk_theme input {
    color: #F2F2F2;
}
.sk_theme .title {
    color: #F2F2F2;
    overflow: hidden;
}
.sk_theme .url {
    color: #ADACAD;
    font-weight: lighter !important;
    overflow: hidden;
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
    display: none !important;
}
#sk_omnibarSearchArea {
    display: flex;
    align-items: center;
    padding-bottom: 0px;
    border-bottom: 0px solid #6D598B;
}
.sk_theme #sk_omnibarSearchResult {
    margin: 0 0.5rem;
}
.sk_theme #sk_omnibarSearchResult ul li {
    padding: 0.4rem 0.6rem;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: rgba(36, 39, 58, 0.0);
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3480D3;
    border-radius: 5px;
}
.sk_theme #sk_omnibarSearchResult ul li.focused .title, 
.sk_theme #sk_omnibarSearchResult ul li.focused .url {
    color: #ffffff !important;
}
#sk_status, #sk_find {
    font-size: 20pt;
}
#sk_omnibarSearchArea .prompt, #sk_omnibarSearchArea .resultPage {
    font-size: 20pt;
}
#sk_omnibarSearchArea>input {
    font-size: 20pt;
    padding: 6px 0px 6px 0.3rem;
}
.sk_omnibar_middle {
    top: 10%;
    border-radius: 10px;
}
#sk_usage, #sk_popup, #sk_editor {
    overflow: auto;
    position: fixed;
    top: 10%;
    width: min(90%, 700px);
    max-height: 70%;
    left: max(calc((100% - 700px)/2), 5%);
    text-align: left;
    box-shadow: 0px 20px 40px 10px rgba(0, 0, 0, 0.5);
    z-index: 2147483298;
    padding: 1rem;
}
.ace_editor {
    z-index: 2147483300 !important;
    width: min(90%, 700px);
    border: 0.5px solid rgba(255, 255, 255, 0.3) !important;
    border-radius: 7px;
}
.ace_editor,
.ace_gutter,
.ace_gutter-cell {
    color: #F2F2F2 !important;
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    background: rgba(39, 39, 39, 0.7) !important;
}
.ace_print-margin {
    background: #C6A0F6 !important;
    opacity: 0.2 !important;
}
.ace_cursor {
    color: #C6A0F6 !important;
    opacity: 0.7 !important;
}
.normal-mode .ace_cursor {
    opacity: 0.7 !important;
    background: #C6A0F6 !important;
}
.normal-mode .ace_hidden-cursors .ace_cursor {
    background: transparent !important;
    border: 1px solid #C6A0F6;
    opacity: 0.7 !important;
}
.ace_selected-word {
    background: transparent !important;
    border: 0px !important;
}
.ace_selection {
    opacity: 0.5 !important;
    background: #C6A0F6 !important;
}
`;


Light_theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 14px;
    backdrop-filter: blur(30px);
    background: rgba(241, 241, 241, 0.6);
    color: #3C3C3C;
    border: 0.5px solid rgba(0, 0, 0, 0.3);
    caret-color: #000000;
}
#sk_omnibar {
    overflow: hidden;
    position: fixed;
    width: min(90%, 750px);
    max-height: 70%;
    left: max(calc((100% - 750px)/2), 5%);
    text-align: left;
    box-shadow: 0px 10px 20px 1px rgba(0, 0, 0, 0.2);
    z-index: 2147483000;
}
.sk_theme tbody {
    color: #8839EF;
}
.sk_theme input {
    color: #3C3C3C;
}
.sk_theme .title {
    color: #3C3C3C;
    overflow: hidden;
}
.sk_theme .url {
    color: #3C3C3C;
    font-weight: lighter !important;
    overflow: hidden;
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
    display: none !important;
}
#sk_omnibarSearchArea {
    display: flex;
    align-items: center;
    padding-bottom: 0px;
    border-bottom: 0px solid #CEC0F2;
}
.sk_theme #sk_omnibarSearchResult {
    margin: 0 0.5rem;
}
.sk_theme #sk_omnibarSearchResult ul li {
    padding: 0.4rem 0.6rem;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: rgba(239, 241, 245, 0.0);
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #5097F7;
    border-radius: 7px;
    color: #ffffff !important;
}
.sk_theme #sk_omnibarSearchResult ul li.focused .omnibar_highlight {
    color: #C6A0F6;
}
.sk_theme #sk_omnibarSearchResult ul li.focused .title, 
.sk_theme #sk_omnibarSearchResult ul li.focused .url {
    color: #ffffff !important;
}
#sk_status, #sk_find {
    font-size: 20pt;
}
#sk_omnibarSearchArea .prompt, #sk_omnibarSearchArea .resultPage {
    font-size: 20pt;
}
#sk_omnibarSearchArea>input {
    font-size: 20pt;
    padding: 6px 0px 6px 0.3rem;
}
.sk_omnibar_middle {
    top: 10%;
    border-radius: 10px;
}
#sk_usage, #sk_popup, #sk_editor {
    overflow: auto;
    position: fixed;
    top: 10%;
    width: min(90%, 700px);
    max-height: 70%;
    left: max(calc((100% - 700px)/2), 5%);
    text-align: left;
    box-shadow: 0px 10px 20px 1px rgba(0, 0, 0, 0.2);
    z-index: 2147483298;
    padding: 1rem;
}
.ace_editor {
    z-index: 2147483300 !important;
    width: min(90%, 700px);
    border: 0.5px solid rgba(0, 0, 0, 0.3) !important;
    border-radius: 7px;
}
.ace_editor,
.ace_gutter,
.ace_gutter-cell {
    color: #4C4F69 !important;
    backdrop-filter: blur(30px);
    -webkit-backdrop-filter: blur(30px);
    background: rgba(241, 241, 241, 0.6) !important;
}
.ace_cursor {
    color: #8839EF !important;
    opacity: 0.9 !important;
}
.normal-mode .ace_cursor {
    opacity: 0.7 !important;
    background: #8839EF !important;
}
.normal-mode .ace_hidden-cursors .ace_cursor {
    background: transparent !important;
    border: 1px solid #8839EF;
    opacity: 0.7 !important;
}
`;


settings.theme = `
    @media (prefers-color-scheme: dark) {
    ${Dark_theme}
}
    @media (prefers-color-scheme: light) {
    ${Light_theme}
}
}
`

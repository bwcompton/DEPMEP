$(document).on('shiny:inputchanged', function(event) {
    if (event.name === 'howto' ||
        event.name === 'aboutMEP' ||
        event.name === 'crossing_standards' ||
        event.name === 'sourcedata' ||
        event.name === 'beta') {
        _paq.push(['trackEvent', 'input', event.name]);
    }
    if (event.name === 'map_marker_click') {
        _paq.push(['trackEvent', 'input', 'crossing popup']);
    }
    if (event.name === 'map_shape_click') {
        _paq.push(['trackEvent', 'input', 'stream popup']);
    }
});
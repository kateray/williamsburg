var App = {};

function initMap(data){
  var baseLayer = L.tileLayer( 'https://api.mapbox.com/styles/v1/mapbox/light-v9/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3JheSIsImEiOiJjaXoxZmdyZ3gwMDE1MnFvZG9oZmhrMTBsIn0.mvcEq1pLdeOv-xUSGn6sVw' );

  var cfg = {
    "radius": 20,
    "maxOpacity": .9,
    "minOpacity": 0.04,
    "useLocalExtrema": false,
    latField: 'lat',
    lngField: 'lng',
    valueField: 'count'
  };

  var heatmapLayer = new HeatmapOverlay(cfg);

  App.map = new L.Map('map-container', {
    attributionControl: false,
    center: new L.LatLng(40.734583, -73.997263),
    zoomControl: false,
    zoom: 13,
    layers: [baseLayer, heatmapLayer]
  });

  L.control.zoom({
    position:'topright'
  }).addTo(App.map);

  heatmapLayer.setData({max: 10, data: data});
}

jQuery(document).ready(function($){
  var bloodhound = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: "/search/%QUERY",
      wildcard: "%QUERY"
    },
    limit: 10
  });
  bloodhound.initialize();

  $('#search').typeahead(null, {
    display: 'value',
    source: bloodhound.ttAdapter(),
    templates: {
      empty: [
        '<div class="empty-message">',
          "we don't have that city",
        '</div>'
      ].join('\n'),
      suggestion: function (data) {
        return '<div>' + data.name + '</div>';
      }
    }
  });

  $('#search').bind('typeahead:selected', function(event, datum, name) {
    App.map.setView(new L.LatLng(datum.lat, datum.lng), 13)
  });
})

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

  var map = new L.Map('map-container', {
    center: new L.LatLng(40.734583, -73.997263),
    zoomControl: false,
    zoom: 13,
    layers: [baseLayer, heatmapLayer]
  });

  L.control.zoom({
    position:'bottomleft'
  }).addTo(map);

  heatmapLayer.setData({max: 10, data: data});
}

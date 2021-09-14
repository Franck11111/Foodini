import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  //Fit map to markers
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    // styling your map
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/indiravh/ckt9xm0hz19w817qwtjfi0e17'
    });
    // add markers
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      // code below is linked to standard/normal marker
      // new mapboxgl.Marker({
      //   color: "#FF4848",
      // }).setLngLat([ marker.lng, marker.lat ])
      //   .setPopup(popup) // sets a popup on this marker
      //   .addTo(map);

      // Map resize to take all space
      map.on('idle', function () { map.resize() });

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '41px';
      element.style.height = '41px';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
  });
    //Fit map to markers
    fitMapToMarkers(map, markers);
    map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                      mapboxgl: mapboxgl }));
  }
};

export { initMapbox };

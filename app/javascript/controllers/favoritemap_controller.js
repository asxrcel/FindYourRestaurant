import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    markers: Array
  }
  static targets = ["map"]

  connect() {
    console.log("Markers:", this.markersValue)
    console.log(this.mapTarget)
  }

  toggleMap(event) {
    event.preventDefault()
    const wasCache = this.mapTarget.classList.contains("d-none")
    this.mapTarget.classList.toggle("d-none")
    if (wasCache) {
      this.buttonTarget.innerText = "Masquer la carte"
      if (this.map) {
        this.map.resize()
        return
      }
      mapboxgl.accessToken = "pk.eyJ1IjoiZ2FzcGFyZDAwIiwiYSI6ImNtaHN5bDZydTE3aHcybHI0Y243bzY2dG0ifQ.ZKbOmRjLRtc7P5RkRKHv5g"
      if (mapboxgl.setTelemetryDisabled) {
        mapboxgl.setTelemetryDisabled(true)
      }
      this.map = new mapboxgl.Map({
        container: this.mapTarget,
        style: "mapbox://styles/mapbox/streets-v9",
        center: [2.35, 48.85],
        zoom: 12
      })
      this.map.on("load", () => {
        this.addMarkers()
        this.fitBoundsToMarkers()
      })
    } else {
      this.buttonTarget.innerText = "Afficher la carte"
    }
  }
  addMarkers() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(new mapboxgl.Popup().setHTML(`<h6>${marker.name}</h6>`))
        .addTo(this.map)
    })
  }
  fitBoundsToMarkers() {
    if (this.markersValue.length === 0) return
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat])
    })
    this.map.fitBounds(bounds, {
      padding: 50,
      maxZoom: 15,
      duration: 800
    })
  }
}

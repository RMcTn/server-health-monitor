import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {
	static targets = ["chart", "heartbeat"]
	connect() {
		this.chart = new Chartkick.LineChart(this.chartTarget, this.data, {"title": "Response time for last 10 requests", "ytitle": "Response time in seconds"})
		console.log(this.data)
	}

	heartbeatTargetConnected() {
		if (this.chart) {
			this.chart.updateData(this.data)
		}
	}

	get data() {
		let data = {}
		let maxHeatbeats = 10
		this.heartbeatTargets.slice(0, maxHeatbeats).forEach((heartbeat) => {

			// Remove /" from start and end of the requestTime
			if (heartbeat.dataset.responseTime == null) {
				return;
			}
			data[heartbeat.dataset.requestTime.slice(1, heartbeat.dataset.requestTime.length - 2)] = heartbeat.dataset.responseTime
		})
		return data
	}
}

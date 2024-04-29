import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
import debounce from 'lodash.debounce'

// Connects to data-controller="address"
export default class extends Controller {
  static targets = ["zipCode", "state", "city", "other"]

  initialize() {
    debounce(this.fetch.bind(this), 300)
  }

  fetch() {
    const zipCode = this.zipCodeTarget.value

    if (zipCode.length !== 8) return

    get(`/address/via_cep/${zipCode}`, { responseKind: "turbo-stream" })

  }
}

class UserAddress {
  constructor(data) {
    this.zipCode = data.cep || ""
    this.other = [data.logradouro, data.complemento, data.bairro].filter(Boolean).join(", ")
    this.city = data.localidade || ""
    this.state = data.uf || ""
  }
}

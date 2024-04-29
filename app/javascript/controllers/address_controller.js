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

    get(`/address/via_cep/${zipCode}`, { responseKind: "json" })
      .then(response => response.json)
      .then(data => this.#updateFields(data))
      .catch(error => {
        console.error("Erro ao buscar endereço:", error);
      });
  }

  #updateFields(data) {
    const userAddress = new UserAddress(data)

    this.stateTarget.value = userAddress.state
    this.cityTarget.value = userAddress.city
    this.otherTarget.value = userAddress.other
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

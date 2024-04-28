class Address::ViaCepController < ApplicationController
  def show
    zip_code = params[:zip_code]

    connection = Faraday.new(url: 'https://viacep.com.br/ws/')
    response = connection.get("#{zip_code}/json/")

    json = response.body

    render json:, status: :ok
  end
end

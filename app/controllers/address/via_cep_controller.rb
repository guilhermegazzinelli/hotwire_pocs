class Address::ViaCepController < ApplicationController
  def show
    zip_code = params[:zip_code]

    connection = Faraday.new(url: 'https://viacep.com.br/ws/')
    response = connection.get("#{zip_code}/json/")

    json = response.body
    respond_to do |format|
      format.json {  render json: json, status: :ok }
      format.turbo_stream {
        ua = JSON.parse(json)
        aux = { zip_code: ua["cep"], state: ua['uf'], city: ua['localidade'], other: nil}
        ua = User.new
        ua.build_user_address(aux)
        render turbo_stream: [
        turbo_stream.update("address", partial: "users/replace_form", locals: {user_address: ua.user_address})]
      }
    end
  end
end

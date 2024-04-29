class Address::ViaCepController < ApplicationController
  def show
    zip_code = params[:zip_code]

    connection = Faraday.new(url: 'https://viacep.com.br/ws/')
    response = connection.get("#{zip_code}/json/")

    json = response.body
    respond_to do |format|
      format.json { render json:, status: :ok }
      format.turbo_stream do
        ua = JSON.parse(json)
        aux = { zip_code: ua['cep'], state: ua['uf'], city: ua['localidade'],
                other: [ua['logradouro'], ua['complemento'], ua['bairro']].compact_blank.join(', ') }
        ua = User.new
        ua.build_user_address(aux)
        render turbo_stream: [
          turbo_stream.update('address', partial: 'users/address/fields', locals: { user_address: ua.user_address })
        ]
      end
    end
  end
end

class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'GBMY10DPP5TWMWQLHUBQ3YHOWB1RVSZP3I2JZETH0DIKVWVV'
        req.params['client_secret'] = 'XD1QKIZ3RBH20CE5GSUIOJUBQHCFDYSRGCZ4X5PC5QL1XSPU'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body_hash = JSON.parse(@resp.body)
      @venues = body_hash["response"]["venues"]

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
      render 'search'
  end
end

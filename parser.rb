require 'json'
require 'uri'
require 'net/http'
require 'openssl'



def found_sign (options)
	url = URI("https://twitter154.p.rapidapi.com/user/tweets?username=neural_horo&limit=12")

	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Get.new(url)
	request["X-RapidAPI-Key"] = '372bb9b92fmshacf21ece441dddep178f03jsndd1c8e1899f7'
	request["X-RapidAPI-Host"] = 'twitter154.p.rapidapi.com'

	response = http.request(request)

	raw_tweets = JSON.parse(response.read_body)

	tweets = raw_tweets['results'].map {|tweet| tweet['text']}

	found = nil

	raw_tweets['results'].each do |i|
		if i['text'].include?(options)
			found = i['text']
		end
	end

	return found
end


	
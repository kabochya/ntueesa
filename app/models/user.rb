class User < ActiveRecord::Base
	belongs_to :department
	has_many :payments
	has_many :purchases, through: :payments
	LOGIN_SUCCESS=1
	LOGIN_FAIL=2
	CONNECTION_FAIL=3
	protected

	def ntu_vpn_auth username, password
		require 'net/http'
		require 'uri'
		require 'openssl'
		uri=URI.parse('https://sslvpn.ntu.edu.tw')
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		login_req= Net::HTTP::Post.new('/dana-na/auth/url_default/login.cgi')
		login_req.set_form_data( {'username'=>username,'password'=>password,'realm'=>'NTU EMail Account'})
		login_req['Referer']= uri.host+'dana-na/auth/url_default/welcome.cgi'
		login_req.content_length=login_req.body.length
		begin
		res=http.request(login_req)
		rescue 
			return CONNECTION_FAIL
		end
		return LOGIN_FAIL if /fail/=~res['location']
		
		cookie=res['set-cookie']
		dsid=/DSID=[^;]+(?=;)/.match(cookie)

		logout_req= Net::HTTP::Get.new('/dana-na/auth/logout.cgi')
		logout_req['DNT']=1
		logout_req['Cookie']=dsid[0]
		http.request(logout_req)

		return LOGIN_SUCCESS
	end
end

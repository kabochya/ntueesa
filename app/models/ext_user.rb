class ExtUser < User
	
	def authenticate password
		ntu_vpn_auth account,password
	end
end

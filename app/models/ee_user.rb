class EeUser < User
	def authenticate account, password
		ntu_vpn_auth account,password
	end
end

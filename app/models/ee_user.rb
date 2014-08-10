class EeUser < User
	def authenticate password
		ntu_vpn_auth school_id,password
	end
end

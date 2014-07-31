class TempUser < User
	def authenticate account, password
		if password==self.password
			return LOGIN_SUCCESS
		else
			return LOGIN_FAIL
		end
	end
end

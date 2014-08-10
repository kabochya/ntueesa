class TempUser < User
	def authenticate pwd
		if pwd==self.password
			return LOGIN_SUCCESS
		else
			return LOGIN_FAIL
		end
	end
end

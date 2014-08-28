class BookLog < ActiveRecord::Base
	def self.success_record act ,by ,obj, msg=nil
		create!(action:act,role:by.class.base_class.to_s,role_id:by.id,object:obj.class.base_class.to_s,object_id:obj.id,message:msg)
	end
	def self.fail_record act ,by ,fail_obj ,msg
		if req
			loc = req.remote_ip
		else
			loc = nil
		end
		create!(action:act+'_fail',role:by.class.base_class.to_s,role_id:by.id,object:obj.new.class.base_class.to_s,message:msg)
	end
end

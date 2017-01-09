class PcmAccount < ActiveRecord::Base
	self.table_name = 'PCM_ACCOUNT'

	has_many :PcmCard, primary_key: :customerid, foreign_key: "CUSTOMERID"
end

class PcmCard < ActiveRecord::Base
	self.table_name = 'PCM_CARD'

	has_one :PcmAccount, primary_key: :customerid, foreign_key: "CUSTOMERID"
end

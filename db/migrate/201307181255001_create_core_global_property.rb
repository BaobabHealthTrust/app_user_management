class CreateCoreGlobalProperty < ActiveRecord::Migration
	def self.up		
		create_table "global_property", :primary_key => "property", :force => true do |t|
      t.text   "property_value", :limit => 16777215
      t.text   "description"
      t.string "uuid",           :limit => 38,       :null => false
    end
    
    add_index "global_property", ["uuid"], :name => "global_property_uuid_index", :unique => true

	end

	def self.down
			drop_table "global_property"
	end
end

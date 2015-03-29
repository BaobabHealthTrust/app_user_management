class CorePrivilege < ActiveRecord::Base
  self.table_name = 'privilege'
  self.primary_key = "privilege"

  has_many :role_privileges, :class_name => "CoreRolePrivilege", :foreign_key => :privilege, :dependent => :delete_all
  has_many :roles, :class_name => "CoreRole", :through => :role_privileges

end


### Original SQL Definition for privilege #### 
#   `privilege` varchar(50) NOT NULL default '',
#   `description` varchar(250) NOT NULL default '',
#   PRIMARY KEY  (`privilege_id`)

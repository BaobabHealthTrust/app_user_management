class CoreUserRole < ActiveRecord::Base
  self.table_name = 'user_role'
  self.primary_keys = :role, :user_id

  belongs_to :user, :class_name => 'CoreUser', :foreign_key => :user_id

  def self.distinct_roles
    # CoreUserRole.find(:all, :select => "DISTINCT role")

    CoreUserRole.all.select("DISTINCT role")
  end
end

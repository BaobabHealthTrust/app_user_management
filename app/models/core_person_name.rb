class CorePersonName < ActiveRecord::Base
  self.table_name = 'person_name'
  self.primary_key = :person_name_id

  belongs_to :person, :class_name => 'CorePerson', :foreign_key => :person_id

  default_scope { order('preferred DESC') }

  default_scope { where(:voided => 0) } if column_names.include?("voided")

end

class CorePerson < ActiveRecord::Base
  self.table_name = 'person'
  self.primary_key = :person_id

  has_many :names, :class_name => 'CorePersonName', :foreign_key => :person_id, :dependent => :destroy

  default_scope { where(:voided => 0) } if column_names.include?("voided")

  def fullname

    "#{self.names.first.given_name rescue nil} #{self.names.first.family_name rescue nil}"

  end

end

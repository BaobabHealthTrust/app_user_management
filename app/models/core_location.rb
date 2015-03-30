class CoreLocation < ActiveRecord::Base
  self.table_name = 'location'
  self.primary_key = :location_id

  cattr_accessor :current_location

  def site_id
    CoreLocation.current_health_center.location_id.to_s
  rescue 
    raise "The id for this location has not been set (#{CoreLocation.current_location.name rescue "Unknown"}, #{CoreLocation.current_location.id rescue "NULL"})"
  end

  def children
    return [] if self.name.match(/ - /)
    # CoreLocation.find(:all, :conditions => ["name LIKE ?","%" + self.name + " - %"])
    CoreLocation.where("name LIKE ?","%" + self.name + " - %")
  end

  def parent
    return nil unless self.name.match(/(.*) - /)
    CoreLocation.where(name: $1).first
  end

  def site_name
    self.name.gsub(/ -.*/,"")
  end

  def related_locations_including_self
    if self.parent
      return self.parent.children + [self]
    else
      return self.children + [self]
    end
  end

  def related_to_location?(location)
    self.site_name == location.site_name
  end

  def self.current_health_center
    # @@current_health_center ||= CoreLocation.find(CoreGlobalProperty.find_by_property("current_health_center_id").property_value) rescue self.current_location

    @@current_health_center ||= CoreLocation.where(location_id: (CoreGlobalProperty.where(property: "current_health_center_id").first.property_value rescue nil)).first rescue self.current_location
  end

  def self.current_arv_code
    current_health_center.neighborhood_cell rescue nil
  end
end

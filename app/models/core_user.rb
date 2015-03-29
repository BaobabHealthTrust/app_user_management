# require 'digest/sha1'

class CoreUser < ActiveRecord::Base
  self.table_name = 'users'
  self.primary_key = :user_id

  before_create :modify_values
  before_update :modify_old_values

  cattr_accessor :current_user
  attr_accessor :plain_password

  has_many :user_properties, :class_name => "CoreUserProperty", :foreign_key => :user_id
  has_many :user_roles, :class_name => "CoreUserRole", :foreign_key => :user_id, :dependent => :delete_all

  def first_name
    CoreUserProperty.find_by_user_id_and_property(self.user_id, "First Name").property_value rescue ""
  end

  def last_name
    CoreUserProperty.find_by_user_id_and_property(self.user_id, "Last Name").property_value rescue ""
  end

  def gender
    CoreUserProperty.find_by_user_id_and_property(self.user_id, "Gender").property_value rescue ""
  end

  def name
    self.first_name + " " + self.last_name
    # CorePerson.find(self.user_id).name
  end
    
  def modify_values
    self.salt = CoreUser.random_string(10) if !self.salt?
    self.password = encrypt(self.password, self.salt) #if self.plain_password
    self.date_created = Time.now
    self.uuid = ActiveRecord::Base.connection.select_one("SELECT UUID() as uuid")['uuid']
  end
   
  def self.authenticate(login, password) 
     
    # u = find :first, :conditions => {:username => login}

    u = self.where(username: login).first

    u && u.authenticated?(password) ? u : nil
    #raise password
  end
      
  def authenticated?(plain)
    #  raise "#{plain} #{password} #{encrypt(plain, salt)} #{salt} :  #{Digest::SHA1.hexdigest(plain+salt)} : #{self.salt}"
    #raise "#{self.salt}"
    encrypt(plain, salt) == password || Digest::SHA1.hexdigest("#{plain}#{salt}") == password
  end

  def admin?
    admin = user_roles.map{|user_role| user_role.role }.include? 'Informatics Manager'
    admin = user_roles.map{|user_role| user_role.role }.include? 'System Developer' unless admin
    admin = user_roles.map{|user_role| user_role.role }.include? 'Superuser' unless admin
    admin
  end
      
  # Encrypts plain data with the salt.
  # Digest::SHA1.hexdigest("#{plain}#{salt}") would be equivalent to
  # MySQL SHA1 method, however OpenMRS uses a custom hex encoding which drops
  # Leading zeroes
  def encrypt(plain, salt)
    encoding = Digest::SHA1.hexdigest("#{plain}#{salt}")
    # digest = Digest::SHA1.digest("#{plain}#{salt}")
    # (0..digest.size-1).each{|i| encoding << digest[i].to_s(16) }
    encoding
  end  

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def self.save_property(user_id, property, property_value)
    u = CoreUser.find(user_id)
    user_property = CoreUserProperty.find_by_property_and_user_id(property, user_id) rescue nil

    if user_property
      user_property.property_value = property_value
      user_property.save
    else 
      user_property = CoreUserProperty.new()
      user_property.user_id = user_id
      user_property.property = property
      user_property.property_value = property_value
      user_property.save
    end
  end

  def modify_old_values
    self.salt = CoreUser.random_string(10) if !self.salt?
    self.password = encrypt(self.password, self.salt) #if self.plain_password
  end

  def password_expiry
    property = "last_password_update"
    user_id = self.id

    # expiry_date = CoreUserProperty.find_by_property_and_user_id(property, user_id).property_value rescue nil

    expiry_date = CoreUserProperty.where(user_id: self.id, property: property).last.property_value rescue nil

    if expiry_date
      (expiry_date.to_date + 30.days).strftime("%Y-%m-%d") rescue nil
    else
     CoreUser.save_property(user_id, property, Date.today)
    end
    
  end

  def superuser?
    user_roles.map{|user_role| user_role.role }.include? 'superuser'
  end  

  def manager?
    user_roles.map{|user_role| user_role.role.downcase }.include? 'program manager'
  end

  def status
    # CoreUserProperty.find_by_property("Status", :conditions => ["user_id = ?", self.id]) rescue nil

    CoreUserProperty.where(user_id: self.id, property: "status").last rescue nil
  end

  def status_value
    self.status.property_value rescue nil
  end

  def logged_in?
    # user = CoreUserProperty.find_by_user_id_and_property(self.id, "Token") rescue nil

    user = CoreUserProperty.where(user_id: self.id, property: "Token").last rescue nil

    if user
      return true
    else
      return false
    end
  end

  def demographics
    {
      :user_id => self.id,
      :name => self.name,
      :token => (self.user_properties.find_by_property("Token").property_value rescue nil),
      :roles => (self.user_roles.collect{|r| r.role} rescue []),
      :status => self.status_value
    }
  end

end

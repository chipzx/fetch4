=begin rdoc
= Provisioned Code Tables
 A ProvisionedCodeTable is an ActiveRecord object for database tables that contain a list of items ("codes") for a single area of concern. A good example is our animal_types table, which contains items like 'Dog', 'Cat', 'Rabbit', etc. A code table for FetchIt must have the following three fields:

* name (string field, required)
* description  (text field, can be null)
* group_id (integer field, required, foreign key to groups.id)

The combination of name + group_id must always be unique. Default validations are supplied to enforce required fields and uniqueness.

Every time a new group is created, the set of values in a code table for the "root" group (group.id = 0) gets copied to that group. This is part of the process of provisioning a new group. The standard set of values for each code table is copied to the new group, and the new group's administrators can then customize them (if necessary) for their group's needs.

To that end, a provision method is provided to clone the values for each code table's root group values to the new group.
=end

module ProvisionedCodeTable 
  extend ActiveSupport::Concern

  included do
    validates :name, :group_id, presence: true
    validates :name, uniqueness: {scope: :group_id}
  end

  # include the MultiTenant module
  def self.included klass
    klass.class_eval do
      include MultiTenant
    end
  end

  module ClassMethods
    def provision(root_id, new_group_id)
      defaults = self.unscope(:where).where('group_id = ?', root_id)
      raise Exception, "No default #{self.name} records found" if defaults.size == 0
      defaults.to_a.each do |obj|
        new_obj = self.new(:name => obj.name, :description => obj.description, :group_id => new_group_id)
        new_obj.save
        puts("Saved id: #{new_obj.id} name: #{new_obj.name} group_id: #{new_obj.group}")
      end
      unless Rails.env.test?
        new_objs = self.where('group_id = ?', new_group_id)
        raise Exception, "New objects do not match defaults" if new_objs.size != defaults.size
      end
    end
  end
end

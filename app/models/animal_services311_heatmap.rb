class AnimalServices311Heatmap < ActiveRecord::Base
  include MultiTenant

  scope :with_sr_type, -> type { where("service_request_type = ?", type) if type }
  scope :with_sr_status_type, -> itype { where("service_request_status_type = ?", itype) if itype }
  scope :with_fy_type, -> ftype { where("fiscal_year = ?", ftype) if ftype }

  filterrific(
    default_filter_params: { with_sr_type: 'Loose Dog' }, 
    available_filters: [
      :with_sr_type,
      :with_sr_status_type,
      :with_fy_type
    ]
  )

  def self.options_for_sr_type
    all = [ "All", nil ]
    opts = (ServiceRequestType.all.to_a.map { |t| [t.name, t.name] })
    opts.unshift(all)
  end

  def self.options_for_sr_status_type
    all = [ "All", nil ]
    opts = (ServiceRequestStatusType.all.to_a.map { |t| [t.name, t.name] })
    opts.unshift(all)
  end

  def self.options_for_fy_type
    opts = { "All" => nil, "2014" => 2014, "2015" => 2015 }
  end

end

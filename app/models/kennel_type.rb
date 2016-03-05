class KennelType < ActiveRecord::Base
  include ProvisionedCodeTable

  def self.default_type
    # The first one defined for each group is the default - Usually named "Standard"
    return KennelType.order("id").limit(1).to_a[0]
  end
end

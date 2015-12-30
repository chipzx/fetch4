require 'rails_helper'
require 'multi_tenant_helper'

describe Privilege do
  it_behaves_like 'a multiTenantTable'
end

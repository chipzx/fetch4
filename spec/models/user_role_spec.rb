require 'rails_helper'
require 'multi_tenant_helper'

describe UserRole do
  it_behaves_like 'a multiTenantTable'
end

require 'rails_helper'

describe OutcomeType do
  it "checks multi-tenant methods" do
    group = create(:group)
    it = create(:outcometype)
    OutcomeType.current = group.id
    g = OutcomeType.current
    g == group.id
  end

  it "requires a name and group" do
    group = create(:group)
    it = create(:outcometype)
    it.save!
    group.id.eql?(it.group)
  end
end

require 'rails_helper'

describe IntakeType do
  it "checks multi-tenant methods" do
    group = create(:group)
    it = create(:intaketype)
    IntakeType.current = group.id
    g = IntakeType.current
    g == group.id
  end

  it "requires a name and group" do
    group = create(:group)
    it = create(:intaketype)
    it.save!
    group.id.eql?(it.group)
  end
end

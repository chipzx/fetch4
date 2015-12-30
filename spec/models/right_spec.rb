require 'rails_helper'

describe Right do

  it "checks required fields" do
    r = create(Right)
    expect(r.resource).to_not be_nil
    expect(r.action).to_not be_nil
    r.save
    expect(Right.all.size).to eq(1)
    r2 = Right.new
    expect(r2.resource).to be_nil
    expect(r2.action).to be_nil
    expect { r2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    # expect(r2.action).to be_nil
    # expect { r2.save }.to raise_error(ActiveRecord::RecordInvalid)
    r2.resource = 'kennel'
    r2.action = 'index'
    r.save!
  end

  it "checks unique fields" do
    r = create(Right)
    r.save
    expect(Right.all.size).to eq(1)
    expect { create(Right) }.to raise_error(ActiveRecord::RecordInvalid)
    r2 = Right.new
    r2.resource = r.resource
    r2.action = r.action
    expect {r2.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end

end

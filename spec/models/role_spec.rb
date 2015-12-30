require 'rails_helper'
require 'code_table_spec_helper'

describe Role do
  let (:group) {
    create(:group)
  }
  it_behaves_like 'a provisionedCodeTable'
  describe "role fields" do
    it "requires active flag and description" do
      Role.current = group.id
      r = Role.new
      r.name = 'some name'
      expect { r.save!}.to raise_error(ActiveRecord::RecordInvalid)
      r.description = 'some description'
      r.active = true
      r.save!
      expect(r.description).to_not be_nil
      expect(r.active).to eq(true)
    
    end
  end
end
  

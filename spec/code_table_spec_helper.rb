shared_examples "a provisionedCodeTable" do
  let(:provisionedCodeTable) { build(described_class.name.downcase) }

  let (:group) {
    create(:group)
  }
  let (:new_group) {
    create(:new_group)
  }

  describe "multitenancy" do
    it "sets and checks the group id" do
      provisionedCodeTable.class.current = group.id
      g = provisionedCodeTable.class.current
      expect(g).to eq(group.id)
    end
  end  

  describe "validations" do
    it "requires name and group id" do
      provisionedCodeTable.class.current = group.id
      provisionedCodeTable.name = 'some name'
      provisionedCodeTable.group_id = group.id
      provisionedCodeTable.save!
      expect(provisionedCodeTable.name).to_not be_nil
      # this also tests the multi-tenancy code - group_id automatically gets set
      # on save
      expect(provisionedCodeTable.group_id).to_not be_nil
    end

    it "prevents duplicate records" do
      provisionedCodeTable.class.current = group.id
      provisionedCodeTable.name = 'some name'
      provisionedCodeTable.group_id = provisionedCodeTable.class.current
      provisionedCodeTable.save!
      pct1 = provisionedCodeTable.class.find_by_name("some name")
      expect(pct1).to_not be_nil
      pct2 = build(described_class.name.downcase)
      pct2.name = pct1.name 
      pct2.group_id = pct1.group_id
      pct2.description = 'Duplicate record'
      expect { pct2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      pct = provisionedCodeTable.class.find_by_name("some name")
      expect(pct.description).to_not eq('Duplicate record')
    end
  end

  describe "provisioning" do
    it "provisions to a new group" do
      provisionedCodeTable.class.current = group.id
      provisionedCodeTable.group_id = provisionedCodeTable.class.current
      provisionedCodeTable.save!
      puts("Group Id is #{group.id}, new group id is #{new_group.id}")
      provisionedCodeTable.class.provision(group.id, new_group.id)
      # TODO: Add assertions
      # validation happens inside provision method - have problem with newly
      # created records showing up in test environment [ccy 2015/12/23]
    end
  end 

end

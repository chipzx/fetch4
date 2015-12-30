shared_examples "a multiTenantTable" do
  let(:multiTenantTable) { build(described_class.name.downcase) }

  let (:group) {
    create(:group)
  }

  before (:each) do
      multiTenantTable.class.current = group.id
  end

  describe "multitenancy" do
    it "sets and checks the group id" do
      g = multiTenantTable.class.current
      expect(g).to eq(group.id)
    end
  end  

end

require 'rails_helper'

feature 'Search Animals' do
  let (:group_name) { "fetchit" }
  let (:time_zone) { "UTC" }
  let (:email) { "admin@fetchitsoftware.com" }
  let (:password) { "password" }

  def create_animal(animal_type_id: nil, anumber: nil, name: nil, kennel_id: nil, group_id: nil, intake_type_id: nil)
    anumber ||= "A#{Faker::Number.number(6)}"
    name ||= Faker::name 
    Animal.create!(animal_type_id: animal_type_id, anumber: anumber, name: name, kennel_id: kennel_id, group_id: group_id, intake_type_id: intake_type_id)
  end

  before do
    g = Group.create!(name: :group_name,
                 time_zone: :time_zone)
    i = IntakeType.create!(name: "Unknown", group_id: g.id)
    kt = KennelType.create!(name: "Standard", group_id: g.id)
    k1 = Kennel.create!(name: "101", kennel_type_id: kt.id, group_id: g.id)
    k2 = Kennel.create!(name: "102", kennel_type_id: kt.id, group_id: g.id)
    k3 = Kennel.create!(name: "103", kennel_type_id: kt.id, group_id: g.id)
    dog = AnimalType.create!(name: "Dog", description: "All Canines", group_id: g.id)
    AnimalType.create!(name: "Cat", description: "All Felines", group_id: g.id)
    User.create(email: email,
                password: password,
                password_confirmation: password,
                group_id: g.id,
                confirmed_at: Date.today)

    create_animal(animal_type_id: dog.id, anumber: "A555555", name: "Bowzer", kennel_id: k1.id, group_id: g.id, intake_type_id: i.id)
    create_animal(animal_type_id: dog.id, anumber: "A715647", name: "Rex", kennel_id: k2.id, group_id: g.id, intake_type_id: i.id)
    create_animal(animal_type_id: dog.id, anumber: "A555666", name: "Bowser", kennel_id: k3.id, group_id: g.id, intake_type_id: i.id)

    # Log In
    visit "/animals"
    # Log In
    fill_in "Email", with: "admin@fetchitsoftware.com"
    fill_in "Password", with: "password"
    click_button "Log in"
  end

  scenario "Default load" do
    expect(page.find("h1")).to have_content("Animals Under Care")
    # test if all records show
    expect(page.all("tr").count).to eq(4)
    # test if ordered by kennel
    expect(page.all("tr")[1]).to have_content("101")
    expect(page.all("tr")[2]).to have_content("102")
    expect(page.all("tr")[3]).to have_content("103")
  end
  
  scenario "Test full-text search" do
    within "section.search-form" do
      fill_in "keywords", with: "Bow"
    end
    sleep(4)
    expect(page.find("h1")).to have_content("Animals Under Care")
    expect(page.all("tr").count).to eq(3)
    expect(page.all("tr")[1]).to have_content("101")
    expect(page.all("tr")[2]).to have_content("103")
    save_screenshot("/tmp/test_full_text_search.png")
    within "section.search-results" do
      expect(page.all("tr")[1]).to have_content("Bowzer")
      expect(page.all("tr")[2]).to have_content("Bowser")
    end
  end
  
end

class CreateParties < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection

    create_table :party_types do |t|
      t.string :name, :null => false
      t.text   :description
      t.timestamps null: false
    end

    add_index(:party_types, :name, :name => 'index_party_types_uidx', :unique => true)

    create_table :parties do |t|
      t.integer :party_type_id, :null => false
      t.integer :group_id, :null => false
      t.timestamps null: false
    end

    add_index(:parties, :party_type_id)
    add_index(:parties, :group_id)

    create_table :relationship_types do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps null: false
    end

    add_index(:relationship_types, :name, :name => 'index_relationship_types_uidx', :unique => true)

    create_table :party_relationships do |t|
      t.integer :party_id, :null => false
      t.integer :related_party_id, :null => false
      t.integer :relationship_type_id, :null => false
      t.timestamps null: false
    end

    add_index(:party_relationships, [:party_id, :related_party_id, :relationship_type_id], :name => 'index_party_relationships_uidx', :unique => true)
    add_index(:party_relationships, :related_party_id)
    add_index(:party_relationships, :relationship_type_id)

    create_table :organizations do |t|
      t.integer :party_type_id, :null => false
      t.integer :group_id, :null => false
      t.string  :name, :null => false
      t.timestamps null: false
    end

    add_index(:organizations, :name, :name => 'index_organizations_uidx', :unique => true)
    add_index(:organizations, :party_type_id)
    add_index(:organizations, :group_id)

    create_table :people do |t|
      t.integer :party_type_id, :null => false
      t.integer :group_id, :null => false
      t.string  :first_name, :null => false
      t.string  :middle_name
      t.string  :last_name, :null => false
      t.string  :salutation
      t.string  :suffix
      t.timestamps null: false
    end

    #TODO: How to distinguish between persons with same name?
    add_index(:people, [:last_name, :first_name, :middle_name])
    add_index(:people, [:first_name, :last_name])
    add_index(:people, :party_type_id)
    add_index(:people, :group_id)

    create_table :address_types do |t|
      t.string :name, :null => false
      t.text   :description
      t.integer :precedence, { :null => false, :default => 3 }
      t.timestamps null: false
    end

    add_index(:address_types, :name, :name => 'index_address_types_uidx', :unique => true)

    create_table :addresses do |t|
      t.integer :party_id, :null => false
      t.integer :address_type_id, :null => false
      t.string  :street_address_1, :null => false
      t.string  :street_address_2
      t.string  :city, :null => false
      t.string  :county 
      t.string  :state, :null => false
      t.string  :postal_code, :null => false
      t.string  :country, :null => false
      t.float   :latitude
      t.float   :longitude
      t.timestamps null: false
    end

    add_index(:addresses, :address_type_id)
    add_index(:addresses, [:party_id, :street_address_1, :street_address_2, :city, :state, :postal_code, :country, :address_type_id], :name => 'index_addresses_uidx', :unique => true)
    add_index(:addresses, :postal_code)
    add_index(:addresses, :state)
    add_index(:addresses, :city)

    create_table :contact_types do |t|
      t.string :name, :null => false
      t.text   :description
      t.timestamps null: false
    end

    add_index(:contact_types, :name, :name => 'index_contact_types_uidx', :unique => true)

    create_table :contacts do |t|
      t.integer :contact_type_id, :null => false
      t.integer :party_id, :null => false
      t.text    :description
      t.timestamps null: false
    end

    add_index(:contacts, [:party_id, :contact_type_id])
    add_index(:contacts, :contact_type_id)

    create_table :email_contacts do |t|
      t.integer :contact_type_id, :null => false
      t.integer :party_id, :null => false
      t.text    :description
      t.string :email, :null => false
      t.boolean :is_primary, { :null => false, :default => :false }
      t.timestamps null: false
    end

    add_index(:email_contacts, :email)
    add_index(:email_contacts, [:party_id, :contact_type_id, :email], :name => 'index_email_contacts_uidx', :unique => true)
    add_index(:email_contacts, :contact_type_id)

    create_table :phone_contacts do |t|
      t.integer :contact_type_id, :null => false
      t.integer :party_id, :null => false
      t.text    :description
      t.string  :country_code, { :null => false, :default => '01' }
      t.string  :phone_number, :null => false
      t.string  :extension
      t.string  :phone_type, { :null => false, :default => 'other' }
      t.boolean :is_primary, { :null => false, :default => false }
      t.timestamps null: false
    end

    add_index(:phone_contacts, [:country_code, :phone_number, :extension, :phone_type, :party_id, :contact_type_id], :name => 'index_phone_contacts_uidx', :unique => true)
    add_index(:phone_contacts, :phone_number)
    add_index(:phone_contacts, :party_id)
    add_index(:phone_contacts, :contact_type_id)
    add_index(:phone_contacts, :phone_type)

    create_table :media_types do |t|
      t.string  :name, :null => false
      t.text    :media_uri
      t.text    :description
      t.timestamps null: false
    end

    add_index(:media_types, [:name, :media_uri], :name => 'index_media_types_uidx', :unique => true)
    
    create_table :media_contacts do |t|
      t.integer :contact_type_id, :null => false
      t.integer :party_id, :null => false
      t.text    :description
      t.integer :media_type_id, :null => false
      t.text    :uri, :null => false
      t.timestamps null: false
    end

    add_index(:media_contacts, [:media_type_id, :uri, :party_id, :contact_type_id], :name => 'index_media_contacts_uidx', :unique => true)
    add_index(:media_contacts, :party_id)
    add_index(:media_contacts, :contact_type_id)

    create_table :party_roles do |t|
      t.integer  :party_id
      t.string   :role_name, :null => false
      t.datetime :start_time, :null => false
      t.datetime :end_time
      t.timestamps null: false
    end

    add_index(:party_roles, [:party_id, :role_name, :start_time], :name => 'index_party_roles_uidx', :unique => true)

    # Make people and organizations child tables of parties
    conn.execute('ALTER TABLE people INHERIT parties')
    conn.execute('ALTER TABLE organizations INHERIT parties')
    # since we want people and organizations to inherit from parties, they need to use same sequence generator
    conn.execute("ALTER TABLE people ALTER COLUMN id SET DEFAULT nextval('parties_id_seq'::regclass)")
    conn.execute("ALTER TABLE organizations ALTER COLUMN id SET DEFAULT nextval('parties_id_seq'::regclass)")

    # this table and functions/triggers handle the problem that parent table in an inheritance hierarchy cannot be used for fk constraints
    # see http://stackoverflow.com/questions/4940974/postgresql-foreign-key-not-existing-issue-of-inheritance
    create_table :party_pks do |t|
      t.integer :party_id
      t.integer :group_id
      t.integer :party_type_id
      t.timestamps null: false
    end

    add_index(:party_pks, :party_id, :name => 'index_party_pks_party_id_uidx', :unique => true)
    add_index(:party_pks, [:group_id, :party_id], :name => 'index_party_pks_group_id_uidx', :unique => true)
    add_index(:party_pks, [:party_type_id, :party_id, :group_id], :name => 'index_party_pks_party_type_id_uidx', :unique => true)

    # insert trigger 
    conn.execute("CREATE OR REPLACE FUNCTION update_party_pks() RETURNS trigger AS $$ BEGIN INSERT INTO party_pks (party_id, group_id, party_type_id, created_at, updated_at) VALUES (NEW.id, NEW.group_id, NEW.party_type_id, now(), now()); RETURN null; END; $$ LANGUAGE plpgsql VOLATILE;")

    # delete trigger - parties.id is immutable, so there is no need for an update trigger
    conn.execute("CREATE OR REPLACE FUNCTION delete_party_pks() RETURNS trigger AS $$ BEGIN DELETE FROM party_pks WHERE OLD.id = party_id; RETURN null; END; $$ LANGUAGE plpgsql VOLATILE;");
 
    # triggers for organizations table
    conn.execute("CREATE TRIGGER insert_org_parties_pk_trigger AFTER INSERT ON organizations FOR EACH ROW EXECUTE PROCEDURE update_party_pks()")
    conn.execute("CREATE TRIGGER delete_org_parties_pk_trigger AFTER DELETE ON organizations FOR EACH ROW EXECUTE PROCEDURE delete_party_pks()")

    # triggers for people table 
    conn.execute("CREATE TRIGGER insert_people_parties_pk_trigger AFTER INSERT ON people FOR EACH ROW EXECUTE PROCEDURE update_party_pks()")
    conn.execute("CREATE TRIGGER delete_people_parties_pk_trigger AFTER DELETE ON people FOR EACH ROW EXECUTE PROCEDURE delete_party_pks()")
        
    # Make email_contacts, phone_contacts, and media_contacts child tables of contacts
    conn.execute('ALTER TABLE email_contacts INHERIT contacts')
    conn.execute('ALTER TABLE phone_contacts INHERIT contacts')
    conn.execute('ALTER TABLE media_contacts INHERIT contacts')

    # Add table to use for contact fk relationships
    create_table :contact_pks do |t|
      t.integer :contact_id
      t.integer :party_id
      t.integer :contact_type_id
      t.timestamps null: false
    end

    add_index(:contact_pks, :contact_id, :name => 'index_contact_pks_contact_id_uidx', :unique => true)
    add_index(:contact_pks, [:party_id, :contact_id], :name => 'index_contact_pks_party_id_uidx', :unique => true)

    conn.execute("CREATE OR REPLACE function update_contact_pks() RETURNS trigger AS $$ BEGIN INSERT INTO contact_pks (contact_id, party_id, contact_type_id, created_at, updated_at) VALUES (NEW.id, NEW.party_id, NEW.contact_type_id, now(), now()); RETURN null; END; $$ LANGUAGE plpgsql VOLATILE;")

    conn.execute("CREATE OR REPLACE function delete_contact_pks() RETURNS trigger AS $$ BEGIN DELETE FROM contact_pks WHERE OLD.id = contact_id; RETURN null; END; $$ LANGUAGE plpgsql VOLATILE;")

    # insert trigger
    conn.execute("CREATE TRIGGER insert_contacts_pk_trigger AFTER INSERT ON email_contacts FOR EACH ROW EXECUTE PROCEDURE update_contact_pks()")
    conn.execute("CREATE TRIGGER insert_contacts_pk_trigger AFTER INSERT ON phone_contacts FOR EACH ROW EXECUTE PROCEDURE update_contact_pks()")
    conn.execute("CREATE TRIGGER insert_contacts_pk_trigger AFTER INSERT ON media_contacts FOR EACH ROW EXECUTE PROCEDURE update_contact_pks()")

    # delete trigger
    conn.execute("CREATE TRIGGER delete_contacts_pk_trigger AFTER DELETE ON email_contacts FOR EACH ROW EXECUTE PROCEDURE delete_contact_pks()")
    conn.execute("CREATE TRIGGER delete_contacts_pk_trigger AFTER DELETE ON phone_contacts FOR EACH ROW EXECUTE PROCEDURE delete_contact_pks()")
    conn.execute("CREATE TRIGGER delete_contacts_pk_trigger AFTER DELETE ON media_contacts FOR EACH ROW EXECUTE PROCEDURE delete_contact_pks()")

    # Use parent table id sequence
    conn.execute("ALTER TABLE email_contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq')")
    conn.execute("ALTER TABLE phone_contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq')")
    conn.execute("ALTER TABLE media_contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq')")
    conn.execute("DROP SEQUENCE email_contacts_id_seq")
    conn.execute("DROP SEQUENCE phone_contacts_id_seq")
    conn.execute("DROP SEQUENCE media_contacts_id_seq")

    # Add foreign keys
    conn.execute('ALTER TABLE parties ADD CONSTRAINT parties_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)')
    conn.execute('ALTER TABLE organizations ADD CONSTRAINT organizations_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)')
    conn.execute('ALTER TABLE people ADD CONSTRAINT people_group_id_fk FOREIGN KEY (group_id) REFERENCES groups(id)')
    conn.execute('ALTER TABLE addresses ADD CONSTRAINT addresses_party_id_fk FOREIGN KEY (party_id) REFERENCES party_pks(party_id) ON DELETE CASCADE')

    conn.execute('ALTER TABLE contacts ADD CONSTRAINT contacts_parties_party_id_fk FOREIGN KEY (party_id) REFERENCES party_pks(party_id) ON DELETE CASCADE')
    conn.execute("ALTER TABLE contact_pks ADD CONSTRAINT contact_pks_parties_party_id_fk FOREIGN KEY (party_id) REFERENCES party_pks(party_id) ON DELETE CASCADE")
    conn.execute("ALTER TABLE email_contacts ADD CONSTRAINT email_contacts_pk_contact_id_fk FOREIGN KEY (id) REFERENCES contact_pks(contact_id) ON DELETE CASCADE INITIALLY DEFERRED")
    conn.execute("ALTER TABLE phone_contacts ADD CONSTRAINT phone_contacts_pk_contact_id_fk FOREIGN KEY (id) REFERENCES contact_pks(contact_id) ON DELETE CASCADE INITIALLY DEFERRED")
    conn.execute("ALTER TABLE media_contacts ADD CONSTRAINT media_contacts_pk_contact_id_fk FOREIGN KEY (id) REFERENCES contact_pks(contact_id) ON DELETE CASCADE INITIALLY DEFERRED")

    conn.execute("ALTER TABLE party_roles ADD CONSTRAINT party_roles_party_id_fk FOREIGN KEY (party_id) REFERENCES party_pks(party_id) ON DELETE CASCADE")

    conn.execute('ALTER TABLE party_relationships ADD CONSTRAINT party_relationships_parent_id_fk FOREIGN KEY (party_id) REFERENCES party_pks(party_id)')
    conn.execute('ALTER TABLE party_relationships ADD CONSTRAINT party_relationships_child_id_fk FOREIGN KEY (related_party_id) REFERENCES party_pks(party_id) ON DELETE CASCADE') 
    conn.execute('ALTER TABLE party_relationships ADD CONSTRAINT party_relationships_relationship_type_id_fk FOREIGN KEY(relationship_type_id) REFERENCES relationship_types(id) ON DELETE CASCADE')

    conn.execute('ALTER TABLE parties ADD CONSTRAINT parties_party_type_id_fk FOREIGN KEY (party_type_id) REFERENCES party_types(id)')

    conn.execute('ALTER TABLE addresses ADD CONSTRAINT addresses_address_type_id_fk FOREIGN KEY (address_type_id) REFERENCES address_types(id)')
    conn.execute('ALTER TABLE contacts ADD CONSTRAINT contacts_contact_type_id_fk FOREIGN KEY (contact_type_id) REFERENCES contact_types(id)')
    conn.execute('ALTER TABLE email_contacts ADD CONSTRAINT email_contacts_contact_type_id_fk FOREIGN KEY (contact_type_id) REFERENCES contact_types(id)')
    conn.execute('ALTER TABLE phone_contacts ADD CONSTRAINT phone_contacts_contact_type_id_fk FOREIGN KEY (contact_type_id) REFERENCES contact_types(id)')
    conn.execute('ALTER TABLE media_contacts ADD CONSTRAINT media_contacts_contact_type_id_fk FOREIGN KEY (contact_type_id) REFERENCES contact_types(id)')
    conn.execute('ALTER TABLE media_contacts ADD CONSTRAINT media_contacts_media_type_fk FOREIGN KEY (media_type_id) REFERENCES media_types(id)')

    # Seed type tables 
    conn.execute("INSERT INTO party_types (name, description, created_at, updated_at) values ('person', 'An individual person', now(), now())")
    conn.execute("INSERT INTO party_types (name, description, created_at, updated_at) values ('organization', 'A group of persons organized for some purpose', now(), now())")
  
    # Seed relationship types
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('division', 'organizational division', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('department', 'organizational department', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('program', 'organizational program', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('subsidiary', 'organizational subsidiary', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('spouse', 'husband or wife', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('child', 'child', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('relative', 'other relative', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('roommate', 'co-habitant', now(), now())")
    conn.execute("INSERT INTO relationship_types (name, description, created_at, updated_at) values ('guardian', 'guardian of minor', now(), now())")

    # Seed address_types
    conn.execute("INSERT INTO address_types (name, description, precedence, created_at, updated_at) values ('residence', 'This is both the billing and shipping address', 1, now(), now())")
    conn.execute("INSERT INTO address_types (name, description, precedence, created_at, updated_at) values ('billing', 'Address to send bills to', 2, now(), now())")
    conn.execute("INSERT INTO address_types (name, description, precedence, created_at, updated_at) values ('shipping', 'Address to send mail and send good to', 3, now(), now())")

    # Seed contact_types
    conn.execute("INSERT INTO contact_types (name, description, created_at, updated_at) values ('Phone Number', 'Country code, area code, and local number', now(), now())")
    conn.execute("INSERT INTO contact_types (name, description, created_at, updated_at) values ('Email Address', 'Email address for party', now(), now())")
    conn.execute("INSERT INTO contact_types (name, description, created_at, updated_at) values ('Media', 'Website, social media, etc.', now(), now())")

    # Seed media_types
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('website', 'http://', 'Main website for party', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('blog', 'http://', 'Dedicated blog site', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('Facebook', 'http://facebook.com/', 'Facebook address', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('Twitter', 'http://twitter.com', 'Twitter handle', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('Pinterest', 'http://pinterest.com', 'PInterest address', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('Instagram', 'http://instagram.com', 'Instagram address', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('Tumblr', 'http://tumblr.com', 'Tumblr address', now(), now())")
    conn.execute("INSERT INTO media_types (name, media_uri, description, created_at, updated_at) values ('Dribbble', 'http://dribbble.com', 'Dribbble address', now(), now())")
  end

  def down
    drop_table :party_roles
    drop_table :media_contacts
    drop_table :media_types
    drop_table :phone_contacts
    drop_table :email_contacts
    drop_table :contacts
    drop_table :contact_types
    drop_table :addresses
    drop_table :address_types
    drop_table :people
    drop_table :organizations
    drop_table :party_relationships
    drop_table :relationship_types
    drop_table :parties
    drop_table :party_types
    drop_table :contact_pks
    drop_table :party_pks
  end

end

class BreedGroupMappings < ActiveRecord::Migration
  def up
    conn = ActiveRecord::Base.connection
    create_table :breed_group_mappings do |t|
      t.string :animal_type, null: false
      t.string :breed_group, null: false
      t.string :breed, null: false
      t.timestamps null: false
    end

    conn.execute("ALTER TABLE breed_group_mappings ALTER COLUMN created_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE breed_group_mappings ALTER COLUMN updated_at SET DATA TYPE timestamp with time zone")
    conn.execute("ALTER TABLE breed_group_mappings ALTER COLUMN created_at SET DEFAULT now()")
    conn.execute("ALTER TABLE breed_group_mappings ALTER COLUMN updated_at SET DEFAULT now()")

    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Am Pit Bull%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Pit Bull%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Amer Bulldog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'American Staff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Black Mouth Cur%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Blue Lacy%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Lacy%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Boxer%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Bulldog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Eng Bulldog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Olde English Bulldog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Old Eng Bulldog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Bull Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Bull Terr', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Catahoula%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Staffordshire%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Argentine Dogo%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Cane Corso%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Cur%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Bully Breeds', 'Presa Canario%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'German Shepherd%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Shepherd%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Germ Sh%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Eng Shepherd%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Eng Sheepdog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Picardy Sheepdg%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Old Eng Sheepdog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Oldeng Sheepdog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Mastiff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Neapolitan Mastiff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Akita%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Anatol Shepherd%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Anatolian Shepherd%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Belg Malinois%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Belgian Malinois%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Belg Sheepdog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Great Pyrenees%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Leonberger%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Mastiff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Eng Mastiff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Bullmastiff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Bull Mastiff%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Rottweiler%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Siberian Husky%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Alaskan Husky%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Alaskan Malamute%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Alask Malamute%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Doberman%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Bernese Mtn Dog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Gr Swiss Mtn%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Boerboel%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Dogue de Bordeaux%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Dogue de Bordx%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Amer Eskimo%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Canadian Eskimo%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'German Pinscher%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'Samoyed%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Guard Breeds', 'St Bernard%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Airedale%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Beagle%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Boston Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Chinese Sharpei%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Chinese Shar-Pei%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Chow Chow%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Dalmation%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'French Bulldog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Pug%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Aust Kelpie%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Australian Kelpie%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Corgi%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Welsh Corgi%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Basenji%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Basset%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Finnish Spitz%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Schnauzer, Giant%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Midsize Breeds', 'Whippet%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Miniature Poodle%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Poodle%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Affenpinscher%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Min Pinscher%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Miniature Pinscher%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Bichon Frise%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Chihuahua%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Dachshund%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Jack Russ%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Lhasa Apso%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Min Pinscher%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Pekingese%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Pomeranian%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Schnauzer%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Shih Tzu%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Bruss Griffon%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Wh Pt Griffon%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Griffon%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Chinese Crested%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Ital Greyhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Maltese%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Manchester Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Mex Hairless%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Papillon%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Parson Russ Ter%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Pekingese%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Small Breeds', 'Toy Fox Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'American Blue Heeler%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Aust Cattle Dog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Australian Cattle Dog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Aust Shep%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Australian Shep%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Bluetick%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Dutch Shep%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Border Collie%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Collie%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Carolina Dog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Bearded Collie%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Cattle Dogs', 'Queensland Heeler%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Flat Coat Retr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Labrador Retr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Golden Retr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Chesa Bay Retr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Chesapeake Bay Retr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Eng Setter%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Newfoundland%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Ns Duck Tolling%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Port Water Dog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Retrievers', 'Retriever%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Amer Foxhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Eng Foxhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Black/Tan Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Bloodhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Coonhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Eng Coonhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Greyhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Great Dane%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Ibizan%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Irish Wolfhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Pharoah Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Plott Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Podengo%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Pointer%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Eng Pointer%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Tr Walker Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Rhod Ridgeback%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Rhodesian Ridgeback%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Redbone Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Saluki%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Swiss Hound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Viszla%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Hounds', 'Weimaraner%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Cairn Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Fox Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Irish Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Rat Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Aust Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Bedlington Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Norfolk Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Norwhich Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Tibetan Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Tibetan Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Yorkshire Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Boykin Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Brittany%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Cavalier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Cocker Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Field Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Eng Cocker Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Eng Springer Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Eng Sprngr Span%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Patterdale Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Scot Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Sc Wheat Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Selyham Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Silky Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Skye Terr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Spaniel%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'Welsh Terrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Terriers/Spaniels', 'West Highland%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'American Indian Dog%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Beauceron%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Belg Tervuren%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Canaan%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Coton De Tulear%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Dandie Dimont%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Feist%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Glen of Imaal%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Harrier%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Havanese%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Japanese Chin%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Jindo%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Keeshond%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Kuvasz%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Lowchen %', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Otterhound%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Pbgv%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Schipperke%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Shetland%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Shetld%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Shiba Inu%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Spinone%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Swed Vallund%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Tenn Tr%', 'Dog')")
    conn.execute("INSERT INTO breed_group_mappings (breed_group, breed, animal_type) VALUES ('Other', 'Treeing Cur%', 'Dog')")
    
    conn.execute("UPDATE breed_group_mappings SET breed = LOWER(breed)")
  end

  def down
    drop_table :breed_group_mappings;
  end
end
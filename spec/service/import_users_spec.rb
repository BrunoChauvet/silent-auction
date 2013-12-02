require 'spec_helper'

describe ImportUsers do

  describe "#import" do

    let(:file_path) {'spec/fixtures/gala_tables.xlsx'}

    it "should extract the tables" do
      ImportUsers.import file_path

      user_groups = UserGroup.order('sort_order')
      user_groups.length.should eql(26)
      user_groups[0].name.should eql('Table 1')
    end

    it "should not recreate an existing table" do
      UserGroup.create!(name: 'Table 1', sort_order: 1)

      ImportUsers.import file_path

      user_groups = UserGroup.order('sort_order')
      user_groups.each do |user_group|
      end

      user_groups.length.should eql(26)
      user_groups[0].name.should eql('Table 1')
    end

    it "should extract the users" do
      ImportUsers.import file_path

      users = User.all
      users.length.should eql(245)
      
      user = User.where(first_name: 'Lea', last_name: 'Seguier').first
      user.title.should eql('Mrs')
      user.first_name.should eql('Lea')
      user.last_name.should eql('Seguier')
      user.user_group.name.should eql('Table 9')
    end

    it "should update an existing user" do
      table = UserGroup.create!(name: 'Table 2', sort_order: 2)
      User.create(title: 'Mrs', first_name: 'Lea', last_name: 'Seguier', user_group: table, pin: 1122)

      ImportUsers.import file_path

      user = User.where(first_name: 'Lea', last_name: 'Seguier').first
      user.title.should eql('Mrs')
      user.first_name.should eql('Lea')
      user.last_name.should eql('Seguier')
      user.user_group.name.should eql('Table 9')
      user.pin.should eql("1122")
    end

  end

end

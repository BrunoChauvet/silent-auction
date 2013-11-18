require 'spec_helper'

describe ImportUsers do

  describe "#import" do

    let(:file_path) {'spec/fixtures/gala_tables.xlsx'}

    it "should extract the tables" do
      ImportUsers.import file_path

      user_groups = UserGroup.order('sort_order')
      user_groups.length.should eql(31)
      user_groups[0].name.should eql('Table 0')
    end

    it "should not recreate an existing table" do
      UserGroup.create!(name: 'Table 1', sort_order: 1)

      ImportUsers.import file_path

      user_groups = UserGroup.order('sort_order')
      user_groups.each do |user_group|
      end

      user_groups.length.should eql(31)
      user_groups[1].name.should eql('Table 1')
    end

    it "should extract the users" do
      ImportUsers.import file_path

      users = User.all
      users.length.should eql(128)
      
      user = User.where(first_name: 'Emmanuel', last_name: 'About').first
      user.title.should eql('Mr')
      user.first_name.should eql('Emmanuel')
      user.last_name.should eql('About')
      user.user_group.name.should eql('Table 15')
    end

    it "should update an existing user" do
      table = UserGroup.create!(name: 'Table 2', sort_order: 2)
      User.create(title: 'Mr', first_name: 'Emmanuel', last_name: 'About', user_group: table)

      ImportUsers.import file_path

      user = User.where(first_name: 'Emmanuel', last_name: 'About').first
      user.title.should eql('Mr')
      user.first_name.should eql('Emmanuel')
      user.last_name.should eql('About')
      user.user_group.name.should eql('Table 15')
    end

  end

end

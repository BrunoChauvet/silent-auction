require 'spec_helper'

describe ImportUsers do

  describe "#import" do

    let(:file_path) {'spec/fixtures/gala_tables.xls'}

    it "should extract the tables" do
      ImportUsers.import file_path

      user_groups = UserGroup.order('sort_order')
      user_groups.length.should eql(30)
      user_groups[0].name.should eql('Table 1')
    end

    it "should not recreate an existing table" do
      UserGroup.create!(name: 'Table 1', sort_order: 1)

      ImportUsers.import file_path

      user_groups = UserGroup.order('sort_order')
      user_groups.length.should eql(30)
      user_groups[0].name.should eql('Table 1')
    end

    it "should extract the users" do
      ImportUsers.import file_path

      users = User.order('first_name, last_name')
      users.length.should eql(300)
      users[0].title.should eql('Dr.')
      users[0].first_name.should eql('Abbot')
      users[0].last_name.should eql('Head')
      users[0].user_group.name.should eql('Table 1')
    end

    it "should update an existing user" do
      table = UserGroup.create!(name: 'Table 2', sort_order: 2)
      User.create(title: 'Mr', first_name: 'Abbot', last_name: 'Head', user_group: table)

      ImportUsers.import file_path

      user = User.where(first_name: 'Abbot', last_name: 'Head').first
      user.title.should eql('Dr.')
      user.first_name.should eql('Abbot')
      user.last_name.should eql('Head')
      user.user_group.name.should eql('Table 1')
    end

  end

end

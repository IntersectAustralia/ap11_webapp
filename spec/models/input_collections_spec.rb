require 'spec_helper'

describe InputCollection do
  describe "associations" do
    it { should belong_to :experiment }
  end

  describe "validations" do
    it { should validate_presence_of :for_code1 }
    it { should ensure_length_of(:name).is_at_most(512) }
    it { should ensure_length_of(:license).is_at_most(2000) }
    it { should ensure_length_of(:access_rights).is_at_most(2000) }
    it { should ensure_length_of(:location).is_at_most(2000) }
    it { should ensure_length_of(:website_name).is_at_most(512) }
    it { should ensure_length_of(:url).is_at_most(2000) }

    it "should be invalid if url is supplied but no website name exists" do
      c = FactoryGirl.create(:input_collection)
      c.send(:url=, "http://www.ap11.com")
      c.should_not be_valid
      c.errors[:website_name].should eq ["can't be blank"]
    end

    it "should be invalid if website name is supplied but no url exists" do
      c = FactoryGirl.create(:input_collection)
      c.send(:website_name=, "AP11")
      c.should_not be_valid
      c.errors[:url].should eq ["can't be blank"]
    end

    it "should check if URL exists" do
      c = FactoryGirl.create(:input_collection, :url => "http://www.ap11.com", :website_name => "AP11")
      result = c.url_exists?
      result.should be_true
    end

    it "should check if website name exists" do
      c = FactoryGirl.create(:input_collection, :url => "http://www.ap11.com", :website_name => "AP11")
      result = c.website_name_exists?
      result.should be_true
    end
  end
end
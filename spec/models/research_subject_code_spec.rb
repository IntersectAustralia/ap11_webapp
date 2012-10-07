require 'spec_helper'

describe ResearchSubjectCode do
  describe "Display name of research codes" do
    it "should return the code and the name separated by a hyphen" do
      rsc = FactoryGirl.create(:research_subject_code, :subject_code => "123456", :subject_name => "MyString")
      s = rsc.display_name
      s.should eq("123456 - MyString")
    end
  end
end

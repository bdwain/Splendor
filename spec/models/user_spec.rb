require 'spec_helper'

describe User do
  describe "displayname" do
    it { should validate_presence_of(:displayname) }
    it { should ensure_length_of(:displayname).is_at_least(3).is_at_most(20) }
  end

  #describe "players" do
  #  it { should have_many(:players) }
  #end
  
end


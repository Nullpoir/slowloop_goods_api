require 'rails_helper'

RSpec.describe Good, type: :model do
  describe 'Relation' do
    it { is_expected.to have_many :users }
  end
end

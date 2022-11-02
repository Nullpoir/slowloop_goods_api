require 'rails_helper'

RSpec.describe GoodUser, type: :model do
  describe 'Relation' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :good }
  end

  describe 'validations' do
    describe 'user_id' do
      context 'uniqueness' do
        subject { build :good_user }

        it do
          expect(subject).to validate_uniqueness_of(:user_id).ignoring_case_sensitivity
                                                             .scoped_to(:good_id)
        end
      end
    end
  end
end

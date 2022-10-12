require 'rails_helper'

RSpec.describe "Api::Admin::Goods", type: :request do
  let!(:login_user) { create :user, is_admin: true }
  let(:result) { JSON.parse(response.body) }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:not_logged_in_headers) { { 'Host' => 'example.com', 'Content-Type' => 'application/json' } }
  let(:user_logged_in_headers) { not_logged_in_headers.merge(user_token) }
  let(:invalid_user_logged_in_headers) { not_logged_in_headers.merge(invalid_user_token) }
  let(:user_token) { login_user.create_new_auth_token }

  describe '#index' do
    subject { get api_admin_goods_path, params: params, headers: request_headers }
    let!(:params) do
      {
        limit: nil,
        offset: nil,
        order_by: nil,
        direction: nil
      }
    end
    context '正常系' do
      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データ10件ある場合に' do
          let!(:created_number) { 10 }
          let!(:goods) { create_list :good, created_number}
          it 'データを全件返すこと' do
            subject
  
            is_expected.to eq 200
            expect(result["goods"].size).to eq created_number
          end

          context 'ソートをする場合に' do
            it 'id descでソートできること' do
              params[:order_by] = 'id'
              params[:direction] = 'desc'
  
              subject
    
              is_expected.to eq 200
              expect(result["goods"].size).to eq created_number
              expect(result["goods"].pluck('id')).to eq Good.order(id: :desc).pluck(:id)
            end
          end

          context '検索する場合に' do
            let!(:search_value) { goods.third.name }
            it '検索できること' do
              params[:"q[name_cont]"] = search_value

              is_expected.to eq 200
              expect(result["goods"].size).to eq Good.where('name LIKE ?', "%#{search_value}%").size
            end
          end
        end
      end
      context 'ログインしていない時' do
        let!(:request_headers) { not_logged_in_headers }
        let!(:created_number) { 10 }
        let!(:goods) { create_list :good, created_number}

        it '401になること' do
          subject

          is_expected.to eq 401
          expect(result["errors"].size).not_to eq nil
        end
      end
    end
    context '異常系' do
      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データ0件ある場合に' do
          let!(:created_number) { 0 }
          let!(:goods) { create_list :good, created_number}
          it 'データを0件返すこと' do
            subject
  
            is_expected.to eq 200
            expect(result["goods"].size).to eq created_number
          end
        end
        context 'ソートをする場合に' do
          let!(:created_number) { 10 }
          let!(:goods) { create_list :good, created_number }
          it '値がブランクの場合はid ascでソートされるること' do
            subject
  
            is_expected.to eq 200
            expect(result["goods"].size).to eq created_number
            expect(result["goods"].pluck('id')).to eq Good.order(id: :asc).pluck(:id)
          end
        end
      end
    end
  end
end

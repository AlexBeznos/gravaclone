describe API::V1::UsersController do
  describe 'GET #me' do
    let!(:user)        { create :user }
    let!(:application) { create :client_application } # OAuth application
    let!(:token)       { Doorkeeper::AccessToken.create application: application, resource_owner_id: user.id }

    it 'responds with 200' do
      get '/api/v1/users/me',
        :as => :json,
        :headers => { "Authorization" => "Bearer #{token.token}" }

      expect(response.status).to eq(200)
    end

    it 'returns the user as json' do
      get '/api/v1/users/me',
        :as => :json,
        :headers => { "Authorization" => "Bearer #{token.token}" }

      serializer = ActiveModelSerializers::SerializableResource.new(user)
      expect(response.body).to eq serializer.to_json
    end
  end

  describe 'GET #show' do
    let!(:user)        { create :user }
    let(:email)        { 'boo@u.com' }
    let(:email_base64) { Base64.urlsafe_encode64('boo@u.com') }
    let!(:new_user)    { create :user, email: email}
    let!(:application) { create :client_application } # OAuth application
    let!(:token)       { Doorkeeper::AccessToken.create application: application, resource_owner_id: user.id }

    it 'responds with 200' do
      get "/api/v1/users/#{email_base64}",
        :as => :json,
        :headers => { "Authorization" => "Bearer #{token.token}" }

      expect(response.status).to eq(200)
    end

    it 'returns the user as json' do
      get "/api/v1/users/#{email_base64}",
        :as => :json,
        :headers => { "Authorization" => "Bearer #{token.token}" }

      serializer = ActiveModelSerializers::SerializableResource.new(new_user)
      expect(response.body).to eq serializer.to_json
    end
  end
end

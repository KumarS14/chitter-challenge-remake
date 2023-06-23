require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  context "GET /" do
        it 'should allow me to show the signup page' do
            response = get('/signup')
            expect(response.status).to eq(200)
            expect(response.body).to include('<form action="/post-signup" method="POST">')

        end
        it 'should show me the peeps in reverse chronological order' do
            response = get('/peeps')
            response.status.to eq(200)


        end
    end
    context "POST /" do
        it 'Should tell the user that they have not entered in all boxes' do
            response = post("/post-signup")
            expect(response.status).to eq(404)
            expect(response.body).to eq('Signup unsuccessful')
        end    
       xit 'should tell me that the signup was successful' do
            response = post("/post-signup", email: 'signup@example.com', user_name: 'testuser1', password: 'testpassword')
            expect(response.status).to eq(200)
            expect(response.body).to eq("Signup successful")

        end


    end
end

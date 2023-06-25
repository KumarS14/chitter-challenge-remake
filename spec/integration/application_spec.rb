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
            expect(response.status).to eq(200)
            expect(response.body).to include('content2')


        end
        it 'should show the user a login page to enter the correct details' do
            response = get('/login-page')
            expect(response.status).to eq(200)
            expect(response.body).to include('<form action="/login" method="POST">')
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
            expect(response.status).to eq(302)
            expect(response.body).to eq("Signup successful")

        end
        it 'should allow the user to login and re-direct to peeps page' do
            response = post("/login", email: "email3@gmail.com", password: "password3")
            expect(response.status).to eq(302)
        end
        it 'should allow me to enter a incorrect invalid email or password and return a error message' do
            response = post("/login", email: "email3@gmail.com", password: "password3")
            expect(response.body).to eq('')
            expect(response.status).to eq(302)

        end

    end
end

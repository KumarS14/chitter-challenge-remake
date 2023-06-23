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
        expect(response.body).to include('<form action="post-signup" type="POST">')

    end
end
end

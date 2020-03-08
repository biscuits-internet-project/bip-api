require 'rails_helper'

RSpec.describe "MediaContents", type: :request do
  describe "GET /media_contents" do
    it "works! (now write some real specs)" do
      get media_contents_path
      expect(response).to have_http_status(200)
    end
  end
end

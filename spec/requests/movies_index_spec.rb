require 'rails_helper'

RSpec.describe "Movies index", type: :request do
  it "loads successfully" do
    get movies_path
    expect(response).to have_http_status(:ok)
  end
end

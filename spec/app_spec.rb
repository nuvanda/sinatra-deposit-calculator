require File.expand_path '../spec_helper.rb', __FILE__

describe "Test Application" do
  context "routes" do
    it "get root page" do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to include("Deposit Calculator")
    end

    context "post" do
      let(:valid_params) { { amount: "7707", rate: "134", start_date: "2020-03-15", term_length: "1", term_type: "years"} }

      context "valid parameters" do
        it "raise error" do
          post '/', valid_params

          expect(last_response).to be_ok
          expect(last_response.body).to include("7707", "134")
          expect(last_response.body).not_to include("інфляції")
        end
      end

      context "invalid parameters" do
        let(:invalid_params) { { amount: '', rate: '', start_date: '', term_length: '', term_type: ''} }

        it "raise error" do
          post '/', invalid_params

          expect(last_response).not_to be_ok
        end
      end

      context "inflation parameter" do

        it "raise error" do
          post '/', valid_params.merge(inflation_rate: "99")

          expect(last_response).to be_ok
          expect(last_response.body).to include("інфляції")
        end
      end
    end
  end
end

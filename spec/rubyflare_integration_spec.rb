describe 'integration' do
  describe Rubyflare, order: :defined do
    context 'given I have valid Cloudflare credentials' do
      let(:email)   { ENV['CLOUDFLARE_EMAIL'] }
      let(:api_key) { ENV['CLOUDFLARE_API_KEY'] }

      context 'when I create a Rubyflare instance' do
        let(:connection) { described_class.connect_with(email, api_key) }

        context 'and GET my Cloudflare user details' do

          it 'should return a valid response' do
            response = connection.get('user')
            expect(response).to be_successful
          end
        end

        context 'and update(PATCH) my user details' do

          it 'should return a valid response' do
            response = connection.patch('user', { first_name: 'Trevor' })
            expect(response).to be_successful
          end
        end

        context 'and create(POST) a new zone' do

          it 'should return a valid response' do
            response = connection.post('zones', { name: 'example.org' })
            expect(response).to be_successful
          end
        end

        context 'and remove(DELETE) a zone' do

          it 'should return a valid response' do
            domain_zone = connection.get('zones', { name: 'example.org' })
            response = connection.delete("zones/#{domain_zone.result[:id]}")
            expect(response).to be_successful
          end
        end
      end
    end
  end
end

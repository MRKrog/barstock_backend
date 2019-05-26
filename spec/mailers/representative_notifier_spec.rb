require 'rails_helper'

RSpec.describe RepresentativeNotifierMailer, type: :mailer do
  describe 'invite_email' do
    before(:each) do
      email_data = { items: [{ id: 1, name: 'Fireball', quantity: '4', price: '5.8' }, { id: 2, name: 'Jim Beam', quantity: '2', price: '20' }],
                     phone_number: 9_703_637_280,
                     name: 'The Basement',
                     address: '78295 US Highway 40 Winter Park, CO',
                     email: 'mike@thebasement.com',
                     rep_email: 'paul@gmail.com',
                     total_cost: '200' }

      @mail = RepresentativeNotifierMailer.send_order(email_data).deliver_now
    end

    it 'renders the subject' do
      expect(@mail.subject).to eq("The Basement's Order")
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eq(['paul@gmail.com'])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(['no-reply@barstock.com'])
    end

    it 'assigns delivery location' do
      expect(@mail.body.encoded).to match('The Basement')
      expect(@mail.body.encoded).to match('78295 US Highway 40 Winter Park, CO')
    end

    it 'assigns order details' do
      expect(@mail.body.encoded).to match('Fireball')
      expect(@mail.body.encoded).to match('4')
      expect(@mail.body.encoded).to match('5.8')
      expect(@mail.body.encoded).to match('Jim Beam')
      expect(@mail.body.encoded).to match('2')
      expect(@mail.body.encoded).to match('20')
      expect(@mail.body.encoded).to match('200')
    end

    it 'assigns delivery contact info' do
      expect(@mail.body.encoded).to match('mike@thebasement.com')
      expect(@mail.body.encoded).to match('9703637280')
    end
  end
end

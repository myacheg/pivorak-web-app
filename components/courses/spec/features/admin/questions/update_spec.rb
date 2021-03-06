require 'rails_helper'

RSpec.describe 'Question UPDATE' do
  let!(:season)                 { create(:season, title: 'Test Season', status: :planned) }
  let!(:user)                   { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:question)               { create(:question, season: season) }
  let!(:season_creator)         { ::Courses::Mentor.create(user: user, season: season) }
  let(:test_questions_path)     { '/admin/courses/seasons/test-season/questions' }
  let(:test_edit_question_path) { '/admin/courses/seasons/test-season/questions/1/edit' }

  before { visit test_edit_question_path }

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Body',  with: ''
      click_button 'Update Question'

      expect_an_error question_body: :blank
    end
  end

  context 'valid input' do
    it 'update question' do
      fill_in 'Body',  with: 'Awesome Question'
      click_button 'Update Question'

      expect(page).to have_current_path test_questions_path
      expect(page).to have_content 'Awesome Question'
    end
  end
end

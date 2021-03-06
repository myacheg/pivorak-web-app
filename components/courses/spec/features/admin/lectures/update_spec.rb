require 'rails_helper'

RSpec.describe 'Lecture UPDATE' do
  let!(:season)  { create(:season, title: 'Test Season', status: :live) }
  let!(:user)    { create(:user) }
  let!(:venue)   { create(:venue) }
  let!(:mentor)  { ::Courses::Mentor.create(user: user, season: season) }
  let!(:lecture) { create(:lecture, title: 'Awesome lecture', mentor: mentor, venue_id: 1, season: season) }

  before { visit "/admin/courses/seasons/test-season/lectures/awesome-lecture/edit" }

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Update Lecture'

      expect_an_error lecture_title: :blank
    end
  end

  context 'valid input' do
    it 'update season' do
      fill_in 'Title',  with: 'Super Lecture'
      click_button 'Update Lecture'

      expect(page).to have_current_path '/admin/courses/seasons/test-season/lectures'
      expect(page).to have_content 'Super Lecture'
    end
  end
end

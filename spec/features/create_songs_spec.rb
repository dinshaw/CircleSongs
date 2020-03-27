RSpec.feature 'As an admin user' do
  let(:user) { users(:admin) }
  let(:title) { FFaker::Music.song }
  let(:description) { FFaker::Lorem.paragraphs.join("\n") }
  let(:alternate_title) { FFaker::Music.song }
  let(:composer) { FFaker::Music.song }
  let(:composer_url) { FFaker::Internet.http_url }
  let(:lyrics) { FFaker::Music.song }
  let(:underlined_lyric) { "This <u>lyric</u> is underlined." }
  let(:translation) { FFaker::Music.song }
  let(:underlined_translation) { "This <u>translation</u> is underlined." }
  let(:chords) { 'Swing [D]low, sweet [G]chari[D]ot' }
  let(:formatted_chords) { 'Swing low, sweet chariot' }

  before do
    login
    visit admin_songs_path
  end

  scenario 'I can create a Song', :chrome do
    click_on 'New Song'
    fill_in 'Title', with: title
    fill_in 'Alternate title', with: alternate_title
    fill_in 'Composer', with: composer
    fill_in 'Composer url', with: composer_url
    fill_in 'Lyrics', with: lyrics
    fill_in 'Translation', with: translation
    fill_in 'Chords', with: chords
    fill_in 'Description', with: description
    check 'Traditional'
    check 'English'
    check 'Spanish'
    click_on 'Create Song'
    expect(page).to have_content 'Song was successfully created.'
    expect(page).to have_content title
    expect(page).to have_content alternate_title
    expect(page).to have_link(composer, href: composer_url)
    expect(page).to have_content lyrics
    expect(page).to have_content translation
    expect(page).to have_content description
    expect(page).to have_content 'Traditional'
    expect(page).to have_content 'English and Spanish'
    expect(page).not_to have_content chords
    expect(page).to have_content formatted_chords
  end

  scenario 'I can underline text in Song#lyrics and Song#translation' do
    click_on 'New Song'
    fill_in 'Title', with: title
    fill_in 'Lyrics', with: underlined_lyric
    fill_in 'Translation', with: underlined_translation
    click_on 'Create Song'
    within '.row-lyrics' do
      expect(page).to have_selector 'u'
    end
    within '.row-translation' do
      expect(page).to have_selector 'u'
    end
    visit songs_path
    click_on title
    within '.lyrics' do
      expect(page).to have_selector 'u'
    end
    within '.translation' do
      expect(page).to have_selector 'u'
    end
  end
end

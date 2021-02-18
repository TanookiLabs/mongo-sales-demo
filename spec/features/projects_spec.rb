RSpec.describe 'Projects', js: true do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  before(:each) { signin(user.email, user.password) }

  scenario 'moving to new screen updates select dropdown' do
    screens = create_list(:screen, 3, project: project)
    screens[0].update(root: true)
    create(:screen_link, screen: screens[0], destination_screen: screens[1])
    visit project_path(project)
    new_window = window_opened_by { click_on 'Launch (no session)' }
    expect(page).to have_select('screen', selected: project.root_screen.title)
    within_window new_window do
      find('a', visible: false).click
    end
    expect(page).to have_select('screen', selected: screens[1].title)
  end
end

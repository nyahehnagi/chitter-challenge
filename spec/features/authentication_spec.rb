feature 'authentication' do
  it 'a user can sign in' do
    create_test_user
    # sessions is a RESTful resource - This is standard for signing-in
    visit_sessions_new_and_sign_in(
      email: 'test@example.com', password: 'password123'
    )

    expect(page).to have_content 'Welcome, test@example.com'
  end

  scenario 'a user sees an error if they get their email wrong' do
    create_test_user

    visit_sessions_new_and_sign_in(
      email: 'nottherightemail@me.com', password: 'password123'
    )

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their password wrong' do
    create_test_user

    visit_sessions_new_and_sign_in(
      email: 'test@example.com', password: 'wrongpassword'
    )

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user can sign out' do
    create_test_user

    visit_sessions_new_and_sign_in(
      email: 'test@example.com', password: 'password123'
    )

    click_button('Sign out')

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'You have signed out.'
  end

end
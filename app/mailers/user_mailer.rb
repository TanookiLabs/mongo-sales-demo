class UserMailer < ApplicationMailer
  def session_notes(demo_session)
    @demo_session = demo_session
    mail(to: demo_session.user.email, subject: "Sales Session Report - #{demo_session.title} - #{demo_session.created_at.strftime('%Y-%m-%d')}")
  end
end

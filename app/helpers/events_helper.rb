module EventsHelper
  def setup_user(user, event)
    (event.meetup_profiles.all - user.noted).each do |profile|
      user.notes.build(about: profile)
    end
    return user
  end
end

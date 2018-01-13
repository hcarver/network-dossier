require 'rmeetup_override'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def meetup
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    omniauth_data = request.env["omniauth.auth"]
    meetup_profile = MeetupProfile.find_by_id(omniauth_data["uid"])
    if not meetup_profile then
      meetup_profile = MeetupProfile.new
      meetup_profile.id = omniauth_data["uid"]
    end

    # Fill in data
    meetup_profile.name = omniauth_data["info"]["name"]
    meetup_profile.photo_url = omniauth_data["info"]["photo_url"]
    meetup_profile.access_token = omniauth_data["credentials"]["token"]
    meetup_profile.refresh_token = omniauth_data["credentials"]["refresh_token"]
    meetup_profile.access_expiration = omniauth_data["credentials"]["expires_at"]
    meetup_profile.other_services = omniauth_data["extra"]["raw_info"]["other_services"].to_s
    meetup_profile.save!

    @user = User.find_by_meetup_profile_id(meetup_profile.id)
    unless @user then
      @user = User.new
      @user.meetup_profile = meetup_profile
      @user.save!
    end

    results = RMeetup::Client.fetch(:events, {member_id: meetup_profile.id, access_token: meetup_profile.access_token, status: 'past,upcoming', rsvp: 'yes'})
    results.each do |result|
      event = Event.find_by_meetup_id(result.event['id'])
      if not event then
        event = Event.new
        event.meetup_id = result.event['id']
      end
      event.name = result.event['name']
      event.group_name = result.event['group']['name']
      event.venue_name = result.event['venue']['name']
      event.time = Time.at(result.event['time'].to_i / 1000)
      event.meetup_url = result.event['event_url']
      event.save!

      rsvps = RMeetup::Client.fetch(:rsvps, {event_id: event.meetup_id, access_token: meetup_profile.access_token, rsvp: 'yes'})
      rsvps.each do |rsvp|
        profile = MeetupProfile.find_by_id(rsvp.member['member_id'])
        profile = MeetupProfile.new(id: rsvp.member['member_id']) unless profile

        profile.name = rsvp.member['name']
        profile.photo_url = rsvp.member_photo['photo_link'] if rsvp.member_photo
        profile.save()

        event.attendances.find_or_create_by(meetup_profile_id: profile.id)
      end
    end

    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Meetup") if is_navigational_format?
  end
end

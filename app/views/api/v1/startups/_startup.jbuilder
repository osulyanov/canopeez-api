json.id startup.id
json.category_id startup.category_id
json.name startup.name
json.logo_url startup.logo_url
json.description startup.description
json.pitch startup.pitch
json.twitter_url startup.twitter_url
json.facebook_url startup.facebook_url
json.google_url startup.google_url
json.linkedin_url startup.linkedin_url
json.youtube_url startup.youtube_url
json.instagram_url startup.instagram_url
json.crowdfunding_url startup.crowdfunding_url
json.partner_ids startup.partner_ids
json.reference_ids startup.reference_ids
json.founder_ids startup.founder_ids

if user_signed_in? && current_user.id != startup.user_id
  json.favorite startup.in_favorites?(current_user)
  json.subscribed startup.in_subscriptions?(current_user)
  json.attachments startup.comments do |comment|
    json.text comment.comment
    json.user_name comment.user.display_name
  end
end

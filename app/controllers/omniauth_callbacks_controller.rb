class OmniauthCallbacksController < ApplicationController
  def twitter
    Rails.logger.info auth
    username = auth.info.nickname
    twitter_account = Current.user.twitter_accounts.find_or_initialize_by(username: username)

    twitter_account.assign_attributes(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )

    if twitter_account.save(validate: false)
      redirect_to twitter_accounts_path, notice: "Successfully connected Twitter"
    else
      Rails.logger.error twitter_account.errors.full_messages.to_sentence
      redirect_to root_path, alert: "Failed to connect Twitter: #{twitter_account.errors.full_messages.to_sentence}"
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end

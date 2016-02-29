# Default strategy for signing in a user, based on remote user attribute in headers.
module Behaviors
  module HttpHeaderAuthenticatableBehavior

    # Called if the user doesn't already have a rails session cookie
    def valid_user?(headers)
      remote_user = remote_user(headers)
      !remote_user.blank? and remote_user != '(null)'
    end

    protected

    # Remote user is coming back from cosign as uniquename.
    # Append @umich.edu to this value to satisfy user model validations
    def remote_user(headers)
      return "#{headers['HTTP_X_REMOTE_USER']}@umich.edu" if headers['HTTP_X_REMOTE_USER']
      return nil
    end

  end
end

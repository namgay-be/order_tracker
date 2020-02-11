module DeviseSanitizer
  def configure_permitted_parameters
    sanitize_invitation_params
    sanitize_accept_invitation_params
  end

  private

  def sanitize_invitation_params
    devise_parameter_sanitizer.permit(
      :invite,
      keys: %i[
        email
        role_id
      ]
    )
  end

  def sanitize_accept_invitation_params
    devise_parameter_sanitizer.permit(
      :accept_invitation,
      keys: %i[
        password
        password_confirmation
        invitation_token
        name
        username
        phone
        designation
        image
      ]
    )
  end
end

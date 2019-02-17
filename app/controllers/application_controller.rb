class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = locale
  end

  def locale
    @locale ||= (params[:locale] ||
      http_accept_language.compatible_language_from(I18n.available_locales) ||
      I18n.default_locale)
  end

  def default_url_options
    return {} if params[:locale].blank?
    { locale: locale }
  end
end

require 'bundler'
Bundler.require

require 'json'

class Application < Sinatra::Base
  register Padrino::Mailer

  configure do
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path = Dir[File.join(settings.root, 'config', 'locales', '*.yml')]
    I18n.backend.load_translations
  end

  before '/:locale/*' do
    I18n.locale = params[:locale]
    request.path_info = '/' + params[:splat][0]
  end

  set :delivery_method, ENV['DELIVERY_METHOD'] || 'smtp' => {
    address: ENV['SMTP_HOST'] || 'localhost',
    port: ENV['SMTP_PORT'] || 25,
    user_name: ENV['SMTP_USERNAME'] || ENV['SENDGRID_USERNAME'],
    password: ENV['SMTP_PASSWORD'] || ENV['SENDGRID_PASSWORD'],
    authentication: ENV['SMTP_AUTHENTICATION'] || 'plain',
    enable_starttls_auto: ENV['SMTP_ENABLE_STARTTLS_AUTO'] != 'false'
  }

  get '/' do
    'Running mailform-action'
  end

  post '/' do
    logger.info 'HTTP Request: ' + params.inspect
    ref_url = request.referer || params['_url']
    forms = JSON.parse(ENV['FORMS'])
    forms.each do |key, value|
      if ref_url.index(key) == 0
        @url = key
        @mailaddrs = value
      end
    end
    if !ENV['SPAM_FILTER'].to_s.empty? &&
        params.values.select {|value| value.match(ENV['SPAM_FILTER']) }.any?
      logger.error 'Matched spam filter'
      @title = I18n.t(:send_failure)
      slim :failure
    elsif ! @url
      logger.error 'URL not registerd'
      @title = I18n.t(:send_failure)
      slim :failure
    else
      @mailaddrs.each do |mailaddr|
        email(
          from: ENV['MAIL_FROM'] || 'no-replay@example.com',
          to: mailaddr,
          subject: '[Contact] ' + URI.parse(@url).host,
          locals: { url: @url, params: params },
          render: :contact
        )
      end
      @title = I18n.t(:send_success)
      slim :success
    end
  end

end

ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      'raghavan.kandala@gmail.com',
    :password =>       'e18485db-3536-4821-8d80-38de90eb0dbf',
    :domain =>         'heroku.com',
    :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp

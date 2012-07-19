
  ActionMailer::Base.smtp_settings = {
	:address        => 'smtp.sendgrid.net',
	:port           => '587',
	:authentication => :plain,
	:user_name      => 'app5739932@heroku.com',
	:password       => '4ambbtc2',
	:domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp
SimpleCaptcha.setup do |sc|
  sc.tmp_path = '/tmp' # or somewhere in project eg. Rails.root.join('tmp/simple_captcha').to_s, make shure directory exists
end

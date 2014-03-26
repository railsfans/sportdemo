class Notifier < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_user.subject
  #
 default :from => "foobar@example.org"  

    def confirm(email, passwordtoken)
        @message = "Thank you for confirmation!"
        @username=Login.find(Student.where(:email=>email).first.login_id).username
        @passwordtoken=passwordtoken
        attachments["rails.png"]=File.read(Rails.root.join("app/assets/images/rails.png"))
        mail(:to => email, :subject => "reset password") 
    end  
end

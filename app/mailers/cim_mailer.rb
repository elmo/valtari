class CimMailer < ActionMailer::Base
  default from: 'support@valtariexchange.com'
  layout false

  def invitation(user:, cim:)
   headers "X-SMTPAPI" => {
      sub: {
        "%invited_user%" => [user.email],
        "%password%" => [cim.password_for_email(email: user.email)],
        "%cim_or_pitch_book%" => ["CIM"],
        "%url%" => [cim.short_url]
    },
   filters: {
     "templates": {
       "settings": {
         "enable": 1,
           "template_id": 'bf2f1382-d317-4c99-94f6-780f0bea2b17'
          }
        }
      }
    }.to_json
    mail(to: user.email, subject: "You have been invited to view a presentation on Valtari Exchange")
  end


end

class DealRoomMailer < ActionMailer::Base
  default from: 'info@valtariexchange.com'
  layout false

  def invitation(user:, deal_room:)
    @user = user
    @deal_room = deal_room
    mail(to: user.email, subject: "You have been invited to a Deal Room on Valtari Exchange")
  end

end

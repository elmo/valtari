module VerificationsHelper

  def verification_statues
    [
      Verification::STATUS_NEW,
      Verification::STATUS_PENDING,
      Verification::STATUS_COMPLETE
    ]
  end

end

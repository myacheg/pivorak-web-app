class InviteByEmailForm
  include ActiveModel::Model
  attr_accessor :email

  DELIMITER = ','

  validates :email,
            presence: true,
            format: {with: Devise.email_regexp, message: 'example:  john@gmail.com'}, unless: :email_is_list?
  validate :emails_are_valid, if: :email_is_list?

  private

  def emails_are_valid
    invalid_emails = emails.select do |email|
      !InviteByEmailForm.new(email: email.strip).valid?
    end

    return if invalid_emails.empty?

    errors.add(:email, "Following emails are invalid: #{invalid_emails.join(DELIMITER)}")
  end

  def emails
    email.split(DELIMITER).reject(&:blank?)
  end

  def email_is_list?
    return false if email.blank?

    email.include?(DELIMITER)
  end
end

class Message < ApplicationRecord
  belongs_to :user

  enum state: {
    hidden: 0,
    shared: 1
  }

  after_initialize :set_default_enum, if: :new_record?

  after_commit do
    MessageRelayJob.perform_later(self)
    PublicMessageRelayJob.perform_later(self) unless hidden?
  end

  private

  def set_default_enum
    self.state ||= :shared
  end
end

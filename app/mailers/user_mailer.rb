class UserMailer < ActionMailer::Base
  add_template_helper ApplicationHelper

  default from: 'Leave Tracker | Nascenia <no-reply@nascenia.com>'

  layout 'notification'

  def send_leave_application_notification(leave, email)
    @leave = leave
    @user = @leave.user
    @email = email

    mail to: @email, subject: "#{@user.name} has applied for a leave"
  end

  def send_approval_or_rejection_notification(leave)
    @leave = leave
    @user = @leave.user

    if @leave.is_accepted?
      subject = 'Leave Approved'
      @title = 'Your leave application has just been approved.'
      @greetings = '- Enjoy your vacation!'
    elsif @leave.is_rejected?
      subject = 'Leave Rejected'
      @title = 'Your leave application has just been rejected.'
      @greetings = '- Better luck next time!'
    end

    mail to: @user.email, subject: subject
  end

  def send_unannounced_leave_notification(leave)
    @leave = leave
    @user = @leave.user
    subject = 'Unannounced leave'
    @greetings = '- Have a nice day!'

    mail to: 'nafiz@nascenia.com', subject: subject
  end
end

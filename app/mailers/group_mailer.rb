class GroupMailer < ApplicationMailer
  default from: ENV['KEY']
  layout 'mailer'
  def send_mail(mail_title,mail_content,group_users) #メソッドに対して引数を設定
    @mail_title = mail_title
    @mail_content = mail_content
    mail bcc: group_users.pluck(:email), subject: mail_title #送信先の設定
  end
end

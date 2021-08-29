;;; mail.el -*- lexical-binding: t; -*-

(set-email-account! "posteo"
  '((mu4e-sent-folder       . "/mailbox/posteoSent")
    (mu4e-drafts-folder     . "/mailbox/posteoDrafts")
    (mu4e-trash-folder      . "/mailbox/posteoTrash")
    ;; (mu4e-refile-folder     . "/posteo/All Mail")
    (smtpmail-smtp-user     . "mail")
    (mu4e-compose-signature . "---\nname"))
  t)

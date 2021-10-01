;;; mail.el -*- lexical-binding: t; -*-

(set-email-account! "posteo"
  '((mu4e-sent-folder       . "/posteo/Sent")
    (mu4e-drafts-folder     . "/posteo/Drafts")
    (mu4e-trash-folder      . "/posteo/Trash")
    ;; (mu4e-refile-folder     . "/posteo/All Mail")
    (smtpmail-smtp-user     . "mail")
    (mu4e-compose-signature . "---\nname"))
  t)

(set-email-account! "uni"
  '((mu4e-sent-folder       . "/uni/Sent")
    (mu4e-drafts-folder     . "/uni/Entw&APw-rfe")
    (mu4e-trash-folder      . "/uni/Trash")
    ;; (mu4e-refile-folder     . "/uni/All Mail")
    (smtpmail-smtp-user     . "unilmail")
    (mu4e-compose-signature . "---\nname"))
  t)

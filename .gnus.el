(setq nntp-maximum-request 3)
(setq nntp-connection-timeout 3)
(setq nntp-maximum-request 100)
(setq nntp-warn-about-losing-connection t)
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-root "")
(setq gnus-sum-thread-tree-single-indent "")
(setq gnus-sum-thread-tree-leaf-with-other "+-> ")
(setq gnus-sum-thread-tree-vertical "|")
(setq gnus-sum-thread-tree-single-leaf "`-> ")
(setq gnus-select-method '(nnnil ""))

(setq gnus-posting-styles
      '( (message-news-p) (address "rlonstein+usenet@pobox.com")))

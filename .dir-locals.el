;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((org-mode . ((eval . (progn
                        (setq-local org-download-image-dir
                                    (expand-file-name "./static/images"
                                                      (file-name-directory buffer-file-name))
                                    org-download-link-format-function
                                    (lambda
                                      (filename)
                                      (format "[[/images/%s]]"
                                              (file-name-nondirectory filename)))))))))

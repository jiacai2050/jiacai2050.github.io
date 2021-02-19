((org-mode . ((eval .
                    (progn
                      (setq-local org-download-image-dir (expand-file-name "./static/images" (file-name-directory buffer-file-name))

                                  org-download-link-format-function (lambda (filename)
                                                                      (format "[[/images/%s]]" (file-name-nondirectory filename))))
                      ;; (make-local-variable 'org-link-parameters)
                      ;; (org-link-set-parameters
                      ;;  "file"
                      ;;  :follow (lambda (path)
                      ;;            (let (newpath (expand-file-name path "/tmp"))
                      ;;              (message "newpath %s" newpath))
                      ;;            newpath
		              ;;            ))
                      )
                    ))))

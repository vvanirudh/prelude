(defvar ddavis-clangd-exe (executable-find "clangd")
  "clangd executable path")

(defun dd/projectile-proj-find-function (dir)
  (let ((root (projectile-project-root dir)))
    (and root (cons 'transient root))))

(require 'eglot)

(defun dd/cpp-eglot-enable ()
  "enable variables and hooks for eglot cpp IDE"
  (interactive)
  (setq company-backends
        (cons 'company-capf
              (remove 'company-capf company-backends)))
  (with-eval-after-load 'project
    (add-to-list 'project-find-functions
                 'dd/projectile-proj-find-function))
  (add-to-list 'eglot-server-programs
               `((c++-mode) ,ddavis-clangd-exe))
  (add-hook 'c++-mode-hook 'eglot-ensure))

(defun dd/cpp-eglot-disable ()
  "disable hook for eglot"
  (interactive)
  (remove-hook 'c++-mode-hook 'eglot-ensure))


(defun vdesk ()
  (interactive)
  (dired "/ssh:avemula@avemula.vdesk.cloud.aurora.tech:~/Developer/av/"))

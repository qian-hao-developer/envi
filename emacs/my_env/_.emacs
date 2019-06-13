(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" "a5956ec25b719bf325e847864e16578c61d8af3e8a3d95f60f9040d02497e408" "cd4d1a0656fee24dc062b997f54d6f9b7da8f6dc8053ac858f15820f9a04a679" default)))
 '(package-selected-packages (quote (gruvbox-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load color theme when startup
(load-theme 'gruvbox-dark-medium t)

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;; startup customize
(setq initial-frame-alist
    (append (list
            ;; startup frame position
                    '(top . 0)
                            '(left . 1060)
                                    ;; size
                                            '(width . 120)
                                                    '(height . 60)
                                                        )
    initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

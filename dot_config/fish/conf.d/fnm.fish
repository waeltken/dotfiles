{{ if or (eq .chezmoi.os "darwin") (ne .chezmoi.arch "arm64") -}}
fnm env --use-on-cd --shell fish | source
{{ end -}}


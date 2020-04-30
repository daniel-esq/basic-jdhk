{{/* vim: set filetype=mustache: */}}

{{- define "appVersion" -}}
{{- $appVersion := default .Chart.AppVersion .Values.shortHash -}}
{{- $list := $appVersion | splitList "-" -}}
{{- $length := len $list -}}
{{- $lastIndex := add $length -1 -}}
{{- $shortHash := index $list $lastIndex -}}
{{- printf "%s" $shortHash -}}
{{- end -}}

{{- define "PROXY_BODY_SIZE" -}}
{{- default "15m" .Values.global.PROXY_BODY_SIZE | quote -}}
{{- end -}}

{{- define "PROXY_BUFFER_NUMBER" -}}
{{- default "4" .Values.global.PROXY_BUFFER_NUMBER | quote -}}
{{- end -}}

{{- define "PROXY_BUFFER_SIZE" -}}
{{- default "16k" .Values.global.PROXY_BUFFER_SIZE | quote -}}
{{- end -}}

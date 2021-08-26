{{/*
Return the proper baremetalOperator image name
*/}}
{{- define "baremetalOperator.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.baremetalOperator.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "baremetalOperator.kubeRBACProxy.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.kubeRBACProxy.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "baremetalOperator.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.baremetalOperator.image .Values.kubeRBACProxy.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "baremetalOperator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (printf "%s" (include "common.names.fullname" .)) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}



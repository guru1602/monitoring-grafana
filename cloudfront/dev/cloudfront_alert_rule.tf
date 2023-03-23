# provider "grafana" {
#   alias = "alert_source"
#   url   = var.grafana_url
#   auth  = var.grafana_api_key
# }

# resource "grafana_rule_group" "my_rule_group" {
#       provider         = grafana.alert_source
#       folder_uid       = grafana_folder.test.uid
#       interval_seconds = 120
#       name             = "Dev Cloudfront Alert for 5xxErrorRate"
#       org_id           = 2
#       rule {
#           condition      = "C"
#           exec_err_state = "Error"
#           for            = "5m"
#           name           = "Dev Cloudfront Alert for 5xxErrorRate"
#           no_data_state  = "NoData"
#           labels         = {
#             namespace = "dev cloudfront" 
#            }  
#           annotations = {
#             dashboardUid = grafana_dashboard.metrics.uid
#             panelId      = "2"
#           }
#           data {
#               ref_id         = "A"
#               query_type      = ""
#               relative_time_range {
#                   from = 600
#                   to   = 0
#               }
#               datasource_uid = grafana_data_source.cloudwatch.uid
#               model = jsonencode( {
#                       alias         = "" 
#                       datasource    = {
#                         type = "cloudwatch"
#                         uid  = grafana_data_source.cloudwatch.uid
#                       }
#                       dimensions    = {
#                           DistributionId = ["*"]
#                         }
#                       expression       = "SEARCH('$DistributionId)"
#                       id               = ""
#                       intervalMs       = 1000
#                       label            = ""
#                       matchExact       = false
#                       maxDataPoints    = 43200
#                       metricEditorMode = 0
#                       metricName       = "5xxErrorRate"
#                       metricQueryType  = 0
#                       namespace        = "AWS/CloudFront"
#                       period           = ""
#                       queryMode        = "Metrics"
#                       refId            = "A"
#                       region           = "us-east-1"
#                       sqlExpression    = ""
#                       statistic        = "Maximum"
#                     }
#                 )
#           }
#           data {
#               ref_id         = "B"
#               relative_time_range {
#                   from = 600
#                   to   = 0
#                 }
#               datasource_uid = "-100"
#               model          = jsonencode(
#                     {
#                       conditions    = [
#                            {
#                               evaluator = {
#                                   params = []
#                                   type   = "gt"
#                                 }
#                               operator  = {
#                                   type = "and"
#                                 }
#                               query     = {
#                                   params = ["B"]
#                                 }
#                               reducer   = {
#                                   params = []
#                                   type   = "last"
#                                 }
#                               type      = "query"
#                             },
#                         ]
#                       datasource    = {
#                           type = "__expr__"
#                           uid  = "-100"
#                         }
#                       expression    = "A"
#                       hide          = false
#                       intervalMs    = 1000
#                       maxDataPoints = 43200
#                       reducer       = "count"
#                       refId         = "B"
#                       type          = "reduce"
#                     }
#                 )
#           }
#           data {
#               ref_id         = "C"
#               relative_time_range {
#                   from = 600
#                   to   = 0
#                 }
#               datasource_uid = "-100"
#               model          = jsonencode(
#                     {
#                       conditions    = [
#                            {
#                               evaluator = {
#                                     params = [100]
#                                     type   = "gt"
#                                 }
#                               operator  = {
#                                    type = "and"
#                                 }
#                               query     = {
#                                    params = ["C"]
#                                 }
#                               reducer   = {
#                                   params = []
#                                   type   = "last"
#                                 }
#                               type      = "query"
#                             },
#                         ]
#                       datasource  = {
#                            type = "__expr__"
#                            uid  = "-100"
#                         }
#                       expression    = "B"
#                       hide          = false
#                       intervalMs    = 1000
#                       maxDataPoints = 43200
#                       refId         = "C"
#                       type          = "threshold"
#                     }
#                 )
#           }
#         }
#     }

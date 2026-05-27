output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "uuid" {
  description = "UUID of the event source mapping"
  value       = try(aws_lambda_event_source_mapping.this[0].uuid, null)
}

output "state" {
  description = "State of the event source mapping"
  value       = try(aws_lambda_event_source_mapping.this[0].state, null)
}

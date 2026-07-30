resource "aws_lambda_event_source_mapping" "this" {
  count = module.this.enabled ? 1 : 0

  event_source_arn        = var.event_source_arn
  function_name           = var.function_name
  batch_size              = var.batch_size
  enabled                 = var.mapping_enabled
  starting_position       = var.starting_position
  function_response_types = length(var.function_response_types) > 0 ? var.function_response_types : null
}

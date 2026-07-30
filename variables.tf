variable "event_source_arn" {
  description = "ARN of the event source (SQS, DynamoDB, Kinesis)"
  type        = string
  validation {
    condition     = length(var.event_source_arn) > 0
    error_message = "event_source_arn must not be empty."
  }
}

variable "function_name" {
  description = "Name or ARN of the Lambda function"
  type        = string
  validation {
    condition     = length(var.function_name) > 0
    error_message = "function_name must not be empty."
  }
}

variable "batch_size" {
  description = "Maximum number of records per batch"
  type        = number
  default     = 10
}

variable "mapping_enabled" {
  description = "Whether the event source mapping is enabled"
  type        = bool
  default     = true
}

variable "starting_position" {
  description = "Starting position for stream-based sources (LATEST, TRIM_HORIZON)"
  type        = string
  default     = null
}

variable "function_response_types" {
  description = "Response types the Lambda returns to the event source. Set to [\"ReportBatchItemFailures\"] on an SQS mapping so the function can report per-message failures and only failed messages are redelivered instead of the whole batch. Default [] preserves prior behaviour (argument omitted from the resource)."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.function_response_types) <= 1 && alltrue([for v in var.function_response_types : v == "ReportBatchItemFailures"])
    error_message = "function_response_types must be either [] or [\"ReportBatchItemFailures\"] (the only value AWS accepts)."
  }
}

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

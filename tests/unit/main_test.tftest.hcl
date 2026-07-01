# Unit Tests for tf-atom-lambda-event-source-mapping-aws
#
# These tests use a mock provider — no real AWS calls are made.
# Run with:        terraform test -test-directory=tests/unit
# Run verbose:     terraform test -test-directory=tests/unit -verbose
# Run specific:    terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# NOTE: Assertions target plan-KNOWN values only (the enabled flag and
# input pass-throughs). Computed attributes such as uuid/state are unknown
# under a mock provider and are therefore NOT asserted at plan time.

mock_provider "aws" {}

variables {
  # tf-label context inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Module's own required inputs (valid sample values)
  event_source_arn = "arn:aws:sqs:us-east-1:123456789012:eg-test-thing-queue"
  function_name    = "arn:aws:lambda:us-east-1:123456789012:function:eg-test-thing-fn"
}

# ---------------------------------------------------------------------------
# Test: Module creates the event source mapping when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output must be true when the module is enabled"
  }

  assert {
    condition     = length(aws_lambda_event_source_mapping.this) == 1
    error_message = "Exactly one aws_lambda_event_source_mapping must be planned when enabled"
  }

  assert {
    condition     = aws_lambda_event_source_mapping.this[0].event_source_arn == "arn:aws:sqs:us-east-1:123456789012:eg-test-thing-queue"
    error_message = "event_source_arn must be passed through to the resource unchanged"
  }
}

# ---------------------------------------------------------------------------
# Test: Module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output must be false when enabled = false"
  }

  assert {
    condition     = length(aws_lambda_event_source_mapping.this) == 0
    error_message = "No event source mapping must be planned when enabled = false"
  }

  assert {
    condition     = output.uuid == null
    error_message = "uuid output must be null when the module creates nothing"
  }
}

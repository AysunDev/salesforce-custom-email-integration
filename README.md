# Salesforce Custom Email Integration (HTTP Callout)

This project demonstrates how to send custom outbound emails from Salesforce
using an external email service via HTTP callout. It includes a trigger,
handler, request wrapper, configuration via Custom Metadata, and logging
into a custom object.

## Features

- When a new Contact is created, the system can:
  - (Optionally) verify the email
  - Send a custom notification email to the Contact
- Email content (subject, body, recipients) is built in Apex
- Endpoint URL and token are stored in Custom Metadata (no hard-coded URLs)
- All success / error messages from the external service are logged

## Technical Components

| Component                         | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| `CustomEmail.cls`                | Main Apex class that performs the HTTP POST callout to the external email API |
| `CustomEmailRequest.cls`        | Wrapper class used to build the JSON request body           |
| `CustomEmailUtility.cls`        | Reads configuration (endpoint, token, logo URL) from `CustomEmail_Config__mdt` |
| `CustomEmailTester.cls`         | Helper / test class used to manually trigger email sending   |
| `ContactTrigger.trigger`        | After Insert / After Update trigger on Contact               |
| `ContactTriggerHandler.cls`     | Trigger handler that runs email verification and sends notification emails |
| `ProcessLogsHelper.cls`         | Utility class that writes success and error logs into `Process_Log__c` (custom object) |

## How It Works

1. A new Contact record is created in Salesforce.
2. The `ContactTrigger` fires (after insert).
3. `ContactTriggerHandler`:
   - Optionally verifies the email address
   - Calls `CustomEmail.sendSingleEmailWithoutAttachmentFuture(...)`
4. `CustomEmail`:
   - Builds a `CustomEmailRequest` object (recipients, subject, body, attachments if needed)
   - Serializes it to JSON
   - Reads the endpoint URL and token from `CustomEmail_Config__mdt`
   - Performs an HTTP POST callout to the external email API
5. The external service sends the email and returns a response.
6. `ProcessLogsHelper` stores:
   - Status code
   - Response body
   - Error messages (if any)
   - A flag that indicates whether it was an error or success

## Configuration

1. Create a Custom Metadata record for `CustomEmail_Config__mdt`:
   - `Endpoint__c` – base URL of the external email service
   - `Token__c` – API token or key (used as query parameter or header)
   - `Logo__c` – optional logo URL to be included in the email
2. Make sure the callout domain is added as a Remote Site Setting (or Named Credential, depending on the version).
3. Deploy all Apex classes, trigger, and custom object / metadata to your org.
4. (Optional) Update the trigger / handler logic to match your own business rules.

## Usage

- Create or update a Contact with a valid email address.
- The trigger runs and, if conditions are met, an email is sent through the external email service.
- Check the `Process_Log__c` records to see:
  - request/response information
  - success or error status
  - detailed error messages if something went wrong.

## Notes

- The integration is provider-agnostic: you can plug in any email service
  (Twilio, Mailgun, a custom microservice, etc.) by changing the endpoint
  and token in `CustomEmail_Config__mdt`.
- Callouts are executed in a `@future(callout=true)` method to avoid
  blocking the main transaction and to respect governor limits.

# mobile (Mobile Frontend)
## Getting Started

MODULES
- Authentication (Phone)
- Recommendation (AI, Agency)
- Communication (P2P, Broadcast) (Messages)
- Reputation (Individual Score, Social Score)

- Shares
  - Alerts (Family, Friends, Public)
  - Location (Family, Friends)
- Invites
  - Safe Walk (Requests: Accept, Reject, Ignore)

### Authentication

STATES
- SignedOutState (countryCode, phoneNumber)
- AuthenticationFailedState (phoneNumber, message) -> true|false
- VerificationRequestedState (phoneNumber) -> verificationId
- SignedInState -> UserEntity

EVENTS
- OnPhoneVerificationRequested -> WaitingVerificationCode
- OnPhoneVerificationSubmitted -> SignedIn | AuthenticationFailed
- OnSignOutRequested -> SignedOut

### Recommendation

?

### Communication

Family is a Group (fixed)

Message (scope: user (P2P), group (P2P), location (BROADCAST))
Request (Message: { scope: ,  }, Response: [])
Response (Session: [])
### Reputation

Challenge (type: Reputation)
/ each challenge has a weight
- NationalID
- EmailVerification
- AddressConfirmation
- InstitutionAffiliation
- VaccinationCertification


- Create 6 users (phones) (1 main, 2 family, 3 acquaintances (2 on same location))
- Create 1 authority (agency)
- For user (Main) : Share Alert (group, location), Send Request (group), Sound Alarm
- For user (Agency) : Share Alert (location)
- For user ()
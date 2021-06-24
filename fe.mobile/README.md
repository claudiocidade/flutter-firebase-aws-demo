# Mobile (Mobile Frontend)
## Getting Started

MODULES
- Authentication (Phone)
- Recommendation (AI, Agency)
- Communication (P2P, Broadcast) (Messages)
- Reputation (Individual Score, Social Score)

### Authentication

MODULES
- Authentication
- User

BLOC : AUTH
BLOC : USER

STATES : USER
EVENTS : USER
- OnConnect() -> OnSignIn() -> User::IsSignedIn
- OnDisconnect() -> OnSignOut() -> Authentication::IsSignedOut

STATES : AUTHENTICATION
- SignedOutState
- WaitingSignInResponseState
- WaitingVerficationPinCodeState
- SignedInState
EVENTS : AUTHENTICATION
- OnVerifyPhoneNumber()
- OnConfirmSignIn()
- OnSignOut()

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

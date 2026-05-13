# AttributedRelationships

Demo project to explore converting a CoreData project with ordered many:many and one:many relationships into a data model compatible with CloudKit

Updating GitHub token for use in xcode or sourcetree
- need to use classic token
- need to set admin:public_key, repo, user
- might need to remove old entries from keychain
    - keychain delete seems to fail silently unless you have password app open
- note that i successfully used a token to push from xcode, but the token I thought I was using reports it wasn't used (the classic token) whereas the one that failed (fine-grained) appears to have been used.  WTF.
- deleted the classic token to try again


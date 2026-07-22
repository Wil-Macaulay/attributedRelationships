# Mastodon threads
This file captures the mastodon thread(s) I generated in the course of figuring this stuff out, starting Dec 8 2025.

I've used a line starting with t: to indicate the tags used for each post, to avoid Xcode's Markdown renderer rendering them as headers. 

## Thread 1 (Dec 8 2025 - Jan 14 2026)
I've had apps on the iOS App Store since 2009, both #indiedev and as jobs.   The Craic (https://apps.apple.com/app/the-craic/id586009292) is an app for finding #irishmusic tunes written in abc notation (https://abcnotation.com), displaying them as standard music notation and organizing them as tune sets and collections.
Since V 1.0  in 2012 a lot has changed in the #iosdev world. Any new app has to support cloud syncing between clients. I'm going to try a #buildInPublic experiment to make me actually get to it. 1/n

t: #indiedev #irishmusic #iosdev #buildInPublic 

The app started as objective-C using an in-memory data model persisted to Apple plists. I added #coredata classes soon after. Currently the data model has 4 major domain classes mirrored by core data classes, and some additional classes for convenience.  

I've converted the majority of the code to Swift. I've kept all rendering and editing logic (display, audio, export etc) in Swift, using core data only for persistence and search. 2/n

t:  #indiedev #irishmusic #iosdev #buildInPublic #coredata 

To zoom in a bit on the problem at hand: #cloudKit is the obvious choice for sync between devices.  Apple's documentation would have you believe that all you need to do is change your  NSPersistentContainer to a NSPersistentCloudKitContainer and all will be well! 
Not so fast. 
First of all, the coredata and cloudkit data models have to be compatible.  In this case, we find the dreaded OrderedRelationship in two places. 
3/n

t: #indiedev #irishmusic #iosdev #buildInPublic #coredata #cloudKit
Tune to TuneSet is a many:many relationship ordered by the tunes’ play order. Functionally, the user can add Tunes to TuneSets and re-order or remove them. We must convert the many:many relationship to an intermediate object with an ordering attribute that we can use when we retrieve a TuneSet. We will have to be able to manipulate the ordering attribute to let the user drag Tunes to re-order them in the UI.
4/n

t: #indiedev #irishmusic #iosdev #buildInPublic #coredata #cloudKit

The second case is a little more complex. Collections can contain Tunes and TuneSets. By default, they are time-ordered when users add to their contents. Users can also reorder them, and I've had requests (not yet implemented) for alphabetical and most-recent first ordering.
A superclass (Searchable) inherited by both TuneSet and Tune allows for containment of both in a Collection. 

5/n

t: #indiedev #irishmusic #iosdev #buildInPublic #coredata #cloudKit

diagrams of where we are so far…
6/n

t: #indiedev #irishmusic #iosdev #buildInPublic #coredata #cloudKit

Now we've sketched out a workable data model that works in both coreData and CloudKit, we need to work out:
- how to migrate from the existing model to the new one without losing data.
- how to handle merging databases from different devices given that the user might have duplicate entries or collections with different members or different ordering 

7/n

t: #indiedev #irishmusic #iosdev #buildInPublic #coredata #cloudKit

Apple has improved their migration support since I last looked - migrating to the data model outlined above would work as a staged migration:
- add the new entities and any attributes needed to define ordering or deduplication
- populate the intermediate attributed relationships 
- delete the old entities

https://developer.apple.com/documentation/coredata/staged-migrations

Now we can safely move from NSPersistentContainer to a NSPersistentCloudKitContainer
 
8/n

t: #indiedev #irishmusic #iosdev #buildInPublic #coredata #cloudKit

As an aside - I've learned a lot about CoreData and CloudKit from @fatbobman's blog. 

https://fatbobman.com/en/posts/coredatawithcloudkit-1/
 
9/n

t: #iosdev #buildInPublic #coredata #cloudKit

There is some Apple demo code from WWDC 2022 that gives an example of deduplication on CloudKit sync.  It's a simplified demo but it does give an example of a many:many (unordered) relationship.  Let's see if we can get it running.
https://developer.apple.com/documentation/coredata/synchronizing-a-local-store-to-the-cloud

10/n

t: #iosdev #buildInPublic #coredata #cloudKit

Got the demo working after some annoying debug sessions.  Seems like it has not been revisited since 2022, and iOS 18 changed the behaviour of collectionView.dequeueReusableCell - as of iOS 18 it asserts if you call it outside of cellForItemAt indexpath.  it was being called in awakeFromNib to set a font. 

You would think that a company with the resources of Apple would at a minimum task interns to COMPILE AND RUN demos called out in the docs 
11/n

 t: #iosdev #buildInPublic #coredata #cloudKit  I also have make sure I'm selecting the Private database and the com.apple.coredata.cloudkit'recordName' is not marked queryable

https://lyons.app/2021/07/05/how-to-fix-field-recordname-is-not-mcom.apple.coredata.cloudkit/

gave me the answer: I have to modify the schema by adding a queryable index called recordName to the recordName metadata field for each record type so I can view the records. I also have make sure I'm selecting the Private database and the com.apple.coredata.cloudkit zone. 
12/n

t: #iosdev #buildInPublic #coredata #cloudKit

Enough for tonight. Tomorrow I'll start prototyping the migration from explicitly ordered many:many to implicitly ordered via intermediate attributed relationship objects.

13/n

t: #iosdev #buildInPublic #coredata #cloudKit

So the next question is - create a purpose-built prototype to experiment with attributed relationships or bang away at a disposable branch of my main project? I know what I _should_ do...  And it will make things easier to share here without distractions.  So a new project using Storyboard (i.e. UIKit) template with CoreData. Minimum deployment will be iOS 17. No CloudKit as yet, I want to be able to test migration from ordered many:many .

14/n

t: #iosdev #buildInPublic #coredata #cloudKit

Roughed in a little prototype - UI mostly done, some test classes to create Tunes and TuneSets. Tomorrow rough in Collections.   Nice that UIKit now lets us add UISplitViewControllers as tabs on UITabControllers.  

15/n

t:  #iosdev #buildInPublic #coredata #uikit
Some random observations while developing the prototype/testbed app:
Why doesn't Apple put the superclass in the Swift version of the docs for #UIKit ? It's still there in the Obj-C version. There's lot's of times when I need to see the APIs for the superclass.
I'm using #UIKit, not SwiftUI. I've done a bit of playing with SwiftUI, but I've been using UIKit since 2009, and I like it better for CoreData related stuff, so I will stick with it.

16/n

t: #iosdev #buildInPublic #coredata #uikit

Over the years I've been using Storyboards less and less.  I now tend to build VCs programmatically using UIStackViews.

The shipping version manages a single 3-pane UISplitViewController and transitions manually to a tab bar when necessary. This works back to iOS 15, but it's annoying to debug and makes assumptions about the frameworks that may not be true going forward.

17/n

T: #iosdev #buildInPublic #coredata #uikit

I’m using a UITabBarController with UISplitViewControllers as the individual tabs for the prototype. This works nicely in iOS 26, but not in iOS 18, and no hope of getting it to run on anything earlier.

18/n

T: #iosdev #buildInPublic #coredata #uikit

I know that UITableViewControllers are sort-of soft-deprecated, but they're a lot easier to use for this sort of prototyping than UICollectionViewControllers.  Also, diffable data sources are recommended but are way overkill for most situations and hard to understand.

19/N

t: #iosdev #buildInPublic #coredata #uikit

Most of this went together pretty easily but I spent way too much time trying to figure out how to get my tableHeaderView to properly respect changing margins as sidebars and splitviewcontrollers resize and show/hide.

20/n


t: #iosdev #buildInPublic #coredata #uikit

I couldn't figure out how to do it programmatically, but I had to make it a subclass of UITableViewHeaderFooterView, add it as a subview of the TableView in the storyboard and then put my stackView as a subview of the contentView, with explicit constraints, which magically obeys the changing margins.

21/n

t: #iosdev #buildInPublic #coredata #uikit
You can find what I've done so far at:

https://github.com/Wil-Macaulay/attributedRelationships

22/n

t: #iosdev #buildInPublic #coredata #uikit

Going to need some unit tests. Looks like the new Swift Testing framework is pretty neat, so let's try using that.  I’m not a TDD guy, so this may be a rabbit hole that might take a while, but probably worth a try.  Start by adding a test target as per the WWDC 2024 video https://developer.apple.com/videos/play/wwdc2024/10179

23/n

t:  #iosdev #buildInPublic #coredata #uikit

Add a new test target from the file menu…
Odd that it doesn't follow the same deployment info as the main target (ios 18) , but defaults to iOS 26.1 (the version of Xcode I’m running)

24/n

t:  #iosdev #buildInPublic #coredata #uikit #swiftTesting

Added my first set of unit tests - just creating a single instance of each of my core entities - pushed to GitHub for those that care!  Next step is to add tests for the relationships: for example, adding a Tune to a TuneSet and then reordering them.
Found a neat trick on testing Core Data without leaving droppings - use /dev/null as the store. See
https://medium.com/tiendeo-tech/ios-how-to-unit-test-core-data-eb4a754f2603

25/n

t: #iosdev #buildInPublic #coredata #uikit #swiftTesting

This is going to be super important when I change the underlying data model.  Maybe I should add a little facade over the CoreData so I can preserve the API and leave the unit tests unchanged?  That’s the ideal when refactoring, run the exact same suite of tests and have them succeed.  

Still not sure on my approach for testing when synchronization across multiple devices…

26/n

t: #iosdev #buildInPublic #coredata #swiftTesting

Will be exploring Apple’s cktool for #cloudkit setup, which hopefully will let me populate data that will let me test sync 

developer.apple.com/icloud/ck-…

27/n

t: #iosdev #buildInPublic #coredata #swiftTesting 

Not much time to do stuff over the last little while - refactored the unit tests to parameterize them and added some helper functions, added a runtime flag to choose a real file for the SQLite backing store vs. /dev/null   
Changes are in GitHub if anybody is interested https://github.com/Wil-Macaulay/attributedRelationships

28/n

t: #iosdev #buildInPublic #coredata #swiftTesting

Random thoughts for future development:
Object identity is not straightforward. 

If I change a collection name on device A, the change should propagate to device B.  
Should two collections with the same name on different devices but with different members be merged? I think the principle of least surprise would argue that they should. 
 
OTOH,  two tunes with the same name but different melodies should be distinct (common in #irishmusic)

29/n

t: #iosdev #buildInPublic #coredata #swiftTesting #irishmusic

Just a little done these last couple days.  Put together (and pushed) a few more unit tests for core data testing.  Concentrating on the ordered many:many since that's what I need to test. 
 30/n

t: #iosdev #buildInPublic #coredata #swiftTesting 

Swift Testing error messages can be annoyingly obscure - “cannot convert value of type 'nonisolated(nonsending) @Sendable (String, String) async throws -> Void' to expected argument type '@Sendable (String.Element, String.Element) async throws -> Void' (aka '@Sendable (Character, Character) async throws -> ()”

in other words: I forgot my testing macro arguments “abc”,”def" need to be arrays [“abc”],[”def”].  

31/31

## Thread 2 (May 13,14 2026)


t: #buildInPublic #iosDev
Back to this after a hiatus of several weeks.  Starting a new thread

previous thread is here https://mastodon.social/@Tom_frog/115686636425331266

I'm going to need to develop the alternate #coreData model described in the previous thread, then develop a data migration.  Finally, I’ll need to sync and deduplicate.  I will use the the #swiftTesting functions I added in the first phase to test the migration.

staying well away from AI since I want to actually understand what I’m doing at the end.

1/n

t: #buildInPublic #iosDev #coreData #swiftTesting

Since I’m eventually going to have to take a populated database and convert it from the old model to the new model, I’m going to tag the current repo so I can come back to it and build my test data.  I should build a test database now that covers all the cases, but I am pretty sure that I’ll think of more as I go along.

Nevertheless, first order of business is to build some infrastructure to populate the test database.

2/n

I'm going to need test data for the obvious CRUD scenarios, but also special cases to support merging sets and collections, as well as modifying a previously synced entity.  The ability to import a text/JSON file would allow me to test merge logic in a repeatable way without worrying about actually setting up cloud sync.

3/n

So the obvious next step is to be able to import Tune - they're my first entity, and in the real app Tunes can be imported from existing datastores and edited via a text editor. 

In my existing basic data model I have:

Tune - inherited from Searchable
  collatingName : String
  createdDateTime : Date
  displayName : String
  isFavourite : Boolean
  modifiedDateTime : Date
  notes : String

Tune - extension
  tuneSets : (many:many) to Set
  
4/n

Directly editable attributes are displayName, isFavourite and Notes, others are set by the app. To properly merge logic I must decide  
- is an inbound Tune identical to an existing one 
- should changes to an inbound tune apply  to an existing one.

The rule will be:
A - an inbound tune with identical displayName+notes to an existing one is considered identical
B - isFavourite will be set if either the existing or inbound tune has it set

5/n

t: #buildInPublic #iosDev #coreData #swiftTesting

To see if inbound changes apply, I need an invariant identifier so I can tell if I've seen this object before. I don't have one, so I need to add a UUID

6/n


new merge rule:

if inbound has UUID {
    if there is existing with same UUID {
          update existing with user data from most recently modified
        } else { //no UUID match
          if existing with same user data {
             update existing with incoming UUID
          } else {  //no user data match
             insert new with incoming UUID and user data
          }
     }
 } else {//no incoming UUID
    insert with new UUID
}
7/n

t: #buildInPublic #iosDev #coreData #swiftTesting

So I now have a start at a merge strategy I can test.  Note that in the case of UUID conflicts between inbound and existing entities I’m taking the inbound UUID, so that if I modify the local storage it doesn't trigger another modification on the remote - a “sync loop”.  It is still possible to get duplicates locally by creating a new Tune (with a UUID) and then modifying user data to be identical to an existing Tune with a different UUID.
8/n

CoreData: warning: Multiple NSEntityDescriptions claim the NSManagedObject subclass 'TDMTune' so +entity is unable to disambiguate.
this happens after I reset the database by deleting the store: the MOM from the original store is not deleted. 
    
## Thread 3 (July 1 2026)
Starting a new thread again since I got distracted for a bit.  (1/n)

Trying to #buildInPublic an offline-first Swift sync engine for the Craic https://apps.apple.com/app/the-craic/id586009292 which supports arbitrarily ordered many:many relationships, using #CoreData as the underlying store. In the process exploring #swiftTesting

 Previous thread was at https://mastodon.social/@Tom_frog/116569682831391398, start of first thread was at   https://mastodon.social/@Tom_frog/115686636425331266 1/n
 
 2/n
 
t: #buildInPublic #CoreData #swiftTesting

Spending a little time figuring out the best way to build input files of test data. In the Objc days I used to read json into NSDictionaries and then build my domain objects from there. Swift has the Codable protocol (Encodable + Decodable) plus JSONEncoder / JSONDecoder which gives us a nice way of getting from json to domain objects.  (2/n)

t: #buildInPublic #CoreData #swiftTesting

types (that is classes or structs) that are built from Codables can be trivially made codable.  Fortunately most of the properties of our domain objects are Codable (Strings and Dates). however, NSManagedObjects are not directly Codable, since you need an NSManagedObjectContext to create an instance.

There are ways around that, but more importantly we've got [m:m] relationships in our data model which are hard to directly encode/decode.  (3/n)

t: #buildInPublic #CoreData #swiftTesting

So we're introducing some Data Transfer Objects [DTOs] that can be trivially Codable.

How do we represent the [m:m] relationships? two choices:
1. denormalize in the json file, so that we start by ingesting Collections, providing a full copy of each TuneSet and Tune occuring in each Collection then culling out duplicates
2. introduce an ID attribute for each domain object so that we ingest relationships as an ID to be reconciled after ingestion.
(4/n)

t: #buildInPublic #CoreData #swiftTesting

Approach 1 would let us trivially use Decoders to ingest the data files and Encoders to write them, the files will get big fast.
Approach 2 lets us more easily manually prepare special test cases and is easier to understand.  Let's go with approach 2.
(5/n)

t: #buildInPublic #CoreData #swiftTesting

incidentally, nice summary of Codable with JSON here: https://medium.com/@ankuriosdev/basics-of-json-encoding-and-decoding-in-swift-language-6bb73affc6bb

(6/n)

t: #buildInPublic #CoreData #swiftTesting

A slight wrinkle: a Collection can contain both Tunes and TuneSets, in arbitrary order.  In our CoreData model, we handle this by having a common superclass, Collectable, which has the common attributes and relationships.  The ‘obvious' thing to do is have a common DTO superclass AbcCollectible handle basic encoding and decoding with the subclasses doing anything specific - in our trimmed down prototype that means TuneSet handling contained Tunes
(7/n)

t: #buildInPublic #CoreData #swiftTesting

Do I need an explicit ‘type' field as shown here? let's see…

https://medium.com/@ankuriosdev/mastering-advanced-json-decoding-in-swift-part-2-74d5a956dd0a

(8/n)

t: #buildInPublic #CoreData #swiftTesting

Looks like I can't inherit CodingKeys from a superclass, I have to redefine them in any subclass that adds properties.  Yet another example of the Swift language designers wagging their collective fingers at inheritance vs composition… 

(9/n)

t: #buildInPublic #CoreData #swiftTesting

I can't inherit CodingKeys, but I _can_ inherit init(from decoder) as well as superclass properties.  

so I've implemented AbcCollectable as a superclass of AbcTune and AbcTuneSet, mirroring the TDMTune and TDMTuneSet relationships. (pushed to the GitHub repo for anyone who’s following along.

Next I want to implement AbcCollection as a container for _both_ AbcTunes and AbcTuneSets

(10/n)

t: #buildInPublic #CoreData #swiftTesting

(got distracted by other stuff, including wiring up a gazebo and playing tunes. Back at it now…)

I want to be able to allow the user to have an arbitrary Collection of Tunes and Sets in any order, so I’ll need an Array of Collectables [AbcCollectable].  Now I really am going to need to distinguish between a Tune and a TuneSet at runtime. (11/n)

t: #buildInPublic #CoreData #swiftTesting

I found a few similar ways of doing this using enum with associated type

https://medium.com/@ankuriosdev/mastering-advanced-json-decoding-in-swift-part-2-74d5a956dd0a

https://www.caseyliss.com/2023/2/2/decoding-heterogeneous-json-arrays-in-swift

This one from @paulio87@hachyderm.io seems the most straightforward  to me:

https://paul-samuels.com/blog/2019/01/02/swift-heterogeneous-codable-array/

it doesn’t require the domain DTOs (in this case AbcTune and AbcTuneSet) to have an explicit 'type’ field, but brings that out to a container.  

(12/n)

t: #buildInPublic #CoreData #swiftTesting

ready to push to GitHub again.  The DTOs are in the main project but only being exercised from the playground.  Time to implement transferring from the DTO to the CoreData store.

13/n

t: #buildInPublic #CoreData #swiftTesting

next: Conversion of the DTOs to CoreData objects.  
The current structure of JSON encoding assumes a top-down/denormalized structure for import, but since Tunes <-> TuneSets is many:many and Collectibles <-> Collections is m:m,  I'd like a way to avoid re-specifying the containment tree.

 As part of that I'll need to look at how to de-duplicate with respect to existing objects. 

14/n

t: #buildInPublic #CoreData #swiftTesting

lets do the simplest case first: AbcTune to TDMTune.

15/n

t: #buildInPublic #CoreData #swiftTesting

bit of a digression here: from my ObjC CoreData days I've been generating the NSManagedObject class definitions through XCode, then my own related code (in this case for translating back and forth from the DTOs) in a separate file as an objC category, with the generated files untouched.
I built class methods in the base TDMSearchable class
  class func makeInstance(from abcObj : some AbcCollectable, context :NSManagedObjectContext) -> TDMSearchable 
16/n

t: #buildInPublic #CoreData #swiftTesting

Since my inheritance tree for the DTOs maps 1:1 onto the CoreData managed objects, I'd like to inherit the class methods in the subclasses TDMTune and TDMTuneSet, e.g. in TDMTuneSet
    class func makeInstance(from abcObj: AbcTuneSet, context: NSManagedObjectContext) -> TDMTuneSet

Unfortunately Swift doesn’t allow overriding base-class methods in an extension, so I have to modify the generated TDMxxx+CoreDataClass.swift
17/n

t: #buildInPublic #CoreData #swiftTesting

To satisfy myself that XCode doesn't touch the generated xxx+CoreDataClass.swift file if it exists, when regenerating the properties file, I made a small change and tried it.  In the process I added the Swift testing file as a target, which made all my tests fail in strange ways.

back to regularly scheduled programming…

18/n

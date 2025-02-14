import Foundation
import UIKit

/**
 Design and implement a simple social network where users can:
  - create posts,
  - follow/unfollow another user
  - Is able to retrieve a user's 'feed'.  A feed is comprised of posts that
    are created by the user, and by the users they follow.

 Extra Credit:
  - Posts from getFeed are ordered from most recent to least recent.
  - Limit getFeed to 10 most recent posts


 The four stubbed functions must be implemented as provided.
 You may implement additional classes/structs/functions/etc. as needed
*/

/*
 Here’s a Swift implementation of a simple social network using a combination of dictionary-based data structures and linked lists (or arrays for simplicity) to manage posts, followers, and feeds efficiently.

 Approach:
 - User Class:
 Stores user ID, followers, and a list of posts.
 
 - SocialNetwork Class:
 Manages user creation, posting, following/unfollowing, and retrieving the feed.
 Uses a dictionary (users) to store users efficiently.
 
 Implementation:
 */


class User {
    let id: Int
    var posts: [(Int, String)] // Stores (timestamp, post)
    var followers: Set<Int>    // Stores user IDs of followers

    init(id: Int) {
        self.id = id
        self.posts = []
        self.followers = []
    }

    func addPost(_ post: String, timestamp: Int) {
        posts.append((timestamp, post))
    }
}

class SocialNetwork {
    private var users: [Int: User] = [:] // User ID -> User object
    private var timestamp: Int = 0       // Used to order posts

    // Create a new post
    func createPost(userId: Int, post: String) {
        if users[userId] == nil {
            users[userId] = User(id: userId)
        }
        users[userId]?.addPost(post, timestamp: timestamp)
        timestamp += 1
    }

    // Follow a user
    func follow(followerId: Int, followeeId: Int) {
        if users[followerId] == nil {
            users[followerId] = User(id: followerId)
        }
        if users[followeeId] == nil {
            users[followeeId] = User(id: followeeId)
        }
        users[followerId]?.followers.insert(followeeId)
    }

    // Unfollow a user
    func unfollow(followerId: Int, followeeId: Int) {
        users[followerId]?.followers.remove(followeeId)
    }

    // Get the user's feed (latest 10 posts from user + followees)
    func getFeed(userId: Int) -> [String] {
        guard let user = users[userId] else { return [] }
        
        var allPosts: [(Int, String)] = user.posts // Get user's posts
        
        // Add followees' posts
        for followeeId in user.followers {
            if let followee = users[followeeId] {
                allPosts.append(contentsOf: followee.posts)
            }
        }

        // Sort posts by timestamp (most recent first) and get top 10
        return allPosts.sorted { $0.0 > $1.0 }
                       .prefix(10)
                       .map { $0.1 }
    }
}

// Example usage
let network = SocialNetwork()

network.createPost(userId: 1, post: "Hello world!")
network.createPost(userId: 2, post: "Swift is awesome!")
network.follow(followerId: 1, followeeId: 2)
network.createPost(userId: 2, post: "Learning Swift concurrency.")
network.createPost(userId: 1, post: "Building a social network!")

print(network.getFeed(userId: 1)) // Expected: 10 most recent posts from user 1 and followed users

/*
 Explanation & Complexity Analysis:
 
 Creating a Post (O(1))
 Stores posts in a list, adding timestamps for sorting later.
 
 Following/Unfollowing (O(1))
 Uses a Set<Int> to store followers efficiently.
 
 Getting the Feed (O(N log N), where N is total posts from user & followees)
 
 Merges posts from the user and followees.
 Sorts them in descending order based on timestamp.
 
 Returns only the latest 10 posts.
 
 Key Features Implemented:
 ✔️ Users can create posts
 ✔️ Users can follow/unfollow other users
 ✔️ getFeed() shows posts from user + followed users
 ✔️ Posts are sorted from newest to oldest
 ✔️ Limits feed to 10 most recent posts

 This design ensures efficient operations for a scalable social network system.
 */

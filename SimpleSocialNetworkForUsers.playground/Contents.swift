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

/*
 Naming Strategy
 userId → Refers to the user performing the action (e.g., posting, following, or unfollowing).
 targetUserId → Refers to the user being followed or unfollowed (instead of followeeId, which might be confusing).
 postId → Clearly represents the ID of a post.
 */

struct SocialPost {
    let userId: Int
    let postId: String
    let timestamp: Date  // Changed from Int to Date
}

class TalechSocial {
    private var users: [Int: User] = [:]
    private var posts: [SocialPost] = []

    struct User {
        let userId: Int
        var following: Set<Int> = []  // Stores user IDs that this user follows
    }

    // Create a new post
    func createPost(userId: Int, postId: String) {
        let newPost = SocialPost(userId: userId, postId: postId, timestamp: Date())
        posts.append(newPost)
    }

    // Follow another user
    func follow(userId: Int, targetUserId: Int) {
        if users[userId] == nil { users[userId] = User(userId: userId) }
        if users[targetUserId] == nil { users[targetUserId] = User(userId: targetUserId) }
        users[userId]?.following.insert(targetUserId)
    }

    // Unfollow a user
    func unfollow(userId: Int, targetUserId: Int) {
        users[userId]?.following.remove(targetUserId)
    }

    // Retrieve feed (latest 10 posts)
    func getFeed(userId: Int) -> [String] {
        guard let user = users[userId] else { return [] }

        // Get posts from user and followed users
        let feedPosts = posts.filter { $0.userId == userId || user.following.contains($0.userId) }
                             .sorted { $0.timestamp > $1.timestamp }  // Sort by latest first
                             .prefix(10)  // Get latest 10 posts
                             .map { "\($0.postId) - \(formatDate($0.timestamp))" } // Format for output

        return Array(feedPosts)
    }

    // Helper function to format date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"  // Customizable date format
        return formatter.string(from: date)
    }
}

// Example usage
let network = TalechSocial()

network.createPost(userId: 1, postId: "Hello world!")
network.createPost(userId: 2, postId: "Swift is awesome!")
network.follow(userId: 1, targetUserId: 2)
network.createPost(userId: 2, postId: "Learning Swift concurrency.")
network.createPost(userId: 1, postId: "Building a social network!")

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

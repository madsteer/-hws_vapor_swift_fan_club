import Routing
import Vapor
import Fluent
import FluentSQLite

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {

    // only needed once to get the data initialized
//    router.get("setup") { req -> String in
//
//        var forums = [Forum]()
//        forums.append(Forum(id: 1, name: "Taylor's Songs"))
//        forums.append(Forum(id: 2, name: "Taylor's Albums"))
//        forums.append(Forum(id: 3, name: "Taylor's Concerts"))
//
//        for forum in forums {
//            _ = forum.create(on: req)
//        }
//
//        var messages = [Message]()
//        messages.append(Message(id: 1, forum: 1, title: "Welcome", body: "Hello!", parent: 0, user: "twostraws", date: Date()))
//        messages.append(Message(id: 2, forum: 1, title: "Second post", body: "Hello!", parent: 0, user: "twostraws", date: Date()))
//        messages.append(Message(id: 3, forum: 1, title: "Test reply", body: "Yay!", parent: 1, user: "twostraws", date: Date()))
//
//        for message in messages {
//            _ = message.create(on: req)
//        }
//
//        return "OK"
//    }

    router.get { req -> Future<View> in
        struct HomeContext: Codable {
            var username: String?
            var forums: [Forum]
        }

        return Forum.query(on: req).all().flatMap(to: View.self) { forums in
            let context = HomeContext(username: getUsername(req), forums: forums)
            return try req.view().render("home", context)
        }
    }

    router.get("forum", Int.parameter) { req -> Future<View> in
        struct ForumContext: Codable {
            var username: String?
            var forum: Forum
            var messages: [Message]
        }

        // pull out the forum ID they requested
        let forumID = try req.parameters.next(Int.self)

        // look for it in our database
        return Forum.find(forumID, on: req).flatMap(to: View.self) { forum in
            guard let forum = forum else {
                // that forum doesn't exist – bail out!
                throw Abort(.notFound)
            }

            // find all top-level messages that belong to this forum
            let query = Message.query(on: req)
                .filter(\.forum == forum.id!)
                .filter(\.parent == 0)
                .all()

            // convert all our data into a Leaf view
            return query.flatMap(to: View.self) { messages in
                let context = ForumContext(username: getUsername(req), forum: forum, messages: messages)
                return try req.view().render("forum", context)
            }
        }
    }
}

func getUsername(_ req: Request) -> String? {
    return "Testing"
}

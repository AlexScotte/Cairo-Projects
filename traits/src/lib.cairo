trait Summary<T> {
    fn summarize(self: @T) -> ByteArray;
}

#[derive(Drop, Clone)]
struct NewsArticle {
    headline: ByteArray,
    location: ByteArray,
    author: ByteArray,
    content: ByteArray,
}

impl NewsArticleSummary of Summary<NewsArticle> {
    fn summarize(self: @NewsArticle) -> ByteArray {
        format!(
            "{} by {} ({})", self.headline.clone(), self.author.clone(), self.location.clone()
        )
    }
}

#[derive(Drop, Clone)]
struct Tweet {
    username: ByteArray,
    content: ByteArray,
    reply: bool,
    retweet: bool,
}

impl TweetSummary of Summary<Tweet> {
    fn summarize(self: @Tweet) -> ByteArray {
        format!("{}: {}", self.username.clone(), self.content.clone())
    }
}

fn main() {
    let news = NewsArticle {
        headline: "Cairo has become the most popular language for developers",
        location: "Worldwide",
        author: "Cairo Digger",
        content: "Cairo is a new programming language for zero-knowledge proofs",
    };

    let tweet = Tweet {
        username: "EliBenSasson",
        content: "Crypto is full of short-term maximizing projects. \n @Starknet and @StarkWareLtd are about long-term vision maximization.",
        reply: false,
        retweet: false
    }; // Tweet instantiation

    println!("New article available! {}", news.summarize());
    println!("1 new tweet: {}", tweet.summarize());
}

struct Rectangle {
    height: u64,
    width: u64,
}

#[generate_trait]
impl RectangleGeometry of RectangleGeometryTrait {
    fn boundary(self: Rectangle) -> u64 {
        2 * (self.height + self.width)
    }
    fn area(self: Rectangle) -> u64 {
        self.height * self.width
    }
}
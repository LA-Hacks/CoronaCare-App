//This is a structure of a post


class Post {
  String authorName;
  String authorImageUrl;
  String timeAgo;
  String imageList;

  Post({
    this.authorName,
    this.authorImageUrl,
    this.timeAgo,
    this.imageList,
  });
}

final List<Post> posts = [
  Post(
      authorName: 'Sam Martin',
      authorImageUrl: 'assets/images/user0.png',
      timeAgo: '5 min',
      imageList: 'assets/images/post0.jpg'),
  Post(
      authorName: 'Sam Martin',
      authorImageUrl: 'assets/images/user0.png',
      timeAgo: '10 min',
      imageList: 'assets/images/post0.jpg'),
];

final List<String> stories = [
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
  'assets/images/user4.png',
  'assets/images/user0.png',
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
];

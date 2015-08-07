user = User.create(user_name: 'jkowalski', email: 'jan@kowalski.com',
  password: 'password1', password_confirmation: 'password1')
user2 = User.create(user_name: 'snowak', email: 'stefan@nowak.com',
  password: 'password1', password_confirmation: 'password1')
user3 = User.create(user_name: 'kigrekowski',email: 'kazimierz@igrekowski.com',
  password: 'password1', password_confirmation: 'password1')

post = Post.create(caption: 'Cool cat!',
  image: File.new('app/assets/images/cat.jpg'), user_id: user.id)
post2 = Post.create(caption: 'Cats rules!',
  image: File.new('app/assets/images/cat2.jpg'), user_id: user2.id)
post3 = Post.create(caption: 'So sweet! :)',
  image: File.new('app/assets/images/cat3.jpg'), user_id: user3.id)

Comment.create(content: 'Cute cat :)', user_id: user.id, post_id: post2.id)
Comment.create(content: 'Nice :)', user_id: user2.id, post_id: post3.id)
Comment.create(content: 'Cats are awsame :)', user_id: user3.id, post_id: post.id)

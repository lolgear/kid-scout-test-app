# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# thanks for http://www.reddit.com/r/sports/comments/36voua/cokes_slogan_is_share_happiness_so_i_made_an_ad/
# thanks for http://www.reddit.com/r/todayilearned/comments/36vbv5/til_a_sailor_who_wishes_to_grow_a_beard_in_the/
posts = [
  {
    title: %q|Picture/VideoCoke's slogan is "Share Happiness". So I made an ad to remind them of the kind of happiness they're sharing in Qatar|,
    body: %q|how are you? I am fine! Nice to hear you!|,
    comments: [
      {
        body: %q|Powerful and no BS. Nice work OP.|
      },
      {
        body: %q|Share a Coke with a "Slave"|
      },
      {
        body: %q|I can't believe how PC we've become. When did slavery become a bad thing? /s|
      },
      {
        body: %q|Slavery might be bad, but at least it isn't taxation! /libertarian.|
      }
    ]
  },
  {
    title: %q|TIL a sailor who wishes to grow a beard in the Royal Navy|,
    body: %q|TIL a sailor who wishes to grow a beard in the Royal Navy has to submit a permission to stop shaving form. He is then allowed two weeks to grow a full set before he presents himself to the Master at Arms who will decide if his beard looks stupid or is respectably full enough to be permitted.|,
    comments: [
      {
        body: %q|For all the people wondering, yes there are people who can grow a full beard in two weeks..|,
      },
      {
        body: %q|Damn rub it in why dont you.|
      },
      {
        body: %q|I have been growing mine for 23 years and have nary a single hair upon my chin.|
      },
      {
        body: %q|Damn, I'm a female and I have 2. :(|
      }
    ]
  },
  {
    title: %q|My buddy sent me a snap chat of his calf cramping up |,
    body: %q|http://www.reddit.com/r/videos/comments/36v61k/my_buddy_sent_me_a_snap_chat_of_his_calf_cramping/|,
    comments: [
      {
        body: %q|looks like hes defragmenting his leg|
      },
      {
        body: %q|Well, you can definitely run better if your muscle is in one, contiguous piece.|
      },
      {
        body: %q|I thought that just made it easier to read, not actually execute|
      }
    ]
  }
].map{ |item| item[:draft] = false; item }

drafts = [
  {
    title: 'Bla-bla-bla-bla',
    body: 'OMGWTFTBS CAT!',
    comments: []
  },
  {
    title: 'Family Guy quote',
    body: 'yes!',
    comments: [
      {
        body: %q|Tom Tucker: A bit of breaking news. A local family is forced out of their home by ghosts. Who are they gonna call?|
      },
      {
        body: %q|Diane Simmons (sighs): Ghostbusters, Tom.|
      },
      {
        body: %q|Tom Tucker: No, Diane. Their insurance company. That's just stupid what you said. |
      }
    ]
  },
  {
    title: 'Another Family Guy quote',
    body: 'again!',
    comments: [
      {
        body: %q|Stewie: Uh, there's a half-dead-fat-man eating a dead-fat-man...am I the only one who realized? Oh, okay... |
      }
    ]
  },
  {
    title: 'And.. last one Family Guy quote',
    body: 'oh, last',
    comments: [
      {
        body: %q|Chris: What do you do at a Young Republicans meeting?|
      },
      {
        body: %q|Alyssa: We help those who already have the means to help themselves. Also, we perpetuate the idea that Jesus chose America to destroy non-believers and brown people.|
      },
      {
        body: %q|Chris: I don't know why, but I feel safer already.|
      }
    ]
  },
  {
    title: 'Draft without comments, hah',
    body: 'ok, draft here!',
    comments: []
  }
]

(posts + drafts).each{
  |hash|
  hash_comments = hash.delete(:comments)
  post = Post.create(hash)
  hash_comments.each{
    |comment|
    Comment.create(post_id: post.id, body: comment[:body])
  }
}

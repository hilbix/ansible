> WARNING!  
> This is intermediate and may be in a wrong or not really working state.  
> So far it only can be used as a reference.
>
> See also [CONFUSED.md](CONFUSED.md) which I (should) softlink to roles as README which are not ready to be used.

# roles

These are my Ansible roles for all the standard things.

> This still is very basic and not stable yet!
>
> Do not expect compatibility roles to stay when things change!
>
> See `bullshit` below.

Layout:

- Each main role has its own README.md
  - Roles are usually named after the package they use with the same case as the package
  - Hence role names usually are all lowercase
  - main roles contain the install task is some is needed
- `handlers/` are named after their role
  - The action is uppercase
  - The name is the same case as the role
- Example standard handler names for `something/handler/`:
  - `Restart something` (includes `Start`)
  - `Reload something` (includes `Start`)
  - `Stop something`
  - `Disable something` (includes `Stop`)
  - `Mask something` (includes `Disable`)
  - there usually is no `Start something`, see `Reload` or `Restart` instead

Bullshit bingo:

- Some names are wrong and might change in future

Specialized roles:

- Specialized roles are named after the main roles with `-` or `--` prefixed lowercase words to select what they do
  - Many of them are probably bullshit and will be incorporated into the main role using variables in future, probably
- Usually all `templates/` of these specialized roles are kept in the main role

**WARNING!** Explicite language here:

- There is and never will be any Code of Conduct.  Period.  Period of Period.
- Hence expect explicite language like shit, ass, fuck, penis, black, white, master, slave
  - and anything else you might find on Southpark or Rick and Morty
  - or which came from Linus Torvalds until they forced him to stop his very clear and natural language
  - The `master` branch is called `master` because `main` is something completely different
  - There is a huge difference between a `master` disk and a `main` disk.  See?
- Everything shall be kept as follows: ASAP, KISS and DRY
  - ASAP: As Short As Possible
  - KISS: Keep It Stupid Simple
  - DRY: Dont Repeat Yourself
  - So use Gendering only if the text becomes more precise and hence shorter at the same time.
  - Please do not beat poor stutterers who suffer from tourette because they speak genderisms like `Student:innen` or similar.
- Here must not be illegal things
  - Like neglection of Holocaust
  - Like hatespeech or any similar intolerance (except for certain technologies)
- Also keep in mind: **Politically correctness is unsupported here**
  - So you might find statements like "I hate vegan" (which I really do).
- Please do not get me wrong.
  - I do not hate vegans (`s`!), because often those vegans are extremely hot bitches I'd really like to fuck (if they'd agree, which is very unlikely, but hey, I'm a male het).
  - And I do not hate vegan food either as I like salad and potatoes (with my ham and eggs)!
  - But please do not confuse "vegan" with "organic"!  Most "vegan" marked products are nothing less than ridiculously overpriced pure and evil poison.
  - So its just the word "vegan" which I hate, because of how it is used most of the time and hence what it did to this world!
  - Also vegan products usually are sold far more expensive than meat.  I really do not understand that.  And I never will.
  - Note that even equally priced vegan products (like with Burgers) are effectively extremely overpriced, because with meat you stay far longer saturated, so you need to buy less.
  - I can tell.  I am diabetic!
  - So a vegan "replacement" part should not be allowed to cost more than half of meat part in the food.
  - This even should be put into a law!
  - On top of this there should also be a tax of 1 cent per kg meat per year.  So the tax rises 1 cent each year.
  - And yes, I am a meat eater.  So what I write here is politically incorrect to all sides?  You bet it is and that's how I like it!

License?

- Free as in free beer, free speech and free baby.


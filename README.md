# What :: chromogen
Static image gallery generator, for generating galleries like [Chromophiliat](https://chromophiliat.dk/).

See it in action: https://www.youtube.com/watch?v=L5J7-dhq4Is

No server-side scripts, no client-side scripts, just static, pure, blissful HTML with a dash of CSS.

The generated galleries are self-contained, and can be moved around and hosted how ever you want, where ever you want, by whatever server you want.

# Why
Because I had a koken installation that I'd spent a lot of time on, and it just "stopped working" on me, that annoyed me. This is what I need and want.

# How
* edit config.sh
* mkdir input and put full-size images there
* ./gen.sh
* move output dir to wherever you want it.

# System requirements
* Bash
* ImageMagick
* sed
* zip (optional, required if bundling is enabled)


This is not an exercise in doing things right, it's just a tool that I made and may be useful to someone else.

# NaNoGenMo 2015

## Introduction

This is my project for 2015's National Novel-Generating Month. It's forked
from my master's thesis _[Autocento of the breakfast table][]_, which is a lot
of poems n' stuff.  I'm using the content of _Autocento_ as a corpus in my
"novel" -- and that's all I know about it right now.  I'll be updating this
README as I go and know more things.

I do know one other thing: I'm going to be working with the idea of _cento_ in
this novel -- since it'll be a cento of my other work.  So there's that.

[Autocento of the breakfast table]: http://autocento.me

[cento]: http://autocento.me/about.html#cento-or-just-like-everyone-else

## Update 11/05 (technically)

I've just written my first (super-dumb!) novel generator.  It takes a corpus
of words and outputs 50,000 (or thereabouts!) of them to a file called
`novel_$(date +%s).txt`.  It uses `bash`, `$RANDOM`, `head`, `tail`, `fmt`,
and other stuff.  It's in a file called `1.dumb.sh`.  The novels it's
generated are in the root folder -- I'll probbles move them to a novels folder
soon!


title: "What does NaN look like?"
author: David
date: 2006/12/10

I'll tell you what it looks like. 

It looks like -1.#IND. 

That's what it looks like. At least if the code is using the Double.NaN constant. I sure didn't know that before I saw it and, I can tell you, it sure freaked me out when I saw that in the immediate window in Visual Studio. I was working on speeding up another dev's code here and apparently they were using NaN to signify the difference between 0 and "not yet initialized." It works pretty well for them in that case, but as I said, if you're not expecting that, it very well may throw you off. 

And PowerShell is smart enough to just say NaN instead of this -1.#IND stuff. 

Along the same lines, -1.#INF is apparently how Infinity is represented. 

(IND would be indefinite whereas INF is infinite... makes sense I guess.)

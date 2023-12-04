
---
Get your data out of your functions
What does this mean?

The *usefulness* of a function increases with its *generality.*

Let's look at an example:

add = (a) => a + 1

add = (a, b) => a + b

Which of these functions is more useful?
I think we can easily argue that the second version of add is more useful, because it is more general.


Structuring data is perhaps one of the most important skills to develop as a programmer. Being thoughtful about your data structures and, I would say, minimizing the diversity of your data structures will save you a lot of headache when you reach

Here are the three layers

    Presentation
     -
    Logic
     - functions
     - modules
    Data
     - variables
     - data structures


----
"Almost all programming can be viewed as an exercise in caching."
—Terje Mathisen
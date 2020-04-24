---
type: post
---

Corey asked for Django profiling tips. Write about:
 - Database performance is usually the biggest bottleneck in a Django app
 - The ORM is great until you need to scale it...
 - How to profile code using Django Extensions
 - Techniques for assessing the number of database calls and reducing that number
 - Load Testing techniques (loader.io, locust.io)


_I wrote the following to Corey, regarding performance concerns with multi-table inheritance_

I can understand Two Scoops advertising caution about JOIN statements, but not strongly advising against them. The history of programming revolves around creating layers of abstraction that make things easier for the programmer. Each layer introduces “waste” and performance issues, but we take the trade-off, because we can accomplish more, faster. If all we cared about was performance then we would be writing everything in Assembly or C, because “Python doesn’t scale.” Apropos our conversation last Friday, I looked this up: in a 64-bit setting, Python allocates 24 bytes for every integer. So even if you know your value is 0-255 and all you really need is one byte (ex: an unsigned 8-bit int in C), you get something 24X larger than what you need, not to mention the overhead of Python’s runtime environment and JIT compiler. This is all very slow and orders of magnitude more memory-intensive compared to compiled C.

But it’s way easier to write Python and build features quickly. It’s also cheaper to pay for more memory and CPU than it is to pay developers to rewrite everything for performance.

The Django ORM in general is also wasteful, even in a single-table situation: it always retrieves every single field in the DB table, even if you don’t need them! On top of that, it instantiates a Python object, even if you don’t need a full-fledged object. Why not just get a list or dict of the field values? Well, because it’s more convenient to the programmer, and we don’t care about performance until it becomes a problem.

So that’s how I regard multi-table inheritance, too. It seems to me to be really convenient from a programming standpoint and the best way to fit the Django ORM to OOP class inheritance. I like that you can use the base class to query across multiple types and get a single QuerySet.

Now, I would avoid double-nested classes, not just with Django Models, but in general, but mainly because that makes things confusing for the programmer. I would also ultimately favor mix-ins and ‘sibling’ object composition over inheritance, too. For example, a mix-in approach would be to inherit from one or more abstract Models. The downside here vs. multi-table inheritance is that you cannot query across all the types (so I think multi-table is better for Boosters). An example of ‘sibling’ composition is something you’ve already don a few times, ex: creating a UserProfile model that is one-to-one with User.

There are also other techniques for achieving polymorphism, and they all have their trade-offs, which are described pretty well in this article, which I think you’ve seen already, but just in case: https://realpython.com/modeling-polymorphism-django-python/

If and when we start hitting performance problems b/c of the JOINs, we can talk about how we might solve them. Just a few ideas of where to start:

Do we frequently query on fields other than ‘id’ that should be indexed in the DB (ex: ‘created’)?

Do we need full objects in our queries or can we get away with simpler data structures using values_list()?

If we need objects, can we use select_related() and prefetch_related() to reduce the number of DB hits?

If we are still seeing issues, can we cache some values to memory to reduce stress on the DB?

If we need it, I think caching will probably be the ultimate solution, because our bottleneck will be on the DB read side of things, so I can’t foresee that it would ever be worth it to migrate away from multi-table inheritance. At scale, we might change the models and queries to eliminate joins, but we’d still be dealing with a lot of read operations, so caching would still probably be necessary.

Anyway, it’s good that you are aware of how this works under the hood. I think that’s 80% of the battle. I say, as long as you know what you’re doing with the ORM and where you are likely to see bottlenecks, then any solution is just fine.
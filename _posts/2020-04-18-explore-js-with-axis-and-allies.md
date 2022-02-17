---
layout: post
title: "Explore JavaScript with Axis & Allies"
date: 2020-04-18 12:00
description: Use JavaScript to write a Monte Carlo simulation to estimate the probabilities of winning combat scenarios in Axis & Allies.
category: blog
tags: javascript programming
readtime: 30 min
---

Over many years, I've come together with a particular group of friends to play _Axis & Allies (A&A)_, a World War II inspired board game.

For those unfamiliar, _A&A_ puts players in charge of the major nation states of the WWII era. During each turn of the game, you receive IPCs (the game's currency), purchase military units, declare and resolve combat, and make additional non-combat moves. It's a game of grand-scale strategy, but combat between armies is at the heart of the game. As a player, combat is how you capture new territories, grow your economy, and ultimately win the game.

The combat in _A&A_ is really (mathematically) interesting! Like many other board games, dice rolls determine the outcomes, but unlike those other dice-based board games (_Risk_, for example), the probability of success varies based on the types of units engaged and how hits are distributed round-to-round. The more units involved, the less straightforward it is to estimate the probability of success. It can be very difficult, if not impossible, to estimate your chances of winning without the help of a computer - as we shall see.

## What You'll Need

This article is aimed at beginner and intermediate JavaScript developers interested in exploring code-level concerns while implementing a multi-step simulation algorithm. Some more advanced developers and _Axis & Allies_ enthusiasts may also be interested.

1. The main thing you'll need is a way to run JavaScript code. You could create an empty HTML page with a `<script>` tag and open that in a browser, but I also highly recommend [CodePen](https://codepen.io) for prototyping small projects like this.
2. At the end of the article, we'll use [VueJS](https://vuejs.org) to build a user interface that receives user input and displays results. See [VueJS - Getting Started](https://vuejs.org/v2/guide/#Getting-Started).

## What is My Chance of Winning?

Players entering combat in _A&A_ are mainly wondering, "What is my chance of winning this?" Let's look at a small combat to see how we might answer that question.

In _A&A_, Infantry have a weak attack stat of 1 and a slightly better defense stat of 2. When resolving combat, each player rolls a six-sided die. An attack stat of 1 means the attacker must roll a 1 to hit the defender, while the defender must roll a 1 or 2 to hit the attacker.

So in a combat between two Infantry (one attacking, on defending), the defender seems favored to win, because they are more likely to roll a "hit." But by how much are they favored? Combat proceeds in rounds until the attacker gives up (retreats) or until one side has lost all of its units. In this case, each round of combat may have one of four outcomes:

1. Attacker hits, defender misses (combat ends)
2. Attacker misses, defender hits (combat ends)
3. Attacker hits, defender hits (combat ends)
4. Attacker misses, defender misses (combat continues)

Look at #4 again, and notice that there is a scenario where both players miss and combat continues. In fact, this could happen every round, forever. What this means is that even this basic combat situation has an _infinite probability space_! There's an (extremely low) chance that this combat could continue unresolved for eternity. In practice, though, it's not unusual to wait 2-3 rounds for someone to hit.[^1]

By the way, the probability that the attacker will win is about 25%. This _just so happens_ to be approximately the average between the attacker's chance to hit (one in six or 16.66%) and the defender's (two in six or 33.33%). But unfortunately that is not a general rule we can apply to all combats. For instance, in a combat between one Tank (attacks at 3) and one Infantry (defends at 2), the Tank is slightly favored at about 50.4%. If you take a moment to think about the probabilities of rolling certain numbers, these results may seem very unintuitive, and I think they are.

But that is jumping ahead!

What it comes down to is that every combat can be visualized as a tree diagram.

```
                            Start
               /         /         \     \
Round 1   attacker    defender    draw   continue
            wins        wins                  \
Round 2+                                  same tree, repeated...
```

And again, this is one of the most simple examples. As you add units to each side, the tree of possible and likely outcomes grows exponentially.

## "Brute Force" vs. Simulation

In more complex combats with many units we would see a tree with many more branches representing every possible combination of hits and misses, and from this we could observe that the overall probability of success shifts every round, depending on the luck of the players in the previous round(s). For instance, if one player scores many hits during the first round and the other player is unlucky and does not, then that first player has significantly bettered their odds for all future rounds. Put another way, they've narrowed the probability space in their favor.

To compute the probability of success by hand, we'd have to look at every possible scenario and its likelihood. With only a handful of units we'd be looking at hundreds, even thousands of possible outcomes, each with their own distinct probability. This "brute force" strategy would work, but it could be endless, even for a computer.

But there is a better way: the **Monte Carlo simulation**. In this article, we will write a Monte Carlo simulation in JavaScript that repeatedly runs _Axis & Allies_ combats and records the number of scenarios. When we run it 1,000 or 5,000 times, we will start to converge on the overall probability of success or failure. While this might not be as precise a probability as the "brute force" approach, it should be enough to tell us whether or not it's a good idea to invade that province we're looking at.

## Modeling Axis & Allies Units

With that background set, let's start to look at some data and code. As we go, consider the following:

1. How can we best structure our data to produce sensible, easy-to-read code?
2. Since we are building a simulation that needs to run thousands of times, how will our data decisions impact performance - that is, the _speed_ of the simulation?

Let's look at how we might structure data for our simulation. Each unit in _A&A_ has a few elements: a name, IPC value, attack stat, and defense stat. In JavaScript, we might represent that with object literals like so:

```javascript
const Infantry = {
  name: "Infantry",
  ipc: 3,
  attack: 1,
  defense: 2,
};
const Tank = {
  name: "Tank",
  ipc: 6,
  attack: 3,
  defense: 3,
};
```

I think that makes a lot of sense and is easy to read. So now we have objects to represent units. _Axis & Allies_ has many more units than this and some special rules, but we'll focus on these to keep our code samples small.

Now let's create some data structures to represent the _lists_ of units being used by each of our players in a combat. Let's say the attacker is invading with one Infantry and one Tank against a defender's single Infantry:

```javascript
const attackerUnits = [
  {
    name: "Infantry",
    ipc: 3,
    attack: 1,
    defense: 2,
  },
  {
    name: "Tank",
    ipc: 6,
    attack: 3,
    defense: 3,
  },
];
const defenderUnits = [
  {
    name: "Infantry",
    ipc: 3,
    attack: 1,
    defense: 2,
  },
];
```

Here we arrive at our first interesting data modeling decision. Do you know the difference between the above code and this?

```javascript
const Infantry = {
  name: "Infantry",
  ipc: 3,
  attack: 1,
  defense: 2,
};
const Tank = {
  name: "Tank",
  ipc: 6,
  attack: 3,
  defense: 3,
};
const attackerUnits = [Infantry, Tank];
const defenderUnits = [Infantry];
```

Besides being a bit shorter, this code snippet has another very important attribute: both the `attackerUnits` and `defenderUnits` lists contain a **reference** to the same `Infantry` object, while in the first example, the lists referenced entirely different objects. This is because the object literal syntax (the curly braces `{}`) creates a new object in memory whenever it is used.

When it comes to looking at the performance of our simulation, this fact will be very important. Making many reads and writes to memory could slow things down, and objects in particular in JavaScript have extra memory overhead, including "hidden classes" that are created for each object by the browser's JavaScript engine. [This article](https://blog.usejournal.com/the-secrets-of-javascript-object-performance-optimization-5b648fc99f59) explores this in more detail.

Now suppose we decide to refactor a bit and create a formal class to represent units:

```javascript
class Unit {
  constructor(name, ipc, attack, defense) {
    this.name = name;
    this.ipc = ipc;
    this.attack = attack;
    this.defense;
  }
}
```

Given that class, we could do either of the following:

```javascript
// (1) Separate object instances in memory
const attackerUnits = [
  new Unit("Infantry", 3, 1, 2),
  new Unit("Tank", 6, 3, 3),
];
const defenderUnits = [new Unit("Infantry", 3, 1, 2)];

// (2) References to the same instances in memory,
const Infantry = new Unit("Infantry", 3, 1, 2);
const Tank = new Unit("Tank", 6, 3, 3);
const attackerUnits = [Infantry, Tank];
const defenderUnits = [Infantry];
```

This is essentially the same comparison we made before, except that this time we are using the `new` keyword with a class. And once again, the second example will take up less memory than the first. With only three units in play, there isn't much of a difference, but in a scenario where both sides have, say, ten units, there would be more than a tenfold difference in memory use between these two approaches.

## Outlining the Problem

Before writing code, it's always helpful to break down the problem at hand by writing some "pseudo-code" to describe the steps we need to take. We know that a combat goes in "rounds," so let's start there and write out the steps in each round:

**Steps in a Round**

1. Attacker rolls one die for each attacking unit
2. Attacker compares each die roll to the unit's attack stat
3. Attacker records a hit for each die roll equal to or less than the unit's attack stat
4. Defender rolls one die for each defending unit
5. Defender compares each die roll to the unit's defense stat
6. Defender records a hit for each die roll equal to or less than the unit's defense stat
7. Attacker and defender remove units that were "hit"

Phew, that's actually a lot of steps! But it's not too bad. You can probably already imagine that that Step 1 will be a call to a random number generator, Step 2 will be some kind of `if` statement, and Step 3 will increment some kind of counter. And then you've also probably noticed that Steps 4-6 are pretty much the same as Steps 1-3, just taken from the defender's perspective.

Now let's "go up a level" and see how we can use the above routine to simulate an entire combat:

**Steps in a Combat**

1. Set up the attacker and defender unit lists
2. Do a round
3. Check for win, loss, or draw
4. End on a win, loss, or draw, otherwise repeat from Step 2

Alright, this is a bit more straightforward. We've already decided how we'll do Step 1, and we've also covered Step 2. Step 3 looks like it will be some `if` statements, and Step 4 says "repeat from Step 2", so it looks like we'll be wrapping Steps 2-4 in some kind of loop.

Finally, there's one more level to consider. Remember, we don't just want to run the combat once. We want to run it thousands of times and keep track of wins and losses. So we also need to outline the steps for the Monte Carlo Simulation.

**Steps in a Monte Carlo Simulation of Many Combats**

1. Set up the attacker units, defender units, and `x` number of simulations to run
2. Run a combat
3. Record the combat result (win, loss, or draw)
4. Repeat from Step 2 until we have run `x` number of times
5. Display results

This also makes a lot of sense. The main things to consider here are: looping `x` times, resetting the "game board" before each combat (Step 2), counting wins, losses, and draws, and finally displaying results.

And that appears to be everything we'll need. So let's now take these checklists and use them to guide our coding. We can put the above checklists together into a pseudo-code specification that defines our whole application.

```javascript
// STEPS IN A MONTE CARLO SIMULATION
// 1. Set up the attacker units, defender units, and `x` number of simulations to run
// 2. Run a combat
// STEPS IN A COMBAT
// 1. Set up the attacker and defender unit lists
// 2. Do a round
// STEPS IN A ROUND
// 1. Attacker rolls one die for each attacking unit
// 2. Attacker compares each die roll to the unit's attack stat
// 3. Attacker records a hit for each die roll equal to or less than the unit's attack stat
// 4. Defender rolls one die for each defending unit
// 5. Defender compares each die roll to the unit's defense stat
// 6. Defender records a hit for each die roll equal to or less than the unit's defense stat
// 7. Attacker and defender remove units that were "hit"
// 3. Check for win, loss, or draw
// 4. End on a win, loss, or draw, otherwise repeat from Step 2
// 3. Record the combat result (win, loss, or draw)
// 4. Repeat from Step 2 until we have run `x` number of times
// 5. Display results
```

Each level of indentation represents a different checklist, and perhaps you can already see that this is a pretty accurate outline of how the final code might look with the nested loops we will have to create. Laying out the steps in comments in this way can help you stay oriented while working through complicated, multi-step problems like this.

## Coding up a Round

Let's zoom in on the inner-most code for playing a round of combat. Up to now we've explored a couple ways of setting up our virtual game board for combat. Going forward, let's stick with the `Unit` class above and these two unit instances:

```javascript
const Infantry = new Unit("Infantry", 3, 1, 2);
const Tank = new Unit("Tank", 6, 3, 3);
```

Let's also set up the combat again, by giving each our players a list of units:

```javascript
const attackerUnits = [Infantry, Tank];
const defenderUnits = [Infantry];
```

Now, Step 1 calls for rolling a die, and rolling dice is pretty central to running a round, so let's start by writing a function for that:

```javascript
function randBetween(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}
```

This is a generic function to get an integer between `min` and `max`. `Math.random()` generates a decimal between 0 and 1, and the expression `* (max - min + 1) + min` re-scales that value to the range of min-max, finally `Math.floor()` rounds down to the nearest integer.

So to simulate a six-sided die roll, we would have to call `randBetween(1, 6)`. In our simulation, we only need six-sided die (aka "D6"), so we can make things more convenient for ourselves by defining a `rollD6` function.

```javascript
// In traditional `function` syntax:
function rollD6() {
  return randBetween(1, 6);
}

// Or in new "fat arrow" syntax:
const rollD6 = () => randBetween(1, 6);
```

Now that we can roll dice, let's look at a couple ways we might do Steps 1-3. Since we need to roll for each attacking unit, perhaps a `for` loop comes to mind:

```javascript
// 1. Attacker rolls one die for each attacking unit
let attackerHits = 0;
for (let i = 0; i < attackerUnits.length; i++) {
  const unit = attackerUnits[i];
  const roll = rollD6();

  // 2. Attacker compares each die roll to the unit's attack stat
  if (roll <= unit.attack) {
    // 3. Attacker records a hit for each die roll equal to or
    //    less than the unit's attack stat
    attackerHits++;
  }
}
```

This will definitely work, and it's very readable. I think the steps here should be familiar to beginners who have learned the fundamental logic and control flow operators present in most modern languages. One JavaScript-specific quirk is the use of `const` and `let`. The `let` declaration allows us to change the value of a variable. So for example, we can increment `attackerHits` and `i` with the `++` operator. Meanwhile, we use `const` for values we don't want to change. Variables in JavaScript are _block-scoped_ (blocks in JS are usually areas enclosed by curly `{}` braces). That is why we can use `const unit` and `const roll` inside the `for` block. Every time the loop repeats, the previous variables are thrown out and new variables are instantiated inside that block scope.

In general, it's recommended to use `const` whenever possible. Modifying values throughout complicated code risks confusion and difficult bugs.

As an aside, I find that many novice programmers are confused by the use of 'const' with arrays and objects, because arrays and objects declared with 'const' can still have their members modified, for example:

```javascript
const arr = [];
const obj = {};

// This is allowed, even though the above are 'const',
// because 'arr' or 'obj' are references to Array and Object
// instances. We are not changing those references here,
// we are just adding values inside of them.
arr[0] = "hello";
obj.foo = "bar";

// This is not allowed, because it is attempting to assign
// 'arr' and 'obj' to new Array and Object instances, and
// 'const' will not allow us to do that.
arr = ["hello"];
obj = { foo: "bar" };
```

Whether or not it is good idea to allow programmers to modify the contents of objects is a subject of great debate, especially in the functional JavaScript circles. For this reason, tools like [Immutable.js](https://immutable-js.github.io/immutable-js/) were invented, which make it so that object properties can not be changed at all, only replaced with new object instances. I recommend giving this topic a Google.

So what other ways might we do this? Speaking of functional programming (FP), modern JS has some FP tools available to us like `map` and `filter`. We can use these to roll the dice:

```javascript
const attackerHits = attackerUnits
  .map((u) => ({ unit: u, roll: rollD6() }))
  .filter((r) => r.roll <= r.unit.attack).length;
```

This does the same thing as above, but wow! It's a lot shorter. In fact, it's a one-liner. I've just split the lines to make it easier to read. Let's look at what is happening: first, the `map` function creates a new object from each unit in the `attackerList`. Each new object looks something like this: `{ unit, roll }`.

```javascript
const attackerList = [Infantry, Tank];

const result = attackerList.map((u) => ({ unit: u, roll: rollD6() }));
// [
//     { unit: Infantry, roll: 2 },
//     { unit: Tank, roll: 1},
// ]
```

So we've created a set of objects that pairs each unit with a die roll. There is a really cool and useful concept at work here called "object composition." In a sense what we have done _extends_ the capabilities of our `Unit` object without having to modify `Unit` itself. We've done this by wrapping the unit in another object that adds a `roll` property.

Compare that to an approach like this, where we actually change the `Unit` class to add a `roll` property and `rollD6` method to the `Unit` class itself:

```javascript
class Unit() {
    // ... see above

    rollD6() {
        this.roll = rollD6
    }
}
```

Then we'd use that like this:

```javascript
attackerUnits.map((u) => u.rollD6());
```

And that works just as well, we could loop over that list and compare `unit.roll <= unit.attack`. The drawbacks of doing it this way are that we had to modify the `Unit` class to add this capability and our call to `unit.rollD6()` doesn't reveal that `unit.roll` is being changed "behind the scenes."

In larger projects, a change to a key data type like `Unit` might require changes elsewhere in the code. What's more, in functional programming, functions that have "side effects" like this are frowned upon, because they make it hard to see and reason about how and when data is changing. The side effect here is that `rollD6()` is changing the value of `unit.roll`. Compare this to our previous example where we generated `{unit, roll}` objects: `unit` was not modified in any way and it was clear to see how `roll` was being created and added to the data structure. Likewise, these rolls were created on time and never modified.

But perhaps the biggest issue with this approach goes back to our decision to re-use the same `Unit` instances. If we call `unit.rollD6()` on the `Infantry` instance, this will update `Infantry.roll` _everywhere_ that `Infantry` is referenced. This isn't really our intent, and it could lead to some unexpected behavior if we're caught unaware.

Moving on, in the next line of our FP implementation, we have a `filter`. The filter uses the same comparison expression as the `if` statement in our `for`-loop example, only with slightly different syntax to access the properties of the objects we created: `r.roll <= r.unit.attack`. Let's break it down:

```javascript
// Take the result of the 'map' from above
const result = [
  { unit: Infantry, roll: 2 },
  { unit: Tank, roll: 1 },
];

// Filter by rolls less than or equal to the unit's attack stat
const hits = result.filter((r) => r.roll <= r.unit.attack);
// [{unit: Tank, roll: 1}]

// Get the count of the number of remaining elements.
// That is the number of hits!
const numHits = hits.length;
// 1
```

That's pretty clever.

Now let's review this approach by going back to our two questions before: (1) is this easier to read? I think that's debatable. For a beginner, I would say probably not. The first example with the `for`-loop contains syntax that is more universally familiar. I think it's also hard for newbies to imagine the intermediate data structures generated by `map` and `filter`, whereas in the `for`-loop example, it's a bit easier to follow how individual values are changing. On the other hand, more advanced programmers who are able to read this code at a glance will probably appreciate this code for its clarity and "elegance." And I think they would feel reassured that this "pure functional" syntax is doing exactly what it appears to be doing without side effects or surprises.

As for Question 2: what are the performance implications of this code? Compared to the `for`-loop version, the FP code is more inefficient for a few reasons. First, both `map` and `filter` are also loops. This means that the FP code loops two times through the `attackerList` instead of just once. Moreover, the `map` function generates objects, which as mentioned before have a bigger memory "footprint" than the primitive values being used in the `for`-loop example. And this is often how functional programming paradigm works -- it emphasizes clearer code at the cost of memory and processing speed at run time (though there are dedicated functional programming languages like Haskell that have built-in optimizations to help with this).

When we are finished, we could run some benchmark tests to compare the performance of these two approaches, but at a glance, my guess is that the FP version would be slower by a factor of up to 2X. As we run larger simulations with more iterations, this will really add up!

So let's return to our checklist and finish implementing a full round of combat:

```javascript
// SIMULATE A ROUND OF COMBAT
// 1. Attacker rolls one die for each attacking unit,
//    **excluding any casualties**
let attackerHits = 0;
for (let i = attackerCasualties; i < attackerUnits.length; i++) {
  const unit = attackerUnits[i];
  const roll = rollD6();

  // 2. Attacker compares each die roll to the unit's attack stat
  if (roll <= unit.attack) {
    // 3. Attacker records a hit for each die roll equal to or
    //    less than the unit's attack stat
    attackerHits++;
  }
}

// 4. Defender rolls one die for each attacking unit
//    **excluding any casualties**
let defenderHits = 0;
for (let i = defenderCasualties; i < defenderUnits.length; i++) {
  const unit = defenderUnits[i];
  const roll = rollD6();

  // 5. Defender compares each die roll to the unit's defense stat
  if (roll <= unit.defense) {
    // 6. Defender records a hit for each die roll equal to or
    //    less than the unit's defense stat
    defenderHits++;
  }
}

// 7. Attacker and defender remove units that were "hit"
attackerCasualties = Math.min(
  attackerCasualties + defenderHits,
  attackerUnits.length
);
defenderCasualties = Math.min(
  defenderCasualties + attackerHits,
  defenderUnits.length
);
```

So now we've added Steps 4-6, rolling for the defender and comparing the rolls to each unit's `defense` stat. We've also added a couple variables and logic for Step 7, which records the total number of casualties. We use `Math.min` to limit the number of casualties based on the number of attacking or defending units. We cannot take more casualties than we have units. We've also updated the `for` loops to exclude casualties from rolling. As casualties go up, the `for` loop starts at a later index, so we end up rolling for fewer units.

From a gameplay perspective, deciding which units to remove first is very significant. In this case, the units at the beginning of each unit list are taken as "casualties" first and can no longer attack or defend once hit. So if stronger, more valuable units are listed first, they will be removed from combat first, and any competent A&A player will tel you that, as a general rule, you want to remove your weakest, lowest-value units first.

For sake of simplicity, we can deal with this one of two ways: (1) we can ask the user to enter units in the order they expect them to be removed, or (2) we can automatically sort the list of units by their ipc value, like so.

```javascript
attackerUnits.sort((a, b) => a.ipc - b.ipc);
defenderUnits.sort((a, b) => a.ipc - b.ipc);
```

In the real game, there are times where it makes strategic sense to sacrifice higher-valued units or allocate a hit to a Battleship, which has two hit points, but for the sake of simplicity, we will not address that here.

Now let's look again at the alternative FP implementation of a combat round:

```javascript
// Steps 1-3: Attacker rolls and hit count, excluding casualties
const attackerHits = attackerUnits
  .filter((u, index) => index >= attackerCasualties)
  .map((u) => ({ unit: u, roll: rollD6() }))
  .filter((r) => r.roll <= r.unit.attack).length;

// Steps 4-6: Defender rolls and hit count, excluding casualties
const defenderHits = defenderUnits
  .filter((u, index) => index >= defenderCasualties)
  .map((u) => ({ unit: u, roll: rollD6() }))
  .filter((r) => r.roll <= r.unit.defense).length;

// 7. Attacker and defender remove units that were "hit"
attackerCasualties = Math.min(
  attackerCasualties + defenderHits,
  attackerUnits.length
);
defenderCasualties = Math.min(
  defenderCasualties + attackerHits,
  defenderUnits.length
);
```

It's very similar. Here, we are recording casualties in the same way, and we've added another `filter` call to the lists to remove casualties before rolling. Perhaps you are starting to see the "functional" way of thinking, which is to send our unit lists through a "pipeline" of chained functions until we reach the desired result. Again, this is much more concise than the `for`-loop, but may be less readable to beginners and will probably run slower.

And that's it for simulating a combat round!

## Coding a Full Combat

The individual rounds of combat are the real "meat" of this simulation. With that done, playing out a full combat is just a matter of looping until one side or the other has lost, checking after each iteration for a win, loss, or draw. Here's what that looks like:

```javascript
// STEPS IN A COMBAT
// 1. Set up the attacker and defender unit lists
const attackerList = [Infantry, Tank];
const defenderList = [Infantry];

// Also, reset casualties
const attackerCasualties = 0;
const defenderCasualties = 0;

const done = false;
while (!done) {
  // 2. Do a round
  //    ... see above

  // 3. Check for win, loss, or draw
  if (
    attackerCasualties === attackerList.length &&
    defenderCasualties === defenderList.length
  ) {
    alert("It's a draw!");
    done = true;
  } else if (attackerCasualties === attackerList.length) {
    alert("Defender Wins!");
    done = true;
  } else if (defenderCasualties === defenderList.length) {
    alert("Attacker Wins!");
    done = true;
  }
}
```

And that's all there is to this "layer" of things. We use the `while(!done)` loop to repeat rounds of combat until the number of casualties on either side or both sides equals the number of units. We use `alert` to display the result and set `done = true` to exit the loop.

Can you think of a better or more concise way to write the `if` statement that checks for the win condition? One alternative to complex `if...else if` statements is to decompose them into expressions and assign the result of those expressions to variables, like so:

```javascript
// A side has lost when casualties equal their unit count
attackerLost = attackerCasualties === attackerList.length;
defenderLost = defenderCasualtie === defenderList.length;

// We're done if either side has lost
done = attackerLost || defenderLost;

// The attacker wins if they didn't lose and the defender did
attackerWon = !attackerLost && defenderLost;

// The defender wins if they didn't lose and the attacker did
defenderWon = !defenderLost && attackerLost;

// It's a draw if both sides lost
draw = attackerLost && defenderLost;
```

This approach looks a bit more verbose than the `if...else if` pattern, but it has the added benefit of being more explicit about what the comparison operators are intended to check. The logic is also cleanly separated between each value, which means that we can change how any one value is computed without affecting any of the other values. By contrast, `if...else if` chains can quickly become confusing, because each block depends on the logic of the previous block, so if you have a bug, you have to trace the whole chain to understand what's going on.

One final benefit of this approach is that it separates our _data_ and _logic_ from the _presentation_. In the `if...else if` example, each block contained `alert()`s, which meant that the data (the value of `done`) and the logic (the `if...else if`) statements were all coupled together. By creating distinct values to represent the various outcomes, we can separately make a decision about how we want those results to be displayed to a user, whether via an `alert` or, as we'll see later, in the user interface.

## Coding the Monte Carlo Simulation

Now that we can simulate complete multi-round combats, we're ready to wrap everything up in a simulation of repeated combats. This step is going to be very much like the last.

```javascript
// STEPS IN THE MONTE CARLO SIMULATION
// 1. Set up the attacker units, defender units, and `x` number of simulations to run
const attackerList = [Infantry, Tank];
const defenderList = [Infantry];
const simCount = 1000;

// We'll record wins/losses from the attacker's perspective
let wins = 0;
let losses = 0;
let draws = 0;
for (let i = 0; i < simCount; i++) {
  // 2. Run a combat
  // ... see above

  // 3. Record the combat result (win, loss, or draw)
  wins += attackerWon ? 1 : 0;
  losses += defenderWon ? 1 : 0;
  draws += draw ? 1 : 0;

  // 4. Repeat from Step 2 until we have run `x` number of times
}

// 5. Display results
alert(`
wins: ${wins}
losses: ${losses}
draws: ${draws}
success chance: ${wins / simCount}
`);
```

So the main thing we've done here is added variables to track the number of wins, losses, and draws from the attacker's perspective. We check the win state after every combat and increment the appropriate counter. Here we have once again avoided `if...else if` statements by using ternary expressions (the `?...:` syntax) to check the values we declared in the previous section. So for example `wins += attackerWon ? 1 : 0` will add `1` to the win count if the attacker won, otherwise, it will add `0`.

We might have written the same logic using `if...else if`

```javascript
if (attackerWon) {
  wins++;
} else if (defenderWon) {
  losses++;
} else if (draw) {
  draw++;
}
```

And that's pretty clear. But again, the `if...else if` chain couples these lines together, whereas the ternary operator keeps each statement separate, rather than inter-dependent.

Finally, we display the aggregate results in an `alert()`. It gets the job done, but it's rather ugly and inflexible, so next we'll look at how to wire this simulation up to a UI so that you can quickly run different scenarios.

## Coding an Interface

At this point, we have a working simulation, but it's not at all user friendly. In order to update the simulation scenario, you have to alter the code and refresh the page - that is, assuming you are running this JavaScript in an HTML file in a browser. Until now, we haven't really talked about the runtime environment for this code.

Let's use [VueJS](https://vuejs.org/) to quickly prototype a UI. You can follow the [Getting Started](https://vuejs.org/v2/guide/#Getting-Started) guide on the Vue website to create an HTML page that includes vuejs from a CDN or use an online prototyping tool like [CodePen](https://codepen.io).

First, we have to decide how we want to take input. The sky is the limit here, but let's take a very simple approach. Let's give the user three input boxes (1) a number input to specify the simulation count, (2) a text input for the list of attacker units, and (3) a text input for the list of defender units.

We'll allow users to supply a list of units using a string of characters like 'I' for 'Infantry' and 'T' for 'Tank'. When they submit the form, we will parse these strings and create the actual `attackerList` and `defenderList`. Let's start by setting up the template:

```html
<div id="app">
  <h3>Axis & Allies Combat Simulator (Imperative Version)</h3>

  <form @submit.prevent="run">
    <div>
      <label>Simulation Count</label>
      <input type="number" v-model="simCount" />
    </div>
    <div>
      <label>Attacker Units</label>
      <input type="text" v-model="attackerListStr" />
    </div>
    <div>
      <label for="DefenderUnits">Defender Units</label>
      <input type="text" v-model="defenderListStr" />
    </div>
    <button type="submit">Run Sim</button>
  </form>
</div>
```

This mark-up creates a form with the three inputs we need. Note that we've also included a `<button>` tag with `type="submit"` and attached a `@submit` event listener to the form. This allows the user to press the 'Enter' key to submit the form or click on the submit button with their mouse. We've also specified a `v-model` for each form input that corresponds to the three values we want to collect.

Next, we'll set up our VueJS code to power this template:

```javascript
// ... declare randBetween, rollD6, and Unit

const types = {
  I: new Unit("Infantry", 3, 1, 2),
  T: new Unit("Tank", 6, 3, 3),
};

var app = new Vue({
  el: "#app",
  data() {
    return {
      simCount: 1000,
      attackerListStr: "IT",
      defenderListStr: "I",
      results: null,
    };
  },
  methods: {
    buildUnitList(str) {
      const result = [];
      for (let i = 0; i < str.length; i++) {
        const unit = types[str[i]];
        if (unit) {
          result.push(unit);
        }
      }
      return result;
    },
    run() {
      this.results = null;
      const attackerList = this.buildUnitList(this.attackerListStr);
      const defenderList = this.buildUnitList(this.defenderListStr);

      // Run the simulation the number of times indicated by
      // `simCount` and keep track of attacker and defender wins.
      const timeStart = Date.now();
      let attackerWins = 0;
      let defenderWins = 0;
      let draws = 0;
      for (let i = 0; i < this.simCount; i++) {
        // ... RUN COMBAT (see above)

        // Summarize stats across all simulated combats
        this.results = {
          attackerWins,
          defenderWins,
          draws,
          successChance: attackerWins / this.simCount,
          simCount: this.simCount,
          simDuration: String(Date.now() - timeStart) + "ms",
        };
      }
    },
  },
});
```

[View the Complete Code on CodePen](https://codepen.io/whusterj/pen/b4397c0d26fc315dae283d682f7819d8)

A lot of this code should look familiar, though there are a few changes and new additions. Notably, we've added a `types` object that maps the letters 'I' and 'T' to the Infantry and Tank object instances. This pattern is often called a "lookup table" or "dictionary," and it is a convenient way to avoid using `switch` statements or repetitive `if...else if` statements to look up one value based on another value.

Here, the `types` lookup table is used in the `buildUnitList` method, which loops over each character in the string and builds a new list of unit object references. Unrecognized characters are ignored.

```javascript
// Examples of strings converted to unit lists

const str = "IT";
const unitList = buildUnitList(str);
// unitList = [Infantry, Tank]

const str = "IIITTT";
const unitList = buildUnitList(str);
// unitList = [Infantry, Infantry, Infantry, Tank, Tank]
```

The `run()` method is where the magic happens, and all of our simulation code has been placed there. The first thing the `run()` method does is parse the user input using `buildUnitList`. We've also added the variable `timeStart` that grabs a date object before running the simulation. This allows us to compute how long, in milliseconds, it takes for our simulation to run.

The rest of the code is very much the same until the simulation completes. At that point, the results are put together into a `results` object, instead of being displayed in an `alert()`. Again, this demonstrates the principle of decoupling our data and logic from how it's presented.

Because VueJS is reactive, we can present the data rather easily by updating the template:

```html
<div id="app">
  <form><!-- ... see above --></form>

  <div v-if="results !== null">
    <h3>Sim Results</h3>
    <p>
      <strong>Sim Duration:</strong> {{ results.simDuration }}<br />
      <strong>Attacker Wins:</strong> {{ results.attackerWins }}<br />
      <strong>Defender Wins:</strong> {{ results.defenderWins }}<br />
      <strong>Draws:</strong> {{ results.draws }}<br />
      <strong>Success Chance:</strong> {{ results.attackerWins /
      results.simCount }}
    </p>
  </div>
</div>
```

The results `div` will only appear when `results !== null`, and `results` is `null` by default, so this div will be hidden until the simulation has finished running for the first time. The rest of the template lists the results in a `<p>` tag.

And with that, we have successfully hooked our simulation up to a basic UI that allows us to explore different _Axis & Allies_ combat scenarios. [You can check out the complete code and interact with it on CodePen](https://codepen.io/whusterj/pen/b4397c0d26fc315dae283d682f7819d8)

## Summary

In this article we explored a variety of topics, from the motivating problem of combat outcome probabilities in _Axis & Allies_ to code-level considerations, such as the merits of using `if...else if` statements. Perhaps the most interesting thing to me going through this exercise was the realization that the most "naive" and straightforward implementation would be best not only for performance, but also for readability for novice devs unfamiliar with functional programming practices.

This is the main reason I was motivated to write this blog post. I realize I have been conditioned to frown upon `for` loops in code, having "evolved" my personal practice to prefer `map`, `filter`, and friends. In my first attempt implementing this simulator, I used those functions along with other FP concepts like immutability. This meant there were many unncessary extra loops and lots of extra memory consumption as I generated several new objects per loop. The simulation was very slow. I tried to run a simulation with multiple units and 1,000,000 iterations, and my browser locked up. Chrome slowly began consuming more and more system memory. It peaked at 14% before I force-quit the browser. I knew JavaScript was slow, but ...wow.

After that, I decided to go all-out on performance and re-implement the simulator in C as a command-line application, just to see how much faster this could be. Plain C does not have these FP methods, so it was back to `for` loops. C also forces you to think more about memory, so that's when I hit on the idea of having the units be static objects in memory (`struct`s in C) and the unit lists be lists of _references_ (or "pointers") to those values. All other values in the program would be integers that I would increment, so I knew the memory footprint would be small. The C program can run millions of trials with multiple units in under 10 seconds. Then I went back to JavaScript and applied the same principles. The JS version is still much slower, but it can run millions of trials now. Furthermore, the final JS and C implementations are practically identical in terms of syntax, save for C's type annotations. It's pretty fascinating.

It's a lesson that is always useful to learn again no matter how long you do this: that fancy, advanced, and "modern" approaches to programming are not essential to writing effective software.

You can reach me at whusterj@gmail.com. Please feel free to reach out with questions, comments, or corrections regarding this content. I look forward to hearing from you!

---

_Notes_

[^1]: Andrew Howlett demonstrates a "brute force" method and takes this obsession to a whole new level in his paper [Probability of Outcomes of A&A Battles](https://www.radagast.ca/axis_and_allies/probability_of_outcomes_of_a&a_battles.pdf). He also wrote his own [very robust desktop A&A combat simulator back in 2003](https://radagast.ca/axis_and_allies/batsimv2.html) that also uses a Monte Carlo method.

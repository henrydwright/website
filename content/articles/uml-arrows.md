Title: UML arrows - WTH?!
Date: 2022-11-20 19:38
Category: Blog
Tags: back-end,java,modelling,UML,business-analysis
Description: UML arrows - explained in plain English (at last!)
Thumb_Image: test.jpg

When you teach, you reveal the world's lies. This weekend I've been dispelling the idea the words "universal" or "standard" should ever be written in the world of software - demonstrated through the medium of the arrows in [Unified Modelling Language (UML)](https://en.wikipedia.org/wiki/Class_diagram) class diagrams.

UML class diagrams can be used to draw out your object-oriented programming classes and relationships between them. It's essentially a set of paintbrushes you can use to paint the real world into software.  Our, quiet, academic arguments centred on how best to represent relationships between classes with different types of UML arrows. Much like other software concepts, its more of an art than a science and multiple answers are always possible.

### Arrow Types

One resource I found it tricky to find online was a single, plain English, explanation of the different types of UML arrows - with examples. So let's go through some examples here.

Imagine we have been commissioned to write software for managing a library service and, as grade A software architects (alongside our business analysts), are seeking to model a set of classes.

#### Association (has-a)
The first relationship is perhaps the most general of the lot - showing where one class may act on another. Concretely, this usually means one class has a reference to another. We can also use _multiplicity_ to say how many of each class are involved in an association.

In plain English we might say things like _"A branch has one staff member as a manager"_.

In Java we may write ```StaffMember manager;``` in our ```Branch``` class.

<img src="/images/articles/uml-arrows/assoc.jpg" width="250"/>

#### Aggregation (part-of)
A more specific type of association is that of aggregation. It represents an association where the object lives on when the object it is aggregated in is destroyed. This is sometimes called a _"part-whole relationship"_.

In plain English we might say things like _"A loanable item is part of the stock of a branch. Each loanable item can only belong to one branch at a time, but we might move it between branches."_.

In Java we might represent this as ```List<LoanableItem> stock;``` in our ```Branch``` class whilst also keeping references elsewhere.

<img src="/images/articles/uml-arrows/aggreg.jpg" width="250"/>

#### Composition (made-of)
As

#### Inheritance (is-a)
This relationship helps us to define a _hierarchy_ between classes in our model going from a more general concept to a more specialised concept. 

In plain English we might be saying things like _"A book is a loanable item in our library. We also have optical media, both DVDs and Blu-Rays."_

In Java this becomes something like ```Book extends LoanableItem```.

<img src="/images/articles/uml-arrows/inheritance.jpg" width="250"/>


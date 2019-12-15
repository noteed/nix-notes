---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Evaluating expressions

The name "Nix" is also the name of the language used to describe Nix packages.
To play with the language we can use a few approaches.

We can use `nix eval` or `nix-instantiate` to directly evaluate an expression:

```
$ nix eval '(1 + 2)'
3
```

```
$ nix-instantiate --eval --expr '1 + 2'
3
```

We can also use them to evaluate an expression written to a file:

```
$ echo '{ a = 1 + 2; }' > expression.nix
$ nix eval -f expression.nix a
3
```

```
$ echo '1 + 2' > expression.nix
$ nix-instantiate --eval expression.nix
3
```

We can use the interactive REPL:

```
$ nix repl
Welcome to Nix version 2.1.3. Type :? for help.

nix-repl> 1 + 2
3

nix-repl> ^D
```

What if we try to _build_ an expression that doesn't describe a package ?

```
$ nix build -f expression.nix a
error: expression does not evaluate to a derivation (or a set or list of those)
```

And what happens if we evaluate an derivation ?

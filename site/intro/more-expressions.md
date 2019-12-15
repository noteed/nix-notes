---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## More expressions

Lambdas:

```
$ nix eval expr '(a: a + 1)'
<LAMBDA>
```

```
$ nix eval expr '(a: a + 1) 2'
3
```

Attribute sets:

```
$ nix eval '({ a = 1; })'
{ a = 1; }
```

```
$ nix eval '({ a = 1; }.a)'
1
```

Understanding the nested keys syntactic sugar:

```
$ nix-instantiate --eval --expr '{ a.b.c = 1; }.a.b'
{ c = 1; }
$ nix-instantiate --eval --expr '{ a.b.c = 1; }'
{ a = <CODE>; }
$ nix-instantiate --eval --expr --strict '{ a.b.c = 1; }'
{ a = { b = { c = 1; }; }; }
```

Understanding the `<nixpkgs>` path notation:

```
$ pwd
/tmp
$ cat a.nix
{ a = 1 ; }
$ nix-instantiate --eval a.nix
{ a = 1; }
$ nix-instantiate --eval -I mypkgs=./a.nix --expr '<mypkgs>'
/tmp/a.nix
$ nix-instantiate --eval -I mypkgs=./a.nix --expr 'import <mypkgs>'
{ a = 1; }
$ nix-instantiate --eval -I mypkgs=./a.nix --expr 'with import <mypkgs> ; a'
1
```

```
$ nix-instantiate --eval --expr --strict '<nixpkgs>'
/home/thu/.nix-defexpr/channels/nixpkgs
```
